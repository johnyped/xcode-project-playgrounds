//
//  BookingChannelServiceRouterTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest
import Alamofire
import Mockable

final class BookingChannelServiceRouterTests: XCTestCase {
    
    var baseURL: String!
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()
    
    override func setUp() {
        super.setUp()
        baseURL = AppConfiguration.shared.baseURL
    }
    
    func testFetchChannelsRequest() throws {
        // Given
        let router = BookingChannelServiceRouter.fetchChannels
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/channels") == true)
                
    }
    
    func testFetchChannelRequest() throws {
        // Given
        let request = BookingChannelServiceRequest.FetchChannel(id: 1)
        let router = BookingChannelServiceRouter.fetchChannel(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/channels/1") == true)
    }
    
    func testCreateChannelRequest() throws {
        // Given
        let request = BookingChannelServiceRequest.CreateChannel(
            name: "Phone Booking",
            feeRate: 5.0
        )
        let router = BookingChannelServiceRouter.createChannel(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/channels") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Check JSON body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["name"] as? String, "Phone Booking")
            XCTAssertEqual(json?["fee_rate"] as? Double, 5.0)
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testUpdateChannelRequest() throws {
        // Given
        let request = BookingChannelServiceRequest.UpdateChannel(
            id: 1,
            name: "Updated OTA",
            feeRate: 12.0
        )
        let router = BookingChannelServiceRouter.updateChannel(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/channels/1") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Check JSON body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["name"] as? String, "Updated OTA")
            XCTAssertEqual(json?["fee_rate"] as? Double, 12.0)
            XCTAssertNil(json?["id"]) // ID should not be in the body since it's in the URL
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testDeleteChannelRequest() throws {
        // Given
        let request = BookingChannelServiceRequest.DeleteChannel(id: 3)
        let router = BookingChannelServiceRouter.deleteChannel(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "DELETE")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/channels/3") == true)
    }
    
    func testFetchSubChannelsRequest() throws {
        // Given
        let request = BookingChannelServiceRequest.FetchSubChannels(id: 1)
        let router = BookingChannelServiceRouter.fetchSubChannels(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/channels/1/sub-channels") == true)
    }
    
    func testCreateSubChannelRequest() throws {
        // Given
        let request = BookingChannelServiceRequest.CreateSubChannel(
            channelId: 1,
            name: "Expedia",
            feeRate: 10.0
        )
        let router = BookingChannelServiceRouter.createSubChannel(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/channels/1/sub-channels") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Check JSON body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["name"] as? String, "Expedia")
            XCTAssertEqual(json?["fee_rate"] as? Double, 10.0)
            XCTAssertNil(json?["channelId"]) // channelId should not be in the body since it's in the URL
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testUpdateSubChannelRequest() throws {
        // Given
        let request = BookingChannelServiceRequest.UpdateSubChannel(
            channelId: 1,
            subChannelId: 101,
            name: "Updated Booking.com",
            feeRate: 18.0
        )
        let router = BookingChannelServiceRouter.updateSubChannel(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/channels/1/sub-channels/101") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Check JSON body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["name"] as? String, "Updated Booking.com")
            XCTAssertEqual(json?["fee_rate"] as? Double, 18.0)
            XCTAssertNil(json?["channelId"]) // channelId should not be in the body since it's in the URL
            XCTAssertNil(json?["subChannelId"]) // subChannelId should not be in the body since it's in the URL
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testDeleteSubChannelRequest() throws {
        // Given
        let request = BookingChannelServiceRequest.DeleteSubChannel(
            channelId: 1,
            subChannelId: 101
        )
        let router = BookingChannelServiceRouter.deleteSubChannel(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "DELETE")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/channels/1/sub-channels/101") == true)
    }
} 
