//
//  Image.swift
//  Amaze Series
//
//  Created by Eduardo Vital Alencar Cunha on 27/12/2021.
//

import Foundation

struct Poster {
    let originalImageUrl: URL
    let mediumImageUrl: URL
}

extension Poster: Decodable {
    private enum CodingKeys: CodingKey {
        case original, medium
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        originalImageUrl = try URL(string: container.decode(String.self, forKey: .original))!
        mediumImageUrl = try URL(string: container.decode(String.self, forKey: .medium))!
    }
}
