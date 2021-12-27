//
//  Series.swift
//  Amaze Series
//
//  Created by Eduardo Vital Alencar Cunha on 27/12/2021.
//

import Foundation

struct Series {
    let name: String
    let poster: Poster
    let summary: String
    let genres: Set<Genre>
}

extension Series: Decodable {
    enum CodingKeys: CodingKey {
        case name, image, summary, genres, apisodes
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.name = try container.decode(String.self, forKey: .name)
        self.summary = try container.decode(String.self, forKey: .summary)
        self.genres = try container.decode(Set<Genre>.self, forKey: .genres)
        self.poster = try container.decode(Poster.self, forKey: .image)
    }
}
