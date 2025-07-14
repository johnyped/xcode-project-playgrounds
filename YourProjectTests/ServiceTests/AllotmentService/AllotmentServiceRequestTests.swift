//
//  AllotmentServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 7/1/2568 BE.
//

import XCTest

final class AllotmentServiceRequestTests: XCTestCase {
    
    // MARK: - FetchByUnitType Tests
    
    func testFetchByUnitType_WillGenerateCorrectParameters() throws {
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
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["unit_type_id"] as? Int, 179)
        XCTAssertEqual(parameters?["unit_type"] as? String, "ROOM_TYPE")
        XCTAssertEqual(parameters?["start_date"] as? String, "2020-01-01")
        XCTAssertEqual(parameters?["end_date"] as? String, "2020-01-03")
        XCTAssertEqual(parameters?["unit_ids"] as? [Int], [642, 643])
    }
    
    func testFetchByUnitType_WithNilUnitIds_WillGenerateCorrectParameters() throws {
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
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["unit_type_id"] as? Int, 179)
        XCTAssertEqual(parameters?["unit_type"] as? String, "ROOM_TYPE")
        XCTAssertEqual(parameters?["start_date"] as? String, "2020-01-01")
        XCTAssertEqual(parameters?["end_date"] as? String, "2020-01-03")
        XCTAssertNil(parameters?["unit_ids"])
    }
    
    func testFetchByUnitType_WithEmptyUnitIds_WillGenerateCorrectParameters() throws {
        // Given
        let period = PeriodDate(start: Date(timeIntervalSince1970: 1577836800), // 2020-01-01
                               end: Date(timeIntervalSince1970: 1578009600)) // 2020-01-03
        let request = AllotmentServiceRequest.FetchByUnitType(
            hotelId: 105,
            unitTypeId: 179,
            unitType: .roomType,
            period: period,
            unitIds: []
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["unit_type_id"] as? Int, 179)
        XCTAssertEqual(parameters?["unit_type"] as? String, "ROOM_TYPE")
        XCTAssertEqual(parameters?["start_date"] as? String, "2020-01-01")
        XCTAssertEqual(parameters?["end_date"] as? String, "2020-01-03")
        XCTAssertEqual(parameters?["unit_ids"] as? [Int], [])
    }
    
    // MARK: - FetchByMonth Tests
    
    func testFetchByMonth_WillGenerateCorrectParameters() throws {
        // Given
        let month = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let request = AllotmentServiceRequest.FetchByMonth(
            hotelId: 105,
            month: month
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["month"] as? String, "2020-01")
    }
    
    func testFetchByMonth_WithDifferentMonth_WillGenerateCorrectParameters() throws {
        // Given
        let month = Date(timeIntervalSince1970: 1593550800) // 2020-07-01
        let request = AllotmentServiceRequest.FetchByMonth(
            hotelId: 105,
            month: month
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["month"] as? String, "2020-07")
    }
    
    // MARK: - Date Format Tests
    
    func testFetchByUnitType_WithDifferentDates_WillFormatCorrectly() throws {
        // Given
        let period = PeriodDate(start: Date(timeIntervalSince1970: 1609459200), // 2021-01-01
                               end: Date(timeIntervalSince1970: 1609632000)) // 2021-01-03
        let request = AllotmentServiceRequest.FetchByUnitType(
            hotelId: 105,
            unitTypeId: 179,
            unitType: .roomType,
            period: period,
            unitIds: nil
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["start_date"] as? String, "2021-01-01")
        XCTAssertEqual(parameters?["end_date"] as? String, "2021-01-03")
    }
    
    func testFetchByMonth_WithDifferentYear_WillFormatCorrectly() throws {
        // Given
        let month = Date(timeIntervalSince1970: 1640995200) // 2022-01-01
        let request = AllotmentServiceRequest.FetchByMonth(
            hotelId: 105,
            month: month
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["month"] as? String, "2022-01")
    }
    
    // MARK: - Hotel ID Tests
    
    func testFetchByUnitType_WithDifferentHotelId_WillGenerateCorrectParameters() throws {
        // Given
        let period = PeriodDate(start: Date(timeIntervalSince1970: 1577836800), // 2020-01-01
                               end: Date(timeIntervalSince1970: 1578009600)) // 2020-01-04
        let request = AllotmentServiceRequest.FetchByUnitType(
            hotelId: 999,
            unitTypeId: 179,
            unitType: .roomType,
            period: period,
            unitIds: nil
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 999)
    }
    
    func testFetchByMonth_WithDifferentHotelId_WillGenerateCorrectParameters() throws {
        // Given
        let month = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let request = AllotmentServiceRequest.FetchByMonth(
            hotelId: 999,
            month: month
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 999)
    }
} 
