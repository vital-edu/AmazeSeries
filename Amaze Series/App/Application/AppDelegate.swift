//
//  AppDelegate.swift
//  Amaze Series
//
//  Created by Eduardo Vital Alencar Cunha on 27/12/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appRouter: AppRouterType?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let appViewController = self.setupAppViewController()

        appRouter = AppRouter(appViewController: appViewController)
        appRouter?.startApplication()
        return true
    }

    private func setupAppViewController() -> AppViewControllerType {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let appViewController = AppViewController(nibName: nil, bundle: nil)
        self.window?.rootViewController = appViewController
        self.window?.makeKeyAndVisible()
        return appViewController
    }
}
