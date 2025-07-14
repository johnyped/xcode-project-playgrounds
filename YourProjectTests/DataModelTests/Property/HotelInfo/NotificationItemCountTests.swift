//
//  NotificationItemCountTests.swift
//  YourProject
//
//  Created by IntrodexMac on 11/6/2568 BE.
//

import XCTest

final class NotificationItemCountTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let notificationItemCount = createSampleNotificationItemCount()
        
        // Assert
        XCTAssertEqual(notificationItemCount.reservations.unread, 0)
        XCTAssertEqual(notificationItemCount.reservations.readed, 2)
        XCTAssertEqual(notificationItemCount.reservations.total, 2)
        XCTAssertEqual(notificationItemCount.cmBookings.unread, 1)
        XCTAssertEqual(notificationItemCount.cmBookings.readed, 2)
        XCTAssertEqual(notificationItemCount.cmBookings.total, 3)
    }
    
    // MARK: - ItemCount Tests
    
    func test_itemCountInitialization() throws {
        // Arrange & Act
        let itemCount = NotificationItemCount.ItemCount(unread: 5, readed: 10, total: 15)
        
        // Assert
        XCTAssertEqual(itemCount.unread, 5)
        XCTAssertEqual(itemCount.readed, 10)
        XCTAssertEqual(itemCount.total, 15)
    }
    
    func test_itemCountZeroValues() throws {
        // Arrange & Act
        let itemCount = NotificationItemCount.ItemCount(unread: 0, readed: 0, total: 0)
        
        // Assert
        XCTAssertEqual(itemCount.unread, 0)
        XCTAssertEqual(itemCount.readed, 0)
        XCTAssertEqual(itemCount.total, 0)
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "reservations": {
                "unread": 0,
                "readed": 2,
                "total": 2
            },
            "cm_bookings": {
                "unread": 1,
                "readed": 2,
                "total": 3
            }
        }
        """.data(using: .utf8)!
        
        // Act
        let notificationItemCount = try JSONDecoder().decode(NotificationItemCount.self, from: json)
        
        // Assert
        XCTAssertEqual(notificationItemCount.reservations.unread, 0)
        XCTAssertEqual(notificationItemCount.reservations.readed, 2)
        XCTAssertEqual(notificationItemCount.reservations.total, 2)
        XCTAssertEqual(notificationItemCount.cmBookings.unread, 1)
        XCTAssertEqual(notificationItemCount.cmBookings.readed, 2)
        XCTAssertEqual(notificationItemCount.cmBookings.total, 3)
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let notificationItemCount = createSampleNotificationItemCount()
        
        // Act
        let data = try JSONEncoder().encode(notificationItemCount)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        
        // Assert
        let reservations = json["reservations"] as! [String: Any]
        XCTAssertEqual(reservations["unread"] as? Int, 0)
        XCTAssertEqual(reservations["readed"] as? Int, 2)
        XCTAssertEqual(reservations["total"] as? Int, 2)
        
        let cmBookings = json["cm_bookings"] as! [String: Any]
        XCTAssertEqual(cmBookings["unread"] as? Int, 1)
        XCTAssertEqual(cmBookings["readed"] as? Int, 2)
        XCTAssertEqual(cmBookings["total"] as? Int, 3)
    }
    
    func test_decodingWithDifferentValues() throws {
        // Arrange
        let json = """
        {
            "reservations": {
                "unread": 5,
                "readed": 15,
                "total": 20
            },
            "cm_bookings": {
                "unread": 0,
                "readed": 0,
                "total": 0
            }
        }
        """.data(using: .utf8)!
        
        // Act
        let notificationItemCount = try JSONDecoder().decode(NotificationItemCount.self, from: json)
        
        // Assert
        XCTAssertEqual(notificationItemCount.reservations.unread, 5)
        XCTAssertEqual(notificationItemCount.reservations.readed, 15)
        XCTAssertEqual(notificationItemCount.reservations.total, 20)
        XCTAssertEqual(notificationItemCount.cmBookings.unread, 0)
        XCTAssertEqual(notificationItemCount.cmBookings.readed, 0)
        XCTAssertEqual(notificationItemCount.cmBookings.total, 0)
    }
    
    func test_decodingWithLargeNumbers() throws {
        // Arrange
        let json = """
        {
            "reservations": {
                "unread": 999,
                "readed": 1000,
                "total": 1999
            },
            "cm_bookings": {
                "unread": 500,
                "readed": 750,
                "total": 1250
            }
        }
        """.data(using: .utf8)!
        
        // Act
        let notificationItemCount = try JSONDecoder().decode(NotificationItemCount.self, from: json)
        
        // Assert
        XCTAssertEqual(notificationItemCount.reservations.unread, 999)
        XCTAssertEqual(notificationItemCount.reservations.readed, 1000)
        XCTAssertEqual(notificationItemCount.reservations.total, 1999)
        XCTAssertEqual(notificationItemCount.cmBookings.unread, 500)
        XCTAssertEqual(notificationItemCount.cmBookings.readed, 750)
        XCTAssertEqual(notificationItemCount.cmBookings.total, 1250)
    }
    
    // MARK: - Error Handling Tests
    
    func test_decodingWithMissingReservations() throws {
        // Arrange
        let json = """
        {
            "cm_bookings": {
                "unread": 1,
                "readed": 2,
                "total": 3
            }
        }
        """.data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(NotificationItemCount.self, from: json))
    }
    
    func test_decodingWithMissingCmBookings() throws {
        // Arrange
        let json = """
        {
            "reservations": {
                "unread": 0,
                "readed": 2,
                "total": 2
            }
        }
        """.data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(NotificationItemCount.self, from: json))
    }
    
    func test_decodingWithMissingItemCountProperties() throws {
        // Arrange
        let json = """
        {
            "reservations": {
                "unread": 0,
                "total": 2
            },
            "cm_bookings": {
                "unread": 1,
                "readed": 2,
                "total": 3
            }
        }
        """.data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(NotificationItemCount.self, from: json))
    }
    
    func test_decodingWithInvalidDataTypes() throws {
        // Arrange
        let json = """
        {
            "reservations": {
                "unread": "invalid",
                "readed": 2,
                "total": 2
            },
            "cm_bookings": {
                "unread": 1,
                "readed": 2,
                "total": 3
            }
        }
        """.data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(NotificationItemCount.self, from: json))
    }
    
    // MARK: - CodingKeys Tests
    
    func test_codingKeysMapping() throws {
        // Arrange
        let json = """
        {
            "reservations": {
                "unread": 0,
                "readed": 2,
                "total": 2
            },
            "cm_bookings": {
                "unread": 1,
                "readed": 2,
                "total": 3
            }
        }
        """.data(using: .utf8)!
        
        // Act
        let notificationItemCount = try JSONDecoder().decode(NotificationItemCount.self, from: json)
        let encodedData = try JSONEncoder().encode(notificationItemCount)
        let decodedJson = try JSONSerialization.jsonObject(with: encodedData, options: []) as! [String: Any]
        
        // Assert - Verify that cm_bookings key is properly mapped
        XCTAssertNotNil(decodedJson["cm_bookings"])
        XCTAssertNotNil(decodedJson["reservations"])
    }
    
    // MARK: - Helper Methods
    
    private func createSampleNotificationItemCount() -> NotificationItemCount {
        let reservations = NotificationItemCount.ItemCount(unread: 0, readed: 2, total: 2)
        let cmBookings = NotificationItemCount.ItemCount(unread: 1, readed: 2, total: 3)
        
        return NotificationItemCount(reservations: reservations, cmBookings: cmBookings)
    }
    
    private func createEmptyNotificationItemCount() -> NotificationItemCount {
        let reservations = NotificationItemCount.ItemCount(unread: 0, readed: 0, total: 0)
        let cmBookings = NotificationItemCount.ItemCount(unread: 0, readed: 0, total: 0)
        
        return NotificationItemCount(reservations: reservations, cmBookings: cmBookings)
    }
} 