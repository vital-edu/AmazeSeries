//
//  ListSeriesRepository.swift
//  Amaze Series
//
//  Created by Eduardo Vital Alencar Cunha on 27/12/2021.
//

import Foundation

protocol ListSeriesRepositoryProtocol {
    func get(page: Int) async -> RemoteResponse<[Series]>
}

class ListSeriesRepository: ListSeriesRepositoryProtocol {
    private let localService: ListSeriesRemoteServiceProtocol

    init(localService: ListSeriesRemoteServiceProtocol? = nil) {
        self.localService = localService ?? ListSeriesRemoteService()
    }

    func get(page: Int) async -> RemoteResponse<[Series]> {
        return await localService.get(page: page)
    }
}
