//
//  AppConstants.swift
//  FlightsSRPAssignment
//
//  Created by Satyam Sehgal on 08/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//


import Foundation
import UIKit

struct AppConstants {
    enum HTTPMethod : String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
    }
    
    enum StoryBoards: String {
        case main = "Main"
    }
    
    enum SortCriteriaType: String {
        case shortestFirst = "Shortest First"
        case leastPrice = "Least Price"
        case earlyDeparture = "Early Departure"
        case lateDeparture = "Late Departure"
    }
    
    static let disableStateBgColor = UIColor(red: 67/255, green: 67/255, blue: 67/255, alpha: 1.0)
    static let enableStateBgColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
    static let disableTextColor: UIColor =  .white
    static let enableTextColor: UIColor =  .black
}
