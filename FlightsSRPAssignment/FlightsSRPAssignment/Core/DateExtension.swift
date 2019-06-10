//
//  DateExtension.swift
//  FlightsSRPAssignment
//
//  Created by Satyam Sehgal on 09/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

extension Date {
    init(milliseconds: Double) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
    
    static func dateinHHmmStringFormat(milliseconds: Double?) -> String {
        let dateFormatter = getDateFormatter()
        // To convert the date into an HH:mm format
        dateFormatter.dateFormat = "HH:mm"
        return stringFromDate (milliseconds: milliseconds, dateFormatter: dateFormatter)
    }
    
    private static func getDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH.mm.ss"
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.locale = Locale.current
        return formatter
    }
    
    private static func stringFromDate(milliseconds: Double?, dateFormatter: DateFormatter) -> String {
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        guard let milliseconds = milliseconds else { return StringConstants.emptyString }
        let date = Date(milliseconds: milliseconds)
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
