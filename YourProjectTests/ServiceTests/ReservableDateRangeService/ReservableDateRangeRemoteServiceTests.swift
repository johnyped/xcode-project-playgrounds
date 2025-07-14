//
//  ReservableDateRangeRemoteServiceTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 5/7/2568 BE.
//

import XCTest
import Mockable

final class ReservableDateRangeRemoteServiceTests: XCTestCase {
    
    var service: ReservableDateRangeRemoteService!
    var mockAPIManager: MockAPIManagerProtocal!
    var mockLocalStorage: MockLocalStorageManagerProtocal!
       
    override func setUp() {
        super.setUp()
        mockAPIManager = MockAPIManagerProtocal()
        mockLocalStorage = MockLocalStorageManagerProtocal()
        service = ReservableDateRangeRemoteService(
            localStorage: mockLocalStorage,
            apiManager: mockAPIManager
        )
    }
    
    override func tearDown() {
        service = nil
        mockAPIManager = nil
        mockLocalStorage = nil
        super.tearDown()
    }
    
    func test_fetchReservableDateRanges_WillCallAPIManagerWithCorrectRouter() async throws {
        // Arrange
        let hotelId = 123
        let checkInDate = Date(timeIntervalSince1970: 1719446400) // 2024-06-27
        let checkOutDate = Date(timeIntervalSince1970: 1719705600) // 2024-06-30
        let roomIds = [642, 643]
        
        let request = ReservableDateRangeServiceRequest.FetchReservableDateRanges(
            hotelId: hotelId,
            period: .init(start: checkInDate,
                          end: checkOutDate),            
            roomIds: roomIds
        )
        
        let expectedResponse = createMockReservedDateRange()
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // Act
        let result = try await service.fetchReservableDateRanges(request: request)
        
        // Assert
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(.once)
        
        XCTAssertEqual(result.rooms.count, expectedResponse.rooms.count)
        XCTAssertEqual(result.rooms.first?.roomId, expectedResponse.rooms.first?.roomId)
    }
    
    func test_fetchReservableDateRanges_WithPeriodDate_WillCallAPIManagerWithCorrectRouter() async throws {
        // Arrange
        let hotelId = 456
        let startDate = Date(timeIntervalSince1970: 1719446400) // 2024-06-27
        let endDate = Date(timeIntervalSince1970: 1719705600) // 2024-06-30
        let period = PeriodDate(start: startDate, end: endDate)
        let roomIds = [101, 102, 103]
        
        let request = ReservableDateRangeServiceRequest.FetchReservableDateRanges(
            hotelId: hotelId,
            period: period,
            roomIds: roomIds
        )
        
        let expectedResponse = createMockReservedDateRange()
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // Act
        let result = try await service.fetchReservableDateRanges(request: request)
        
        // Assert
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(.once)
        
        XCTAssertEqual(result.rooms.count, expectedResponse.rooms.count)
        XCTAssertEqual(result.rooms.first?.roomId, expectedResponse.rooms.first?.roomId)
    }
    
    func test_fetchReservableDateRanges_WithoutRoomIds_WillCallAPIManagerWithCorrectRouter() async throws {
        // Arrange
        let hotelId = 789
        let checkInDate = Date(timeIntervalSince1970: 1719446400) // 2024-06-27
        let checkOutDate = Date(timeIntervalSince1970: 1719705600) // 2024-06-30
        
        let request = ReservableDateRangeServiceRequest.FetchReservableDateRanges(
            hotelId: hotelId,
            period: .init(start: checkInDate,
                          end: checkOutDate),            
            roomIds: nil
        )
        
        let expectedResponse = createMockReservedDateRange()
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // Act
        let result = try await service.fetchReservableDateRanges(request: request)
        
        // Assert
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(.once)
        
        XCTAssertEqual(result.rooms.count, expectedResponse.rooms.count)
        XCTAssertEqual(result.rooms.first?.roomId, expectedResponse.rooms.first?.roomId)
    }
    
    func test_fetchReservableDateRanges_WhenAPIManagerThrowsError_WillThrowError() async throws {
        // Arrange
        let hotelId = 123
        let checkInDate = Date()
        let checkOutDate = Date()
        
        let request = ReservableDateRangeServiceRequest.FetchReservableDateRanges(
            hotelId: hotelId,
            period: .init(start: checkInDate,
                          end: checkOutDate),            
            roomIds: nil
        )
        
        let expectedError = APIError.networkError(error: NSError(domain: "Test", code: 0))
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any).willProduce{ (a,b) -> ReservedDateRange in
                throw expectedError
            }
        
        // Act & Assert
        do {
            _ = try await service.fetchReservableDateRanges(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is APIError)
        }
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(.once)
    }
    
    func test_fetchReservableDateRanges_WhenAPIManagerReturnsEmptyRooms_WillReturnEmptyResponse() async throws {
        // Arrange
        let hotelId = 999
        let checkInDate = Date()
        let checkOutDate = Date()
        
        let request = ReservableDateRangeServiceRequest.FetchReservableDateRanges(
            hotelId: hotelId,
            period: .init(start: checkInDate,
                          end: checkOutDate),
            roomIds: []
        )
        
        let expectedResponse = ReservedDateRange(rooms: [])
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // Act
        let result = try await service.fetchReservableDateRanges(request: request)
        
        // Assert
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(.once)
        
        XCTAssertTrue(result.rooms.isEmpty)
    }
    
    func test_fetchReservableDateRanges_WhenAPIManagerReturnsMultipleRooms_WillReturnCorrectResponse() async throws {
        // Arrange
        let hotelId = 111
        let checkInDate = Date(timeIntervalSince1970: 1719446400) // 2024-06-27
        let checkOutDate = Date(timeIntervalSince1970: 1719705600) // 2024-06-30
        let roomIds = [1, 2, 3, 4, 5]
        
        let request = ReservableDateRangeServiceRequest.FetchReservableDateRanges(
            hotelId: hotelId,
            period: .init(start: checkInDate,
                          end: checkOutDate),            
            roomIds: roomIds
        )
        
        let expectedResponse = createMockReservedDateRangeWithMultipleRooms()
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // Act
        let result = try await service.fetchReservableDateRanges(request: request)
        
        // Assert
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(.once)
        
        XCTAssertEqual(result.rooms.count, expectedResponse.rooms.count)
        XCTAssertEqual(result.rooms.count, 5)
        
        for (index, room) in result.rooms.enumerated() {
            XCTAssertEqual(room.roomId, expectedResponse.rooms[index].roomId)
            XCTAssertEqual(room.reservableDateRanges.count, expectedResponse.rooms[index].reservableDateRanges.count)
        }
    }
    
    func test_fetchReservableDateRanges_WhenAPIManagerReturnsRoomsWithDifferentDateRanges_WillReturnCorrectResponse() async throws {
        // Arrange
        let hotelId = 222
        let checkInDate = Date(timeIntervalSince1970: 1719446400) // 2024-06-27
        let checkOutDate = Date(timeIntervalSince1970: 1719705600) // 2024-06-30
        let roomIds = [100, 200]
        
        let request = ReservableDateRangeServiceRequest.FetchReservableDateRanges(
            hotelId: hotelId,
            period: .init(start: checkInDate,
                          end: checkOutDate),            
            roomIds: roomIds
        )
        
        let expectedResponse = createMockReservedDateRangeWithDifferentDateRanges()
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // Act
        let result = try await service.fetchReservableDateRanges(request: request)
        
        // Assert
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(.once)
        
        XCTAssertEqual(result.rooms.count, 2)
        
        // First room has more date ranges than second room
        XCTAssertEqual(result.rooms[0].reservableDateRanges.count, 4)
        XCTAssertEqual(result.rooms[1].reservableDateRanges.count, 2)
    }
    
    // MARK: - Helper Methods
    
    private func createMockReservedDateRange() -> ReservedDateRange {
        let dates = [
            Date(timeIntervalSince1970: 1719446400), // 2024-06-27
            Date(timeIntervalSince1970: 1719532800), // 2024-06-28
            Date(timeIntervalSince1970: 1719619200), // 2024-06-29
            Date(timeIntervalSince1970: 1719705600)  // 2024-06-30
        ]
        
        let room = ReservedDateRange.Room(roomId: 643, reservableDateRanges: dates)
        return ReservedDateRange(rooms: [room])
    }
    
    private func createMockReservedDateRangeWithMultipleRooms() -> ReservedDateRange {
        let dates = [
            Date(timeIntervalSince1970: 1719446400), // 2024-06-27
            Date(timeIntervalSince1970: 1719532800), // 2024-06-28
            Date(timeIntervalSince1970: 1719619200), // 2024-06-29
            Date(timeIntervalSince1970: 1719705600)  // 2024-06-30
        ]
        
        let rooms = (1...5).map { index in
            ReservedDateRange.Room(roomId: 100 + index, reservableDateRanges: dates)
        }
        
        return ReservedDateRange(rooms: rooms)
    }
    
    private func createMockReservedDateRangeWithDifferentDateRanges() -> ReservedDateRange {
        let allDates = [
            Date(timeIntervalSince1970: 1719446400), // 2024-06-27
            Date(timeIntervalSince1970: 1719532800), // 2024-06-28
            Date(timeIntervalSince1970: 1719619200), // 2024-06-29
            Date(timeIntervalSince1970: 1719705600)  // 2024-06-30
        ]
        
        let someDates = [
            Date(timeIntervalSince1970: 1719446400), // 2024-06-27
            Date(timeIntervalSince1970: 1719532800)  // 2024-06-28
        ]
        
        let room1 = ReservedDateRange.Room(roomId: 100, reservableDateRanges: allDates)
        let room2 = ReservedDateRange.Room(roomId: 200, reservableDateRanges: someDates)
        
        return ReservedDateRange(rooms: [room1, room2])
    }
} 
