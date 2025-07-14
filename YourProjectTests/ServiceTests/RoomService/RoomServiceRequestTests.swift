//
//  RoomServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest

final class RoomServiceRequestTests: XCTestCase {
    
    func testFetchRoomsRequest() throws {
        // Given
        let request = RoomServiceRequest.FetchRooms(
            hotelId: 105,
            roomTypeId: 201
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["room_type_id"] as? Int, 201)
    }
    
    func testFetchRoomRequest() throws {
        // Given
        let request = RoomServiceRequest.FetchRoom(id: 1)
        
        // Then
        XCTAssertEqual(request.id, 1)
    }
    
    func testCreateRoomRequest() throws {
        // Given
        let request = RoomServiceRequest.CreateRoom(
            code: "102",
            roomTypeId: 201,
            hotelId: 105
        )
        
        // When
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Then
        XCTAssertEqual(json?["code"] as? String, "102")
        XCTAssertEqual(json?["room_type_id"] as? Int, 201)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
    }
    
    func testCreateRoomCodingKeys() throws {
        // Given
        let request = RoomServiceRequest.CreateRoom(
            code: "102",
            roomTypeId: 201,
            hotelId: 105
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json?["code"])
        XCTAssertNotNil(json?["room_type_id"])
        XCTAssertNotNil(json?["hotel_id"])
        XCTAssertNil(json?["roomTypeId"])
        XCTAssertNil(json?["hotelId"])
    }
    
    func testUpdateRoomRequest() throws {
        // Given
        let request = RoomServiceRequest.UpdateRoom(
            id: 1,
            code: "101A",
            status: "unavailable", 
            needCleaning: true
        )
        
        // When
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Then
        XCTAssertEqual(json?["code"] as? String, "101A")
        XCTAssertEqual(json?["status"] as? String, "unavailable")
        XCTAssertEqual(json?["need_cleaning"] as? Bool, true)
        XCTAssertNil(json?["id"]) // ID should not be encoded
    }
    
    func testUpdateRoomCodingKeys() throws {
        // Given
        let request = RoomServiceRequest.UpdateRoom(
            id: 1,
            code: "101A",
            status: "unavailable",
            needCleaning: true
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json?["code"])
        XCTAssertNotNil(json?["status"])
        XCTAssertNotNil(json?["need_cleaning"])
        XCTAssertNil(json?["needCleaning"])
        XCTAssertNil(json?["id"])
    }
    
    func testDeleteRoomRequest() throws {
        // Given
        let request = RoomServiceRequest.DeleteRoom(id: 3)
        
        // Then
        XCTAssertEqual(request.id, 3)
    }
    
    func testChangeRoomTypeRequest() throws {
        // Given
        let request = RoomServiceRequest.ChangeRoomType(
            id: 1,
            roomTypeId: 501
        )
        
        // When
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Then
        XCTAssertEqual(json?["room_type_id"] as? Int, 501)
        XCTAssertNil(json?["id"]) // ID should not be encoded
    }
    
    func testChangeRoomTypeCodingKeys() throws {
        // Given
        let request = RoomServiceRequest.ChangeRoomType(
            id: 1,
            roomTypeId: 501
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json?["room_type_id"])
        XCTAssertNil(json?["roomTypeId"])
        XCTAssertNil(json?["id"])
    }
    
    func testUpdateRoomsOrderRequest() throws {
        // Given
        let request = RoomServiceRequest.UpdateRoomsOrder(
            hotelId: 105,
            roomOrders: [
                RoomServiceRequest.UpdateRoomsOrder.RoomOrder(roomId: 1, order: 1),
                RoomServiceRequest.UpdateRoomsOrder.RoomOrder(roomId: 2, order: 2),
                RoomServiceRequest.UpdateRoomsOrder.RoomOrder(roomId: 3, order: 3)
            ]
        )
        
        // When
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Then
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        let roomOrders = json?["room_orders"] as? [[String: Any]]
        XCTAssertEqual(roomOrders?.count, 3)
        XCTAssertEqual(roomOrders?.first?["room_id"] as? Int, 1)
        XCTAssertEqual(roomOrders?.first?["order"] as? Int, 1)
    }
    
    func testUpdateRoomsOrderCodingKeys() throws {
        // Given
        let request = RoomServiceRequest.UpdateRoomsOrder(
            hotelId: 105,
            roomOrders: [
                RoomServiceRequest.UpdateRoomsOrder.RoomOrder(roomId: 1, order: 1),
                RoomServiceRequest.UpdateRoomsOrder.RoomOrder(roomId: 2, order: 2)
            ]
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json?["hotel_id"])
        XCTAssertNotNil(json?["room_orders"])
        XCTAssertNil(json?["hotelId"])
        XCTAssertNil(json?["roomOrders"])
        
        let roomOrders = json?["room_orders"] as? [[String: Any]]
        XCTAssertNotNil(roomOrders?.first?["room_id"])
        XCTAssertNotNil(roomOrders?.first?["order"])
        XCTAssertNil(roomOrders?.first?["roomId"])
    }
    
    func testBatchCreateRoomsRequest() throws {
        // Given
        let request = RoomServiceRequest.BatchCreateRooms(
            hotelId: 105,
            rooms: [
                RoomServiceRequest.BatchCreateRooms.BatchRoom(code: "201", roomTypeId: 201),
                RoomServiceRequest.BatchCreateRooms.BatchRoom(code: "301", roomTypeId: 301)
            ]
        )
        
        // When
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Then
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        let rooms = json?["rooms"] as? [[String: Any]]
        XCTAssertEqual(rooms?.count, 2)
        XCTAssertEqual(rooms?.first?["code"] as? String, "201")
        XCTAssertEqual(rooms?.first?["room_type_id"] as? Int, 201)
        XCTAssertEqual(rooms?.last?["code"] as? String, "301")
        XCTAssertEqual(rooms?.last?["room_type_id"] as? Int, 301)
    }
    
    func testBatchCreateRoomsCodingKeys() throws {
        // Given
        let request = RoomServiceRequest.BatchCreateRooms(
            hotelId: 105,
            rooms: [
                RoomServiceRequest.BatchCreateRooms.BatchRoom(code: "201", roomTypeId: 201)
            ]
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json?["hotel_id"])
        XCTAssertNotNil(json?["rooms"])
        XCTAssertNil(json?["hotelId"])
        
        let rooms = json?["rooms"] as? [[String: Any]]
        XCTAssertNotNil(rooms?.first?["code"])
        XCTAssertNotNil(rooms?.first?["room_type_id"])
        XCTAssertNil(rooms?.first?["roomTypeId"])
    }
    
    func testBatchDeleteRoomsRequest() throws {
        // Given
        let request = RoomServiceRequest.BatchDeleteRooms(
            hotelId: 105,
            roomIds: [10, 11, 12]
        )
        
        // When
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Then
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        let roomIds = json?["room_ids"] as? [Int]
        XCTAssertEqual(roomIds?.count, 3)
        XCTAssertEqual(roomIds, [10, 11, 12])
    }
    
    func testBatchDeleteRoomsCodingKeys() throws {
        // Given
        let request = RoomServiceRequest.BatchDeleteRooms(
            hotelId: 105,
            roomIds: [10, 11, 12]
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json?["hotel_id"])
        XCTAssertNotNil(json?["room_ids"])
        XCTAssertNil(json?["hotelId"])
        XCTAssertNil(json?["roomIds"])
    }
}
