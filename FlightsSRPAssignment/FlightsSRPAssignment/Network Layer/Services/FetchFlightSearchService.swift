//
//  FetchFlightSearchService.swift
//  FlightsSRPAssignment
//
//  Created by Satyam Sehgal on 08/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

struct FetchFlightSearchService: FetchFlightSearchServiceProtocol {
    
    func fetchFlightData(with endPoint: FetchEndPoint, completionHandler:@escaping (Result<FlightSRPResponseModel, APIServiceError>) -> Void) {
        NetworkRequest.sharedInstance.executeRequest(buildRequest(endPoint: endPoint)) { result in
            switch result {
            case.failure(let apiError) :
                completionHandler(.failure(apiError))
            case .success(let data):
                if let flightSRPResponseModel = try? JSONDecoder().decode(FlightSRPResponseModel.self, from: data) {
                    completionHandler(.success(flightSRPResponseModel))
                } else {
                    completionHandler(.failure(.decodeError))
                }
            }
        }
    }
}
