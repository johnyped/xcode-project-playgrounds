//
//  DeviceServiceRouterTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest
import Alamofire


final class DeviceServiceRouterTests: XCTestCase {
    
    // MARK: - Path Tests
    
    func test_fetchDevices_path() {
        // Arrange
        let router = DeviceServiceRouter.fetchDevices
        
        // Act
        let path = router.path
        
        // Assert
        XCTAssertEqual(path, "/v4/devices")
    }
    
    func test_createDevice_path() {
        // Arrange
        let request = DeviceServiceRequest.CreateDevice(uuid: "test", token: "test")
        let router = DeviceServiceRouter.createDevice(request: request)
        
        // Act
        let path = router.path
        
        // Assert
        XCTAssertEqual(path, "/v4/devices")
    }
    
    func test_fetchDevice_path() {
        // Arrange
        let request = DeviceServiceRequest.FetchDevice(id: 123)
        let router = DeviceServiceRouter.fetchDevice(request: request)
        
        // Act
        let path = router.path
        
        // Assert
        XCTAssertEqual(path, "/v4/devices/123")
    }
    
    func test_updateDevice_path() {
        // Arrange
        let request = DeviceServiceRequest.UpdateDevice(id: 456, uuid: nil, token: nil)
        let router = DeviceServiceRouter.updateDevice(request: request)
        
        // Act
        let path = router.path
        
        // Assert
        XCTAssertEqual(path, "/v4/devices/456")
    }
    
    func test_deleteDevice_path() {
        // Arrange
        let request = DeviceServiceRequest.DeleteDevice(id: 789)
        let router = DeviceServiceRouter.deleteDevice(request: request)
        
        // Act
        let path = router.path
        
        // Assert
        XCTAssertEqual(path, "/v4/devices/789")
    }
    
    func test_updateDeviceToken_path() {
        // Arrange
        let request = DeviceServiceRequest.UpdateDeviceToken(token: "test")
        let router = DeviceServiceRouter.updateDeviceToken(request: request)
        
        // Act
        let path = router.path
        
        // Assert
        XCTAssertEqual(path, "/v4/devices/token")
    }
    
    // MARK: - HTTP Method Tests
    
    func test_fetchDevices_method() {
        // Arrange
        let router = DeviceServiceRouter.fetchDevices
        
        // Act
        let method = router.method
        
        // Assert
        XCTAssertEqual(method, .get)
    }
    
    func test_createDevice_method() {
        // Arrange
        let request = DeviceServiceRequest.CreateDevice(uuid: "test", token: "test")
        let router = DeviceServiceRouter.createDevice(request: request)
        
        // Act
        let method = router.method
        
        // Assert
        XCTAssertEqual(method, .post)
    }
    
    func test_fetchDevice_method() {
        // Arrange
        let request = DeviceServiceRequest.FetchDevice(id: 123)
        let router = DeviceServiceRouter.fetchDevice(request: request)
        
        // Act
        let method = router.method
        
        // Assert
        XCTAssertEqual(method, .get)
    }
    
    func test_updateDevice_method() {
        // Arrange
        let request = DeviceServiceRequest.UpdateDevice(id: 456, uuid: nil, token: nil)
        let router = DeviceServiceRouter.updateDevice(request: request)
        
        // Act
        let method = router.method
        
        // Assert
        XCTAssertEqual(method, .put)
    }
    
    func test_deleteDevice_method() {
        // Arrange
        let request = DeviceServiceRequest.DeleteDevice(id: 789)
        let router = DeviceServiceRouter.deleteDevice(request: request)
        
        // Act
        let method = router.method
        
        // Assert
        XCTAssertEqual(method, .delete)
    }
    
    func test_updateDeviceToken_method() {
        // Arrange
        let request = DeviceServiceRequest.UpdateDeviceToken(token: "test")
        let router = DeviceServiceRouter.updateDeviceToken(request: request)
        
        // Act
        let method = router.method
        
        // Assert
        XCTAssertEqual(method, .put)
    }
    
    // MARK: - Domain Tests
    
    func test_domain() {
        // Arrange
        let router = DeviceServiceRouter.fetchDevices
        
        // Act
        let domain = router.domain
        
        // Assert
        XCTAssertEqual(domain, AppConfiguration.shared.baseURL)
    }
    
    // MARK: - Headers Tests
    
    func test_headers() {
        // Arrange
        let router = DeviceServiceRouter.fetchDevices
        
        // Act
        let headers = router.headers
        
        // Assert
        XCTAssertEqual(headers?["Content-Type"], "application/json")
    }
    
    // MARK: - Parameters Tests
    
    func test_fetchDevices_parameters() {
        // Arrange
        let router = DeviceServiceRouter.fetchDevices
        
        // Act
        let parameters = router.parameters
        
        // Assert
        XCTAssertNil(parameters)
    }
    
    func test_createDevice_parameters() {
        // Arrange
        let request = DeviceServiceRequest.CreateDevice(uuid: "test", token: "test")
        let router = DeviceServiceRouter.createDevice(request: request)
        
        // Act
        let parameters = router.parameters
        
        // Assert
        XCTAssertNil(parameters)
    }
    
    func test_fetchDevice_parameters() {
        // Arrange
        let request = DeviceServiceRequest.FetchDevice(id: 123)
        let router = DeviceServiceRouter.fetchDevice(request: request)
        
        // Act
        let parameters = router.parameters
        
        // Assert
        XCTAssertNil(parameters)
    }
    
    func test_updateDevice_parameters() {
        // Arrange
        let request = DeviceServiceRequest.UpdateDevice(id: 456, uuid: nil, token: nil)
        let router = DeviceServiceRouter.updateDevice(request: request)
        
        // Act
        let parameters = router.parameters
        
        // Assert
        XCTAssertNil(parameters)
    }
    
    func test_deleteDevice_parameters() {
        // Arrange
        let request = DeviceServiceRequest.DeleteDevice(id: 789)
        let router = DeviceServiceRouter.deleteDevice(request: request)
        
        // Act
        let parameters = router.parameters
        
        // Assert
        XCTAssertNil(parameters)
    }
    
    func test_updateDeviceToken_parameters() {
        // Arrange
        let request = DeviceServiceRequest.UpdateDeviceToken(token: "test")
        let router = DeviceServiceRouter.updateDeviceToken(request: request)
        
        // Act
        let parameters = router.parameters
        
        // Assert
        XCTAssertNil(parameters)
    }
    
    // MARK: - Body Tests
    
    func test_fetchDevices_body() {
        // Arrange
        let router = DeviceServiceRouter.fetchDevices
        
        // Act
        let body = router.body
        
        // Assert
        XCTAssertNil(body)
    }
    
    func test_createDevice_body() throws {
        // Arrange
        let request = DeviceServiceRequest.CreateDevice(uuid: "test-uuid", token: "test-token")
        let router = DeviceServiceRouter.createDevice(request: request)
        
        // Act
        let body = router.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let decodedData = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertEqual(decodedData?["uuid"] as? String, "test-uuid")
        XCTAssertEqual(decodedData?["token"] as? String, "test-token")
    }
    
    func test_fetchDevice_body() {
        // Arrange
        let request = DeviceServiceRequest.FetchDevice(id: 123)
        let router = DeviceServiceRouter.fetchDevice(request: request)
        
        // Act
        let body = router.body
        
        // Assert
        XCTAssertNil(body)
    }
    
    func test_updateDevice_body() throws {
        // Arrange
        let request = DeviceServiceRequest.UpdateDevice(id: 456, uuid: "updated-uuid", token: "updated-token")
        let router = DeviceServiceRouter.updateDevice(request: request)
        
        // Act
        let body = router.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let decodedData = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertEqual(decodedData?["uuid"] as? String, "updated-uuid")
        XCTAssertEqual(decodedData?["token"] as? String, "updated-token")
        XCTAssertNil(decodedData?["id"]) // ID should not be in body
    }
    
    func test_deleteDevice_body() {
        // Arrange
        let request = DeviceServiceRequest.DeleteDevice(id: 789)
        let router = DeviceServiceRouter.deleteDevice(request: request)
        
        // Act
        let body = router.body
        
        // Assert
        XCTAssertNil(body)
    }
    
    func test_updateDeviceToken_body() throws {
        // Arrange
        let request = DeviceServiceRequest.UpdateDeviceToken(token: "new-token")
        let router = DeviceServiceRouter.updateDeviceToken(request: request)
        
        // Act
        let body = router.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let decodedData = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertEqual(decodedData?["token"] as? String, "new-token")
    }
    
    // MARK: - URL Request Tests
    
    func test_asURLRequest_fetchDevices() throws {
        // Arrange
        let router = DeviceServiceRouter.fetchDevices
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/devices") == true)
        XCTAssertNil(urlRequest.url?.query)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    func test_asURLRequest_createDevice() throws {
        // Arrange
        let request = DeviceServiceRequest.CreateDevice(uuid: "test-uuid", token: "test-token")
        let router = DeviceServiceRouter.createDevice(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/devices") == true)
        XCTAssertNotNil(urlRequest.httpBody)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    func test_asURLRequest_fetchDevice() throws {
        // Arrange
        let request = DeviceServiceRequest.FetchDevice(id: 123)
        let router = DeviceServiceRouter.fetchDevice(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/devices/123") == true)
        XCTAssertNil(urlRequest.httpBody)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    func test_asURLRequest_updateDevice() throws {
        // Arrange
        let request = DeviceServiceRequest.UpdateDevice(id: 456, uuid: "updated", token: "updated")
        let router = DeviceServiceRouter.updateDevice(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/devices/456") == true)
        XCTAssertNotNil(urlRequest.httpBody)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    func test_asURLRequest_deleteDevice() throws {
        // Arrange
        let request = DeviceServiceRequest.DeleteDevice(id: 789)
        let router = DeviceServiceRouter.deleteDevice(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "DELETE")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/devices/789") == true)
        XCTAssertNil(urlRequest.httpBody)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    func test_asURLRequest_updateDeviceToken() throws {
        // Arrange
        let request = DeviceServiceRequest.UpdateDeviceToken(token: "new-token")
        let router = DeviceServiceRouter.updateDeviceToken(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/devices/token") == true)
        XCTAssertNotNil(urlRequest.httpBody)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
} 
