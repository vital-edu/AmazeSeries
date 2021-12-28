//
//  RemoteResponse.swift
//  Amaze Series
//
//  Created by Eduardo Vital Alencar Cunha on 27/12/2021.
//

import Foundation

enum RemoteResponse<T> {
    case success(data: T)
    case failure(errorDescription: String, rawData: Data?, statusCode: Int?)
}
