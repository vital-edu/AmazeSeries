//
//  AppRouter.swift
//  Amaze Series
//
//  Created by Eduardo Vital Alencar Cunha on 28/12/2021.
//

import Foundation

protocol AppRouterType {
    func startApplication()
}

final class AppRouter {
    private let appViewController: AppViewControllerType
    private var listSeriesRouter: ListSeriesRouterType?

    init(appViewController: AppViewControllerType) {
        self.appViewController = appViewController
    }

    private func routeToListSeries() {
        self.listSeriesRouter = ListSeriesRouter(
            appViewController: self.appViewController,
            routerDelegate: self
        )
        self.listSeriesRouter?.start()
    }
}

extension AppRouter: AppRouterType {
    func startApplication() {
        self.routeToListSeries()
    }
}

extension AppRouter: ListSeriesRouterDelegate {}
