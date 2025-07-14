//
//  NotificationItemRemoteServiceTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest
import Mockable

class NotificationItemRemoteServiceTests: XCTestCase {
    
    var sut: NotificationItemRemoteService!
    var mockAPIManager: MockAPIManagerProtocal!
    var mockLocalStorage: MockLocalStorageManagerProtocal!
    
    override func setUp() {
        super.setUp()
        mockAPIManager = MockAPIManagerProtocal()
        mockLocalStorage = MockLocalStorageManagerProtocal()
        sut = NotificationItemRemoteService(localStorage: mockLocalStorage, apiManager: mockAPIManager)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIManager = nil
        mockLocalStorage = nil
        super.tearDown()
    }
    
    // MARK: - FetchNotifications Tests
    
    func test_fetchNotifications_success() async throws {
        // Arrange
        let notificationItems = NotificationItems(array:[
            createSampleNotificationItem(id: 1, type: .newHmsReservation),
            createSampleNotificationItem(id: 2, type: .newCmBooking)
        ])
        let expectedPaginator = Paginator<NotificationItem>(
            items: notificationItems,
            totalItems: 2,
            totalPages: 1,
            perPage: 20,
            page: 1
        )
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)
        
        let request = NotificationItemServiceRequest.FetchNotifications(
            page: 1,
            perPage: 20,
            sortedBy: "ID",
            sortedOrder: "ASC",
            hotelId: 123
        )
        
        // Act
        let result = try await sut.fetchNotifications(request: request)
        
        // Assert
        XCTAssertEqual(result.items.count, 2)
        XCTAssertEqual(result.totalItems, 2)
        XCTAssertEqual(result.page, 1)
        XCTAssertEqual(result.items[0].id, 1)
        XCTAssertEqual(result.items[1].id, 2)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_fetchNotifications_failure() async {
        // Arrange
        let expectedError = APIError.unknownError(title: "Network Error", subtitle: nil, underlying: nil)
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any).willProduce { a, b -> Paginator<NotificationItem> in
                throw expectedError
            }
        
        let request = NotificationItemServiceRequest.FetchNotifications(
            page: 1,
            perPage: 20,
            sortedBy: nil,
            sortedOrder: nil,
            hotelId: nil
        )
        
        // Act & Assert
        do {
            _ = try await sut.fetchNotifications(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error {
            case APIError.unknownError(let title, subtitle: _, underlying: _):
                XCTAssertEqual(title, "Network Error")
            default:
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    // MARK: - FetchNotification Tests
    
    func test_fetchNotification_success() async throws {
        // Arrange
        let expectedNotification = createSampleNotificationItem(id: 42, type: .newHmsReservation)
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedNotification)
        
        let request = NotificationItemServiceRequest.FetchNotification(id: 42)
        
        // Act
        let result = try await sut.fetchNotification(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedNotification.id)
        XCTAssertEqual(result.notificationType, expectedNotification.notificationType)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_fetchNotification_failure() async {
        // Arrange
        let expectedError = APIError.unknownError(title: "Not Found", subtitle: nil, underlying: nil)
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce { a, b -> NotificationItem in
                throw expectedError
            }
        
        let request = NotificationItemServiceRequest.FetchNotification(id: 999)
        
        // Act & Assert
        do {
            _ = try await sut.fetchNotification(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error {
            case APIError.unknownError(let title, subtitle: _, underlying: _):
                XCTAssertEqual(title, "Not Found")
            default:
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    // MARK: - DeleteNotification Tests
    
    func test_deleteNotification_success() async throws {
        // Arrange
        given(mockAPIManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())
        
        let request = NotificationItemServiceRequest.DeleteNotification(id: 123)
        
        // Act
        try await sut.deleteNotification(request: request)
        
        // Assert
        verify(mockAPIManager)
            .requestACK(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_deleteNotification_failure() async {
        // Arrange
        let expectedError = APIError.unknownError(title: "Unauthorized", subtitle: nil, underlying: nil)
        given(mockAPIManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willProduce { a, b -> Void in
                throw expectedError
            }
        
        let request = NotificationItemServiceRequest.DeleteNotification(id: 123)
        
        // Act & Assert
        do {
            try await sut.deleteNotification(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error {
            case APIError.unknownError(let title, subtitle: _, underlying: _):
                XCTAssertEqual(title, "Unauthorized")
            default:
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    // MARK: - MarkNotificationAsRead Tests
    
    func test_markNotificationAsRead_success() async throws {
        // Arrange
        given(mockAPIManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn()
        
        let request = NotificationItemServiceRequest.MarkNotificationAsRead(id: 456)
        
        // Act
        try await sut.markNotificationAsRead(request: request)
        
        // Assert
        verify(mockAPIManager)
            .requestACK(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_markNotificationAsRead_failure() async {
        // Arrange
        let expectedError = APIError.unknownError(title: "Bad Request", subtitle: nil, underlying: nil)
        given(mockAPIManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willProduce { a, b in
                throw expectedError
            }
        
        let request = NotificationItemServiceRequest.MarkNotificationAsRead(id: 456)
        
        // Act & Assert
        do {
            _ = try await sut.markNotificationAsRead(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error {
            case APIError.unknownError(let title, subtitle: _, underlying: _):
                XCTAssertEqual(title, "Bad Request")
            default:
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    // MARK: - FetchNotificationCount Tests
    
    func test_fetchNotificationCount_success() async throws {
        // Arrange
        let expectedCount = createSampleNotificationItemCount()
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCount)
        
        let request = NotificationItemServiceRequest.FetchNotificationCount(hotelId: 789)
        
        // Act
        let result = try await sut.fetchNotificationCount(request: request)
        
        // Assert
        XCTAssertEqual(result.reservations.unread, expectedCount.reservations.unread)
        XCTAssertEqual(result.cmBookings.total, expectedCount.cmBookings.total)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_fetchNotificationCount_failure() async {
        // Arrange
        let expectedError = APIError.unknownError(title: "Server Error", subtitle: nil, underlying: nil)
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce { a, b -> NotificationItemCount in
                throw expectedError
            }
        
        let request = NotificationItemServiceRequest.FetchNotificationCount(hotelId: 789)
        
        // Act & Assert
        do {
            _ = try await sut.fetchNotificationCount(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error {
            case APIError.unknownError(let title, subtitle: _, underlying: _):
                XCTAssertEqual(title, "Server Error")
            default:
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    // MARK: - MarkAllNotificationsAsRead Tests
    
    func test_markAllNotificationsAsRead_success() async throws {
        // Arrange
        given(mockAPIManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())
        
        let request = NotificationItemServiceRequest.MarkAllNotificationsAsRead(hotelId: 123)
        
        // Act
        try await sut.markAllNotificationsAsRead(request: request)
        
        // Assert
        verify(mockAPIManager)
            .requestACK(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_markAllNotificationsAsRead_failure() async {
        // Arrange
        let expectedError = APIError.unknownError(title: "Network Error", subtitle: nil, underlying: nil)
        given(mockAPIManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willProduce { a, b -> Void in
                throw expectedError
            }
        
        let request = NotificationItemServiceRequest.MarkAllNotificationsAsRead(hotelId: 123)
        
        // Act & Assert
        do {
            try await sut.markAllNotificationsAsRead(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error {
            case APIError.unknownError(let title, subtitle: _, underlying: _):
                XCTAssertEqual(title, "Network Error")
            default:
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    // MARK: - DeleteAllNotifications Tests
    
    func test_deleteAllNotifications_success() async throws {
        // Arrange
        given(mockAPIManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())
        
        let request = NotificationItemServiceRequest.DeleteAllNotifications(hotelId: 321)
        
        // Act
        try await sut.deleteAllNotifications(request: request)
        
        // Assert
        verify(mockAPIManager)
            .requestACK(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_deleteAllNotifications_failure() async {
        // Arrange
        let expectedError = APIError.unknownError(title: "Stubbed Error",
                                                  subtitle: nil,
                                                  underlying: nil)
        given(mockAPIManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willProduce { a, b -> Void in
                throw expectedError
            }
        
        let request = NotificationItemServiceRequest.DeleteAllNotifications(hotelId: 321)
        
        // Act & Assert
        do {
            try await sut.deleteAllNotifications(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error {
            case APIError.unknownError(let title, subtitle: _, underlying: _):
                XCTAssertEqual(title, "Stubbed Error")
            default:
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func createSampleNotificationItem(
        id: Int,
        type: NotificationItem.NotificationType,
        isRead: Bool = false
    ) -> NotificationItem {
        return NotificationItem(
            id: id,
            notificationType: type,
            checkInDate: Date(),
            checkOutDate: Date().addingTimeInterval(86400), // +1 day
            notifiableId: 100 + id,
            notifiableType: type == .newCmBooking ? .cmBooking : .reservation,
            readed: isRead,
            readedAt: isRead ? Date() : nil,
            channelId: nil,
            subChannelId: nil,
            createdAt: Date(),
            updatedAt: Date()
        )
    }
    
    private func createSampleNotificationItemCount() -> NotificationItemCount {
        let reservations = NotificationItemCount.ItemCount(unread: 2, readed: 5, total: 7)
        let cmBookings = NotificationItemCount.ItemCount(unread: 1, readed: 3, total: 4)
        
        return NotificationItemCount(reservations: reservations, cmBookings: cmBookings)
    }
} 
