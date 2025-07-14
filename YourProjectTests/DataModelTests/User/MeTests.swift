//
//  MeTests.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import XCTest

final class MeTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let me = createSampleMe()
        
        // Assert
        XCTAssertEqual(me.id, 38)
        XCTAssertEqual(me.email, "test1@email.com")
        XCTAssertEqual(me.firstName, "John2")
        XCTAssertEqual(me.lastName, "Doe2")
        XCTAssertEqual(me.phoneNumber, "1234567890")
        XCTAssertEqual(me.role, .supportSuperAdmin)
        XCTAssertEqual(me.idCard, "1232323232333")
        XCTAssertEqual(me.authProviders, [])
        XCTAssertEqual(me.images, [])
    }
    
    func test_initWithOptionalProperties() throws {
        // Arrange & Act
        let me = createSampleMe()
        
        // Assert
        XCTAssertNil(me.logoImage)
        XCTAssertNil(me.signSignatureImage)
        XCTAssertNil(me.verifiedAt)
        XCTAssertNil(me.staffId)
    }
    
    func test_initWithDates() throws {
        // Arrange & Act
        let me = createSampleMe()
        
        // Assert
        XCTAssertNotNil(me.createdAt)
        XCTAssertNotNil(me.updatedAt)
        XCTAssertNotNil(me.passwordChangedAt)
    }
    
    // MARK: - Role Tests
    
    func test_roleRawValues() throws {
        XCTAssertEqual(Me.Role.user.rawValue, "ROLE_USER")
        XCTAssertEqual(Me.Role.admin.rawValue, "ROLE_ADMIN")
        XCTAssertEqual(Me.Role.superAdmin.rawValue, "ROLE_SUPER_ADMIN")
        XCTAssertEqual(Me.Role.supportSuperAdmin.rawValue, "ROLE_SUPPORT_SUPER_ADMIN")
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 38,
            "email": "test1@email.com",
            "first_name": "John2",
            "last_name": "Doe2",
            "phone_number": "1234567890",
            "role": "ROLE_SUPPORT_SUPER_ADMIN",
            "id_card": "1232323232333",
            "logo_image": null,
            "sign_signature_image": null,
            "verified_at": null,
            "password_changed_at": "2023-11-28T06:11:43.011+07:00",
            "created_at": "2016-12-28T20:54:08.650+07:00",
            "updated_at": "2025-02-26T05:35:58.313+07:00",
            "auth_providers": [],
            "staff_id": null,
            "images": []
        }
        """.data(using: .utf8)!
        
        // Act
        let me = try JSONDecoder().decode(Me.self, from: json)
        
        // Assert
        XCTAssertEqual(me.id, 38)
        XCTAssertEqual(me.email, "test1@email.com")
        XCTAssertEqual(me.firstName, "John2")
        XCTAssertEqual(me.lastName, "Doe2")
        XCTAssertEqual(me.phoneNumber, "1234567890")
        XCTAssertEqual(me.role, .supportSuperAdmin)
        XCTAssertEqual(me.idCard, "1232323232333")
        XCTAssertNil(me.logoImage)
        XCTAssertNil(me.signSignatureImage)
        XCTAssertNil(me.verifiedAt)
        XCTAssertNotNil(me.passwordChangedAt)
        XCTAssertNotNil(me.createdAt)
        XCTAssertNotNil(me.updatedAt)
        XCTAssertEqual(me.authProviders, [])
        XCTAssertNil(me.staffId)
        XCTAssertEqual(me.images, [])
        
        // Test specific date values
        XCTAssertEqual(me.createdAt.toDateString(FormConfig.DateFormat.yyyyMMdd), "2016-12-28")
        XCTAssertEqual(me.updatedAt.toDateString(FormConfig.DateFormat.yyyyMMdd), "2025-02-26")
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let me = createSampleMe()
        
        // Act
        let encoder = JSONEncoder()
        let data = try encoder.encode(me)
        let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(jsonObject)
        XCTAssertEqual(jsonObject?["id"] as? Int, 38)
        XCTAssertEqual(jsonObject?["email"] as? String, "test1@email.com")
        XCTAssertEqual(jsonObject?["first_name"] as? String, "John2")
        XCTAssertEqual(jsonObject?["last_name"] as? String, "Doe2")
        XCTAssertEqual(jsonObject?["phone_number"] as? String, "1234567890")
        XCTAssertEqual(jsonObject?["role"] as? String, "ROLE_SUPPORT_SUPER_ADMIN")
        XCTAssertEqual(jsonObject?["id_card"] as? String, "1232323232333")
        XCTAssertNil(jsonObject?["logo_image"])
        XCTAssertNil(jsonObject?["sign_signature_image"])
        XCTAssertNil(jsonObject?["verified_at"])
        XCTAssertNotNil(jsonObject?["password_changed_at"])
        XCTAssertNotNil(jsonObject?["created_at"])
        XCTAssertNotNil(jsonObject?["updated_at"])
        
        let authProviders = jsonObject?["auth_providers"] as? [String]
        XCTAssertEqual(authProviders, [])
        
        let images = jsonObject?["images"] as? [String]
        XCTAssertEqual(images, [])
        
        XCTAssertNil(jsonObject?["staff_id"])
    }
    
    // MARK: - Helper Methods
    
    private func createSampleMe() -> Me {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = FormConfig.DateFormat.datetimeISO
        
        return Me(
            id: 38,
            email: "test1@email.com",
            firstName: "John2",
            lastName: "Doe2",
            phoneNumber: "1234567890",
            role: .supportSuperAdmin,
            idCard: "1232323232333",
            logoImage: nil,
            signSignatureImage: nil,
            verifiedAt: nil,
            passwordChangedAt: "2023-11-28T06:11:43.011+07:00",
            authProviders: [],
            images: [],
            staffId: nil,
            createdAt: dateFormatter.date(from: "2016-12-28T20:54:08.650+07:00")!,
            updatedAt: dateFormatter.date(from: "2025-02-26T05:35:58.313+07:00")!
        )
    }
}
