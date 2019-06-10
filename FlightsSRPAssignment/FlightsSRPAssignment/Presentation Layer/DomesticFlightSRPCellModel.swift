//
//  DomesticFlightSRPCellModel.swift
//  FlightsSRPAssignment
//
//  Created by Satyam Sehgal on 09/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

class DomesticFlightSRPCellModel {
    let originCode, destinationCode, price, takeoffTime, landingTime, airlineCode, classType: String
    
    required init(with data: FlightsData) {
        self.originCode = data.originCode
        self.destinationCode = data.destinationCode
        self.takeoffTime = data.takeoffTime
        self.landingTime = data.landingTime
        self.price = data.price
        self.airlineCode = data.airlineCode
        self.classType = data.classType
    }
    
    static func getTripDuration(from takeOffTime: String, arrivalTime: String) -> String {
        let difference = (Double(arrivalTime) ?? 0.0) - (Double(takeOffTime) ?? 0.0)
        let dateInHHMM = Date.dateinHHmmStringFormat(milliseconds: difference)
        let componentArray = dateInHHMM.split(separator: ":")
        let hrComponent = componentArray.first
        let minComponent = componentArray.last
        return "\(hrComponent ?? "")h \(minComponent ?? "")m"
    }
    
    static func formatDate(from str: String) -> String? {
        var dateInHhmmFormat: String?
        if let doubleValue = Double(str) {
            dateInHhmmFormat = Date.dateinHHmmStringFormat(milliseconds: doubleValue)
        }
        return dateInHhmmFormat
    }
}
