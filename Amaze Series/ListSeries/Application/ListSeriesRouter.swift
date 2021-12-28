//
//  ListSeriesRouter.swift
//  Amaze Series
//
//  Created by Eduardo Vital Alencar Cunha on 28/12/2021.
//

import Foundation

protocol ListSeriesRouterType {
    func start()
}

protocol ListSeriesRouterDelegate: AnyObject {}

class ListSeriesRouter {
    private weak var appViewController: AppViewControllerType?
    private weak var routerDelegate: ListSeriesRouterDelegate?

    init(appViewController: AppViewControllerType, routerDelegate: ListSeriesRouterDelegate) {
        self.appViewController = appViewController
        self.routerDelegate = routerDelegate
    }
}

extension ListSeriesRouter: ListSeriesRouterType {
    func start() {
        let interactor = ListSeriesInteractor()
        let presenter = ListSeriesPresenter(interactor: interactor)
        let viewController = ListSeriesViewController(presenter: presenter)

        interactor.interactorDelegate = presenter

        appViewController?.updateCurrent(to: viewController)
    }
}
