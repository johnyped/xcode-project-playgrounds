//
//  BookingChannelTests.swift
//  YourProject
//
//  Created by IntrodexMac on 10/5/2568 BE.
//

import XCTest

final class BookingChannelTests: XCTestCase {
    
    func testChannelDecoding() throws {
        // Given
        let jsonString = """
        {
            "id": 4,
            "name": "Social Media",
            "fee_rate": "1.23",
            "created_at": "2017-01-18T11:30:40.415+07:00",
            "updated_at": "2017-03-09T23:51:29.629+07:00",
            "sub_channels": [
                {
                    "id": 31,
                    "name": "Travel together (เที่ยวด้วยกัน)",
                    "fee_rate": "0.0",
                    "created_at": "2024-02-26T21:32:48.594+07:00",
                    "updated_at": "2024-02-26T21:32:48.594+07:00"
                }
            ]
        }
        """
        
        let jsonData = jsonString.data(using: .utf8)!
        
        // When
        let channel = try JSONDecoder().decode(BookingChannel.self, from: jsonData)
        
        // Then
        XCTAssertEqual(channel.id, 4)
        XCTAssertEqual(channel.name, "Social Media")
        XCTAssertEqual(channel.feeRate, 1.23, accuracy: 0.0001)
        XCTAssertEqual(channel.subChannels.count, 1)        
        
        // Test sub-channel
        let subChannel = channel.subChannels[0]
        XCTAssertEqual(subChannel.id, 31)
        XCTAssertEqual(subChannel.name, "Travel together (เที่ยวด้วยกัน)")
        XCTAssertEqual(subChannel.feeRate, 0.0)
    }
    
    func testChannelEncoding() throws {
        // Given
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        let createdAt = dateFormatter.date(from: "2017-01-18T11:30:40.415+07:00")!
        let updatedAt = dateFormatter.date(from: "2017-03-09T23:51:29.629+07:00")!
        
        let subChannel = BookingChannel.SubChannel(
            id: 31,
            name: "Travel together (เที่ยวด้วยกัน)",
            feeRate: 1.23,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
        
        let channel = BookingChannel(
            id: 4,
            name: "Social Media",
            feeRate: 3.45,
            subChannels: [subChannel],
            createdAt: createdAt,
            updatedAt: updatedAt
        )
        
        // When
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(channel)
        let decodedChannel = try JSONDecoder().decode(BookingChannel.self, from: jsonData)
        
        // Then
        XCTAssertEqual(decodedChannel.id, channel.id)
        XCTAssertEqual(decodedChannel.name, channel.name)
        XCTAssertEqual(decodedChannel.feeRate, channel.feeRate, accuracy: 0.0001)
        XCTAssertEqual(decodedChannel.subChannels.count, channel.subChannels.count)
        
    }
}

