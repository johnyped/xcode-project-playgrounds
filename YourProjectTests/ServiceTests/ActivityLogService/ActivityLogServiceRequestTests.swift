//
//  ActivityLogServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 1/7/2568 BE.
//

import XCTest

final class ActivityLogServiceRequestTests: XCTestCase {
    
    // MARK: - FetchCreatorByFinancialRecord Tests
    
    func testFetchCreatorByFinancialRecord_WillGenerateCorrectParameters() throws {
        // Given
        let request = ActivityLogServiceRequest.FetchCreatorByFinancialRecord(
            hotelId: 105,
            financialRecordId: 440
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["financial_record_id"] as? Int, 440)
    }
    
    // MARK: - FetchCreatorByReservation Tests
    
    func testFetchCreatorByReservation_WillGenerateCorrectParameters() throws {
        // Given
        let request = ActivityLogServiceRequest.FetchCreatorByReservation(
            hotelId: 105,
            reservationId: 273
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["reservation_id"] as? Int, 273)
    }
    
    // MARK: - FetchCreatorByAdditional Tests
    
    func testFetchCreatorByAdditional_WillGenerateCorrectParameters() throws {
        // Given
        let request = ActivityLogServiceRequest.FetchCreatorByAdditional(
            hotelId: 105,
            additionalId: 273
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["additional_id"] as? Int, 273)
    }
    
    // MARK: - FetchCreatorByAccount Tests
    
    func testFetchCreatorByAccount_WillGenerateCorrectParameters() throws {
        // Given
        let request = ActivityLogServiceRequest.FetchCreatorByAccount(
            hotelId: 105,
            accountId: 1
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["account_id"] as? Int, 1)
    }
    
    // MARK: - FetchCreatorByAccountItem Tests
    
    func testFetchCreatorByAccountItem_WillGenerateCorrectParameters() throws {
        // Given
        let request = ActivityLogServiceRequest.FetchCreatorByAccountItem(
            hotelId: 105,
            accountItemId: 1
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["account_item_id"] as? Int, 1)
    }
    
    // MARK: - Edge Cases Tests
    
    func testFetchCreatorByFinancialRecord_WithDifferentValues_WillGenerateCorrectParameters() throws {
        // Given
        let request = ActivityLogServiceRequest.FetchCreatorByFinancialRecord(
            hotelId: 42,
            financialRecordId: 999
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 42)
        XCTAssertEqual(parameters?["financial_record_id"] as? Int, 999)
    }
    
    func testFetchCreatorByReservation_WithLargeIds_WillGenerateCorrectParameters() throws {
        // Given
        let request = ActivityLogServiceRequest.FetchCreatorByReservation(
            hotelId: 999999,
            reservationId: 123456789
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 999999)
        XCTAssertEqual(parameters?["reservation_id"] as? Int, 123456789)
    }
    
    func testFetchCreatorByAccountItem_WithMinimalValues_WillGenerateCorrectParameters() throws {
        // Given
        let request = ActivityLogServiceRequest.FetchCreatorByAccountItem(
            hotelId: 1,
            accountItemId: 1
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 1)
        XCTAssertEqual(parameters?["account_item_id"] as? Int, 1)
    }
} 