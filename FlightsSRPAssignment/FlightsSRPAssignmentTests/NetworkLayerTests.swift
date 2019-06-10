//
//  NetworkLayerTests.swift
//  FlightsSRPAssignmentTests
//
//  Created by Satyam Sehgal on 10/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import XCTest
@testable import FlightsSRPAssignment

class MockFetchFlightSearchService: FetchFlightSearchServiceProtocol {
    var responseJSONString: [String: Any]?
    func fetchFlightData(with endPoint: FetchEndPoint, completionHandler: @escaping (Result<FlightSRPResponseModel, APIServiceError>) -> Void) {
        guard let responseString = responseJSONString, let data = try? JSONSerialization.data(withJSONObject: responseString, options: []) else {
            completionHandler(.failure(.fetchError))
            return
        }
        guard let responseModel = try? JSONDecoder().decode(FlightSRPResponseModel.self, from: data) else {
            completionHandler(.failure(.decodeError))
            return
        }
        completionHandler(.success(responseModel))
    }
}

class NetworkLayerTests: XCTestCase {
   var mockFetchFlightService: MockFetchFlightSearchService?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchFlightServiceSuccess() {
        mockFetchFlightService?.responseJSONString =  [
            "airlineMap": [
                "SJ": "Spicejet",
                "AI": "Air India",
                "G8": "Go Air",
                "JA": "Jet Airways",
                "IN": "Indigo"
            ],
            "airportMap": [
                "DEL": "New Delhi",
                "MUM": "Mumbai"
            ],
            "flightsData": [
                [
                    "originCode": "DEL",
                    "destinationCode": "MUM",
                    "takeoffTime": "1396614600000",
                    "landingTime": "1396625400000",
                    "price": "11500",
                    "airlineCode": "G8",
                    "class": "Business"
                ],
            ]
        ]
        mockFetchFlightService?.fetchFlightData(with: .fetchFlight, completionHandler: {
            (result) in
            var isNetWorkResultSuccess = false
            switch result {
            case .success(_):
                isNetWorkResultSuccess = true
            case .failure(_):
                isNetWorkResultSuccess = false
            }
            XCTAssert(isNetWorkResultSuccess == true , "Failed")
        })
    }
    
    func testFetchFlightServiceFailure() {
        mockFetchFlightService?.responseJSONString = nil
        mockFetchFlightService?.fetchFlightData(with: .fetchFlight) { (result) in
            var networkFailureError : APIServiceError?
            switch result {
            case .success(_):
                networkFailureError = nil
            case .failure(let error):
                networkFailureError = error
            }
            XCTAssert(networkFailureError == APIServiceError.fetchError , "Failed")
        }
    }
}
