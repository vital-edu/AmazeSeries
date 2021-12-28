//
//  ListSeriesPresenter.swift
//  Amaze Series
//
//  Created by Eduardo Vital Alencar Cunha on 28/12/2021.
//

import Foundation

protocol ListSeriesPresenterType {
    func onListSeriesPresented(on listSeriesView: ListSeriesViewControllerType)
    func loadNextPage()
}

class ListSeriesPresenter {
    private let interactor: ListSeriesInteractorType

    weak var listSeriesView: ListSeriesViewControllerType?

    init(interactor: ListSeriesInteractorType) {
        self.interactor = interactor
    }
}

extension ListSeriesPresenter: ListSeriesPresenterType {
    func onListSeriesPresented(on listSeriesView: ListSeriesViewControllerType) {
        self.listSeriesView = listSeriesView
        Task(priority: .medium) {
            await self.interactor.getNextSeriesPage()
        }
    }

    func loadNextPage() {
        Task(priority: .medium) {
            await self.interactor.getNextSeriesPage()
        }
    }
}

extension ListSeriesPresenter: ListSeriesInteractorDelegate {
    func onUpdate(state: ListSeriesState) {
        guard let listSeriesView = self.listSeriesView else { return }
        DispatchQueue.main.async {
            listSeriesView.onSeriesFetched(series: state.series)
        }
    }
}
