//
//  ListSeriesMockedData.swift
//  AmazeSeriesTests
//
//  Created by Eduardo Vital Alencar Cunha on 28/12/2021.
//

import Foundation

final class ListSeriesMockedData {
    public static let seriesJson: URL = Bundle(for: ListSeriesMockedData.self)
            .url(forResource: "ListSeries", withExtension: "json")!
}
