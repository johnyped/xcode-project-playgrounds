//
//  NotificationItemServiceRequestTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest


class NotificationItemServiceRequestTests: XCTestCase {

    // MARK: - FetchNotifications Tests
    
    func test_fetchNotificationsRequest_parametersMapping() {
        // Arrange
        let request = NotificationItemServiceRequest.FetchNotifications(
            page: 1,
            perPage: 20,
            sortedBy: "ID",
            sortedOrder: "ASC",
            hotelId: 123
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? Int, 20)
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 123)
    }
    
    func test_fetchNotificationsRequest_withNilValues() {
        // Arrange
        let request = NotificationItemServiceRequest.FetchNotifications(
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            hotelId: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertTrue(parameters?.isEmpty ?? true)
    }
    
    func test_fetchNotificationsRequest_withPartialValues() {
        // Arrange
        let request = NotificationItemServiceRequest.FetchNotifications(
            page: 2,
            perPage: nil,
            sortedBy: "created_at",
            sortedOrder: nil,
            hotelId: 456
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertEqual(parameters?["page"] as? Int, 2)
        XCTAssertNil(parameters?["per_page"])
        XCTAssertEqual(parameters?["sorted_by"] as? String, "created_at")
        XCTAssertNil(parameters?["sorted_order"])
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 456)
    }
    
    // MARK: - FetchNotificationCount Tests
    
    func test_fetchNotificationCountRequest_parametersMapping() {
        // Arrange
        let request = NotificationItemServiceRequest.FetchNotificationCount(hotelId: 789)
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 789)
    }
    
    func test_fetchNotificationCountRequest_withNilHotelId() {
        // Arrange
        let request = NotificationItemServiceRequest.FetchNotificationCount(hotelId: nil)
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertTrue(parameters?.isEmpty ?? true)
    }
    
    // MARK: - MarkAllNotificationsAsRead Tests
    
    func test_markAllNotificationsAsReadRequest_bodyEncoding() throws {
        // Arrange
        let request = NotificationItemServiceRequest.MarkAllNotificationsAsRead(hotelId: 123)
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let json = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertEqual(json?["hotel_id"] as? Int, 123)
    }
    
    func test_markAllNotificationsAsReadRequest_withNilHotelId() throws {
        // Arrange
        let request = NotificationItemServiceRequest.MarkAllNotificationsAsRead(hotelId: nil)
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let json = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertNil(json?["hotel_id"])
    }
    
    func test_markAllNotificationsAsReadRequest_codingKeys() throws {
        // Arrange
        let request = NotificationItemServiceRequest.MarkAllNotificationsAsRead(hotelId: 456)
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let json = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertNotNil(json?["hotel_id"]) // Should use snake_case key
        XCTAssertNil(json?["hotelId"]) // Should not use camelCase key
    }
    
    // MARK: - DeleteAllNotifications Tests
    
    func test_deleteAllNotificationsRequest_parametersMapping() {
        // Arrange
        let request = NotificationItemServiceRequest.DeleteAllNotifications(hotelId: 321)
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 321)
    }
    
    func test_deleteAllNotificationsRequest_withNilHotelId() {
        // Arrange
        let request = NotificationItemServiceRequest.DeleteAllNotifications(hotelId: nil)
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertTrue(parameters?.isEmpty ?? true)
    }
    
    // MARK: - ByID Tests
    
    func test_byIDRequest_structure() {
        // Arrange & Act
        let request = NotificationItemServiceRequest.ByID(id: 42)
        
        // Assert
        XCTAssertEqual(request.id, 42)
    }
    
    func test_typeAliases() {
        // Verify that type aliases are correctly set up
        let fetchRequest: NotificationItemServiceRequest.FetchNotification = NotificationItemServiceRequest.ByID(id: 1)
        let deleteRequest: NotificationItemServiceRequest.DeleteNotification = NotificationItemServiceRequest.ByID(id: 2)
        let markReadRequest: NotificationItemServiceRequest.MarkNotificationAsRead = NotificationItemServiceRequest.ByID(id: 3)
        
        XCTAssertEqual(fetchRequest.id, 1)
        XCTAssertEqual(deleteRequest.id, 2)
        XCTAssertEqual(markReadRequest.id, 3)
    }
} 
