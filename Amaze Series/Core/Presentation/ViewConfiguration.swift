//
//  ViewConfiguration.swift
//  Amaze Series
//
//  Created by Eduardo Vital Alencar Cunha on 28/12/2021.
//

import Foundation

protocol ViewConfiguration: AnyObject {
    func buildViewHierarchy()
    func setupConstraints()
    func configureViews()
    func buildLayout()
}

extension ViewConfiguration {
    public func buildLayout(){
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }

    public func configureViews() {}
}
