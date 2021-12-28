//
//  AppViewController.swift
//  Amaze Series
//
//  Created by Eduardo Vital Alencar Cunha on 27/12/2021.
//

import UIKit

protocol AppViewControllerType: AnyObject {
    func updateCurrent(to viewController: UIViewController)
}

class AppViewController: UIViewController {
    private var current: UIViewController?
}

extension AppViewController: AppViewControllerType {
    func updateCurrent(to viewController: UIViewController) {
        addChild(viewController)
        viewController.view.frame = view.bounds

        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)

        current?.willMove(toParent: nil)
        current?.view.removeFromSuperview()
        current?.removeFromParent()
        current = viewController
    }
}
