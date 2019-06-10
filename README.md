# FlightSRPAssignment

FlightSRP Assignment 
 
Problem statement Fetch data from "https://www.ixigo.com/sampleFlightData" and show them in list


Install and Run - As no pods are used so download and run it 

Architecture

Code structure has been divided like Three folders - Core , Network Layer, Presentation Layer
Followed MVVM Architecture along with object oriented along with Solid principles: 
DomesticFlightSRPViewController- Contains all UI stuff related code.
FlightSRPResponseModel - Conforms codable protocol
Network Layer - Tried to use of generics and singleton pattern
Applied all possible sorting logics and applied animations



Unit Testing 
 Cover all possible test cases in the project

FlightSRPResponseModelTests.swift - Tested initialization of FlightSRPResponseModel
 -  testViewModelIntialisation()
NetworkLayerTest.swift -  Tested the api call for both success and failure cases
testFetchFlightServiceSuccess()
testFetchFlightServiceFailure()

3. DomesticFlightCellModelTests - testGetTripDurationSuccess() and testGetTripDurationFailure()







 

