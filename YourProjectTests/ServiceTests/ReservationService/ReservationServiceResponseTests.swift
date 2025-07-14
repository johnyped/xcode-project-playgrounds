//
//  ReservationServiceResponseTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest

class ReservationServiceResponseTests: XCTestCase {
    
    // MARK: - Test ConfirmationInfo Initialization
    
    func test_confirmationInfo_initialization_withAllParameters() {
        // Arrange & Act
        let confirmationInfo = ReservationServiceResponse.ConfirmationInfo(
            createdAt: "2023-11-15T10:30:00Z",
            remark: "Confirmation successful",
            url: "https://example.com/confirmation/123"
        )
        
        // Assert
        XCTAssertEqual(confirmationInfo.createdAt, "2023-11-15T10:30:00Z")
        XCTAssertEqual(confirmationInfo.remark, "Confirmation successful")
        XCTAssertEqual(confirmationInfo.url, "https://example.com/confirmation/123")
    }
    
    func test_confirmationInfo_initialization_withDefaultValues() {
        // Arrange & Act
        let confirmationInfo = ReservationServiceResponse.ConfirmationInfo()
        
        // Assert
        XCTAssertNil(confirmationInfo.createdAt)
        XCTAssertNil(confirmationInfo.remark)
        XCTAssertNil(confirmationInfo.url)
    }
    
    func test_confirmationInfo_initialization_withPartialParameters() {
        // Arrange & Act
        let confirmationInfo = ReservationServiceResponse.ConfirmationInfo(
            createdAt: "2023-11-15T10:30:00Z",
            remark: nil,
            url: "https://example.com/confirmation/123"
        )
        
        // Assert
        XCTAssertEqual(confirmationInfo.createdAt, "2023-11-15T10:30:00Z")
        XCTAssertNil(confirmationInfo.remark)
        XCTAssertEqual(confirmationInfo.url, "https://example.com/confirmation/123")
    }
    
    // MARK: - Test ConfirmationInfo Decoding
    
    func test_confirmationInfo_decodesCorrectly_withAllFields() throws {
        // Arrange
        let json = """
        {
            "created_at": "2023-11-15T10:30:00Z",
            "remark": "Confirmation generated successfully",
            "url": "https://example.com/confirmation/512"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        // Act
        let confirmationInfo = try decoder.decode(
            ReservationServiceResponse.ConfirmationInfo.self,
            from: json
        )
        
        // Assert
        XCTAssertEqual(confirmationInfo.createdAt, "2023-11-15T10:30:00Z")
        XCTAssertEqual(confirmationInfo.remark, "Confirmation generated successfully")
        XCTAssertEqual(confirmationInfo.url, "https://example.com/confirmation/512")
    }
    
    func test_confirmationInfo_decodesCorrectly_withNullFields() throws {
        // Arrange
        let json = """
        {
            "created_at": null,
            "remark": null,
            "url": null
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        // Act
        let confirmationInfo = try decoder.decode(
            ReservationServiceResponse.ConfirmationInfo.self,
            from: json
        )
        
        // Assert
        XCTAssertNil(confirmationInfo.createdAt)
        XCTAssertNil(confirmationInfo.remark)
        XCTAssertNil(confirmationInfo.url)
    }
    
    func test_confirmationInfo_decodesCorrectly_withMissingFields() throws {
        // Arrange
        let json = """
        {
            "created_at": "2023-11-15T10:30:00Z"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        // Act
        let confirmationInfo = try decoder.decode(
            ReservationServiceResponse.ConfirmationInfo.self,
            from: json
        )
        
        // Assert
        XCTAssertEqual(confirmationInfo.createdAt, "2023-11-15T10:30:00Z")
        XCTAssertNil(confirmationInfo.remark)
        XCTAssertNil(confirmationInfo.url)
    }
    
    func test_confirmationInfo_decodesCorrectly_withEmptyObject() throws {
        // Arrange
        let json = """
        {}
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        // Act
        let confirmationInfo = try decoder.decode(
            ReservationServiceResponse.ConfirmationInfo.self,
            from: json
        )
        
        // Assert
        XCTAssertNil(confirmationInfo.createdAt)
        XCTAssertNil(confirmationInfo.remark)
        XCTAssertNil(confirmationInfo.url)
    }
    
    func test_confirmationInfo_decodesCorrectly_withEmptyStrings() throws {
        // Arrange
        let json = """
        {
            "created_at": "",
            "remark": "",
            "url": ""
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        // Act
        let confirmationInfo = try decoder.decode(
            ReservationServiceResponse.ConfirmationInfo.self,
            from: json
        )
        
        // Assert
        XCTAssertEqual(confirmationInfo.createdAt, "")
        XCTAssertEqual(confirmationInfo.remark, "")
        XCTAssertEqual(confirmationInfo.url, "")
    }
    
    // MARK: - Test ConfirmationInfo Encoding
    
    func test_confirmationInfo_encodesCorrectly_withAllFields() throws {
        // Arrange
        let confirmationInfo = ReservationServiceResponse.ConfirmationInfo(
            createdAt: "2023-11-15T10:30:00Z",
            remark: "Confirmation generated successfully",
            url: "https://example.com/confirmation/512"
        )
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        
        // Act
        let data = try encoder.encode(confirmationInfo)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["created_at"] as? String, "2023-11-15T10:30:00Z")
        XCTAssertEqual(json?["remark"] as? String, "Confirmation generated successfully")
        XCTAssertEqual(json?["url"] as? String, "https://example.com/confirmation/512")
    }
    
    func test_confirmationInfo_encodesCorrectly_withNilFields() throws {
        // Arrange
        let confirmationInfo = ReservationServiceResponse.ConfirmationInfo(
            createdAt: nil,
            remark: nil,
            url: nil
        )
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        
        // Act
        let data = try encoder.encode(confirmationInfo)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(json)
        XCTAssertTrue(json?["created_at"] is NSNull || json?["created_at"] == nil)
        XCTAssertTrue(json?["remark"] is NSNull || json?["remark"] == nil)
        XCTAssertTrue(json?["url"] is NSNull || json?["url"] == nil)
    }
    
    func test_confirmationInfo_encodesCorrectly_withPartialFields() throws {
        // Arrange
        let confirmationInfo = ReservationServiceResponse.ConfirmationInfo(
            createdAt: "2023-11-15T10:30:00Z",
            remark: nil,
            url: "https://example.com/confirmation/512"
        )
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        
        // Act
        let data = try encoder.encode(confirmationInfo)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["created_at"] as? String, "2023-11-15T10:30:00Z")
        XCTAssertTrue(json?["remark"] is NSNull || json?["remark"] == nil)
        XCTAssertEqual(json?["url"] as? String, "https://example.com/confirmation/512")
    }
    
    // MARK: - Test CodingKeys Mapping
    
    func test_confirmationInfo_codingKeys_mapCorrectly() {
        // Arrange
        let codingKeys = ReservationServiceResponse.ConfirmationInfo.CodingKeys.self
        
        // Assert
        XCTAssertEqual(codingKeys.createdAt.rawValue, "created_at")
        XCTAssertEqual(codingKeys.remark.rawValue, "remark")
        XCTAssertEqual(codingKeys.url.rawValue, "url")
    }
    
    // MARK: - Test Round-trip Encoding/Decoding
    
    func test_confirmationInfo_roundTrip_encodingDecoding() throws {
        // Arrange
        let originalConfirmationInfo = ReservationServiceResponse.ConfirmationInfo(
            createdAt: "2023-11-15T10:30:00Z",
            remark: "Test confirmation with special characters: äöü 中文 🎉",
            url: "https://example.com/confirmation/512?token=abc123&lang=en"
        )
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        // Act
        let data = try encoder.encode(originalConfirmationInfo)
        let decodedConfirmationInfo = try decoder.decode(
            ReservationServiceResponse.ConfirmationInfo.self,
            from: data
        )
        
        // Assert
        XCTAssertEqual(decodedConfirmationInfo.createdAt, originalConfirmationInfo.createdAt)
        XCTAssertEqual(decodedConfirmationInfo.remark, originalConfirmationInfo.remark)
        XCTAssertEqual(decodedConfirmationInfo.url, originalConfirmationInfo.url)
    }
    
    // MARK: - Test Edge Cases
    
    func test_confirmationInfo_handlesLongStrings() throws {
        // Arrange
        let longString = String(repeating: "A", count: 1000)
        let confirmationInfo = ReservationServiceResponse.ConfirmationInfo(
            createdAt: longString,
            remark: longString,
            url: longString
        )
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        // Act & Assert - Should not throw
        let data = try encoder.encode(confirmationInfo)
        let decoded = try decoder.decode(
            ReservationServiceResponse.ConfirmationInfo.self,
            from: data
        )
        
        XCTAssertEqual(decoded.createdAt, longString)
        XCTAssertEqual(decoded.remark, longString)
        XCTAssertEqual(decoded.url, longString)
    }
    
    func test_confirmationInfo_handlesSpecialCharacters() throws {
        // Arrange
        let specialChars = "Special chars: 特殊字符 🎉 äöü ñ €$¥£ \n\t\r"
        let confirmationInfo = ReservationServiceResponse.ConfirmationInfo(
            createdAt: "2023-11-15T10:30:00Z",
            remark: specialChars,
            url: "https://example.com/confirmation/512"
        )
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        // Act
        let data = try encoder.encode(confirmationInfo)
        let decoded = try decoder.decode(
            ReservationServiceResponse.ConfirmationInfo.self,
            from: data
        )
        
        // Assert
        XCTAssertEqual(decoded.remark, specialChars)
    }
    
    // MARK: - Test Real-world Examples
    
    func test_confirmationInfo_realWorldExample() throws {
        // Arrange
        let json = """
        {
            "created_at": "2024-01-15T14:30:00.000Z",
            "remark": "Reservation confirmed for John Smith. Check-in: 2024-01-20, Check-out: 2024-01-23. Room: Deluxe Suite",
            "url": "https://hotel-api.example.com/reservations/rsvt_5la15znqpb30lz5rmqj/confirmation.pdf"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        // Act
        let confirmationInfo = try decoder.decode(
            ReservationServiceResponse.ConfirmationInfo.self,
            from: json
        )
        
        // Assert
        XCTAssertEqual(confirmationInfo.createdAt, "2024-01-15T14:30:00.000Z")
        XCTAssertEqual(confirmationInfo.remark, "Reservation confirmed for John Smith. Check-in: 2024-01-20, Check-out: 2024-01-23. Room: Deluxe Suite")
        XCTAssertEqual(confirmationInfo.url, "https://hotel-api.example.com/reservations/rsvt_5la15znqpb30lz5rmqj/confirmation.pdf")
    }
} 