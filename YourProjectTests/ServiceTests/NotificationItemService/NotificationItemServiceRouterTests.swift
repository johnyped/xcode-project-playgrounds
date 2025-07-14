//
//  NotificationItemServiceRouterTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest
import Alamofire


class NotificationItemServiceRouterTests: XCTestCase {

    // MARK: - FetchNotifications Tests
    
    func test_fetchNotificationsRouter_URLConstruction() throws {
        // Arrange
        let request = NotificationItemServiceRequest.FetchNotifications(
            page: 1,
            perPage: 20,
            sortedBy: "ID",
            sortedOrder: "ASC",
            hotelId: 123
        )
        let router = NotificationItemServiceRouter.fetchNotifications(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/notifications") == true)
        
        // Check URL parameters
        guard let urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false) else {
            XCTFail("Failed to create URL components")
            return
        }
        
        let queryItems = urlComponents.queryItems ?? []
        XCTAssertTrue(queryItems.contains { $0.name == "page" && $0.value == "1" })
        XCTAssertTrue(queryItems.contains { $0.name == "per_page" && $0.value == "20" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_by" && $0.value == "ID" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_order" && $0.value == "ASC" })
        XCTAssertTrue(queryItems.contains { $0.name == "hotel_id" && $0.value == "123" })
    }
    
    func test_fetchNotificationsRouter_withEmptyParameters() throws {
        // Arrange
        let request = NotificationItemServiceRequest.FetchNotifications(
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            hotelId: nil
        )
        let router = NotificationItemServiceRouter.fetchNotifications(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/notifications") == true)
        
        // Check that URL has no query parameters
        guard let urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false) else {
            XCTFail("Failed to create URL components")
            return
        }
        
        XCTAssertTrue(urlComponents.queryItems?.isEmpty ?? true)
    }
    
    // MARK: - FetchNotification Tests
    
    func test_fetchNotificationRouter_URLConstruction() throws {
        // Arrange
        let request = NotificationItemServiceRequest.FetchNotification(id: 42)
        let router = NotificationItemServiceRouter.fetchNotification(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/notifications/42") == true)
        XCTAssertNil(urlRequest.httpBody)
    }
    
    // MARK: - DeleteNotification Tests
    
    func test_deleteNotificationRouter_URLConstruction() throws {
        // Arrange
        let request = NotificationItemServiceRequest.DeleteNotification(id: 123)
        let router = NotificationItemServiceRouter.deleteNotification(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "DELETE")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/notifications/123") == true)
        XCTAssertNil(urlRequest.httpBody)
    }
    
    // MARK: - MarkNotificationAsRead Tests
    
    func test_markNotificationAsReadRouter_URLConstruction() throws {
        // Arrange
        let request = NotificationItemServiceRequest.MarkNotificationAsRead(id: 456)
        let router = NotificationItemServiceRouter.markNotificationAsRead(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/notifications/456/read") == true)
        XCTAssertNil(urlRequest.httpBody)
    }
    
    // MARK: - FetchNotificationCount Tests
    
    func test_fetchNotificationCountRouter_URLConstruction() throws {
        // Arrange
        let request = NotificationItemServiceRequest.FetchNotificationCount(hotelId: 789)
        let router = NotificationItemServiceRouter.fetchNotificationCount(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/notifications/count") == true)
        
        // Check URL parameters
        guard let urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false) else {
            XCTFail("Failed to create URL components")
            return
        }
        
        let queryItems = urlComponents.queryItems ?? []
        XCTAssertTrue(queryItems.contains { $0.name == "hotel_id" && $0.value == "789" })
    }
    
    func test_fetchNotificationCountRouter_withNilHotelId() throws {
        // Arrange
        let request = NotificationItemServiceRequest.FetchNotificationCount(hotelId: nil)
        let router = NotificationItemServiceRouter.fetchNotificationCount(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/notifications/count") == true)
        
        // Check that URL has no query parameters
        guard let urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false) else {
            XCTFail("Failed to create URL components")
            return
        }
        
        XCTAssertTrue(urlComponents.queryItems?.isEmpty ?? true)
    }
    
    // MARK: - MarkAllNotificationsAsRead Tests
    
    func test_markAllNotificationsAsReadRouter_URLConstruction() throws {
        // Arrange
        let request = NotificationItemServiceRequest.MarkAllNotificationsAsRead(hotelId: 123)
        let router = NotificationItemServiceRouter.markAllNotificationsAsRead(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/notifications/read-all") == true)
        XCTAssertNotNil(urlRequest.httpBody)
        
        // Check JSON body
        if let httpBody = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: Any]
            XCTAssertEqual(json?["hotel_id"] as? Int, 123)
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func test_markAllNotificationsAsReadRouter_withNilHotelId() throws {
        // Arrange
        let request = NotificationItemServiceRequest.MarkAllNotificationsAsRead(hotelId: nil)
        let router = NotificationItemServiceRouter.markAllNotificationsAsRead(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/notifications/read-all") == true)
        XCTAssertNotNil(urlRequest.httpBody)
        
        // Check JSON body
        if let httpBody = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: Any]
            XCTAssertNil(json?["hotel_id"])
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    // MARK: - DeleteAllNotifications Tests
    
    func test_deleteAllNotificationsRouter_URLConstruction() throws {
        // Arrange
        let request = NotificationItemServiceRequest.DeleteAllNotifications(hotelId: 321)
        let router = NotificationItemServiceRouter.deleteAllNotifications(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "DELETE")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/notifications/delete-all") == true)
        
        // Check URL parameters
        guard let urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false) else {
            XCTFail("Failed to create URL components")
            return
        }
        
        let queryItems = urlComponents.queryItems ?? []
        XCTAssertTrue(queryItems.contains { $0.name == "hotel_id" && $0.value == "321" })
    }
    
    func test_deleteAllNotificationsRouter_withNilHotelId() throws {
        // Arrange
        let request = NotificationItemServiceRequest.DeleteAllNotifications(hotelId: nil)
        let router = NotificationItemServiceRouter.deleteAllNotifications(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "DELETE")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/notifications/delete-all") == true)
        
        // Check that URL has no query parameters
        guard let urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false) else {
            XCTFail("Failed to create URL components")
            return
        }
        
        XCTAssertTrue(urlComponents.queryItems?.isEmpty ?? true)
    }
    
    // MARK: - Router Properties Tests
    
    func test_routerDomain() {
        // Arrange
        let request = NotificationItemServiceRequest.FetchNotifications(page: 1, perPage: 20, sortedBy: nil, sortedOrder: nil, hotelId: nil)
        let router = NotificationItemServiceRouter.fetchNotifications(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.domain, AppConfiguration.shared.baseURL)
    }
    
    func test_routerHeaders() {
        // Arrange
        let request = NotificationItemServiceRequest.FetchNotifications(page: 1, perPage: 20, sortedBy: nil, sortedOrder: nil, hotelId: nil)
        let router = NotificationItemServiceRouter.fetchNotifications(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.headers?["Content-Type"], "application/json")
    }
    
    func test_routerPaths() {
        // Test all router paths
        let fetchNotificationsRouter = NotificationItemServiceRouter.fetchNotifications(
            request: NotificationItemServiceRequest.FetchNotifications(page: nil, perPage: nil, sortedBy: nil, sortedOrder: nil, hotelId: nil)
        )
        XCTAssertEqual(fetchNotificationsRouter.path, "/v4/notifications")
        
        let fetchNotificationRouter = NotificationItemServiceRouter.fetchNotification(
            request: NotificationItemServiceRequest.FetchNotification(id: 123)
        )
        XCTAssertEqual(fetchNotificationRouter.path, "/v4/notifications/123")
        
        let deleteNotificationRouter = NotificationItemServiceRouter.deleteNotification(
            request: NotificationItemServiceRequest.DeleteNotification(id: 456)
        )
        XCTAssertEqual(deleteNotificationRouter.path, "/v4/notifications/456")
        
        let markAsReadRouter = NotificationItemServiceRouter.markNotificationAsRead(
            request: NotificationItemServiceRequest.MarkNotificationAsRead(id: 789)
        )
        XCTAssertEqual(markAsReadRouter.path, "/v4/notifications/789/read")
        
        let countRouter = NotificationItemServiceRouter.fetchNotificationCount(
            request: NotificationItemServiceRequest.FetchNotificationCount(hotelId: nil)
        )
        XCTAssertEqual(countRouter.path, "/v4/notifications/count")
        
        let readAllRouter = NotificationItemServiceRouter.markAllNotificationsAsRead(
            request: NotificationItemServiceRequest.MarkAllNotificationsAsRead(hotelId: nil)
        )
        XCTAssertEqual(readAllRouter.path, "/v4/notifications/read-all")
        
        let deleteAllRouter = NotificationItemServiceRouter.deleteAllNotifications(
            request: NotificationItemServiceRequest.DeleteAllNotifications(hotelId: nil)
        )
        XCTAssertEqual(deleteAllRouter.path, "/v4/notifications/delete-all")
    }
    
    func test_routerMethods() {
        // Test all HTTP methods
        let fetchNotificationsRouter = NotificationItemServiceRouter.fetchNotifications(
            request: NotificationItemServiceRequest.FetchNotifications(page: nil, perPage: nil, sortedBy: nil, sortedOrder: nil, hotelId: nil)
        )
        XCTAssertEqual(fetchNotificationsRouter.method, .get)
        
        let fetchNotificationRouter = NotificationItemServiceRouter.fetchNotification(
            request: NotificationItemServiceRequest.FetchNotification(id: 123)
        )
        XCTAssertEqual(fetchNotificationRouter.method, .get)
        
        let deleteNotificationRouter = NotificationItemServiceRouter.deleteNotification(
            request: NotificationItemServiceRequest.DeleteNotification(id: 456)
        )
        XCTAssertEqual(deleteNotificationRouter.method, .delete)
        
        let markAsReadRouter = NotificationItemServiceRouter.markNotificationAsRead(
            request: NotificationItemServiceRequest.MarkNotificationAsRead(id: 789)
        )
        XCTAssertEqual(markAsReadRouter.method, .put)
        
        let countRouter = NotificationItemServiceRouter.fetchNotificationCount(
            request: NotificationItemServiceRequest.FetchNotificationCount(hotelId: nil)
        )
        XCTAssertEqual(countRouter.method, .get)
        
        let readAllRouter = NotificationItemServiceRouter.markAllNotificationsAsRead(
            request: NotificationItemServiceRequest.MarkAllNotificationsAsRead(hotelId: nil)
        )
        XCTAssertEqual(readAllRouter.method, .put)
        
        let deleteAllRouter = NotificationItemServiceRouter.deleteAllNotifications(
            request: NotificationItemServiceRequest.DeleteAllNotifications(hotelId: nil)
        )
        XCTAssertEqual(deleteAllRouter.method, .delete)
    }
} 
