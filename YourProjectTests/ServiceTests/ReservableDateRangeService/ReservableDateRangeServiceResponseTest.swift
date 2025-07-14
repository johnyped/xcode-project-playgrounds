//
//  ReservableDateRangeServiceResponseTest.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//

import XCTest

final class ReservableDateRangeServiceResponseTests: XCTestCase {
    
    typealias ReservedDateRange = ReservableDateRangeServiceResponse.ReservedDateRange
    typealias Room = ReservableDateRangeServiceResponse.Room
    
    // MARK: - Initialization Tests
    
    func test_initReservedDateRangeWithRequiredProperties() throws {
        // Arrange & Act
        let reservedDateRange = createSampleReservedDateRange()
        
        // Assert
        XCTAssertEqual(reservedDateRange.rooms.count, 2)
        
        let firstRoom = reservedDateRange.rooms[0]
        XCTAssertEqual(firstRoom.roomId, 643)
        XCTAssertEqual(firstRoom.reservableDateRanges.count, 4)
        
        let secondRoom = reservedDateRange.rooms[1]
        XCTAssertEqual(secondRoom.roomId, 642)
        XCTAssertEqual(secondRoom.reservableDateRanges.count, 4)
    }
    
    func test_initRoomWithRequiredProperties() throws {
        // Arrange & Act
        let room = createSampleRoom()
        
        // Assert
        XCTAssertEqual(room.roomId, 643)
        XCTAssertEqual(room.reservableDateRanges.count, 4)
        XCTAssertNotNil(room.reservableDateRanges.first)
    }
    
    func test_initRoomWithEmptyDates() throws {
        // Arrange & Act
        let room = Room(roomId: 100, reservableDateRanges: [])
        
        // Assert
        XCTAssertEqual(room.roomId, 100)
        XCTAssertTrue(room.reservableDateRanges.isEmpty)
    }
    
    // MARK: - Codable Tests
    
    func test_decodingReservedDateRangeFromJSON() throws {
        // Arrange
        let json = """
        {
            "rooms": [
                {
                    "room_id": 643,
                    "reservable_date_ranges": [
                        "2025-06-27",
                        "2025-06-28",
                        "2025-06-29",
                        "2025-06-30"
                    ]
                },
                {
                    "room_id": 642,
                    "reservable_date_ranges": [
                        "2025-06-27",
                        "2025-06-28",
                        "2025-06-29",
                        "2025-06-30"
                    ]
                }
            ]
        }
        """.data(using: .utf8)!
        
        // Act
        let reservedDateRange = try JSONDecoder().decode(ReservedDateRange.self, from: json)
        
        // Assert
        XCTAssertEqual(reservedDateRange.rooms.count, 2)
        
        let firstRoom = reservedDateRange.rooms[0]
        XCTAssertEqual(firstRoom.roomId, 643)
        XCTAssertEqual(firstRoom.reservableDateRanges.count, 4)
        
        let secondRoom = reservedDateRange.rooms[1]
        XCTAssertEqual(secondRoom.roomId, 642)
        XCTAssertEqual(secondRoom.reservableDateRanges.count, 4)
        
        // Verify dates are correctly parsed
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.locale = Locale(identifier: "en")
        
        let expectedDate = formatter.date(from: "2025-06-27")!
        XCTAssertEqual(firstRoom.reservableDateRanges.first, expectedDate)
    }
    
    func test_decodingRoomFromJSON() throws {
        // Arrange
        let json = """
        {
            "room_id": 643,
            "reservable_date_ranges": [
                "2025-06-27",
                "2025-06-28",
                "2025-06-29",
                "2025-06-30"
            ]
        }
        """.data(using: .utf8)!
        
        // Act
        let room = try JSONDecoder().decode(Room.self, from: json)
        
        // Assert
        XCTAssertEqual(room.roomId, 643)
        XCTAssertEqual(room.reservableDateRanges.count, 4)
        
        // Verify dates are correctly parsed
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.locale = Locale(identifier: "en")
        
        let expectedDates = [
            formatter.date(from: "2025-06-27")!,
            formatter.date(from: "2025-06-28")!,
            formatter.date(from: "2025-06-29")!,
            formatter.date(from: "2025-06-30")!
        ]
        
        XCTAssertEqual(room.reservableDateRanges, expectedDates)
    }
    
    func test_encodingReservedDateRangeToJSON() throws {
        // Arrange
        let reservedDateRange = createSampleReservedDateRange()
        
        // Act
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        let jsonData = try encoder.encode(reservedDateRange)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        
        // Assert
        XCTAssertTrue(jsonString.contains("\"rooms\""))
        XCTAssertTrue(jsonString.contains("\"room_id\":643"))
        XCTAssertTrue(jsonString.contains("\"room_id\":642"))
        XCTAssertTrue(jsonString.contains("\"reservable_date_ranges\""))
        XCTAssertTrue(jsonString.contains("\"2025-06-27\""))
        XCTAssertTrue(jsonString.contains("\"2025-06-30\""))
    }
    
    func test_encodingRoomToJSON() throws {
        // Arrange
        let room = createSampleRoom()
        
        // Act
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        let jsonData = try encoder.encode(room)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        
        // Assert
        XCTAssertTrue(jsonString.contains("\"room_id\":643"))
        XCTAssertTrue(jsonString.contains("\"reservable_date_ranges\""))
        XCTAssertTrue(jsonString.contains("\"2025-06-27\""))
        XCTAssertTrue(jsonString.contains("\"2025-06-30\""))
    }
    
    // MARK: - Edge Cases Tests
    
    func test_decodingEmptyRooms() throws {
        // Arrange
        let json = """
        {
            "rooms": []
        }
        """.data(using: .utf8)!
        
        // Act
        let reservedDateRange = try JSONDecoder().decode(ReservedDateRange.self, from: json)
        
        // Assert
        XCTAssertTrue(reservedDateRange.rooms.isEmpty)
    }
    
    func test_decodingRoomWithEmptyDates() throws {
        // Arrange
        let json = """
        {
            "room_id": 100,
            "reservable_date_ranges": []
        }
        """.data(using: .utf8)!
        
        // Act
        let room = try JSONDecoder().decode(Room.self, from: json)
        
        // Assert
        XCTAssertEqual(room.roomId, 100)
        XCTAssertTrue(room.reservableDateRanges.isEmpty)
    }
    
    func test_decodingRoomWithInvalidDates() throws {
        // Arrange
        let json = """
        {
            "room_id": 100,
            "reservable_date_ranges": [
                "2025-06-27",
                "invalid-date",
                "2025-06-28",
                ""
            ]
        }
        """.data(using: .utf8)!
        
        // Act
        let room = try JSONDecoder().decode(Room.self, from: json)
        
        // Assert
        XCTAssertEqual(room.roomId, 100)
        // Only valid dates should be included (invalid ones filtered out by compactMap)
        XCTAssertEqual(room.reservableDateRanges.count, 2)
        
        // Verify that valid dates are correctly parsed
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.locale = Locale(identifier: "en")
        
        let expectedDates = [
            formatter.date(from: "2025-06-27")!,
            formatter.date(from: "2025-06-28")!
        ]
        
        XCTAssertEqual(room.reservableDateRanges, expectedDates)
    }
    
    func test_roundTripEncodeDecodeConsistency() throws {
        // Arrange
        let originalReservedDateRange = createSampleReservedDateRange()
        
        // Act - Encode then decode
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(originalReservedDateRange)
        let decodedReservedDateRange = try JSONDecoder().decode(ReservedDateRange.self, from: jsonData)
        
        // Assert
        XCTAssertEqual(originalReservedDateRange.rooms.count, decodedReservedDateRange.rooms.count)
        
        for (original, decoded) in zip(originalReservedDateRange.rooms, decodedReservedDateRange.rooms) {
            XCTAssertEqual(original.roomId, decoded.roomId)
            XCTAssertEqual(original.reservableDateRanges.count, decoded.reservableDateRanges.count)
            XCTAssertEqual(original.reservableDateRanges, decoded.reservableDateRanges)
        }
    }
    
    // MARK: - Helper Methods
    
    private func createSampleReservedDateRange() -> ReservedDateRange {
        let room1 = createSampleRoom()
        let room2 = createSampleRoom(roomId: 642)
        
        return ReservedDateRange(rooms: [room1, room2])
    }
    
    private func createSampleRoom(roomId: Int = 643) -> Room {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.locale = Locale(identifier: "en")
        
        let dates = [
            formatter.date(from: "2025-06-27")!,
            formatter.date(from: "2025-06-28")!,
            formatter.date(from: "2025-06-29")!,
            formatter.date(from: "2025-06-30")!
        ]
        
        return Room(roomId: roomId, reservableDateRanges: dates)
    }
    
    private func createSampleRoomWithCustomDates(roomId: Int, dateStrings: [String]) -> Room {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.locale = Locale(identifier: "en")
        
        let dates = dateStrings.compactMap { formatter.date(from: $0) }
        
        return Room(roomId: roomId, reservableDateRanges: dates)
    }
} 