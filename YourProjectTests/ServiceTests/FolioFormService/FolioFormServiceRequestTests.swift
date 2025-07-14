//
//  FolioFormServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 13/6/2568 BE.
//

import XCTest

final class FolioFormServiceRequestTests: XCTestCase {
    
    func testFetchByHotelRequest_WillGenerateCorrectParameters() {
        // Given
        let request = FolioFormServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // When
        guard let parameters = request.parameters else {
            XCTFail("Parameters should not be nil")
            return
        }
        
        // Then
        XCTAssertEqual(parameters["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters["page"] as? Int, 1)
        XCTAssertEqual(parameters["per_page"] as? String, "20")
        XCTAssertEqual(parameters["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters["sorted_order"] as? String, "ASC")
    }
    
    func testFetchByHotelRequest_WithNilValues_WillGenerateMinimalParameters() {
        // Given
        let request = FolioFormServiceRequest.FetchByHotel(
            hotelId: 105,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // When
        guard let parameters = request.parameters else {
            XCTFail("Parameters should not be nil")
            return
        }
        
        // Then
        XCTAssertEqual(parameters["hotel_id"] as? Int, 105)
        XCTAssertNil(parameters["page"])
        XCTAssertNil(parameters["per_page"])
        XCTAssertNil(parameters["sorted_by"])
        XCTAssertNil(parameters["sorted_order"])
    }
    
    func testFetchByHotelRequest_WithInvalidPage_WillExcludePageParameter() {
        // Given
        let request = FolioFormServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 0, // Invalid page
            perPage: .ten,
            sortedBy: .createdAt,
            sortedOrder: .descending
        )
        
        // When
        guard let parameters = request.parameters else {
            XCTFail("Parameters should not be nil")
            return
        }
        
        // Then
        XCTAssertEqual(parameters["hotel_id"] as? Int, 105)
        XCTAssertNil(parameters["page"]) // Should be excluded because page < 1
        XCTAssertEqual(parameters["per_page"] as? String, "10")
        XCTAssertEqual(parameters["sorted_by"] as? String, "CREATED_AT")
        XCTAssertEqual(parameters["sorted_order"] as? String, "DESC")
    }
    
    func testFetchByQueryRequest_WillGenerateCorrectParameters() {
        // Given
        let request = FolioFormServiceRequest.FetchByQuery(
            hotelId: 105,
            query: "test query",
            page: 2,
            perPage: .ten,
            sortedBy: .createdAt,
            sortedOrder: .descending
        )
        
        // When
        guard let parameters = request.parameters else {
            XCTFail("Parameters should not be nil")
            return
        }
        
        // Then
        XCTAssertEqual(parameters["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters["query"] as? String, "test query")
        XCTAssertEqual(parameters["page"] as? Int, 2)
        XCTAssertEqual(parameters["per_page"] as? String, "10")
        XCTAssertEqual(parameters["sorted_by"] as? String, "CREATED_AT")
        XCTAssertEqual(parameters["sorted_order"] as? String, "DESC")
    }
    
    func testFetchByPeriodRequest_WillGenerateCorrectParameters() {
        // Given
        let startDate = Date(timeIntervalSince1970: 1704067200) // 2024-01-01
        let endDate = Date(timeIntervalSince1970: 1735689600) // 2025-01-01
        let period = PeriodDate(start: startDate, end: endDate)
        
        let request = FolioFormServiceRequest.FetchByPeriod(
            hotelId: 105,
            period: period,
            page: 1,
            perPage: .fifty,
            sortedBy: .updatedAt,
            sortedOrder: .ascending
        )
        
        // When
        guard let parameters = request.parameters else {
            XCTFail("Parameters should not be nil")
            return
        }
        
        // Then
        XCTAssertEqual(parameters["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters["start_date"] as? String, "2024-01-01")
        XCTAssertEqual(parameters["end_date"] as? String, "2025-01-01")
        XCTAssertEqual(parameters["page"] as? Int, 1)
        XCTAssertEqual(parameters["per_page"] as? String, "50")
        XCTAssertEqual(parameters["sorted_by"] as? String, "UPDATED_AT")
        XCTAssertEqual(parameters["sorted_order"] as? String, "ASC")
    }
    
    func testFetchByReservationRequest_WillGenerateCorrectParameters() {
        // Given
        let request = FolioFormServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 512,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // When
        guard let parameters = request.parameters else {
            XCTFail("Parameters should not be nil")
            return
        }
        
        // Then
        XCTAssertEqual(parameters["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters["reservation_id"] as? Int, 512)
        XCTAssertEqual(parameters["page"] as? Int, 1)
        XCTAssertEqual(parameters["per_page"] as? String, "20")
        XCTAssertEqual(parameters["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters["sorted_order"] as? String, "ASC")
    }
    
    func testCreateFolioFormReservationRequest_WillGenerateCorrectBody() throws {
        // Given
        let request = FolioFormServiceRequest.CreateFolioFormReservation(
            hotelId: 105,
            reservationId: 179,
            hotelContactId: 8,
            customerContactId: 6,
            vatIncluded: false,
            remark: "test remark",
            internalNote: "test internal note",
            paymentInfo: "2, 2 (111-1-11111-2)",
            groupRoomCharge: true,
            groupAdditionalItem: false
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
        XCTAssertEqual(json?["reservation_id"] as? Int, 179)
        XCTAssertEqual(json?["hotel_contact_id"] as? Int, 8)
        XCTAssertEqual(json?["customer_contact_id"] as? Int, 6)
        XCTAssertEqual(json?["vat_included"] as? Bool, false)
        XCTAssertEqual(json?["remark"] as? String, "test remark")
        XCTAssertEqual(json?["internal_note"] as? String, "test internal note")
        XCTAssertEqual(json?["payment_info"] as? String, "2, 2 (111-1-11111-2)")
        XCTAssertEqual(json?["group_room_charge"] as? Bool, true)
        XCTAssertEqual(json?["group_additional_item"] as? Bool, false)
    }
    
    func testCreateFolioFormReservationRequest_WithNilValues_WillGenerateCorrectBody() throws {
        // Given
        let request = FolioFormServiceRequest.CreateFolioFormReservation(
            hotelId: 105,
            reservationId: 179,
            hotelContactId: 8,
            customerContactId: 6,
            vatIncluded: true,
            remark: nil,
            internalNote: nil,
            paymentInfo: "payment info",
            groupRoomCharge: false,
            groupAdditionalItem: true
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
        XCTAssertEqual(json?["reservation_id"] as? Int, 179)
        XCTAssertEqual(json?["hotel_contact_id"] as? Int, 8)
        XCTAssertEqual(json?["customer_contact_id"] as? Int, 6)
        XCTAssertEqual(json?["vat_included"] as? Bool, true)
        XCTAssertEqual(json?["payment_info"] as? String, "payment info")
        XCTAssertEqual(json?["group_room_charge"] as? Bool, false)
        XCTAssertEqual(json?["group_additional_item"] as? Bool, true)
        // Nil values should not be present in JSON
        XCTAssertNil(json?["remark"])
        XCTAssertNil(json?["internal_note"])
    }
    
    func testUpdateFolioFormRequest_WillGenerateCorrectBody() throws {
        // Given
        let request = FolioFormServiceRequest.UpdateFolioForm(
            id: 1,
            hotelContactId: 9,
            customerContactId: 7,
            remark: "updated remark",
            internalNote: "updated internal note",
            paymentInfo: "updated payment info",
            groupRoomCharge: false,
            groupAdditionalItem: true
        )
        
        // When
        guard let body = request.body else {
            XCTFail()
            return
        }
        
        // Then
        let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any]
        
        XCTAssertNotNil(json)
        // id should not be in the JSON body as it's used in URL path
        XCTAssertNil(json?["id"])
        XCTAssertEqual(json?["hotel_contact_id"] as? Int, 9)
        XCTAssertEqual(json?["customer_contact_id"] as? Int, 7)
        XCTAssertEqual(json?["remark"] as? String, "updated remark")
        XCTAssertEqual(json?["internal_note"] as? String, "updated internal note")
        XCTAssertEqual(json?["payment_info"] as? String, "updated payment info")
        XCTAssertEqual(json?["group_room_charge"] as? Bool, false)
        XCTAssertEqual(json?["group_additional_item"] as? Bool, true)
    }
    
    func testUpdateFolioFormRequest_WithAllNilValues_WillGenerateEmptyBody() throws {
        // Given
        let request = FolioFormServiceRequest.UpdateFolioForm(
            id: 1,
            hotelContactId: nil,
            customerContactId: nil,
            remark: nil,
            internalNote: nil,
            paymentInfo: nil,
            groupRoomCharge: nil,
            groupAdditionalItem: nil
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
        
        // All optional fields should be absent
        XCTAssertNil(json?["hotel_contact_id"])
        XCTAssertNil(json?["customer_contact_id"])
        XCTAssertNil(json?["remark"])
        XCTAssertNil(json?["internal_note"])
        XCTAssertNil(json?["payment_info"])
        XCTAssertNil(json?["group_room_charge"])
        XCTAssertNil(json?["group_additional_item"])
    }
    
    // MARK: - ByID Tests
    
    func testFetchById_WillHaveCorrectId() {
        // Given
        let request = FolioFormServiceRequest.FetchById(id: 12345)
        
        // When/Then
        XCTAssertEqual(request.id, 12345)
    }
    
    // MARK: - SortedBy Enum Tests
    
    func testSortedBy_WillHaveCorrectRawValues() {
        XCTAssertEqual(FolioFormServiceRequest.SortedBy.id.rawValue, "ID")
        XCTAssertEqual(FolioFormServiceRequest.SortedBy.createdAt.rawValue, "CREATED_AT")
        XCTAssertEqual(FolioFormServiceRequest.SortedBy.updatedAt.rawValue, "UPDATED_AT")
    }
} 
