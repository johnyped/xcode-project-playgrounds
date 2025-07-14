//
//  FinancialRecordServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 13/6/2568 BE.
//

import XCTest

final class FinancialRecordServiceRequestTests: XCTestCase {
    
    // MARK: - FetchByHotel Tests
    
    func testFetchByHotel_WillGenerateCorrectParameters() throws {
        // Given
        let request = FinancialRecordServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 2,
            perPage: .fifty,
            sortedBy: .createdAt,
            sortedOrder: .descending
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["page"] as? Int, 2)
        XCTAssertEqual(parameters?["per_page"] as? String, "50")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "CREATED_AT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    func testFetchByHotel_WithNilOptionalValues_WillGenerateMinimalParameters() throws {
        // Given
        let request = FinancialRecordServiceRequest.FetchByHotel(
            hotelId: 1,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 1)
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
    }
    
    func testFetchByHotel_WithInvalidPage_WillExcludePageParameter() throws {
        // Given
        let request = FinancialRecordServiceRequest.FetchByHotel(
            hotelId: 1,
            page: 0, // Invalid page
            perPage: .ten,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 1)
        XCTAssertNil(parameters?["page"]) // Should be excluded because page < 1
        XCTAssertEqual(parameters?["per_page"] as? String, "10")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    // MARK: - FetchByPeriod Tests
    
    func testFetchByPeriod_WillGenerateCorrectParameters() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let endDate = Date(timeIntervalSince1970: 1609459200) // 2021-01-01
        let period = PeriodDate(start: startDate, end: endDate)
        
        let request = FinancialRecordServiceRequest.FetchByPeriod(
            hotelId: 1,
            period: period,
            page: 1,
            perPage: .hundred,
            sortedBy: .updatedAt,
            sortedOrder: .ascending
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 1)
        XCTAssertEqual(parameters?["start_date"] as? String, "2020-01-01")
        XCTAssertEqual(parameters?["end_date"] as? String, "2021-01-01")
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "100")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "UPDATED_AT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    // MARK: - FetchByReservation Tests
    
    func testFetchByReservation_WillGenerateCorrectParameters() throws {
        // Given
        let request = FinancialRecordServiceRequest.FetchByReservation(
            hotelId: 2,
            reservationId: 1234,
            page: 3,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .descending
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 2)
        XCTAssertEqual(parameters?["reservation_id"] as? Int, 1234)
        XCTAssertEqual(parameters?["page"] as? Int, 3)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    // MARK: - FetchByCreatedAt Tests
    
    func testFetchByCreatedAt_WillGenerateCorrectParameters() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1714129200) // 2025-04-26 equivalent
        let endDate = Date(timeIntervalSince1970: 1714215600) // 2025-04-27 equivalent
        let periodDate = PeriodDate(start: startDate, end: endDate)
        
        let request = FinancialRecordServiceRequest.FetchByCreatedAt(
            hotelId: 3,
            periodDate: periodDate,
            page: 1,
            perPage: .fifty,
            sortedBy: .createdAt,
            sortedOrder: .ascending
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 3)
        XCTAssertNotNil(parameters?["start_at"]) // Should contain ISO datetime format
        XCTAssertNotNil(parameters?["end_at"]) // Should contain ISO datetime format
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "50")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "CREATED_AT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    // MARK: - FetchByAccountItem Tests
    
    func testFetchByAccountItem_WillGenerateCorrectParameters() throws {
        // Given
        let request = FinancialRecordServiceRequest.FetchByAccountItem(
            hotelId: 4,
            accountItemId: 567,
            page: 2,
            perPage: .ten,
            sortedBy: .updatedAt,
            sortedOrder: .descending
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 4)
        XCTAssertEqual(parameters?["account_item_id"] as? Int, 567)
        XCTAssertEqual(parameters?["page"] as? Int, 2)
        XCTAssertEqual(parameters?["per_page"] as? String, "10")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "UPDATED_AT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    // MARK: - CreateFinancialRecord Tests
    
    func testCreateFinancialRecord_WillGenerateCorrectBody() throws {
        // Given
        let timestamp = Date(timeIntervalSince1970: 1713254537)
        let request = FinancialRecordServiceRequest.CreateFinancialRecord(
            hotelId: 105,
            name: "Test Payment",
            paymentMethod: "Credit Card",
            note: "Test note",
            timestamp: timestamp,
            amount: 1250.50,
            recordableId: 1001,
            recordableType: .reservation,
            bankAccountId: 42
        )
        
        // When
        guard let body = request.body else {
            XCTFail()
            return
        }
        
        // Then
        
        // Decode the body to verify its contents
        let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["name"] as? String, "Test Payment")
        XCTAssertEqual(json?["payment_method"] as? String, "Credit Card")
        XCTAssertEqual(json?["note"] as? String, "Test note")
        XCTAssertEqual(json?["timestamp"] as? String, "2024-04-16T15:02:17.000+07:00")
        XCTAssertEqual(json?["amount"] as? String, "1250.5")
        XCTAssertEqual(json?["recordable_id"] as? Int, 1001)
        XCTAssertEqual(json?["recordable_type"] as? String, "RESERVATION")
        XCTAssertEqual(json?["bank_account_id"] as? Int, 42)
    }
    
    func testCreateFinancialRecord_WithNilValues_WillGenerateCorrectBody() throws {
        // Given
        let timestamp = Date()
        let request = FinancialRecordServiceRequest.CreateFinancialRecord(
            hotelId: 105,
            name: "Test Payment",
            paymentMethod: "Cash",
            note: nil, // Nil note
            timestamp: timestamp,
            amount: 100.0,
            recordableId: 1001,
            recordableType: .accountItem,
            bankAccountId: nil // Nil bank account
        )
        
        // When
        guard let body = request.body else {
            XCTFail()
            return
        }
        
        // Then
        let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any]
        
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["name"] as? String, "Test Payment")
        XCTAssertEqual(json?["payment_method"] as? String, "Cash")
        XCTAssertNil(json?["note"]) // Should be nil
        XCTAssertNotNil(json?["timestamp"]) // Should have timestamp
        XCTAssertEqual(json?["amount"] as? String, "100.0")
        XCTAssertEqual(json?["recordable_id"] as? Int, 1001)
        XCTAssertEqual(json?["recordable_type"] as? String, "ACCOUNT_ITEM")
        XCTAssertNil(json?["bank_account_id"]) // Should be nil
    }
    
    // MARK: - UpdateFinancialRecord Tests
    
    func testUpdateFinancialRecord_WillGenerateCorrectBody() throws {
        // Given
        let timestamp = Date(timeIntervalSince1970: 1713254537)
        let request = FinancialRecordServiceRequest.UpdateFinancialRecord(
            id: 439,
            name: "Updated Payment",
            paymentMethod: "Bank Transfer",
            note: "Updated note",
            timestamp: timestamp,
            amount: 2500.75,
            recordableId: 2002,
            recordableType: .additional,
            bankAccountId: 99
        )
        
        // When
        guard let body = request.body else {
            XCTFail()
            return
        }
        
        // Then
        let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any]
        
        XCTAssertNotNil(json)
        // Note: 'id' should not be in the body as it's used in URL path
        XCTAssertNil(json?["id"])
        XCTAssertEqual(json?["name"] as? String, "Updated Payment")
        XCTAssertEqual(json?["payment_method"] as? String, "Bank Transfer")
        XCTAssertEqual(json?["note"] as? String, "Updated note")
        XCTAssertEqual(json?["timestamp"] as? String, "2024-04-16T15:02:17.000+07:00")
        XCTAssertEqual(json?["amount"] as? String, "2500.75")
        XCTAssertEqual(json?["recordable_id"] as? Int, 2002)
        XCTAssertEqual(json?["recordable_type"] as? String, "ADDITIONAL")
        XCTAssertEqual(json?["bank_account_id"] as? Int, 99)
    }
    
    func testUpdateFinancialRecord_WithAllNilValues_WillGenerateEmptyBody() throws {
        // Given
        let request = FinancialRecordServiceRequest.UpdateFinancialRecord(
            id: 439,
            name: nil,
            paymentMethod: nil,
            note: nil,
            timestamp: nil,
            amount: nil,
            recordableId: nil,
            recordableType: nil,
            bankAccountId: nil
        )
        
        // When
        guard let body = request.body else {
            XCTFail()
            return
        }
        
        // Then
        let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any]
        
        XCTAssertNotNil(json)
        // Should not contain id as it's not encoded
        XCTAssertNil(json?["id"])
        
        // All optional fields should be absent or null
        XCTAssertNil(json?["name"])
        XCTAssertNil(json?["payment_method"])
        XCTAssertNil(json?["note"])
        XCTAssertNil(json?["timestamp"])
        XCTAssertNil(json?["amount"])
        XCTAssertNil(json?["recordable_id"])
        XCTAssertNil(json?["recordable_type"])
        XCTAssertNil(json?["bank_account_id"])
    }
    
    // MARK: - ByID Tests
    
    func testFetchById_WillHaveCorrectId() {
        // Given
        let request = FinancialRecordServiceRequest.FetchById(id: 12345)
        
        // When/Then
        XCTAssertEqual(request.id, 12345)
    }
    
    func testDeleteFinancialRecord_WillHaveCorrectId() {
        // Given
        let request = FinancialRecordServiceRequest.DeleteFinancialRecord(id: 67890)
        
        // When/Then
        XCTAssertEqual(request.id, 67890)
    }
    
    // MARK: - SortedBy Enum Tests
    
    func testSortedBy_WillHaveCorrectRawValues() {
        XCTAssertEqual(FinancialRecordServiceRequest.SortedBy.id.rawValue, "ID")
        XCTAssertEqual(FinancialRecordServiceRequest.SortedBy.createdAt.rawValue, "CREATED_AT")
        XCTAssertEqual(FinancialRecordServiceRequest.SortedBy.updatedAt.rawValue, "UPDATED_AT")
    }
} 
