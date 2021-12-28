//
//  ListSeriesRemoteService.swift
//  Amaze Series
//
//  Created by Eduardo Vital Alencar Cunha on 27/12/2021.
//

import Foundation
import Alamofire

protocol ListSeriesRemoteServiceProtocol {
    func get(page: Int) async -> RemoteResponse<[Series]>
}

class ListSeriesRemoteService: ListSeriesRemoteServiceProtocol {
    private let session: Session

    init(session: Session? = nil) {
        self.session = session ?? Session.default
    }

    func get(page: Int) async -> RemoteResponse<[Series]> {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.tvmaze.com"
        urlComponents.path = "/shows"
        urlComponents.queryItems = [
            URLQueryItem(name: "page", value: String(page))
        ]

        let request = session.request(urlComponents)

        return await withCheckedContinuation { continuation in
            request.validate().responseData { (response) in
                switch response.result {
                case .success(let data):
                    let series: [Series]
                    do {
                        series = try JSONDecoder().decode([Series].self, from: data)
                    } catch {
                        let result = RemoteResponse<[Series]>.failure(errorDescription: error.localizedDescription, rawData: data, statusCode: response.response?.statusCode)
                        return continuation.resume(returning: result)
                    }

                    let result = RemoteResponse.success(data: series)
                    continuation.resume(returning: result)
                case .failure(let error):
                    let result = RemoteResponse<[Series]>.failure(
                        errorDescription: error.localizedDescription,
                        rawData: response.data,
                        statusCode: error.responseCode
                    )

                    continuation.resume(returning: result)
                }
            }
        }
    }
}
