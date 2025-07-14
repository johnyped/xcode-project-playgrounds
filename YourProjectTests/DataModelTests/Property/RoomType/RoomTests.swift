//
//  RoomTests.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//

import XCTest

final class RoomTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithAllProperties() throws {
        // Arrange & Act
        let room = createSampleRoom()
        
        // Assert
        XCTAssertEqual(room.id, 1)
        XCTAssertEqual(room.roomTypeId, 180)
        XCTAssertEqual(room.code, "Test Room")
        XCTAssertEqual(room.order, 1)
        XCTAssertEqual(room.status, .available)
        XCTAssertTrue(room.needCleaning)
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 644,
            "code": "5",
            "status": "AVAILABLE", 
            "need_cleaning": true,
            "order": 0,
            "created_at": "2022-01-11T00:50:21.937+07:00",
            "updated_at": "2023-06-24T15:40:31.474+07:00",
            "room_type_id": 180
        }
        """.data(using: .utf8)!
        
        // Act
        let room = try JSONDecoder().decode(Room.self, from: json)
        
        // Assert
        XCTAssertEqual(room.id, 644)
        XCTAssertEqual(room.code, "5")
        XCTAssertEqual(room.status, .available)
        XCTAssertTrue(room.needCleaning)
        XCTAssertEqual(room.order, 0)
        XCTAssertEqual(room.roomTypeId, 180)
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let room = createSampleRoom()
        
        // Act
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(room)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        
        // Assert
        XCTAssertTrue(jsonString.contains("\"id\" : 1"))
        XCTAssertTrue(jsonString.contains("\"room_type_id\" : 180"))
        XCTAssertTrue(jsonString.contains("\"code\" : \"Test Room\""))
        XCTAssertTrue(jsonString.contains("\"order\" : 1"))
        XCTAssertTrue(jsonString.contains("\"status\" : \"AVAILABLE\""))
        XCTAssertTrue(jsonString.contains("\"need_cleaning\" : true"))
    }
    
    // MARK: - Helper Methods
    
    private func createSampleRoom() -> Room {
        return Room(
            id: 1,
            roomTypeId: 180,
            code: "Test Room",
            order: 1,
            status: .available,
            needCleaning: true,
            createdAt: Date(timeIntervalSince1970: 1000),
            updatedAt: Date(timeIntervalSince1970: 2000)
        )
    }
}
