//
//  DeviceRemoteServiceTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest
import Mockable


final class DeviceRemoteServiceTests: XCTestCase {
    
    private var sut: DeviceRemoteService!
    
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()
    
    override func setUp() {
        super.setUp()
        sut = DeviceRemoteService(
            apiManager: apiManager,
            localStorageManager: localStorage
        )
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Helper Methods
    
    private func createSampleDevice(id: Int = 1, uuid: String = "test-uuid", token: String = "test-token") -> Device {
        return Device(
            id: id,
            uuid: uuid,
            token: token,
            userId: 123,
            createdAt: "2024-01-01T00:00:00Z",
            updatedAt: "2024-01-01T00:00:00Z"
        )
    }
    
    private func createSampleDevices() -> Devices {
        let devices = [
            createSampleDevice(id: 1, uuid: "uuid-1", token: "token-1"),
            createSampleDevice(id: 2, uuid: "uuid-2", token: "token-2")
        ]
        return Devices(array: devices)
    }
    
    // MARK: - FetchDevices Tests
    
    func test_fetchDevices_success() async throws {
        // Arrange
        let expectedDevices = createSampleDevices()
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedDevices)
        
        // Act
        let result = try await sut.fetchDevices()
        
        // Assert
        XCTAssertEqual(result.count, 2)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_fetchDevices_failure() async throws {
        // Arrange
        let expectedError = APIError.unknownError(title: "Network Error", subtitle: nil, underlying: nil)
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any).willProduce { a, b -> Devices in
                throw expectedError
            }
        
        // Act & Assert
        do {
            _ = try await sut.fetchDevices()
            XCTFail("Expected error to be thrown")
        } catch {
            switch error {
            case APIError.unknownError(let title, subtitle: _, underlying: _):
                XCTAssertEqual(title, "Network Error")
            default:
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    // MARK: - CreateDevice Tests
    
    func test_createDevice_success() async throws {
        // Arrange
        let expectedDevice = createSampleDevice(id: 123, uuid: "new-uuid", token: "new-token")
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedDevice)
        
        let request = DeviceServiceRequest.CreateDevice(
            uuid: "new-uuid",
            token: "new-token"
        )
        
        // Act
        let result = try await sut.createDevice(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedDevice.id)
        XCTAssertEqual(result.uuid, expectedDevice.uuid)
        XCTAssertEqual(result.token, expectedDevice.token)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_createDevice_failure() async throws {
        // Arrange
        let expectedError = APIError.unknownError(title: "Bad Request", subtitle: nil, underlying: nil)
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce { a, b -> Device in
                throw expectedError
            }
        
        let request = DeviceServiceRequest.CreateDevice(
            uuid: "invalid-uuid",
            token: "invalid-token"
        )
        
        // Act & Assert
        do {
            _ = try await sut.createDevice(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error {
            case APIError.unknownError(let title, subtitle: _, underlying: _):
                XCTAssertEqual(title, "Bad Request")
            default:
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    // MARK: - FetchDevice Tests
    
    func test_fetchDevice_success() async throws {
        // Arrange
        let expectedDevice = createSampleDevice(id: 456, uuid: "fetch-uuid", token: "fetch-token")
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedDevice)
        
        let request = DeviceServiceRequest.FetchDevice(id: 456)
        
        // Act
        let result = try await sut.fetchDevice(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedDevice.id)
        XCTAssertEqual(result.uuid, expectedDevice.uuid)
        XCTAssertEqual(result.token, expectedDevice.token)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_fetchDevice_failure() async throws {
        // Arrange
        let expectedError = APIError.unknownError(title: "Not Found", subtitle: nil, underlying: nil)
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce { a, b -> Device in
                throw expectedError
            }
        
        let request = DeviceServiceRequest.FetchDevice(id: 999)
        
        // Act & Assert
        do {
            _ = try await sut.fetchDevice(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error {
            case APIError.unknownError(let title, subtitle: _, underlying: _):
                XCTAssertEqual(title, "Not Found")
            default:
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    // MARK: - UpdateDevice Tests
    
    func test_updateDevice_success() async throws {
        // Arrange
        let expectedDevice = createSampleDevice(id: 789, uuid: "updated-uuid", token: "updated-token")
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedDevice)
        
        let request = DeviceServiceRequest.UpdateDevice(
            id: 789,
            uuid: "updated-uuid",
            token: "updated-token"
        )
        
        // Act
        let result = try await sut.updateDevice(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedDevice.id)
        XCTAssertEqual(result.uuid, expectedDevice.uuid)
        XCTAssertEqual(result.token, expectedDevice.token)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_updateDevice_failure() async throws {
        // Arrange
        let expectedError = APIError.unknownError(title: "Unauthorized", subtitle: nil, underlying: nil)
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce { a, b -> Device in
                throw expectedError
            }
        
        let request = DeviceServiceRequest.UpdateDevice(
            id: 789,
            uuid: "updated-uuid",
            token: "updated-token"
        )
        
        // Act & Assert
        do {
            _ = try await sut.updateDevice(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error {
            case APIError.unknownError(let title, subtitle: _, underlying: _):
                XCTAssertEqual(title, "Unauthorized")
            default:
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    // MARK: - DeleteDevice Tests
    
    func test_deleteDevice_success() async throws {
        // Arrange
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn()
        
        let request = DeviceServiceRequest.DeleteDevice(id: 123)
        
        // Act
        try await sut.deleteDevice(request: request)
        
        // Assert
        verify(apiManager)
            .requestACK(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_deleteDevice_failure() async throws {
        // Arrange
        let expectedError = APIError.unknownError(title: "Forbidden", subtitle: nil, underlying: nil)
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willProduce { a, b -> Void in
                throw expectedError
            }
        
        let request = DeviceServiceRequest.DeleteDevice(id: 123)
        
        // Act & Assert
        do {
            try await sut.deleteDevice(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error {
            case APIError.unknownError(let title, subtitle: _, underlying: _):
                XCTAssertEqual(title, "Forbidden")
            default:
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    // MARK: - UpdateDeviceToken Tests
    
    func test_updateDeviceToken_success() async throws {
        // Arrange
        let expectedDevice = createSampleDevice(id: 555, uuid: "token-uuid", token: "new-token-123")
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedDevice)
        
        let request = DeviceServiceRequest.UpdateDeviceToken(token: "new-token-123")
        
        // Act
        let result = try await sut.updateDeviceToken(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedDevice.id)
        XCTAssertEqual(result.uuid, expectedDevice.uuid)
        XCTAssertEqual(result.token, "new-token-123")
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_updateDeviceToken_failure() async throws {
        // Arrange
        let expectedError = APIError.unknownError(title: "Server Error", subtitle: nil, underlying: nil)
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce { a, b -> Device in
                throw expectedError
            }
        
        let request = DeviceServiceRequest.UpdateDeviceToken(token: "invalid-token")
        
        // Act & Assert
        do {
            _ = try await sut.updateDeviceToken(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error {
            case APIError.unknownError(let title, subtitle: _, underlying: _):
                XCTAssertEqual(title, "Server Error")
            default:
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    // MARK: - Router Verification Tests
    
    func test_fetchDevices_usesCorrectRouter() async throws {
        // Arrange
        let expectedDevices = createSampleDevices()
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedDevices)
        
        // Act
        _ = try await sut.fetchDevices()
        
        // Assert
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_createDevice_usesCorrectRouter() async throws {
        // Arrange
        let expectedDevice = createSampleDevice()
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedDevice)
        
        let request = DeviceServiceRequest.CreateDevice(uuid: "test", token: "test")
        
        // Act
        _ = try await sut.createDevice(request: request)
        
        // Assert
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_fetchDevice_usesCorrectRouter() async throws {
        // Arrange
        let expectedDevice = createSampleDevice()
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedDevice)
        
        let request = DeviceServiceRequest.FetchDevice(id: 1)
        
        // Act
        _ = try await sut.fetchDevice(request: request)
        
        // Assert
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_updateDevice_usesCorrectRouter() async throws {
        // Arrange
        let expectedDevice = createSampleDevice()
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedDevice)
        
        let request = DeviceServiceRequest.UpdateDevice(id: 1, uuid: "updated", token: "updated")
        
        // Act
        _ = try await sut.updateDevice(request: request)
        
        // Assert
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_deleteDevice_usesCorrectRouter() async throws {
        // Arrange
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn()
        
        let request = DeviceServiceRequest.DeleteDevice(id: 1)
        
        // Act
        try await sut.deleteDevice(request: request)
        
        // Assert
        verify(apiManager)
            .requestACK(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_updateDeviceToken_usesCorrectRouter() async throws {
        // Arrange
        let expectedDevice = createSampleDevice()
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedDevice)
        
        let request = DeviceServiceRequest.UpdateDeviceToken(token: "new-token")
        
        // Act
        _ = try await sut.updateDeviceToken(request: request)
        
        // Assert
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
} 
