//
//  LinkUnitTypeTests.swift
//  YourProject
//
//  Created by IntrodexMini on 3/7/2568 BE.
//

import XCTest

final class LinkUnitTypeTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let linkUnitType = createSampleLinkUnitType()
        
        // Assert
        XCTAssertEqual(linkUnitType.id, 1)
        XCTAssertEqual(linkUnitType.name, "link 1")
        XCTAssertEqual(linkUnitType.baseRate, 500.0)
        XCTAssertEqual(linkUnitType.hotelId, 105)
        XCTAssertTrue(linkUnitType.roomTypeIds.isEmpty)
        XCTAssertNotNil(linkUnitType.createdAt)
        XCTAssertNotNil(linkUnitType.updatedAt)
    }
    
    func test_initWithOptionalProperties() throws {
        // Arrange & Act
        let linkUnitType = createSampleLinkUnitType()
        
        // Assert
        XCTAssertNil(linkUnitType.description)
    }
    
    func test_initWithRoomTypeIds() throws {
        // Arrange
        let roomTypeIds = [101, 102, 103]
        
        // Act
        let linkUnitType = createSampleLinkUnitType(roomTypeIds: roomTypeIds)
        
        // Assert
        XCTAssertEqual(linkUnitType.roomTypeIds, roomTypeIds)
        XCTAssertEqual(linkUnitType.roomTypeIds.count, 3)
    }
    
    func test_initWithDescription() throws {
        // Arrange
        let description = "Test link unit type description"
        
        // Act
        let linkUnitType = createSampleLinkUnitType(description: description)
        
        // Assert
        XCTAssertEqual(linkUnitType.description, description)
    }
    
    func test_initWithDates() throws {
        // Arrange & Act
        let linkUnitType = createSampleLinkUnitType()
        
        // Assert
        XCTAssertNotNil(linkUnitType.createdAt)
        XCTAssertNotNil(linkUnitType.updatedAt)
        XCTAssertEqual(linkUnitType.createdAt.toDateString(FormConfig.DateFormat.yyyyMMdd), "2020-04-26")
        XCTAssertEqual(linkUnitType.updatedAt.toDateString(FormConfig.DateFormat.yyyyMMdd), "2020-04-26")
    }
    
    // MARK: - Property Tests
    
    func test_baseRateProperty() throws {
        // Arrange
        let expectedRate = 750.5
        
        // Act
        let linkUnitType = createSampleLinkUnitType(baseRate: expectedRate)
        
        // Assert
        XCTAssertEqual(linkUnitType.baseRate, expectedRate)
    }
    
    func test_hotelIdProperty() throws {
        // Arrange
        let expectedHotelId = 200
        
        // Act
        let linkUnitType = createSampleLinkUnitType(hotelId: expectedHotelId)
        
        // Assert
        XCTAssertEqual(linkUnitType.hotelId, expectedHotelId)
    }
    
    func test_nameProperty() throws {
        // Arrange
        let expectedName = "Premium Link Unit"
        
        // Act
        let linkUnitType = createSampleLinkUnitType(name: expectedName)
        
        // Assert
        XCTAssertEqual(linkUnitType.name, expectedName)
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
           "id": 1,
           "name": "link 1",
           "base_rate": "500.0",
           "description": null,
           "created_at": "2020-04-26T17:34:40.863+07:00",
           "updated_at": "2020-04-26T17:34:40.863+07:00",
           "room_type_ids": [],
           "hotel_id": 105
        }
        """.data(using: .utf8)!
        
        // Act
        let linkUnitType = try JSONDecoder().decode(LinkUnitType.self, from: json)
        
        // Assert
        XCTAssertEqual(linkUnitType.id, 1)
        XCTAssertEqual(linkUnitType.name, "link 1")
        XCTAssertEqual(linkUnitType.baseRate, 500.0)
        XCTAssertNil(linkUnitType.description)
        XCTAssertEqual(linkUnitType.hotelId, 105)
        XCTAssertTrue(linkUnitType.roomTypeIds.isEmpty)
        XCTAssertNotNil(linkUnitType.createdAt)
        XCTAssertNotNil(linkUnitType.updatedAt)
        XCTAssertEqual(linkUnitType.createdAt.toDateString(FormConfig.DateFormat.yyyyMMdd), "2020-04-26")
        XCTAssertEqual(linkUnitType.updatedAt.toDateString(FormConfig.DateFormat.yyyyMMdd), "2020-04-26")
    }
    
    func test_decodingFromJSONWithDescription() throws {
        // Arrange
        let json = """
        {
           "id": 2,
           "name": "link 2",
           "base_rate": "750.5",
           "description": "Test description",
           "created_at": "2020-04-26T17:34:40.863+07:00",
           "updated_at": "2020-04-26T17:34:40.863+07:00",
           "room_type_ids": [101, 102, 103],
           "hotel_id": 105
        }
        """.data(using: .utf8)!
        
        // Act
        let linkUnitType = try JSONDecoder().decode(LinkUnitType.self, from: json)
        
        // Assert
        XCTAssertEqual(linkUnitType.id, 2)
        XCTAssertEqual(linkUnitType.name, "link 2")
        XCTAssertEqual(linkUnitType.baseRate, 750.5)
        XCTAssertEqual(linkUnitType.description, "Test description")
        XCTAssertEqual(linkUnitType.hotelId, 105)
        XCTAssertEqual(linkUnitType.roomTypeIds, [101, 102, 103])
        XCTAssertEqual(linkUnitType.roomTypeIds.count, 3)
    }
    
    func test_decodingFromJSONWithEmptyRoomTypeIds() throws {
        // Arrange
        let json = """
        {
           "id": 3,
           "name": "link 3",
           "base_rate": "1000.0",
           "description": null,
           "created_at": "2020-04-26T17:34:40.863+07:00",
           "updated_at": "2020-04-26T17:34:40.863+07:00",
           "room_type_ids": [],
           "hotel_id": 105
        }
        """.data(using: .utf8)!
        
        // Act
        let linkUnitType = try JSONDecoder().decode(LinkUnitType.self, from: json)
        
        // Assert
        XCTAssertEqual(linkUnitType.id, 3)
        XCTAssertEqual(linkUnitType.name, "link 3")
        XCTAssertEqual(linkUnitType.baseRate, 1000.0)
        XCTAssertNil(linkUnitType.description)
        XCTAssertEqual(linkUnitType.hotelId, 105)
        XCTAssertTrue(linkUnitType.roomTypeIds.isEmpty)
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let linkUnitType = createSampleLinkUnitType()
        
        // Act
        let jsonData = try JSONEncoder().encode(linkUnitType)
        let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["id"] as? Int, 1)
        XCTAssertEqual(json?["name"] as? String, "link 1")
        XCTAssertEqual(json?["base_rate"] as? String, "500.0")
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertNotNil(json?["created_at"])
        XCTAssertNotNil(json?["updated_at"])
        
        let roomTypeIds = json?["room_type_ids"] as? [Int]
        XCTAssertNotNil(roomTypeIds)
        XCTAssertTrue(roomTypeIds?.isEmpty ?? false)
    }
    
    func test_encodingToJSONWithDescription() throws {
        // Arrange
        let linkUnitType = createSampleLinkUnitType(description: "Test description")
        
        // Act
        let jsonData = try JSONEncoder().encode(linkUnitType)
        let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["description"] as? String, "Test description")
    }
    
    func test_encodingToJSONWithRoomTypeIds() throws {
        // Arrange
        let roomTypeIds = [101, 102, 103]
        let linkUnitType = createSampleLinkUnitType(roomTypeIds: roomTypeIds)
        
        // Act
        let jsonData = try JSONEncoder().encode(linkUnitType)
        let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(json)
        let decodedRoomTypeIds = json?["room_type_ids"] as? [Int]
        XCTAssertEqual(decodedRoomTypeIds, roomTypeIds)
    }
    
    func test_roundTripEncodingDecoding() throws {
        // Arrange
        let originalLinkUnitType = createSampleLinkUnitType(
            description: "Round trip test",
            roomTypeIds: [101, 102, 103]
        )
        
        // Act
        let jsonData = try JSONEncoder().encode(originalLinkUnitType)
        let decodedLinkUnitType = try JSONDecoder().decode(LinkUnitType.self, from: jsonData)
        
        // Assert
        XCTAssertEqual(originalLinkUnitType.id, decodedLinkUnitType.id)
        XCTAssertEqual(originalLinkUnitType.name, decodedLinkUnitType.name)
        XCTAssertEqual(originalLinkUnitType.baseRate, decodedLinkUnitType.baseRate)
        XCTAssertEqual(originalLinkUnitType.description, decodedLinkUnitType.description)
        XCTAssertEqual(originalLinkUnitType.hotelId, decodedLinkUnitType.hotelId)
        XCTAssertEqual(originalLinkUnitType.roomTypeIds, decodedLinkUnitType.roomTypeIds)
        XCTAssertEqual(
            originalLinkUnitType.createdAt.toDateString(FormConfig.DateFormat.datetimeISO),
            decodedLinkUnitType.createdAt.toDateString(FormConfig.DateFormat.datetimeISO)
        )
        XCTAssertEqual(
            originalLinkUnitType.updatedAt.toDateString(FormConfig.DateFormat.datetimeISO),
            decodedLinkUnitType.updatedAt.toDateString(FormConfig.DateFormat.datetimeISO)
        )
    }
    
    // MARK: - Edge Cases Tests
    
    func test_decodingWithMissingRoomTypeIds() throws {
        // Arrange
        let json = """
        {
           "id": 4,
           "name": "link 4",
           "base_rate": "300.0",
           "description": null,
           "created_at": "2020-04-26T17:34:40.863+07:00",
           "updated_at": "2020-04-26T17:34:40.863+07:00",
           "hotel_id": 105
        }
        """.data(using: .utf8)!
        
        // Act
        let linkUnitType = try JSONDecoder().decode(LinkUnitType.self, from: json)
        
        // Assert
        XCTAssertEqual(linkUnitType.id, 4)
        XCTAssertEqual(linkUnitType.name, "link 4")
        XCTAssertEqual(linkUnitType.baseRate, 300.0)
        XCTAssertTrue(linkUnitType.roomTypeIds.isEmpty)
        XCTAssertEqual(linkUnitType.hotelId, 105)
    }
    
    func test_decodingWithInvalidRoomTypeIds() throws {
        // Arrange
        let json = """
        {
           "id": 5,
           "name": "link 5",
           "base_rate": "400.0",
           "description": null,
           "created_at": "2020-04-26T17:34:40.863+07:00",
           "updated_at": "2020-04-26T17:34:40.863+07:00",
           "room_type_ids": "invalid",
           "hotel_id": 105
        }
        """.data(using: .utf8)!
        
        // Act
        let linkUnitType = try JSONDecoder().decode(LinkUnitType.self, from: json)
        
        // Assert
        XCTAssertEqual(linkUnitType.id, 5)
        XCTAssertEqual(linkUnitType.name, "link 5")
        XCTAssertEqual(linkUnitType.baseRate, 400.0)
        XCTAssertTrue(linkUnitType.roomTypeIds.isEmpty) // Should default to empty array
        XCTAssertEqual(linkUnitType.hotelId, 105)
    }
    
    // MARK: - Helper Methods
    
    private func createSampleLinkUnitType(
        id: Int = 1,
        name: String = "link 1",
        baseRate: Double = 500.0,
        description: String? = nil,
        roomTypeIds: [Int] = [],
        hotelId: Int = 105
    ) -> LinkUnitType {
        let timestamp = 1587899680.863 // 2020-04-26T17:34:40.863+07:00
        let createdAt = Date(timeIntervalSince1970: timestamp)
        let updatedAt = Date(timeIntervalSince1970: timestamp)
        
        return LinkUnitType(
            id: id,
            name: name,
            baseRate: baseRate,
            description: description,
            roomTypeIds: roomTypeIds,
            hotelId: hotelId,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
} 