//
//  DeviceServiceRequestTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest


final class DeviceServiceRequestTests: XCTestCase {
    
    // MARK: - CreateDevice Tests
    
    func test_createDevice_encoding() throws {
        // Arrange
        let request = DeviceServiceRequest.CreateDevice(
            uuid: "test-uuid-123",
            token: "test-token-456"
        )
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let decodedData = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertEqual(decodedData?["uuid"] as? String, "test-uuid-123")
        XCTAssertEqual(decodedData?["token"] as? String, "test-token-456")
    }
    
    func test_createDevice_codingKeys() throws {
        // Arrange
        let request = DeviceServiceRequest.CreateDevice(
            uuid: "device-uuid",
            token: "device-token"
        )
        
        // Act
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertEqual(json?["uuid"] as? String, "device-uuid")
        XCTAssertEqual(json?["token"] as? String, "device-token")
        XCTAssertEqual(json?.keys.count, 2)
    }
    
    // MARK: - UpdateDevice Tests
    
    func test_updateDevice_encoding_withAllValues() throws {
        // Arrange
        let request = DeviceServiceRequest.UpdateDevice(
            id: 123,
            uuid: "updated-uuid",
            token: "updated-token"
        )
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let decodedData = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertEqual(decodedData?["uuid"] as? String, "updated-uuid")
        XCTAssertEqual(decodedData?["token"] as? String, "updated-token")
        XCTAssertNil(decodedData?["id"]) // ID should not be encoded
    }
    
    func test_updateDevice_encoding_withPartialValues() throws {
        // Arrange
        let request = DeviceServiceRequest.UpdateDevice(
            id: 456,
            uuid: "new-uuid",
            token: nil
        )
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let decodedData = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertEqual(decodedData?["uuid"] as? String, "new-uuid")
        XCTAssertNil(decodedData?["token"])
        XCTAssertNil(decodedData?["id"]) // ID should not be encoded
    }
    
    func test_updateDevice_codingKeys_excludesId() throws {
        // Arrange
        let request = DeviceServiceRequest.UpdateDevice(
            id: 789,
            uuid: "test-uuid",
            token: "test-token"
        )
        
        // Act
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertEqual(json?["uuid"] as? String, "test-uuid")
        XCTAssertEqual(json?["token"] as? String, "test-token")
        XCTAssertNil(json?["id"]) // ID should not be in encoded JSON
        XCTAssertEqual(json?.keys.count, 2)
    }
    
    // MARK: - UpdateDeviceToken Tests
    
    func test_updateDeviceToken_encoding() throws {
        // Arrange
        let request = DeviceServiceRequest.UpdateDeviceToken(
            token: "new-device-token"
        )
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let decodedData = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertEqual(decodedData?["token"] as? String, "new-device-token")
        XCTAssertEqual(decodedData?.keys.count, 1)
    }
    
    func test_updateDeviceToken_codingKeys() throws {
        // Arrange
        let request = DeviceServiceRequest.UpdateDeviceToken(
            token: "token-123"
        )
        
        // Act
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertEqual(json?["token"] as? String, "token-123")
        XCTAssertEqual(json?.keys.count, 1)
    }
    
    // MARK: - ByID Tests
    
    func test_byID_initialization() {
        // Arrange & Act
        let request = DeviceServiceRequest.ByID(id: 999)
        
        // Assert
        XCTAssertEqual(request.id, 999)
    }
    
    // MARK: - Type Aliases Tests
    
    func test_typeAliases() {
        // Arrange & Act
        let fetchRequest = DeviceServiceRequest.FetchDevice(id: 1)
        let deleteRequest = DeviceServiceRequest.DeleteDevice(id: 2)
        let updateRequest = DeviceServiceRequest.UpdateDevice(id: 3, uuid: nil, token: nil)
        
        // Assert
        XCTAssertEqual(fetchRequest.id, 1)
        XCTAssertEqual(deleteRequest.id, 2)
        XCTAssertEqual(updateRequest.id, 3)
    }
} 
