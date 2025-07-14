//
//  RoomTypeServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//

import XCTest

final class RoomTypeServiceRequestTests: XCTestCase {
    
    func testFetchRoomTypesRequest() throws {
        // Given
        let request = RoomTypeServiceRequest.FetchRoomTypes(hotelId: 123)
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Then
        XCTAssertEqual(json?["hotel_id"] as? Int, 123)
    }
    
    func testCreateRoomTypeRequest_WithAllParameters() throws {
        // Given
        let request = RoomTypeServiceRequest.CreateRoomType(
            hotelId: 123,
            name: "Executive Room",
            baseRate: 2000.0,
            baseGuestNumber: 2,
            extraBedRate: 600.0,
            extraGuestRate: 350.0,
            maxExtraBedNumber: 1,
            maxExtraGuestNumber: 2,
            limitedNumberOfCmUnits: 8,
            description: "Executive business room"
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Then
        XCTAssertEqual(json?["hotel_id"] as? Int, 123)
        XCTAssertEqual(json?["name"] as? String, "Executive Room")
        XCTAssertEqual(json?["base_rate"] as? String, "2000.0")
        XCTAssertEqual(json?["base_guest_number"] as? Int, 2)
        XCTAssertEqual(json?["extra_bed_rate"] as? String, "600.0")
        XCTAssertEqual(json?["extra_guest_rate"] as? String, "350.0")
        XCTAssertEqual(json?["max_extra_bed_number"] as? Int, 1)
        XCTAssertEqual(json?["max_extra_guest_number"] as? Int, 2)
        XCTAssertEqual(json?["limited_number_of_cm_units"] as? Int, 8)
        XCTAssertEqual(json?["description"] as? String, "Executive business room")
    }
    
    func testUpdateRoomTypesOrderRequest() throws {
        // Given
        let request = RoomTypeServiceRequest.UpdateRoomTypesOrder(
            hotelId: 123,
            roomTypeOrders: [
                RoomTypeServiceRequest.UpdateRoomTypesOrder.RoomTypeOrder(roomTypeId: 1, order: 0),
                RoomTypeServiceRequest.UpdateRoomTypesOrder.RoomTypeOrder(roomTypeId: 2, order: 1),
                RoomTypeServiceRequest.UpdateRoomTypesOrder.RoomTypeOrder(roomTypeId: 3, order: 2)
            ]
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Then
        XCTAssertEqual(json?["hotel_id"] as? Int, 123)
        
        let roomTypeOrders = json?["room_type_orders"] as? [[String: Any]]
        XCTAssertNotNil(roomTypeOrders)
        XCTAssertEqual(roomTypeOrders?.count, 3)
        
        // Check first order
        let firstOrder = roomTypeOrders?.first
        XCTAssertEqual(firstOrder?["room_type_id"] as? Int, 1)
        XCTAssertEqual(firstOrder?["order"] as? Int, 0)
    }
} 