//
//  SeriesEpisode.swift
//  Amaze Series
//
//  Created by Eduardo Vital Alencar Cunha on 27/12/2021.
//

import Foundation
import UIKit

struct SeriesEpisode: Hashable {
    let season: Int
    let episode: Int

    init?(season: Int, episode: Int) {
        guard season >= 0, episode >= 0 else { return nil }

        self.season = season
        self.episode = episode
    }
}
