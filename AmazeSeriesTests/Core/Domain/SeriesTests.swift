//
//  SeriesTests.swift
//  AmazeSeriesTests
//
//  Created by Eduardo Vital Alencar Cunha on 27/12/2021.
//

import XCTest
@testable import Amaze_Series

class SeriesTests: XCTestCase {
    func testInitFromDecoder_withJSONDecoder() throws {
        let testBundle = Bundle(for: type(of: self))
        guard let fileUrl = testBundle.url(forResource: "Series", withExtension: "json") else {
            return XCTFail("JSON file not found.")
        }

        guard let data = try? Data(contentsOf: fileUrl) else {
            return XCTFail("Invalid JSON file.")
        }

        let series = try JSONDecoder().decode(Series.self, from: data)
        XCTAssertEqual(series.name, "Kirby Buckets")
        XCTAssertEqual(series.summary, "<p>The single-camera series that mixes live-action and animation stars Jacob Bertrand as the title character. <b>Kirby Buckets</b> introduces viewers to the vivid imagination of charismatic 13-year-old Kirby Buckets, who dreams of becoming a famous animator like his idol, Mac MacCallister. With his two best friends, Fish and Eli, by his side, Kirby navigates his eccentric town of Forest Hills where the trio usually find themselves trying to get out of a predicament before Kirby's sister, Dawn, and her best friend, Belinda, catch them. Along the way, Kirby is joined by his animated characters, each with their own vibrant personality that only he and viewers can see.</p>")
        XCTAssertEqual(series.poster.originalImageUrl.absoluteString, "https://static.tvmaze.com/uploads/images/original_untouched/1/4600.jpg")
        XCTAssertEqual(series.genres, [Genre.comedy])
    }
}
