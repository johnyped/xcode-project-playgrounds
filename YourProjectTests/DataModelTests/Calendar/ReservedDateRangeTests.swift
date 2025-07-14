//
//  ReservedDateRangeTests.swift
//  YourProject
//
//  Created by IntrodexMini on 5/7/2568 BE.
//

import XCTest

final class ReservedDateRangeTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let reservedDateRange = createSampleReservedDateRange()
        
        // Assert
        XCTAssertEqual(reservedDateRange.rooms.count, 2)
        XCTAssertEqual(reservedDateRange.rooms[0].roomId, 643)
        XCTAssertEqual(reservedDateRange.rooms[1].roomId, 642)
        XCTAssertEqual(reservedDateRange.rooms[0].reservableDateRanges.count, 4)
        XCTAssertEqual(reservedDateRange.rooms[1].reservableDateRanges.count, 4)
    }
    
    func test_initWithEmptyRooms() throws {
        // Arrange & Act
        let reservedDateRange = ReservedDateRange(rooms: [])
        
        // Assert
        XCTAssertTrue(reservedDateRange.rooms.isEmpty)
    }
    
    func test_initWithSingleRoom() throws {
        // Arrange
        let room = createSampleRoom()
        
        // Act
        let reservedDateRange = ReservedDateRange(rooms: [room])
        
        // Assert
        XCTAssertEqual(reservedDateRange.rooms.count, 1)
        XCTAssertEqual(reservedDateRange.rooms[0].roomId, 643)
        XCTAssertEqual(reservedDateRange.rooms[0].reservableDateRanges.count, 4)
    }
    
    // MARK: - Room Tests
    
    func test_roomInitWithRequiredProperties() throws {
        // Arrange & Act
        let room = createSampleRoom()
        
        // Assert
        XCTAssertEqual(room.roomId, 643)
        XCTAssertEqual(room.reservableDateRanges.count, 4)
        XCTAssertEqual(room.reservableDateRanges[0], "2025-06-27".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(room.reservableDateRanges[1], "2025-06-28".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(room.reservableDateRanges[2], "2025-06-29".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(room.reservableDateRanges[3], "2025-06-30".toDate(FormConfig.DateFormat.yyyyMMdd))
    }
    
    func test_roomInitWithEmptyDateRanges() throws {
        // Arrange & Act
        let room = ReservedDateRange.Room(roomId: 100, reservableDateRanges: [])
        
        // Assert
        XCTAssertEqual(room.roomId, 100)
        XCTAssertTrue(room.reservableDateRanges.isEmpty)
    }
    
    func test_roomInitWithSingleDateRange() throws {
        // Arrange
        guard let date = "2025-06-27".toDate(FormConfig.DateFormat.yyyyMMdd) else {
            XCTFail("Failed to create date")
            return
        }
        
        // Act
        let room = ReservedDateRange.Room(roomId: 200, reservableDateRanges: [date])
        
        // Assert
        XCTAssertEqual(room.roomId, 200)
        XCTAssertEqual(room.reservableDateRanges.count, 1)
        XCTAssertEqual(room.reservableDateRanges[0], date)
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
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
        
        // First room
        XCTAssertEqual(reservedDateRange.rooms[0].roomId, 643)
        XCTAssertEqual(reservedDateRange.rooms[0].reservableDateRanges.count, 4)
        XCTAssertEqual(reservedDateRange.rooms[0].reservableDateRanges[0], "2025-06-27".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(reservedDateRange.rooms[0].reservableDateRanges[1], "2025-06-28".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(reservedDateRange.rooms[0].reservableDateRanges[2], "2025-06-29".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(reservedDateRange.rooms[0].reservableDateRanges[3], "2025-06-30".toDate(FormConfig.DateFormat.yyyyMMdd))
        
        // Second room
        XCTAssertEqual(reservedDateRange.rooms[1].roomId, 642)
        XCTAssertEqual(reservedDateRange.rooms[1].reservableDateRanges.count, 4)
        XCTAssertEqual(reservedDateRange.rooms[1].reservableDateRanges[0], "2025-06-27".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(reservedDateRange.rooms[1].reservableDateRanges[1], "2025-06-28".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(reservedDateRange.rooms[1].reservableDateRanges[2], "2025-06-29".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(reservedDateRange.rooms[1].reservableDateRanges[3], "2025-06-30".toDate(FormConfig.DateFormat.yyyyMMdd))
    }
    
    func test_decodingFromJSONWithEmptyRooms() throws {
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
    
    func test_decodingFromJSONWithEmptyDateRanges() throws {
        // Arrange
        let json = """
        {
            "rooms": [
                {
                    "room_id": 643,
                    "reservable_date_ranges": []
                }
            ]
        }
        """.data(using: .utf8)!
        
        // Act
        let reservedDateRange = try JSONDecoder().decode(ReservedDateRange.self, from: json)
        
        // Assert
        XCTAssertEqual(reservedDateRange.rooms.count, 1)
        XCTAssertEqual(reservedDateRange.rooms[0].roomId, 643)
        XCTAssertTrue(reservedDateRange.rooms[0].reservableDateRanges.isEmpty)
    }
    
    func test_decodingFromJSONWithInvalidDateFormat() throws {
        // Arrange
        let json = """
        {
            "rooms": [
                {
                    "room_id": 643,
                    "reservable_date_ranges": [
                        "2025-06-27",
                        "invalid-date",
                        "2025-06-29"
                    ]
                }
            ]
        }
        """.data(using: .utf8)!
        
        // Act
        let reservedDateRange = try JSONDecoder().decode(ReservedDateRange.self, from: json)
        
        // Assert
        XCTAssertEqual(reservedDateRange.rooms.count, 1)
        XCTAssertEqual(reservedDateRange.rooms[0].roomId, 643)
        XCTAssertEqual(reservedDateRange.rooms[0].reservableDateRanges.count, 2) // Invalid date should be filtered out
        XCTAssertEqual(reservedDateRange.rooms[0].reservableDateRanges[0], "2025-06-27".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(reservedDateRange.rooms[0].reservableDateRanges[1], "2025-06-29".toDate(FormConfig.DateFormat.yyyyMMdd))
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let reservedDateRange = createSampleReservedDateRange()
        
        // Act
        let data = try JSONEncoder().encode(reservedDateRange)
        let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
        
        // Assert
        let rooms = json["rooms"] as! [[String: Any]]
        XCTAssertEqual(rooms.count, 2)
        
        // First room
        XCTAssertEqual(rooms[0]["room_id"] as! Int, 643)
        let firstRoomDates = rooms[0]["reservable_date_ranges"] as! [String]
        XCTAssertEqual(firstRoomDates.count, 4)
        XCTAssertEqual(firstRoomDates[0], "2025-06-27")
        XCTAssertEqual(firstRoomDates[1], "2025-06-28")
        XCTAssertEqual(firstRoomDates[2], "2025-06-29")
        XCTAssertEqual(firstRoomDates[3], "2025-06-30")
        
        // Second room
        XCTAssertEqual(rooms[1]["room_id"] as! Int, 642)
        let secondRoomDates = rooms[1]["reservable_date_ranges"] as! [String]
        XCTAssertEqual(secondRoomDates.count, 4)
        XCTAssertEqual(secondRoomDates[0], "2025-06-27")
        XCTAssertEqual(secondRoomDates[1], "2025-06-28")
        XCTAssertEqual(secondRoomDates[2], "2025-06-29")
        XCTAssertEqual(secondRoomDates[3], "2025-06-30")
    }
    
    func test_encodingEmptyRoomsToJSON() throws {
        // Arrange
        let reservedDateRange = ReservedDateRange(rooms: [])
        
        // Act
        let data = try JSONEncoder().encode(reservedDateRange)
        let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
        
        // Assert
        let rooms = json["rooms"] as! [[String: Any]]
        XCTAssertTrue(rooms.isEmpty)
    }
    
    func test_roundTripEncodeDecodeJSON() throws {
        // Arrange
        let original = createSampleReservedDateRange()
        
        // Act
        let encoded = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(ReservedDateRange.self, from: encoded)
        
        // Assert
        XCTAssertEqual(decoded.rooms.count, original.rooms.count)
        
        for (index, room) in decoded.rooms.enumerated() {
            XCTAssertEqual(room.roomId, original.rooms[index].roomId)
            XCTAssertEqual(room.reservableDateRanges.count, original.rooms[index].reservableDateRanges.count)
            
            for (dateIndex, date) in room.reservableDateRanges.enumerated() {
                XCTAssertEqual(date, original.rooms[index].reservableDateRanges[dateIndex])
            }
        }
    }
    
    // MARK: - Edge Cases Tests
    
    func test_roomWithLargeRoomId() throws {
        // Arrange & Act
        let room = ReservedDateRange.Room(roomId: Int.max, reservableDateRanges: [])
        
        // Assert
        XCTAssertEqual(room.roomId, Int.max)
        XCTAssertTrue(room.reservableDateRanges.isEmpty)
    }
    
    func test_roomWithZeroRoomId() throws {
        // Arrange & Act
        let room = ReservedDateRange.Room(roomId: 0, reservableDateRanges: [])
        
        // Assert
        XCTAssertEqual(room.roomId, 0)
        XCTAssertTrue(room.reservableDateRanges.isEmpty)
    }
    
    func test_roomWithManyDateRanges() throws {
        // Arrange
        let dates = (1...100).compactMap { day in
            "2025-06-\(String(format: "%02d", day))".toDate(FormConfig.DateFormat.yyyyMMdd)
        }
        
        // Act
        let room = ReservedDateRange.Room(roomId: 999, reservableDateRanges: Array(dates.prefix(30)))
        
        // Assert
        XCTAssertEqual(room.roomId, 999)
        XCTAssertEqual(room.reservableDateRanges.count, 30)
    }
    
    // MARK: - Helper Methods
    
    private func createSampleRoom() -> ReservedDateRange.Room {
        let dates = [
            "2025-06-27".toDate(FormConfig.DateFormat.yyyyMMdd)!,
            "2025-06-28".toDate(FormConfig.DateFormat.yyyyMMdd)!,
            "2025-06-29".toDate(FormConfig.DateFormat.yyyyMMdd)!,
            "2025-06-30".toDate(FormConfig.DateFormat.yyyyMMdd)!
        ]
        
        return ReservedDateRange.Room(roomId: 643, reservableDateRanges: dates)
    }
    
    private func createSampleReservedDateRange() -> ReservedDateRange {
        let dates = [
            "2025-06-27".toDate(FormConfig.DateFormat.yyyyMMdd)!,
            "2025-06-28".toDate(FormConfig.DateFormat.yyyyMMdd)!,
            "2025-06-29".toDate(FormConfig.DateFormat.yyyyMMdd)!,
            "2025-06-30".toDate(FormConfig.DateFormat.yyyyMMdd)!
        ]
        
        let room1 = ReservedDateRange.Room(roomId: 643, reservableDateRanges: dates)
        let room2 = ReservedDateRange.Room(roomId: 642, reservableDateRanges: dates)
        
        return ReservedDateRange(rooms: [room1, room2])
    }
} 
