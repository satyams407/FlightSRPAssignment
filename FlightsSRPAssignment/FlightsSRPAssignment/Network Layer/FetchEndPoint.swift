//
//  FetchEndPoint.swift
//  FlightsSRPAssignment
//
//  Created by Satyam Sehgal on 08/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

// Can have mutilple cases for fetch request for different api calls
enum FetchEndPoint {
    case fetchFlight
}

extension FetchEndPoint {
    var baseURL: URL {
        guard let url = URL(string: AppURLConstants.basefetchURL) else {
            fatalError("url can't be made right now")
        }
        return url
    }
    
    var httpMethod: AppConstants.HTTPMethod {
        return .get
    }
}
