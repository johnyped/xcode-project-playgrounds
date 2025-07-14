//
//  BookingChannelServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest

final class BookingChannelServiceRequestTests: XCTestCase {
    
    func testFetchChannelRequest() throws {
        // Given
        let request = BookingChannelServiceRequest.FetchChannel(id: 1)
        
        // Then
        XCTAssertEqual(request.id, 1)
    }
    
    func testCreateChannelRequest() throws {
        // Given
        let request = BookingChannelServiceRequest.CreateChannel(
            name: "Phone Booking",
            feeRate: 5.0
        )
        
        // When
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Then
        XCTAssertEqual(json?["name"] as? String, "Phone Booking")
        XCTAssertEqual(json?["fee_rate"] as? Double, 5.0)
    }
    
    func testCreateChannelCodingKeys() throws {
        // Given
        let request = BookingChannelServiceRequest.CreateChannel(
            name: "Direct Booking",
            feeRate: 2.5
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json?["name"])
        XCTAssertNotNil(json?["fee_rate"])
        XCTAssertNil(json?["feeRate"]) // Should use snake_case
    }
    
    func testUpdateChannelRequest() throws {
        // Given
        let request = BookingChannelServiceRequest.UpdateChannel(
            id: 1,
            name: "Updated OTA",
            feeRate: 12.0
        )
        
        // When
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Then
        XCTAssertEqual(json?["name"] as? String, "Updated OTA")
        XCTAssertEqual(json?["fee_rate"] as? Double, 12.0)
        XCTAssertNil(json?["id"]) // ID should not be encoded
    }
    
    func testUpdateChannelCodingKeys() throws {
        // Given
        let request = BookingChannelServiceRequest.UpdateChannel(
            id: 1,
            name: "Updated Channel",
            feeRate: nil
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json?["name"])
        XCTAssertNil(json?["feeRate"]) // Should use snake_case
        XCTAssertNil(json?["id"])
    }
    
    func testDeleteChannelRequest() throws {
        // Given
        let request = BookingChannelServiceRequest.DeleteChannel(id: 3)
        
        // Then
        XCTAssertEqual(request.id, 3)
    }
    
    func testCreateSubChannelRequest() throws {
        // Given
        let request = BookingChannelServiceRequest.CreateSubChannel(
            channelId: 1,
            name: "Expedia",
            feeRate: 10.0
        )
        
        // When
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Then
        XCTAssertEqual(json?["name"] as? String, "Expedia")
        XCTAssertEqual(json?["fee_rate"] as? Double, 10.0)
        XCTAssertNil(json?["channelId"]) // channelId should not be encoded
    }
    
    func testCreateSubChannelCodingKeys() throws {
        // Given
        let request = BookingChannelServiceRequest.CreateSubChannel(
            channelId: 1,
            name: "Booking.com",
            feeRate: 15.0
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json?["name"])
        XCTAssertNotNil(json?["fee_rate"])
        XCTAssertNil(json?["feeRate"]) // Should use snake_case
        XCTAssertNil(json?["channelId"])
    }
    
    func testUpdateSubChannelRequest() throws {
        // Given
        let request = BookingChannelServiceRequest.UpdateSubChannel(
            channelId: 1,
            subChannelId: 101,
            name: "Updated Booking.com",
            feeRate: 18.0
        )
        
        // When
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Then
        XCTAssertEqual(json?["name"] as? String, "Updated Booking.com")
        XCTAssertEqual(json?["fee_rate"] as? Double, 18.0)
        XCTAssertNil(json?["channelId"]) // channelId should not be encoded
        XCTAssertNil(json?["subChannelId"]) // subChannelId should not be encoded
    }
    
    func testUpdateSubChannelCodingKeys() throws {
        // Given
        let request = BookingChannelServiceRequest.UpdateSubChannel(
            channelId: 1,
            subChannelId: 101,
            name: "Updated Channel",
            feeRate: nil
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json?["name"])
        XCTAssertNil(json?["feeRate"]) // Should use snake_case
        XCTAssertNil(json?["channelId"])
        XCTAssertNil(json?["subChannelId"])
    }
    
    func testDeleteSubChannelRequest() throws {
        // Given
        let request = BookingChannelServiceRequest.DeleteSubChannel(
            channelId: 1,
            subChannelId: 101
        )
        
        // Then
        XCTAssertEqual(request.channelId, 1)
        XCTAssertEqual(request.subChannelId, 101)
    }
    
    func testFetchSubChannelsRequest() throws {
        // Given
        let request = BookingChannelServiceRequest.FetchSubChannels(id: 1)
        
        // Then
        XCTAssertEqual(request.id, 1)
    }
} 
