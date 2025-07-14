//
//  RoomServiceRouterTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest
import Alamofire
import Mockable

final class RoomServiceRouterTests: XCTestCase {
    
    var baseURL: String!
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()
    
    override func setUp() {
        super.setUp()
        baseURL = AppConfiguration.shared.baseURL
    }
    
    func testFetchRoomsRequest() throws {
        // Given
        let request = RoomServiceRequest.FetchRooms(
            hotelId: 105,
            roomTypeId: 201
        )
        let router = RoomServiceRouter.fetchRooms(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/rooms") == true)
        
        // Check for parameters
        let urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        let hotelIdItem = queryItems.first { $0.name == "hotel_id" }
        let roomTypeIdItem = queryItems.first { $0.name == "room_type_id" }
        
        XCTAssertEqual(hotelIdItem?.value, "105")
        XCTAssertEqual(roomTypeIdItem?.value, "201")
    }
    
    func testFetchRoomRequest() throws {
        // Given
        let request = RoomServiceRequest.FetchRoom(id: 1)
        let router = RoomServiceRouter.fetchRoom(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/rooms/1") == true)
    }
    
    func testCreateRoomRequest() throws {
        // Given
        let request = RoomServiceRequest.CreateRoom(
            code: "102",
            roomTypeId: 201,
            hotelId: 105
        )
        let router = RoomServiceRouter.createRoom(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/rooms") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Check JSON body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["code"] as? String, "102")
            XCTAssertEqual(json?["room_type_id"] as? Int, 201)
            XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testUpdateRoomRequest() throws {
        // Given
        let request = RoomServiceRequest.UpdateRoom(
            id: 1,
            code: "101A",
            status: "unavailable",
            needCleaning: true
        )
        let router = RoomServiceRouter.updateRoom(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/rooms/1") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Check JSON body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["code"] as? String, "101A")
            XCTAssertEqual(json?["status"] as? String, "unavailable")
            XCTAssertEqual(json?["need_cleaning"] as? Bool, true)
            XCTAssertNil(json?["id"]) // ID should not be in the body since it's in the URL
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testDeleteRoomRequest() throws {
        // Given
        let request = RoomServiceRequest.DeleteRoom(id: 3)
        let router = RoomServiceRouter.deleteRoom(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "DELETE")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/rooms/3") == true)
    }
    
    func testChangeRoomTypeRequest() throws {
        // Given
        let request = RoomServiceRequest.ChangeRoomType(
            id: 1,
            roomTypeId: 501
        )
        let router = RoomServiceRouter.changeRoomType(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/rooms/1/change-room-type") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Check JSON body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["room_type_id"] as? Int, 501)
            XCTAssertNil(json?["id"]) // ID should not be in the body since it's in the URL
        } else {
            XCTFail("Request should have a body")
        }
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
        let router = RoomServiceRouter.updateRoomsOrder(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/rooms/update-order") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Check JSON body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["hotel_id"] as? Int, 105)
            let roomOrders = json?["room_orders"] as? [[String: Any]]
            XCTAssertEqual(roomOrders?.count, 3)
            XCTAssertEqual(roomOrders?.first?["room_id"] as? Int, 1)
            XCTAssertEqual(roomOrders?.first?["order"] as? Int, 1)
        } else {
            XCTFail("Request should have a body")
        }
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
        let router = RoomServiceRouter.batchCreateRooms(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/rooms/batch-create") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Check JSON body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["hotel_id"] as? Int, 105)
            let rooms = json?["rooms"] as? [[String: Any]]
            XCTAssertEqual(rooms?.count, 2)
            XCTAssertEqual(rooms?.first?["code"] as? String, "201")
            XCTAssertEqual(rooms?.first?["room_type_id"] as? Int, 201)
            XCTAssertEqual(rooms?.last?["code"] as? String, "301")
            XCTAssertEqual(rooms?.last?["room_type_id"] as? Int, 301)
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testBatchDeleteRoomsRequest() throws {
        // Given
        let request = RoomServiceRequest.BatchDeleteRooms(
            hotelId: 105,
            roomIds: [10, 11, 12]
        )
        let router = RoomServiceRouter.batchDeleteRooms(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "DELETE")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/rooms/batch-delete") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Check JSON body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["hotel_id"] as? Int, 105)
            let roomIds = json?["room_ids"] as? [Int]
            XCTAssertEqual(roomIds?.count, 3)
            XCTAssertEqual(roomIds, [10, 11, 12])
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testFetchRoomsRequestWithOptionalParameters() throws {
        // Given
        let req = RoomServiceRequest.FetchRooms(
            hotelId: 105,
            roomTypeId: 1
        )
        let router = RoomServiceRouter.fetchRooms(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        // Check base path
        XCTAssertTrue(url.absoluteString.contains(baseURL + "/v4/rooms"))
        
        // Check that only non-nil parameters are included
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        XCTAssertTrue(queryItems.contains { $0.name == "hotel_id" && $0.value == "105" })
        XCTAssertTrue(queryItems.contains { $0.name == "room_type_id" && $0.value == "1" })
    }
    
    func testCreateRoomRequestWithMinimalFields() throws {
        // Given
        let req = RoomServiceRequest.CreateRoom(
            code: "501",
            roomTypeId: 201,
            hotelId: 105
        )
        let router = RoomServiceRouter.createRoom(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/rooms")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.post.rawValue)
        
        // Test parameters
        if let body = urlRequest.httpBody {
            do {
                if let json = try JSONSerialization.jsonObject(with: body,
                                                               options: []) as? [String: Any] {
                    XCTAssertEqual(json["code"] as? String, "501")
                    XCTAssertEqual(json["room_type_id"] as? Int, 201)
                    XCTAssertEqual(json["hotel_id"] as? Int, 105)
                    
                } else {
                    XCTFail("JSON is not a dictionary")
                }
            } catch {
                XCTFail("Failed to parse JSON: \(error)")
            }
        } else {
            XCTFail("HTTP body is nil")
        }
    }
    
} 
