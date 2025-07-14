//
//  BlackoutServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 5/7/2568 BE.
//

import XCTest

final class BlackoutServiceRequestTests: XCTestCase {
    
    // MARK: - FetchByPeriod Tests
    
    func testFetchByPeriod_WillGenerateCorrectParameters() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1716926400) // 2024-05-29
        let endDate = Date(timeIntervalSince1970: 1717012800) // 2024-05-30
        let period = PeriodDate(start: startDate, end: endDate)
        
        let request = BlackoutServiceRequest.FetchByPeriod(
            hotelId: 105,
            period: period,
            page: 1,
            perPage: .twenty,
            sortedBy: .createdAt,
            sortedOrder: .descending
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["start_date"] as? String, "2024-05-29")
        XCTAssertEqual(parameters?["end_date"] as? String, "2024-05-30")
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "CREATED_AT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    func testFetchByPeriod_WithNilOptionalValues_WillGenerateMinimalParameters() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1716926400) // 2024-05-29
        let endDate = Date(timeIntervalSince1970: 1717012800) // 2024-05-30
        let period = PeriodDate(start: startDate, end: endDate)
        
        let request = BlackoutServiceRequest.FetchByPeriod(
            hotelId: 105,
            period: period,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["start_date"] as? String, "2024-05-29")
        XCTAssertEqual(parameters?["end_date"] as? String, "2024-05-30")
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
    }
    
    func testFetchByPeriod_WithInvalidPage_WillExcludePageParameter() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1716926400) // 2024-05-29
        let endDate = Date(timeIntervalSince1970: 1717012800) // 2024-05-30
        let period = PeriodDate(start: startDate, end: endDate)
        
        let request = BlackoutServiceRequest.FetchByPeriod(
            hotelId: 105,
            period: period,
            page: 0, // Invalid page
            perPage: .ten,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNil(parameters?["page"]) // Should be excluded because page < 1
        XCTAssertEqual(parameters?["per_page"] as? String, "10")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    // MARK: - CreateBlackoutUnit Tests
    
    func testCreateBlackoutUnit_WillGenerateCorrectBody() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1716926400) // 2024-05-29
        let endDate = Date(timeIntervalSince1970: 1717012800) // 2024-05-30
        let period = PeriodDate(start: startDate, end: endDate)
        
        let request = BlackoutServiceRequest.CreateBlackoutUnit(
            hotelId: 105,
            unitableId: 620,
            unitableType: .room,
            period: period,
            removesDate: nil,
            note: "Test blackout unit",
            emoji: "🚫",
            quantity: 1
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
        XCTAssertEqual(json?["unitable_id"] as? Int, 620)
        XCTAssertEqual(json?["unitable_type"] as? String, "ROOM")
        XCTAssertEqual(json?["start_date"] as? String, "2024-05-29")
        XCTAssertEqual(json?["end_date"] as? String, "2024-05-30")
        XCTAssertNil(json?["removes_date"])
        XCTAssertEqual(json?["note"] as? String, "Test blackout unit")
        XCTAssertEqual(json?["emoji"] as? String, "🚫")
        XCTAssertEqual(json?["quantity"] as? Int, 1)
    }
    
    func testCreateBlackoutUnit_WithNilValues_WillGenerateCorrectBody() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1716926400) // 2024-05-29
        let endDate = Date(timeIntervalSince1970: 1717012800) // 2024-05-30
        let period = PeriodDate(start: startDate, end: endDate)
        
        let request = BlackoutServiceRequest.CreateBlackoutUnit(
            hotelId: 105,
            unitableId: 620,
            unitableType: .room,
            period: period,
            removesDate: nil, // Nil removes date
            note: nil, // Nil note
            emoji: nil, // Nil emoji
            quantity: 1
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
        XCTAssertEqual(json?["unitable_id"] as? Int, 620)
        XCTAssertEqual(json?["unitable_type"] as? String, "ROOM")
        XCTAssertEqual(json?["start_date"] as? String, "2024-05-29")
        XCTAssertEqual(json?["end_date"] as? String, "2024-05-30")
        XCTAssertNil(json?["removes_date"]) // Should be nil
        XCTAssertNil(json?["note"]) // Should be nil
        XCTAssertNil(json?["emoji"]) // Should be nil
        XCTAssertEqual(json?["quantity"] as? Int, 1)
    }
    
    // MARK: - UpdateBlackoutUnit Tests
    
    func testUpdateBlackoutUnit_WillGenerateCorrectBody() throws {
        // Given
        let removesDate = Date(timeIntervalSince1970: 1717099200) // 2024-05-31
        
        let request = BlackoutServiceRequest.UpdateBlackoutUnit(
            id: 172,
            note: "Updated blackout unit",
            emoji: "⚠️",
            removesDate: removesDate        
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
        XCTAssertEqual(json?["note"] as? String, "Updated blackout unit")
        XCTAssertEqual(json?["emoji"] as? String, "⚠️")
        XCTAssertEqual(json?["removes_date"] as? String, "2024-05-31")
    }
    
    func testUpdateBlackoutUnit_WithAllNilValues_WillGenerateEmptyBody() throws {
        // Given
        let request = BlackoutServiceRequest.UpdateBlackoutUnit(
            id: 172,
            note: nil,
            emoji: nil,
            removesDate: nil
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
        XCTAssertNil(json?["note"])
        XCTAssertNil(json?["emoji"])
        XCTAssertNil(json?["removes_date"])
    }
    
    // MARK: - BatchCreateBlackoutUnits Tests
    
    func testBatchCreateBlackoutUnits_WillGenerateCorrectBody() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1716926400) // 2024-05-29
        let endDate = Date(timeIntervalSince1970: 1717012800) // 2024-05-30
        let period = PeriodDate(start: startDate, end: endDate)
        
        let blackoutUnit1 = BlackoutServiceRequest.BatchBlackoutUnit(
            unitableId: 620,
            unitableType: .room,
            period: period,
            removesDate: nil,
            note: "Batch test 1",
            emoji: nil,
            quantity: 1
        )
        
        let blackoutUnit2 = BlackoutServiceRequest.BatchBlackoutUnit(
            unitableId: 621,
            unitableType: .room,
            period: period,
            removesDate: nil,
            note: "Batch test 2",
            emoji: nil,
            quantity: 1
        )
        
        let request = BlackoutServiceRequest.BatchCreateBlackoutUnits(
            hotelId: 105,
            blackoutUnits: [blackoutUnit1, blackoutUnit2]
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
        XCTAssertNotNil(json?["blackout_units"])
        
        let blackoutUnitsArray = json?["blackout_units"] as? [[String: Any]]
        XCTAssertEqual(blackoutUnitsArray?.count, 2)
        
        // Check first blackout unit
        let firstUnit = blackoutUnitsArray?[0]
        XCTAssertEqual(firstUnit?["unitable_id"] as? Int, 620)
        XCTAssertEqual(firstUnit?["unitable_type"] as? String, "ROOM")
        XCTAssertEqual(firstUnit?["start_date"] as? String, "2024-05-29")
        XCTAssertEqual(firstUnit?["end_date"] as? String, "2024-05-30")
        XCTAssertEqual(firstUnit?["note"] as? String, "Batch test 1")
        XCTAssertEqual(firstUnit?["quantity"] as? Int, 1)
        
        // Check second blackout unit
        let secondUnit = blackoutUnitsArray?[1]
        XCTAssertEqual(secondUnit?["unitable_id"] as? Int, 621)
        XCTAssertEqual(secondUnit?["unitable_type"] as? String, "ROOM")
        XCTAssertEqual(secondUnit?["start_date"] as? String, "2024-05-29")
        XCTAssertEqual(secondUnit?["end_date"] as? String, "2024-05-30")
        XCTAssertEqual(secondUnit?["note"] as? String, "Batch test 2")
        XCTAssertEqual(secondUnit?["quantity"] as? Int, 1)
    }
    
    // MARK: - BatchDeleteBlackoutUnits Tests
    
    func testBatchDeleteBlackoutUnits_WillGenerateCorrectParameters() throws {
        // Given
        let request = BlackoutServiceRequest.BatchDeleteBlackoutUnits(
            hotelId: 105,
            ids: [172, 173, 174]
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["blackout_unit_ids"] as? [Int], [172, 173, 174])
    }
    
    // MARK: - ByID Tests
    
    func testFetchById_WillHaveCorrectId() {
        // Given
        let request = BlackoutServiceRequest.FetchById(id: 172)
        
        // When/Then
        XCTAssertEqual(request.id, 172)
    }
    
    func testDeleteBlackoutUnit_WillHaveCorrectId() {
        // Given
        let request = BlackoutServiceRequest.DeleteBlackoutUnit(id: 172)
        
        // When/Then
        XCTAssertEqual(request.id, 172)
    }
    
    // MARK: - SortedBy Enum Tests
    
    func testSortedBy_WillHaveCorrectRawValues() {
        XCTAssertEqual(BlackoutServiceRequest.SortedBy.id.rawValue, "ID")
        XCTAssertEqual(BlackoutServiceRequest.SortedBy.startDate.rawValue, "START_DATE")
        XCTAssertEqual(BlackoutServiceRequest.SortedBy.endDate.rawValue, "END_DATE")
        XCTAssertEqual(BlackoutServiceRequest.SortedBy.createdAt.rawValue, "CREATED_AT")
        XCTAssertEqual(BlackoutServiceRequest.SortedBy.updatedAt.rawValue, "UPDATED_AT")
    }
} 