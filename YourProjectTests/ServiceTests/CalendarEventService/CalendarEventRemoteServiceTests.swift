//
//  CalendarEventRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 7/7/2568 BE.
//

import XCTest
import Mockable

final class CalendarEventRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchByMonth_WillGetValidResponse() async throws {
        // Given
        let expectedCalendarEvents = CalendarEvents(array: [])
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCalendarEvents)

        let service = CalendarEventRemoteService(localStorage: localStorage, 
                                                 apiManager: apiManager)
        let testDate = Date(timeIntervalSince1970: 1719792000) // 2024-07-01 for month format
        let request = CalendarEventServiceRequest.FetchByMonth(
            hotelId: 105,
            date: testDate,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .descending
        )

        // When
        let result = try await service.fetchByMonth(request: request)

        // Then
        XCTAssertEqual(result.count, expectedCalendarEvents.count)
    }

    func testFetchByDay_WillGetValidResponse() async throws {
        // Given
        let expectedCalendarEvents = CalendarEvents(array: [])
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCalendarEvents)

        let service = CalendarEventRemoteService(localStorage: localStorage, 
                                                 apiManager: apiManager)
        let testDate = Date(timeIntervalSince1970: 1751364000) // 2025-07-07
        let request = CalendarEventServiceRequest.FetchByDay(
            hotelId: 105,
            date: testDate,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )

        // When
        let result = try await service.fetchByDay(request: request)

        // Then
        XCTAssertEqual(result.count, expectedCalendarEvents.count)
    }

    func testFetchById_WillGetValidResponse() async throws {
        // Given
        let expectedCalendarEvent = CalendarEvent(
            id: 2,
            hotelId: 105,
            title: "Demo",
            note: "Test note",
            date: Date(timeIntervalSince1970: 1751364000), // 2025-07-07
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCalendarEvent)

        let service = CalendarEventRemoteService(localStorage: localStorage, 
                                                 apiManager: apiManager)
        let request = CalendarEventServiceRequest.FetchById(id: 2)

        // When
        let result = try await service.fetchById(request: request)

        // Then
        XCTAssertEqual(result.id, expectedCalendarEvent.id)
        XCTAssertEqual(result.title, expectedCalendarEvent.title)
        XCTAssertEqual(result.note, expectedCalendarEvent.note)
        XCTAssertEqual(result.hotelId, expectedCalendarEvent.hotelId)
    }

    func testCreateCalendarEvent_WillGetValidResponse() async throws {
        // Given
        let expectedCalendarEvent = CalendarEvent(
            id: 3,
            hotelId: 105,
            title: "New Event",
            note: "New event note",
            date: Date(timeIntervalSince1970: 1751364000), // 2025-07-07
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCalendarEvent)

        let service = CalendarEventRemoteService(localStorage: localStorage, 
                                                 apiManager: apiManager)
        let testDate = Date(timeIntervalSince1970: 1751364000) // 2025-07-07
        let request = CalendarEventServiceRequest.CreateCalendarEvent(
            hotelId: 105,
            date: testDate,
            title: "New Event",
            note: "New event note"
        )

        // When
        let result = try await service.createCalendarEvent(request: request)

        // Then
        XCTAssertEqual(result.id, expectedCalendarEvent.id)
        XCTAssertEqual(result.title, expectedCalendarEvent.title)
        XCTAssertEqual(result.note, expectedCalendarEvent.note)
        XCTAssertEqual(result.hotelId, expectedCalendarEvent.hotelId)
    }

    func testUpdateCalendarEvent_WillGetValidResponse() async throws {
        // Given
        let expectedCalendarEvent = CalendarEvent(
            id: 2,
            hotelId: 105,
            title: "Updated Demo",
            note: "Updated note",
            date: Date(timeIntervalSince1970: 1751364000), // 2025-07-07
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCalendarEvent)

        let service = CalendarEventRemoteService(localStorage: localStorage, 
                                                 apiManager: apiManager)
        let request = CalendarEventServiceRequest.UpdateCalendarEvent(
            id: 2,
            date: nil,
            title: "Updated Demo",
            note: "Updated note"
        )

        // When
        let result = try await service.updateCalendarEvent(request: request)

        // Then
        XCTAssertEqual(result.id, expectedCalendarEvent.id)
        XCTAssertEqual(result.title, expectedCalendarEvent.title)
        XCTAssertEqual(result.note, expectedCalendarEvent.note)
        XCTAssertEqual(result.hotelId, expectedCalendarEvent.hotelId)
    }

    func testDeleteCalendarEvent_WillSucceed() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = CalendarEventRemoteService(localStorage: localStorage, 
                                                 apiManager: apiManager)
        let request = CalendarEventServiceRequest.DeleteCalendarEvent(id: 2)

        // When/Then
        do {
            try await service.deleteCalendarEvent(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("Delete should not throw error")
        }
    }
} 