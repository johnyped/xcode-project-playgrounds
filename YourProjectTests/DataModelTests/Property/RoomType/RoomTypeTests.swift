//
//  RoomTypeTests.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//

import XCTest

final class RoomTypeTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithAllProperties() throws {
        // Arrange & Act
        let roomType = createSampleRoomType()
        
        // Assert
        XCTAssertEqual(roomType.id, 1)
        XCTAssertEqual(roomType.hotelId, 105)
        XCTAssertEqual(roomType.order, 1)
        XCTAssertEqual(roomType.name, "Test Room")
        XCTAssertEqual(roomType.description, "Test Description")
        XCTAssertEqual(roomType.baseRate, 500.0, accuracy: 0.001)
        XCTAssertEqual(roomType.baseGuestNumber, 2)
        XCTAssertEqual(roomType.extraBedRate, 200.0, accuracy: 0.001)
        XCTAssertEqual(roomType.extraGuestRate, 300.0, accuracy: 0.001)
        XCTAssertEqual(roomType.maxExtraBedNumber, 1)
        XCTAssertEqual(roomType.maxExtraGuestNumber, 2)
        XCTAssertEqual(roomType.limitedNumberOfCMUnits, 5)
    }
    
    func test_initWithOptionalPropertiesAsNil() throws {
        // Arrange & Act
        let roomType = RoomType(id: 1,
                                order: 1,
                                hotelId: 105,
                                name: "Test Room",
                                description: "Test Description",
                                baseRate: 500.0,
                                baseGuestNumber: 2,
                                extraBedRate: 200.0,
                                extraGuestRate: 300.0,
                                maxExtraBedNumber: 1,
                                maxExtraGuestNumber: 2,
                                limitedNumberOfCmUnits: nil,
                                createdAt: Date(timeIntervalSince1970: 1000),
                                updatedAt: Date(timeIntervalSince1970: 2000))
        
        // Assert
        XCTAssertNil(roomType.limitedNumberOfCMUnits)
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 179,
            "name": "Duluxe Room",
            "base_rate": "520.00",
            "base_guest_number": 30,
            "extra_bed_rate": "500.00",
            "extra_guest_rate": "200.00",
            "max_extra_bed_number": 1,
            "max_extra_guest_number": 1,
            "limited_number_of_cm_units": null,
            "description": "test description",
            "order": 0,
            "created_at": "2019-11-28T11:08:41.259+07:00",
            "updated_at": "2024-05-23T14:12:58.166+07:00",
            "hotel_id": 105
        }
        """.data(using: .utf8)!
        
        // Act
        let roomType = try JSONDecoder().decode(RoomType.self, from: json)
        
        // Assert
        XCTAssertEqual(roomType.id, 179)
        XCTAssertEqual(roomType.name, "Duluxe Room")
        XCTAssertEqual(roomType.baseRate, 520.0, accuracy: 0.001)
        XCTAssertEqual(roomType.baseGuestNumber, 30)
        XCTAssertEqual(roomType.extraBedRate, 500.0, accuracy: 0.001)
        XCTAssertEqual(roomType.extraGuestRate, 200.0, accuracy: 0.001)
        XCTAssertEqual(roomType.maxExtraBedNumber, 1)
        XCTAssertEqual(roomType.maxExtraGuestNumber, 1)
        XCTAssertNil(roomType.limitedNumberOfCMUnits)
        XCTAssertEqual(roomType.description, "test description")
        XCTAssertEqual(roomType.order, 0)
        XCTAssertEqual(roomType.hotelId, 105)
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let roomType = createSampleRoomType()
        
        // Act
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(roomType)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        
        // Assert
        XCTAssertTrue(jsonString.contains("\"id\" : 1"))
        XCTAssertTrue(jsonString.contains("\"hotel_id\" : 105"))
        XCTAssertTrue(jsonString.contains("\"name\" : \"Test Room\""))
        XCTAssertTrue(jsonString.contains("\"base_rate\" : \"500.0\""))
        XCTAssertTrue(jsonString.contains("\"base_guest_number\" : 2"))
        XCTAssertTrue(jsonString.contains("\"extra_bed_rate\" : \"200.0\""))
        XCTAssertTrue(jsonString.contains("\"extra_guest_rate\" : \"300.0\""))
        XCTAssertTrue(jsonString.contains("\"max_extra_bed_number\" : 1"))
        XCTAssertTrue(jsonString.contains("\"max_extra_guest_number\" : 2"))
        XCTAssertTrue(jsonString.contains("\"limited_number_of_cm_units\" : 5"))
    }
    
    // MARK: - Helper Methods
    
    private func createSampleRoomType() -> RoomType {
        return RoomType(id: 1,
                        order: 1,
                        hotelId: 105,
                        name: "Test Room",
                        description: "Test Description",
                        baseRate: 500.0,
                        baseGuestNumber: 2,
                        extraBedRate: 200.0,
                        extraGuestRate: 300.0,
                        maxExtraBedNumber: 1,
                        maxExtraGuestNumber: 2,
                        limitedNumberOfCmUnits: 5,
                        createdAt: Date(timeIntervalSince1970: 1000),
                        updatedAt: Date(timeIntervalSince1970: 2000))
    }
}
