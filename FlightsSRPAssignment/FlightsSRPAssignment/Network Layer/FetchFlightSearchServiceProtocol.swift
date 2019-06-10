//
//  FetchFlightSearchServiceProtocol.swift
//  FlightsSRPAssignment
//
//  Created by Satyam Sehgal on 08/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

protocol FetchFlightSearchServiceProtocol {
    func fetchFlightData(with endPoint: FetchEndPoint, completionHandler: @escaping (Result<FlightSRPResponseModel, APIServiceError>) -> Void)
}

extension FetchFlightSearchServiceProtocol {
    func buildRequest(endPoint: FetchEndPoint) -> URLRequest {
        var request = URLRequest(url: endPoint.baseURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 15)
        request.httpMethod = endPoint.httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
