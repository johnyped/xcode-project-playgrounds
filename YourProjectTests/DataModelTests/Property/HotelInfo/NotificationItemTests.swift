//
//  NotificationItemTests.swift
//  YourProject
//
//  Created by IntrodexMac on 11/6/2568 BE.
//

import XCTest

final class NotificationItemTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let notificationItem = createSampleNotificationItem()
        
        // Assert
        XCTAssertEqual(notificationItem.id, 3566)
        XCTAssertEqual(notificationItem.notificationType, .newHmsReservation)
        XCTAssertEqual(notificationItem.checkInDate, "2024-05-14".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(notificationItem.checkOutDate, "2024-05-15".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(notificationItem.notifiableId, 1089)
        XCTAssertEqual(notificationItem.notifiableType, .reservation)
        XCTAssertEqual(notificationItem.readed, true)
        XCTAssertNotNil(notificationItem.createdAt)
        XCTAssertNotNil(notificationItem.updatedAt)
    }
    
    func test_initWithOptionalProperties() throws {
        // Arrange & Act
        let notificationItem = createSampleNotificationItem()
        
        // Assert
        XCTAssertNotNil(notificationItem.readedAt)
        XCTAssertNil(notificationItem.channelId)
        XCTAssertNil(notificationItem.subChannelId)
    }
    
    func test_initWithNullOptionalProperties() throws {
        // Arrange & Act
        let notificationItem = createSampleNotificationItemWithNulls()
        
        // Assert
        XCTAssertNil(notificationItem.readedAt)
        XCTAssertNil(notificationItem.channelId)
        XCTAssertNil(notificationItem.subChannelId)
    }
    
    // MARK: - NotificationType Tests
    
    func test_notificationTypeRawValues() throws {
        XCTAssertEqual(NotificationItem.NotificationType.newCmBooking.rawValue, "NEW_CM_BOOKING")
        XCTAssertEqual(NotificationItem.NotificationType.updatedCmBooking.rawValue, "CM_BOOKING_WAS_UPDATED")
        XCTAssertEqual(NotificationItem.NotificationType.cancelledCmBooking.rawValue, "CM_BOOKING_WAS_CANCELLED")
        XCTAssertEqual(NotificationItem.NotificationType.newHmsReservation.rawValue, "NEW_HMS_RESERVATION")
        XCTAssertEqual(NotificationItem.NotificationType.updatedHmsReservation.rawValue, "HMS_RESERVATION_WAS_UPDATED")
        XCTAssertEqual(NotificationItem.NotificationType.cancelledHmsReservation.rawValue, "HMS_RESERVATION_WAS_CANCELLED")
    }
    
    // MARK: - ItemKind Tests
    
    func test_itemKindRawValues() throws {
        XCTAssertEqual(NotificationItem.ItemKind.reservation.rawValue, "RESERVATION")
        XCTAssertEqual(NotificationItem.ItemKind.cmBooking.rawValue, "CM_BOOKING")
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON_HmsReservation() throws {
        // Arrange
        let json = """
        {
            "id": 3566,
            "notification_type": "NEW_HMS_RESERVATION",
            "check_in_date": "2024-05-14",
            "check_out_date": "2024-05-15",
            "notifiable_id": 1089,
            "notifiable_type": "RESERVATION",
            "readed": true,
            "readed_at": "2024-06-09T07:43:44.953Z",
            "channel_id": null,
            "sub_channel_id": null,
            "created_at": "2024-05-23T08:56:25.854+07:00",
            "updated_at": "2024-06-03T15:43:19.052+07:00"
        }
        """.data(using: .utf8)!
        
        // Act
        let notificationItem = try JSONDecoder().decode(NotificationItem.self, from: json)
        
        // Assert
        XCTAssertEqual(notificationItem.id, 3566)
        XCTAssertEqual(notificationItem.notificationType, .newHmsReservation)
        XCTAssertEqual(notificationItem.checkInDate.toDateString(FormConfig.DateFormat.yyyyMMdd), "2024-05-14")
        XCTAssertEqual(notificationItem.checkOutDate.toDateString(FormConfig.DateFormat.yyyyMMdd), "2024-05-15")
        XCTAssertEqual(notificationItem.notifiableId, 1089)
        XCTAssertEqual(notificationItem.notifiableType, .reservation)
        XCTAssertEqual(notificationItem.readed, true)
        XCTAssertNotNil(notificationItem.readedAt)
        XCTAssertNil(notificationItem.channelId)
        XCTAssertNil(notificationItem.subChannelId)
        XCTAssertNotNil(notificationItem.createdAt)
        XCTAssertNotNil(notificationItem.updatedAt)
    }
    
    func test_decodingFromJSON_CmBooking() throws {
        // Arrange
        let json = """
        {
            "id": 3560,
            "notification_type": "NEW_CM_BOOKING",
            "check_in_date": "2024-05-31",
            "check_out_date": "2024-05-31",
            "notifiable_id": 83,
            "notifiable_type": "CM_BOOKING",
            "readed": false,
            "readed_at": null,
            "channel_id": 5,
            "sub_channel_id": 12,
            "created_at": "2024-05-23T08:32:02.592+07:00",
            "updated_at": "2024-06-03T15:43:19.014+07:00"
        }
        """.data(using: .utf8)!
        
        // Act
        let notificationItem = try JSONDecoder().decode(NotificationItem.self, from: json)
        
        // Assert
        XCTAssertEqual(notificationItem.id, 3560)
        XCTAssertEqual(notificationItem.notificationType, .newCmBooking)
        XCTAssertEqual(notificationItem.checkInDate.toDateString(FormConfig.DateFormat.yyyyMMdd), "2024-05-31")
        XCTAssertEqual(notificationItem.checkOutDate.toDateString(FormConfig.DateFormat.yyyyMMdd), "2024-05-31")
        XCTAssertEqual(notificationItem.notifiableId, 83)
        XCTAssertEqual(notificationItem.notifiableType, .cmBooking)
        XCTAssertEqual(notificationItem.readed, false)
        XCTAssertNil(notificationItem.readedAt)
        XCTAssertEqual(notificationItem.channelId, 5)
        XCTAssertEqual(notificationItem.subChannelId, 12)
        XCTAssertNotNil(notificationItem.createdAt)
        XCTAssertNotNil(notificationItem.updatedAt)
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let notificationItem = createSampleNotificationItem()
        
        // Act
        let data = try JSONEncoder().encode(notificationItem)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        
        // Assert
        XCTAssertEqual(json["id"] as? Int, 3566)
        XCTAssertEqual(json["notification_type"] as? String, "NEW_HMS_RESERVATION")
        XCTAssertEqual(json["check_in_date"] as? String, "2024-05-14")
        XCTAssertEqual(json["check_out_date"] as? String, "2024-05-15")
        XCTAssertEqual(json["notifiable_id"] as? Int, 1089)
        XCTAssertEqual(json["notifiable_type"] as? String, "RESERVATION")
        XCTAssertEqual(json["readed"] as? Bool, true)
        XCTAssertNotNil(json["readed_at"])
        XCTAssertNil(json["channel_id"])
        XCTAssertNil(json["sub_channel_id"])
        XCTAssertNotNil(json["created_at"])
        XCTAssertNotNil(json["updated_at"])
    }
    
    func test_decodingWithNullValues() throws {
        // Arrange
        let json = """
        {
            "id": 3591,
            "notification_type": "NEW_CM_BOOKING",
            "check_in_date": "2024-06-14",
            "check_out_date": "2024-06-14",
            "notifiable_id": 85,
            "notifiable_type": "CM_BOOKING",
            "readed": false,
            "readed_at": null,
            "channel_id": null,
            "sub_channel_id": null,
            "created_at": "2024-06-09T15:03:03.123+07:00",
            "updated_at": "2024-06-09T15:03:03.123+07:00"
        }
        """.data(using: .utf8)!
        
        // Act
        let notificationItem = try JSONDecoder().decode(NotificationItem.self, from: json)
        
        // Assert
        XCTAssertEqual(notificationItem.id, 3591)
        XCTAssertEqual(notificationItem.notificationType, .newCmBooking)
        XCTAssertEqual(notificationItem.readed, false)
        XCTAssertNil(notificationItem.readedAt)
        XCTAssertNil(notificationItem.channelId)
        XCTAssertNil(notificationItem.subChannelId)
    }
    
    // MARK: - Date Handling Tests
    
    func test_dateFormatting() throws {
        // Arrange
        let notificationItem = createSampleNotificationItem()
        
        // Act & Assert
        XCTAssertEqual(notificationItem.checkInDate.toDateString(FormConfig.DateFormat.yyyyMMdd), "2024-05-14")
        XCTAssertEqual(notificationItem.checkOutDate.toDateString(FormConfig.DateFormat.yyyyMMdd), "2024-05-15")
        XCTAssertNotNil(notificationItem.createdAt.toDateString(FormConfig.DateFormat.datetimeISO))
        XCTAssertNotNil(notificationItem.updatedAt.toDateString(FormConfig.DateFormat.datetimeISO))
    }
    
    // MARK: - Error Handling Tests
    
    func test_decodingWithInvalidNotificationType() throws {
        // Arrange
        let json = """
        {
            "id": 3566,
            "notification_type": "invalid_type",
            "check_in_date": "2024-05-14",
            "check_out_date": "2024-05-15",
            "notifiable_id": 1089,
            "notifiable_type": "RESERVATION",
            "readed": true,
            "readed_at": "2024-06-09T07:43:44.953Z",
            "channel_id": null,
            "sub_channel_id": null,
            "created_at": "2024-05-23T08:56:25.854+07:00",
            "updated_at": "2024-06-03T15:43:19.052+07:00"
        }
        """.data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(NotificationItem.self, from: json))
    }
    
    func test_decodingWithInvalidItemKind() throws {
        // Arrange
        let json = """
        {
            "id": 3566,
            "notification_type": "NEW_HMS_RESERVATION",
            "check_in_date": "2024-05-14",
            "check_out_date": "2024-05-15",
            "notifiable_id": 1089,
            "notifiable_type": "InvalidType",
            "readed": true,
            "readed_at": "2024-06-09T07:43:44.953Z",
            "channel_id": null,
            "sub_channel_id": null,
            "created_at": "2024-05-23T08:56:25.854+07:00",
            "updated_at": "2024-06-03T15:43:19.052+07:00"
        }
        """.data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(NotificationItem.self, from: json))
    }
    
    // MARK: - Helper Methods
    
    private func createSampleNotificationItem() -> NotificationItem {
        let json = """
        {
            "id": 3566,
            "notification_type": "NEW_HMS_RESERVATION",
            "check_in_date": "2024-05-14",
            "check_out_date": "2024-05-15",
            "notifiable_id": 1089,
            "notifiable_type": "RESERVATION",
            "readed": true,
            "readed_at": "2024-06-09T07:43:44.953+07:00",
            "channel_id": null,
            "sub_channel_id": null,
            "created_at": "2024-05-23T08:56:25.854+07:00",
            "updated_at": "2024-06-03T15:43:19.052+07:00"
        }
        """.data(using: .utf8)!
        
        return try! JSONDecoder().decode(NotificationItem.self, from: json)
    }
    
    private func createSampleNotificationItemWithNulls() -> NotificationItem {
        let json = """
        {
            "id": 3591,
            "notification_type": "NEW_CM_BOOKING",
            "check_in_date": "2024-06-14",
            "check_out_date": "2024-06-14",
            "notifiable_id": 85,
            "notifiable_type": "CM_BOOKING",
            "readed": false,
            "readed_at": null,
            "channel_id": null,
            "sub_channel_id": null,
            "created_at": "2024-06-09T15:03:03.123+07:00",
            "updated_at": "2024-06-09T15:03:03.123+07:00"
        }
        """.data(using: .utf8)!
        
        return try! JSONDecoder().decode(NotificationItem.self, from: json)
    }
} 
