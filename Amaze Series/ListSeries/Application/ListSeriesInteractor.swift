//
//  ListSeriesInteractor.swift
//  Amaze Series
//
//  Created by Eduardo Vital Alencar Cunha on 28/12/2021.
//

import Foundation

protocol ListSeriesInteractorDelegate: AnyObject {
    func onUpdate(state: ListSeriesState)
}

protocol ListSeriesInteractorType {
    var interactorDelegate: ListSeriesInteractorDelegate? { get set }

    func getNextSeriesPage() async
}

class ListSeriesInteractor {
    private let repository: ListSeriesRepositoryProtocol
    private var page = 0
    private var state = ListSeriesState.initial {
        didSet {
            interactorDelegate?.onUpdate(state: state)
        }
    }

    weak var interactorDelegate: ListSeriesInteractorDelegate?

    init(repository: ListSeriesRepositoryProtocol? = nil) {
        self.repository = repository ?? ListSeriesRepository()
    }
}

extension ListSeriesInteractor: ListSeriesInteractorType {
    func getNextSeriesPage() async {
        state = .loadInProgress(series: state.series)

        let result = await repository.get(page: page)
        switch result {
        case .success(let series):
            self.state = .loadSuccess(series: state.series + series)
        case .failure(let errorDescription, _, _):
            self.state = .hasFailure(series: state.series, message: errorDescription)
        }
    }
}
