//
//  DomesticFlightCellModelTests.swift
//  FlightsSRPAssignmentTests
//
//  Created by Satyam Sehgal on 10/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import XCTest
@testable import FlightsSRPAssignment

class DomesticFlightCellModelTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetTripDurationSuccess() {
       let duration = DomesticFlightSRPCellModel.formatDate(from: "1234567")
       XCTAssertTrue(duration != nil)
    }
    
    func testGetTripDurationFailure() {
        let duration = DomesticFlightSRPCellModel.formatDate(from: "abcd")
        XCTAssertFalse(duration != nil)
    }

}
