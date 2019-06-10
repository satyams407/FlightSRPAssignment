//
//  FlightSRPModel.swift
//  FlightsSRPAssignment
//
//  Created by Satyam Sehgal on 09/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

// MARK: FlightSRPResponseModel
struct FlightSRPResponseModel: Codable {
    let airlineMap: AirlineMap
    let airportMap: AirportMap
    let flightsData: [FlightsData]
}

// MARK: AirlineMap
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

// MARK: AirportMap
struct AirportMap: Codable {
    let del, mum: String
    
    enum CodingKeys: String, CodingKey {
        case del = "DEL"
        case mum = "MUM"
    }
}

// MARK: FlightsData
struct FlightsData: Codable {
    let originCode, destinationCode, takeoffTime, landingTime, price, airlineCode, classType: String
    
    enum CodingKeys: String, CodingKey {
        case originCode, destinationCode, takeoffTime, landingTime, price, airlineCode
        case classType = "class"
    }
}

extension FlightsData {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        originCode = try container.decode(String.self, forKey: .originCode)
        destinationCode = try container.decode(String.self, forKey: .destinationCode)
        airlineCode = try container.decode(String.self, forKey: .airlineCode)
        price = try container.decode(String.self, forKey: .price)
        classType = try container.decode(String.self, forKey: .classType)
        takeoffTime = try container.decode(String.self, forKey: .takeoffTime)
        landingTime = try container.decode(String.self, forKey: .landingTime)
    }
}

