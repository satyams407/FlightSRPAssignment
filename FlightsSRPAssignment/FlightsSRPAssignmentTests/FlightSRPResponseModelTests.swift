//
//  FlightSRPResponseModelTests.swift
//  FlightsSRPAssignmentTests
//
//  Created by Satyam Sehgal on 10/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import XCTest

@testable import FlightsSRPAssignment

struct MockFlightSRPResponseModel {
    struct FlightSRPResponseModel: Codable {
        let airlineMap: AirlineMap
        let airportMap: AirportMap
        let flightsData: [FlightsData]
    }
    struct AirlineMap: Codable {
        let sj, ai, g8, ja, indigo: String
        enum CodingKeys: String, CodingKey {
            case sj = "SJ"
            case ai = "AI"
            case g8 = "G8"
            case ja = "JA"
            case indigo = "IN"
        }
    }
    struct AirportMap: Codable {
        let DEL, MUM: String
    }
    struct FlightsData: Codable {
        let originCode, destinationCode, takeoffTime, landingTime, price, airlineCode, classType: String
        enum CodingKeys: String, CodingKey {
            case originCode, destinationCode, takeoffTime, landingTime, price, airlineCode
            case classType = "class"
        }
    }
}

class FlightSRPResponseModelTests: XCTestCase {
    var responseModel: MockFlightSRPResponseModel.FlightSRPResponseModel?
    override func setUp() {
    }

    override func tearDown() {
        responseModel = nil
    }

    func testResponseModelIntialation() {
        let json: [String: Any] = [
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
        var data: Data?
        do {
            data = try JSONSerialization.data(withJSONObject: json, options: [])
            responseModel = try JSONDecoder().decode(MockFlightSRPResponseModel.FlightSRPResponseModel.self, from: data!)
        } catch {
            XCTFail("Fail to decode the model")
        }
        XCTAssertTrue(responseModel != nil, "Succesfully initialise the model")
    }
}
