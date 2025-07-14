//
//  StaffServiceRouterTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest
import Alamofire
import Mockable

final class StaffServiceRouterTests: XCTestCase {
    
    var baseURL: String!
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()
    
    override func setUp() {
        super.setUp()
        baseURL = AppConfiguration.shared.baseURL
    }
    
    func testFetchStaffsRequest() throws {
        // Given
        let request = StaffServiceRequest.FetchStaffs(hotelId: 105)
        let router = StaffServiceRouter.fetchStaffs(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/staffs") == true)
        
        // Check for parameters
        let urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        let hotelIdItem = queryItems.first { $0.name == "hotel_id" }
        XCTAssertEqual(hotelIdItem?.value, "105")
    }
    
    func testFetchStaffRequest() throws {
        // Given
        let request = StaffServiceRequest.FetchStaff(id: 1)
        let router = StaffServiceRouter.fetchStaff(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/staffs/1") == true)
    }
    
    func testCreateStaffRequest() throws {
        // Given
        let request = StaffServiceRequest.CreateStaff(
            hotelId: 105,
            username: "staff@example.com",
            password: "password123",
            role: .frontDesk,
            email: "abc@email.com"
        )
        let router = StaffServiceRouter.createStaff(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/staffs") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Check JSON body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["hotel_id"] as? Int, 105)
            XCTAssertEqual(json?["password"] as? String, "password123")
            XCTAssertEqual(json?["username"] as? String, "staff@example.com")
            XCTAssertEqual(json?["role"] as? String, "FRONT_DESK")
            XCTAssertEqual(json?["email"] as? String, "abc@email.com")
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testUpdateStaffRequest() throws {
        // Given
        let request = StaffServiceRequest.UpdateStaff(
            id: 1,
            firstName: "John",
            lastName: "Doe",
            phoneNumber: "123-456-7890",
            pinCode: "1234",
            idCard: "1234567890123",
            email: "abc@example.com"
        )
        let router = StaffServiceRouter.updateStaff(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/staffs/1") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Check JSON body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["first_name"] as? String, "John")
            XCTAssertEqual(json?["last_name"] as? String, "Doe")
            XCTAssertEqual(json?["phone_number"] as? String, "123-456-7890")
            XCTAssertEqual(json?["pin_code"] as? String, "1234")
            XCTAssertEqual(json?["id_card"] as? String, "1234567890123")
            XCTAssertNil(json?["id"]) // ID should not be in the body since it's in the URL
            XCTAssertEqual(json?["email"] as? String, "abc@example.com")
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testChangeStaffUsernameRequest() throws {
        // Given
        let request = StaffServiceRequest.ChangeStaffUsername(
            id: 1,
            username: "newusername@example.com"
        )
        let router = StaffServiceRouter.changeStaffUsername(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/staffs/1/change-username") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Check JSON body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["username"] as? String, "newusername@example.com")
            XCTAssertNil(json?["id"]) // ID should not be in the body since it's in the URL
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testDeleteStaffRequest() throws {
        // Given
        let request = StaffServiceRequest.DeleteStaff(id: 3)
        let router = StaffServiceRouter.deleteStaff(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "DELETE")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/staffs/3") == true)
    }
    
    func testChangeHotelRequest() throws {
        // Given
        let request = StaffServiceRequest.ChangeHotel(
            id: 1,
            hotelId: 201
        )
        let router = StaffServiceRouter.changeHotel(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/staffs/1/change-hotel") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Check JSON body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["hotel_id"] as? Int, 201)
            XCTAssertNil(json?["id"]) // ID should not be in the body since it's in the URL
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testChangePasswordRequest() throws {
        // Given
        let request = StaffServiceRequest.ChangePassword(
            id: 1,
            password: "newpassword123"
        )
        let router = StaffServiceRouter.changePassword(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/staffs/1/change-password") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Check JSON body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["password"] as? String, "newpassword123")
            XCTAssertNil(json?["id"]) // ID should not be in the body since it's in the URL
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testUpdateStatusRequest() throws {
        // Given
        let request = StaffServiceRequest.UpdateStatus(
            id: 1,
            status: .inactive
        )
        let router = StaffServiceRouter.updateStatus(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/staffs/1/status") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Check JSON body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["status"] as? String, "INACTIVE")
            XCTAssertNil(json?["id"]) // ID should not be in the body since it's in the URL
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testVerifyPinRequest() throws {
        // Given
        let request = StaffServiceRequest.VerifyPin(
            id: 1,
            pinCode: "1234"
        )
        let router = StaffServiceRouter.verifyPin(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/staffs/1/verify-pin") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Check JSON body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["pin_code"] as? String, "1234")
            XCTAssertNil(json?["id"]) // ID should not be in the body since it's in the URL
        } else {
            XCTFail("Request should have a body")
        }
    }
} 
