//
//  CMBookingServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//

import XCTest

final class CMBookingServiceRequestTests: XCTestCase {
    
    // MARK: - FetchByHotel Tests
    
    func testFetchByHotel_WillGenerateCorrectParameters() throws {
        // Given
        let request = CMBookingServiceRequest.FetchByHotel(
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
        let request = CMBookingServiceRequest.FetchByHotel(
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
        let request = CMBookingServiceRequest.FetchByHotel(
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
        let startDate = Date(timeIntervalSince1970: 1714129200) // 2025-04-26T20:20:00+07:00 equivalent
        let endDate = Date(timeIntervalSince1970: 1714215600) // 2025-04-27T20:20:00+07:00 equivalent
        
        let request = CMBookingServiceRequest.FetchByPeriod(
            hotelId: 105,
            period: .init(start: startDate,
                          end: endDate),
            includedAcknowledged: true,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNotNil(parameters?["start_at"]) // Should contain ISO datetime format
        XCTAssertNotNil(parameters?["end_at"]) // Should contain ISO datetime format
        XCTAssertEqual(parameters?["included_acknowledged"] as? Bool, true)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func testFetchByPeriod_WithNilOptionalValues_WillGenerateMinimalParameters() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1714129200)
        let endDate = Date(timeIntervalSince1970: 1714215600)
        
        let request = CMBookingServiceRequest.FetchByPeriod(
            hotelId: 105,
            period: .init(start: startDate,
                          end: endDate),
            includedAcknowledged: nil,
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
        XCTAssertNotNil(parameters?["start_at"])
        XCTAssertNotNil(parameters?["end_at"])
        XCTAssertNil(parameters?["included_acknowledged"])
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
    }
    
    // MARK: - FetchByStatus Tests
    
    func testFetchByStatus_WillGenerateCorrectParameters() throws {
        // Given
        let request = CMBookingServiceRequest.FetchByStatus(
            hotelId: 105,
            status: .confirmed,
            includedAcknowledged: false,
            page: 1,
            perPage: .twenty,
            sortedBy: .updatedAt,
            sortedOrder: .descending
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["status"] as? String, "1")
        XCTAssertEqual(parameters?["included_acknowledged"] as? Bool, false)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "UPDATED_AT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    // MARK: - FetchByKeyword Tests
    
    func testFetchByKeyword_WillGenerateCorrectParameters() throws {
        // Given
        let request = CMBookingServiceRequest.FetchByKeyword(
            hotelId: 105,
            keyword: "THA",
            includedAcknowledged: true,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["keyword"] as? String, "THA")
        XCTAssertEqual(parameters?["included_acknowledged"] as? Bool, true)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    // MARK: - FetchBatch Tests
    
    func testFetchBatch_WillGenerateCorrectParameters() throws {
        // Given
        let request = CMBookingServiceRequest.FetchByBatchIds(
            hotelId: 105,
            ids: [1, 2, 3, 4, 5]
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["ids"] as? String, "1,2,3,4,5")
    }
    
    // MARK: - BatchAcknowledge Tests
    
    func testBatchAcknowledge_WillGenerateCorrectBody() throws {
        // Given
        let request = CMBookingServiceRequest.BatchAcknowledge(
            hotelId: 105,
            ids: [1, 2, 3]
        )
        
        // When
        guard let body = request.body else {
            XCTFail("Body should not be nil")
            return
        }
        
        // Then
        let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["cm_booking_ids"] as? [Int], [1, 2, 3])
    }
    
    // MARK: - Sync Tests
    
    func testSync_WillGenerateCorrectBody() throws {
        // Given
        let request = CMBookingServiceRequest.Sync(hotelId: 105)
        
        // When
        guard let body = request.body else {
            XCTFail("Body should not be nil")
            return
        }
        
        // Then
        let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
    }
    
    // MARK: - ByID Tests
    
    func testFetchById_WillHaveCorrectId() {
        // Given
        let request = CMBookingServiceRequest.FetchById(id: 12345)
        
        // When/Then
        XCTAssertEqual(request.id, 12345)
    }
    
    func testAcknowledge_WillHaveCorrectId() {
        // Given
        let request = CMBookingServiceRequest.Acknowledge(id: 67890)
        
        // When/Then
        XCTAssertEqual(request.id, 67890)
    }
    
    // MARK: - SortedBy Enum Tests
    
    func testSortedBy_WillHaveCorrectRawValues() {
        XCTAssertEqual(CMBookingServiceRequest.SortedBy.id.rawValue, "ID")
        XCTAssertEqual(CMBookingServiceRequest.SortedBy.createdAt.rawValue, "CREATED_AT")
        XCTAssertEqual(CMBookingServiceRequest.SortedBy.updatedAt.rawValue, "UPDATED_AT")
    }
} 
