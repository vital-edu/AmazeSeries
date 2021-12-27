//
//  Series.swift
//  Amaze Series
//
//  Created by Eduardo Vital Alencar Cunha on 27/12/2021.
//

import Foundation

struct Series {
    let name: String
    let poster: Image
    let summary: String
    let genres: Set<Genre>
    let episodes: Set<SeriesEpisode>
}
