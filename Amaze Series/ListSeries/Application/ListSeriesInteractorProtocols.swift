//
//  ListSeriesInteractorProtocols.swift
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
