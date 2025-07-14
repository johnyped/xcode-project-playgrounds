//
//  CreatorTests.swift
//  YourProject
//
//  Created by IntrodexMini on 1/7/2568 BE.
//

import XCTest

final class CreatorTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithAllProperties() throws {
        // Arrange & Act
        let creator = Creator(
            id: 38,
            email: "test1@email.com",
            firstName: "John2",
            lastName: "Doe2",
            logoImage: "logo.png",
            staffId: 1,
            role: .user
        )
        
        // Assert
        XCTAssertEqual(creator.id, 38)
        XCTAssertEqual(creator.email, "test1@email.com")
        XCTAssertEqual(creator.firstName, "John2")
        XCTAssertEqual(creator.lastName, "Doe2")
        XCTAssertEqual(creator.logoImage, "logo.png")
        XCTAssertEqual(creator.staffId, 1)
        XCTAssertEqual(creator.role, .user)
    }
    
    func test_initWithRequiredPropertiesOnly() throws {
        // Arrange & Act
        let creator = Creator(
            id: 1,
            email: "user@example.com",
            firstName: "John",
            lastName: "Doe"
        )
        
        // Assert
        XCTAssertEqual(creator.id, 1)
        XCTAssertEqual(creator.email, "user@example.com")
        XCTAssertEqual(creator.firstName, "John")
        XCTAssertEqual(creator.lastName, "Doe")
        XCTAssertNil(creator.logoImage)
        XCTAssertNil(creator.staffId)
        XCTAssertNil(creator.role)
    }
    
    func test_initWithOptionalProperties() throws {
        // Arrange & Act
        let creator = createSampleCreator()
        
        // Assert
        XCTAssertEqual(creator.id, 38)
        XCTAssertEqual(creator.email, "test1@email.com")
        XCTAssertEqual(creator.firstName, "John2")
        XCTAssertEqual(creator.lastName, "Doe2")
        XCTAssertNil(creator.logoImage)
        XCTAssertNil(creator.staffId)
        XCTAssertEqual(creator.role, .supportSuperAdmin)
    }
    
    // MARK: - Role Enum Tests
    
    func test_roleRawValues() throws {
        XCTAssertEqual(Creator.Role.user.rawValue, "ROLE_USER")
        XCTAssertEqual(Creator.Role.admin.rawValue, "ROLE_ADMIN")
        XCTAssertEqual(Creator.Role.superAdmin.rawValue, "ROLE_SUPER_ADMIN")
        XCTAssertEqual(Creator.Role.supportSuperAdmin.rawValue, "ROLE_SUPPORT_SUPER_ADMIN")
    }
    
    func test_roleFromRawValue() throws {
        XCTAssertEqual(Creator.Role(rawValue: "ROLE_USER"), .user)
        XCTAssertEqual(Creator.Role(rawValue: "ROLE_ADMIN"), .admin)
        XCTAssertEqual(Creator.Role(rawValue: "ROLE_SUPER_ADMIN"), .superAdmin)
        XCTAssertEqual(Creator.Role(rawValue: "ROLE_SUPPORT_SUPER_ADMIN"), .supportSuperAdmin)
        XCTAssertNil(Creator.Role(rawValue: "INVALID_ROLE"))
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
            "logo_image": null,
            "staff_id": null,
            "role": "ROLE_SUPPORT_SUPER_ADMIN"
        }
        """.data(using: .utf8)!
        
        // Act
        let creator = try JSONDecoder().decode(Creator.self, from: json)
        
        // Assert
        XCTAssertEqual(creator.id, 38)
        XCTAssertEqual(creator.email, "test1@email.com")
        XCTAssertEqual(creator.firstName, "John2")
        XCTAssertEqual(creator.lastName, "Doe2")
        XCTAssertNil(creator.logoImage)
        XCTAssertNil(creator.staffId)
        XCTAssertEqual(creator.role, .supportSuperAdmin)
    }
    
    func test_decodingWithMissingOptionalFields() throws {
        // Arrange
        let json = """
        {
            "id": 1,
            "email": "user@example.com",
            "first_name": "John",
            "last_name": "Doe"
        }
        """.data(using: .utf8)!
        
        // Act
        let creator = try JSONDecoder().decode(Creator.self, from: json)
        
        // Assert
        XCTAssertEqual(creator.id, 1)
        XCTAssertEqual(creator.email, "user@example.com")
        XCTAssertEqual(creator.firstName, "John")
        XCTAssertEqual(creator.lastName, "Doe")
        XCTAssertNil(creator.logoImage)
        XCTAssertNil(creator.staffId)
        XCTAssertNil(creator.role)
    }
    
    func test_decodingWithEmptyStrings() throws {
        // Arrange - Testing the custom decoder logic that provides default empty strings
        let json = """
        {
            "id": 2,
            "email": null,
            "first_name": null,
            "last_name": null,
            "logo_image": "logo.png",
            "staff_id": 1,
            "role": "ROLE_USER"
        }
        """.data(using: .utf8)!
        
        // Act
        let creator = try JSONDecoder().decode(Creator.self, from: json)
        
        // Assert
        XCTAssertEqual(creator.id, 2)
        XCTAssertEqual(creator.email, "") // Should default to empty string
        XCTAssertEqual(creator.firstName, "") // Should default to empty string
        XCTAssertEqual(creator.lastName, "") // Should default to empty string
        XCTAssertEqual(creator.logoImage, "logo.png")
        XCTAssertEqual(creator.staffId, 1)
        XCTAssertEqual(creator.role, .user)
    }
    
    func test_decodingWithAllRoles() throws {
        let testCases: [(roleString: String, expectedRole: Creator.Role)] = [
            ("ROLE_USER", .user),
            ("ROLE_ADMIN", .admin),
            ("ROLE_SUPER_ADMIN", .superAdmin),
            ("ROLE_SUPPORT_SUPER_ADMIN", .supportSuperAdmin)
        ]
        
        for testCase in testCases {
            // Arrange
            let json = """
            {
                "id": 1,
                "email": "test@example.com",
                "first_name": "Test",
                "last_name": "User",
                "role": "\(testCase.roleString)"
            }
            """.data(using: .utf8)!
            
            // Act
            let creator = try JSONDecoder().decode(Creator.self, from: json)
            
            // Assert
            XCTAssertEqual(creator.role, testCase.expectedRole, "Failed for role: \(testCase.roleString)")
        }
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let creator = createSampleCreator()
        
        // Act
        let data = try JSONEncoder().encode(creator)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["id"] as? Int, 38)
        XCTAssertEqual(json?["email"] as? String, "test1@email.com")
        XCTAssertEqual(json?["first_name"] as? String, "John2")
        XCTAssertEqual(json?["last_name"] as? String, "Doe2")
        XCTAssertEqual(json?["role"] as? String, "ROLE_SUPPORT_SUPER_ADMIN")
        
        // Verify null values are encoded correctly
        XCTAssertTrue(json?["logo_image"] is NSNull)
        XCTAssertTrue(json?["staff_id"] is NSNull)
    }
    
    func test_encodingAndDecodingRoundTrip() throws {
        // Arrange
        let originalCreator = Creator(
            id: 100,
            email: "roundtrip@test.com",
            firstName: "Round",
            lastName: "Trip",
            logoImage: "test_logo.png",
            staffId: 1,
            role: .admin
        )
        
        // Act - Encode then decode
        let encodedData = try JSONEncoder().encode(originalCreator)
        let decodedCreator = try JSONDecoder().decode(Creator.self, from: encodedData)
        
        // Assert
        XCTAssertEqual(originalCreator.id, decodedCreator.id)
        XCTAssertEqual(originalCreator.email, decodedCreator.email)
        XCTAssertEqual(originalCreator.firstName, decodedCreator.firstName)
        XCTAssertEqual(originalCreator.lastName, decodedCreator.lastName)
        XCTAssertEqual(originalCreator.logoImage, decodedCreator.logoImage)
        XCTAssertEqual(originalCreator.staffId, decodedCreator.staffId)
        XCTAssertEqual(originalCreator.role, decodedCreator.role)
    }
    
    // MARK: - Helper Methods
    
    private func createSampleCreator() -> Creator {
        return Creator(
            id: 38,
            email: "test1@email.com",
            firstName: "John2",
            lastName: "Doe2",
            logoImage: nil,
            staffId: nil,
            role: .supportSuperAdmin
        )
    }
} 
