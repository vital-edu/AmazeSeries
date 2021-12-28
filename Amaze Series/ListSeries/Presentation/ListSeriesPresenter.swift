//
//  ListSeriesPresenter.swift
//  Amaze Series
//
//  Created by Eduardo Vital Alencar Cunha on 28/12/2021.
//

import Foundation

protocol ListSeriesPresenterType {
    func onListSeriesPresented(on listSeriesView: ListSeriesViewControllerType) async
}

class ListSeriesPresenter {
    private let interactor: ListSeriesInteractorType

    weak var listSeriesView: ListSeriesViewControllerType?

    init(interactor: ListSeriesInteractorType) {
        self.interactor = interactor
    }
}

extension ListSeriesPresenter: ListSeriesPresenterType {
    func onListSeriesPresented(on listSeriesView: ListSeriesViewControllerType) async {
        self.listSeriesView = listSeriesView
        await self.interactor.getNextSeriesPage()
    }
}
extension ListSeriesPresenter: ListSeriesInteractorDelegate {
    func onUpdate(state: ListSeriesState) {
        guard let listSeriesView = self.listSeriesView else { return }
        listSeriesView.onSeriesFetched(series: state.series)
    }
}
