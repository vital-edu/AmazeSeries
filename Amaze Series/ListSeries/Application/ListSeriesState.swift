//
//  ListSeriesState.swift
//  Amaze Series
//
//  Created by Eduardo Vital Alencar Cunha on 28/12/2021.
//

import Foundation

enum ListSeriesState {
    case initial
    case loadInProgress(series: Array<Series>)
    case loadSuccess(series: Array<Series>)
    case hasFailure(series: Array<Series>, message: String)

    var series: Array<Series> {
        switch self {
        case .initial:
            return []
        case .loadInProgress(let series):
            return series
        case .loadSuccess(let series):
            return series
        case .hasFailure(let series, _):
            return series
        }
    }
}
