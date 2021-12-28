//
//  ListSeriresRemoteServiceTests.swift
//  AmazeSeriesTests
//
//  Created by Eduardo Vital Alencar Cunha on 28/12/2021.
//

import XCTest
import Mocker
import Alamofire
@testable import Amaze_Series

class ListSeriresRemoteServiceTests: XCTestCase {
    func testGetSeries_when200_shoudlReturnListOfSeries() async throws {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        let sessionManager = Alamofire.Session(configuration: configuration)

        let apiEndpoint = URL(string: "https://api.tvmaze.com/shows?page=0")!
        let mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [
            .get: try! Data(contentsOf: ListSeriesMockedData.seriesJson)
        ])
        mock.register()

        let remoteService = ListSeriesRemoteService(session: sessionManager)
        let result = try await remoteService.get(page: 0)

        switch result {
        case .success(let series):
            XCTAssertFalse(series.isEmpty)
            XCTAssertEqual(series[0].name, "Under the Dome")
        case .failure(let errorDescription, _, _):
            XCTFail("Result should not be a failure: \(errorDescription))")
        }
    }

    func testGetSeries_when404_shoudlReturnFailure() async throws {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        let sessionManager = Alamofire.Session(configuration: configuration)

        let apiEndpoint = URL(string: "https://api.tvmaze.com/shows?page=0")!
        let mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 404, data: [
            .get: try! JSONSerialization.data(withJSONObject: [String](), options: [])
        ])
        mock.register()

        let remoteService = ListSeriesRemoteService(session: sessionManager)
        let result = try await remoteService.get(page: 0)

        switch result {
        case .success(_):
            XCTFail("Result should not be a success.")
        case .failure(let errorDescription, let data, let statusCode):
            XCTAssertEqual(statusCode, 404)
            XCTAssertEqual(errorDescription, "Response status code was unacceptable: 404.")
            XCTAssertNotNil(data)
        }
    }
}
