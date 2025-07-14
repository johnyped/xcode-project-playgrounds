//
//  RoomTypeServiceRouterTests.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//

import XCTest
import Alamofire
import Mockable

final class RoomTypeServiceRouterTests: XCTestCase {
    
    var baseURL: String!
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()
    
    override func setUp() {
        super.setUp()
        baseURL = AppConfiguration.shared.baseURL
    }
    
    func testFetchRoomTypesRequest() throws {
        // Given
        let request = RoomTypeServiceRequest.FetchRoomTypes(hotelId: 123)
        let router = RoomTypeServiceRouter.fetchRoomTypes(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/room-types") == true)
        
        // Check for hotel_id parameter
        let urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        let hotelIdItem = queryItems.first { $0.name == "hotel_id" }
        XCTAssertEqual(hotelIdItem?.value, "123")
    }
    
    func testFetchRoomTypeRequest() throws {
        // Given
        let request = RoomTypeServiceRequest.FetchRoomType(id: 1)
        let router = RoomTypeServiceRouter.fetchRoomType(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/room-types/1") == true)
    }
    
    func testCreateRoomTypeRequest() throws {
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
        let router = RoomTypeServiceRouter.createRoomType(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/room-types") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Check JSON body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
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
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testUpdateRoomTypeRequest() throws {
        // Given
        let request = RoomTypeServiceRequest.UpdateRoomType(
            id: 1,
            name: "Updated Executive Room",
            baseRate: 2200.0,
            baseGuestNumber: 2,
            extraBedRate: 650.0,
            extraGuestRate: 380.0,
            maxExtraBedNumber: 1,
            maxExtraGuestNumber: 2,
            limitedNumberOfCmUnits: 10,
            description: "Updated executive business room"
        )
        let router = RoomTypeServiceRouter.updateRoomType(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/room-types/1") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Check JSON body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["name"] as? String, "Updated Executive Room")
            XCTAssertEqual(json?["base_rate"] as? String, "2200.0")
            XCTAssertEqual(json?["base_guest_number"] as? Int, 2)
            XCTAssertEqual(json?["extra_bed_rate"] as? String, "650.0")
            XCTAssertEqual(json?["extra_guest_rate"] as? String, "380.0")
            XCTAssertEqual(json?["max_extra_bed_number"] as? Int, 1)
            XCTAssertEqual(json?["max_extra_guest_number"] as? Int, 2)
            XCTAssertEqual(json?["limited_number_of_cm_units"] as? Int, 10)
            XCTAssertEqual(json?["description"] as? String, "Updated executive business room")
            XCTAssertNil(json?["id"]) // ID should not be in the body since it's in the URL
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testDeleteRoomTypeRequest() throws {
        // Given
        let request = RoomTypeServiceRequest.DeleteRoomType(id: 3)
        let router = RoomTypeServiceRouter.deleteRoomType(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "DELETE")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/room-types/3") == true)
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
        let router = RoomTypeServiceRouter.updateRoomTypesOrder(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/room-types/update-order") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Check JSON body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["hotel_id"] as? Int, 123)
            
            let roomTypeOrders = json?["room_type_orders"] as? [[String: Any]]
            XCTAssertNotNil(roomTypeOrders)
            XCTAssertEqual(roomTypeOrders?.count, 3)
            
            // Check first order
            let firstOrder = roomTypeOrders?.first
            XCTAssertEqual(firstOrder?["room_type_id"] as? Int, 1)
            XCTAssertEqual(firstOrder?["order"] as? Int, 0)
            
            // Check second order
            let secondOrder = roomTypeOrders?[1]
            XCTAssertEqual(secondOrder?["room_type_id"] as? Int, 2)
            XCTAssertEqual(secondOrder?["order"] as? Int, 1)
            
            // Check third order
            let thirdOrder = roomTypeOrders?.last
            XCTAssertEqual(thirdOrder?["room_type_id"] as? Int, 3)
            XCTAssertEqual(thirdOrder?["order"] as? Int, 2)
        } else {
            XCTFail("Request should have a body")
        }
    }
} 
