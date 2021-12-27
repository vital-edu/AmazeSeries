//
//  Image.swift
//  Amaze Series
//
//  Created by Eduardo Vital Alencar Cunha on 27/12/2021.
//

import Foundation

struct Poster {
    let originalImageUrl: String
    let mediumImageUrl: String
}

extension Poster: Decodable {
    private enum CodingKeys: CodingKey {
        case original, medium
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        originalImageUrl = try container.decode(String.self, forKey: .original)
        mediumImageUrl = try container.decode(String.self, forKey: .medium)
    }
}
