//
//  AllotmentServiceRouterTests.swift
//  YourProject
//
//  Created by IntrodexMini on 7/1/2568 BE.
//

import XCTest

final class AllotmentServiceRouterTests: XCTestCase {
    
    func testFetchByUnitTypeRouter_WillHaveCorrectParameters() throws {
        // Given
        let period = PeriodDate(start: Date(timeIntervalSince1970: 1577836800), // 2020-01-01
                               end: Date(timeIntervalSince1970: 1578009600)) // 2020-01-03
        let request = AllotmentServiceRequest.FetchByUnitType(
            hotelId: 105,
            unitTypeId: 179,
            unitType: .roomType,
            period: period,
            unitIds: [642, 643]
        )
        
        // When
        let router = AllotmentServiceRouter.fetchByUnitType(request: request)
        
        // Then
        XCTAssertEqual(router.domain, AppConfiguration.shared.baseURL)
        XCTAssertEqual(router.path, "/v4/allotments/unit-type")
        XCTAssertEqual(router.method, .get)
        
        guard let parameters = router.parameters else {
            XCTFail("Parameters should not be nil")
            return
        }
        
        XCTAssertEqual(parameters["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters["unit_type_id"] as? Int, 179)
        XCTAssertEqual(parameters["unit_type"] as? String, "ROOM_TYPE")
        XCTAssertEqual(parameters["start_date"] as? String, "2020-01-01")
        XCTAssertEqual(parameters["end_date"] as? String, "2020-01-03")
        XCTAssertEqual(parameters["unit_ids"] as? [Int], [642, 643])
    }
    
    func testFetchByUnitTypeRouter_WithNilUnitIds_WillHaveCorrectParameters() throws {
        // Given
        let period = PeriodDate(start: Date(timeIntervalSince1970: 1577836800), // 2020-01-01
                               end: Date(timeIntervalSince1970: 1578009600)) // 2020-01-03
        let request = AllotmentServiceRequest.FetchByUnitType(
            hotelId: 105,
            unitTypeId: 179,
            unitType: .roomType,
            period: period,
            unitIds: nil
        )
        
        // When
        let router = AllotmentServiceRouter.fetchByUnitType(request: request)
        
        // Then
        guard let parameters = router.parameters else {
            XCTFail("Parameters should not be nil")
            return
        }
        
        XCTAssertEqual(parameters["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters["unit_type_id"] as? Int, 179)
        XCTAssertEqual(parameters["unit_type"] as? String, "ROOM_TYPE")
        XCTAssertEqual(parameters["start_date"] as? String, "2020-01-01")
        XCTAssertEqual(parameters["end_date"] as? String, "2020-01-03")
        XCTAssertNil(parameters["unit_ids"])
    }
    
    func testFetchByMonthRouter_WillHaveCorrectParameters() throws {
        // Given
        let month = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let request = AllotmentServiceRequest.FetchByMonth(
            hotelId: 105,
            month: month
        )
        
        // When
        let router = AllotmentServiceRouter.fetchByMonth(request: request)
        
        // Then
        XCTAssertEqual(router.domain, AppConfiguration.shared.baseURL)
        XCTAssertEqual(router.path, "/v4/allotments/month")
        XCTAssertEqual(router.method, .get)
        
        guard let parameters = router.parameters else {
            XCTFail("Parameters should not be nil")
            return
        }
        
        XCTAssertEqual(parameters["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters["month"] as? String, "2020-01")
    }
    
    func testFetchByUnitTypeRouter_URLRequest_WillBeCreatedCorrectly() throws {
        // Given
        let period = PeriodDate(start: Date(timeIntervalSince1970: 1577836800), // 2020-01-01
                               end: Date(timeIntervalSince1970: 1578009600)) // 2020-01-03
        let request = AllotmentServiceRequest.FetchByUnitType(
            hotelId: 105,
            unitTypeId: 179,
            unitType: .roomType,
            period: period,
            unitIds: [642, 643]
        )
        let router = AllotmentServiceRouter.fetchByUnitType(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertNotNil(urlRequest.url)
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems
        
        XCTAssertTrue(queryItems?.contains { $0.name == "hotel_id" && $0.value == "105" } ?? false)
        XCTAssertTrue(queryItems?.contains { $0.name == "unit_type_id" && $0.value == "179" } ?? false)
        XCTAssertTrue(queryItems?.contains { $0.name == "unit_type" && $0.value == "ROOM_TYPE" } ?? false)
        XCTAssertTrue(queryItems?.contains { $0.name == "start_date" && $0.value == "2020-01-01" } ?? false)
        XCTAssertTrue(queryItems?.contains { $0.name == "end_date" && $0.value == "2020-01-03" } ?? false)
    }
    
    func testFetchByMonthRouter_URLRequest_WillBeCreatedCorrectly() throws {
        // Given
        let month = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let request = AllotmentServiceRequest.FetchByMonth(
            hotelId: 105,
            month: month
        )
        let router = AllotmentServiceRouter.fetchByMonth(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertNotNil(urlRequest.url)
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems
        
        XCTAssertTrue(queryItems?.contains { $0.name == "hotel_id" && $0.value == "105" } ?? false)
        XCTAssertTrue(queryItems?.contains { $0.name == "month" && $0.value == "2020-01" } ?? false)
    }
} 
