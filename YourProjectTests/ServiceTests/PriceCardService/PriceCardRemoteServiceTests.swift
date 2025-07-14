//
//  PriceCardRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest
import Mockable

final class PriceCardRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchPriceCards_WillGetValidResponse() async throws {
        // Given
        let array: LocalPriceCards = .init(array: [
            LocalPriceCard(
                id: 1,
                title: "Standard Room Rate",
                description: "Regular pricing for standard rooms",
                dailyPrice: 1500.0,
                totalPrice: 1650.0,
                periodTypes: LocalPriceCard.WeekDays(days: ["Monday", "Tuesday"]),
                exceptionDates: [],
                reservableTypeId: 101,
                reservableType: .roomType,
                code: "STD001",
                color: "#FF5733",
                meal: .init(),
                period: PeriodDate(start: Date(), end: Date().addingTimeInterval(86400 * 7)),
                availableChannels: [],
                createdAt: Date(),
                updatedAt: Date()
            )
        ])
        let expectedPaginator = Paginator<LocalPriceCard>(
            items: array,
            totalItems: 1,
            totalPages: 1,
            perPage: 20,
            page: 1
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce { (_, _) -> Paginator<LocalPriceCard> in
                return expectedPaginator
            }

        let service = PriceCardRemoteService(localStorage: localStorage,
                                           apiManager: apiManager)
        let request = PriceCardServiceRequest.FetchPriceCards(
            page: 1,
            perPage: 20,
            sortedBy: "id",
            sortedOrder: "ASC",
            hotelId: 105,
            roomTypeId: 101
        )

        // When
        let result = try await service.fetchPriceCards(request: request)

        // Then
        XCTAssertEqual(result.totalItems, expectedPaginator.totalItems)
        XCTAssertEqual(result.page, expectedPaginator.page)
        XCTAssertEqual(result.perPage, expectedPaginator.perPage)
        XCTAssertEqual(result.items.first?.id, 1)
        XCTAssertEqual(result.items.first?.title, "Standard Room Rate")
        XCTAssertEqual(result.items.first?.dailyPrice, 1500.0)
    }

    func testFetchPriceCard_WillGetValidResponse() async throws {
        // Given
        let expectedPriceCard = LocalPriceCard(
            id: 2,
            title: "Premium Suite Rate",
            description: "Premium pricing for luxury suites",
            dailyPrice: 3500.0,
            totalPrice: 3850.0,
            periodTypes: LocalPriceCard.WeekDays(days: ["Friday", "Saturday"]),
            exceptionDates: [],
            reservableTypeId: 201,
            reservableType: .roomType,
            code: "PREM002",
            color: "#FFD700",
            meal: .init(),
            period: PeriodDate(start: Date(), end: Date().addingTimeInterval(86400 * 14)),
            availableChannels: [],
            createdAt: Date(),
            updatedAt: Date()
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce { (_, _) -> LocalPriceCard in
                return expectedPriceCard
            }

        let service = PriceCardRemoteService(localStorage: localStorage, 
                                           apiManager: apiManager)
        let request = PriceCardServiceRequest.FetchPriceCard(id: 2)

        // When
        let result = try await service.fetchPriceCard(request: request)

        // Then
        XCTAssertEqual(result.id, expectedPriceCard.id)
        XCTAssertEqual(result.title, expectedPriceCard.title)
        XCTAssertEqual(result.description, expectedPriceCard.description)
        XCTAssertEqual(result.dailyPrice, expectedPriceCard.dailyPrice)
        XCTAssertEqual(result.totalPrice, expectedPriceCard.totalPrice)
        XCTAssertEqual(result.code, expectedPriceCard.code)
        XCTAssertEqual(result.color, expectedPriceCard.color)
    }

    func testFetchPriceCardsByPeriod_WillGetValidResponse() async throws {
        // Given
        let expectedPriceCards = LocalPriceCards(array: [
            LocalPriceCard(
                id: 3,
                title: "Weekend Special",
                description: "Special weekend pricing",
                dailyPrice: 2000.0,
                totalPrice: 2200.0,
                periodTypes: LocalPriceCard.WeekDays(days: ["Saturday", "Sunday"]),
                exceptionDates: [],
                reservableTypeId: 301,
                reservableType: .roomType,
                code: "WKND003",
                color: "#32CD32",
                meal: .init(),
                period: PeriodDate(start: Date(), end: Date().addingTimeInterval(86400 * 2)),
                availableChannels: [],
                createdAt: Date(),
                updatedAt: Date()
            )
        ])
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce { (_, _) -> LocalPriceCards in
                return expectedPriceCards
            }

        let service = PriceCardRemoteService(localStorage: localStorage,
                                           apiManager: apiManager)
        let request = PriceCardServiceRequest.FetchPriceCardsByPeriod(
            hotelId: 105,
            startDate: Date(),
            endDate: Date().addingTimeInterval(86400 * 7),
            channelId: 1,
            subChannelId: 2,
            reservableTypeType: "RoomType",
            reservableTypeId: 301
        )

        // When
        let result = try await service.fetchPriceCardsByPeriod(request: request)

        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.id, 3)
        XCTAssertEqual(result.first?.title, "Weekend Special")
        XCTAssertEqual(result.first?.dailyPrice, 2000.0)
        XCTAssertEqual(result.first?.code, "WKND003")
    }

    func testCreatePriceCard_WillGetValidResponse() async throws {
        // Given
        let expectedPriceCard = LocalPriceCard(
            id: 4,
            title: "New Rate Plan",
            description: "Newly created rate plan",
            dailyPrice: 1800.0,
            totalPrice: 1980.0,
            periodTypes: LocalPriceCard.WeekDays(days: ["Monday", "Wednesday", "Friday"]),
            exceptionDates: [],
            reservableTypeId: 401,
            reservableType: .roomType,
            code: "NEW004",
            color: "#FF69B4",
            meal: .init(),
            period: PeriodDate(start: Date(), end: Date().addingTimeInterval(86400 * 30)),
            availableChannels: [],
            createdAt: Date(),
            updatedAt: Date()
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce { (_, _) -> LocalPriceCard in
                return expectedPriceCard
            }

        let service = PriceCardRemoteService(localStorage: localStorage, 
                                           apiManager: apiManager)
        let request = PriceCardServiceRequest.CreatePriceCard(
            hotelId: 105,
            title: "New Rate Plan",
            reservableTypeId: 401,
            reservableTypeType: "RoomType",
            price: 1800.0,
            description: "Newly created rate plan",
            code: "NEW004",
            color: "#FF69B4",
            periodTypes: ["Monday", "Tuesday", "Wednesday"],
            exceptionDates: ["2024-12-25", "2024-12-31"],
            bfIncluded: true,
            bfAdultPrice: 150.0,
            bfAdultLimit: 2,
            bfAdultExtraRate: 100.0,
            bfAdultExtraLimit: 4,
            bfChildPrice: 75.0,
            bfChildLimit: 2,
            bfChildExtraRate: 50.0,
            bfChildExtraLimit: 4,
            startAt: Date(timeIntervalSince1970: 1672531200), // 2023-01-01 00:00:00 UTC
            endAt: Date(timeIntervalSince1970: 1704067200), // 2024-01-01 00:00:00 UTC
            channels: ["online", "phone"],
            pinned: false
        )

        // When
        let result = try await service.createPriceCard(request: request)

        // Then
        XCTAssertEqual(result.id, expectedPriceCard.id)
        XCTAssertEqual(result.title, expectedPriceCard.title)
        XCTAssertEqual(result.description, expectedPriceCard.description)
        XCTAssertEqual(result.dailyPrice, expectedPriceCard.dailyPrice)
        XCTAssertEqual(result.code, expectedPriceCard.code)
        XCTAssertEqual(result.color, expectedPriceCard.color)
    }

    func testUpdatePriceCard_WillGetValidResponse() async throws {
        // Given
        let expectedPriceCard = LocalPriceCard(
            id: 5,
            title: "Updated Rate Plan",
            description: "Updated pricing information",
            dailyPrice: 2500.0,
            totalPrice: 2750.0,
            periodTypes: LocalPriceCard.WeekDays(days: ["Tuesday", "Thursday"]),
            exceptionDates: [],
            reservableTypeId: 501,
            reservableType: .roomType,
            code: "UPD005",
            color: "#8A2BE2",
            meal: .init(),
            period: PeriodDate(start: Date(), end: Date().addingTimeInterval(86400 * 60)),
            availableChannels: [],
            createdAt: Date(),
            updatedAt: Date()
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce { (_, _) -> LocalPriceCard in
                return expectedPriceCard
            }

        let service = PriceCardRemoteService(localStorage: localStorage, 
                                           apiManager: apiManager)
        let request = PriceCardServiceRequest.UpdatePriceCard(
            id: 5,
            title: "Updated Rate Plan",
            description: "Updated pricing information",
            reservableTypeId: 501,
            reservableTypeType: "RoomType",
            price: 2500.0,
            code: "UPD005",
            color: "#8A2BE2",
            periodTypes: ["Friday", "Saturday"],
            exceptionDates: ["2024-11-28"],
            bfIncluded: false,
            bfAdultPrice: nil,
            bfAdultLimit: nil,
            bfAdultExtraRate: nil,
            bfAdultExtraLimit: nil,
            bfChildPrice: nil,
            bfChildLimit: nil,
            bfChildExtraRate: nil,
            bfChildExtraLimit: nil,
            startAt: Date(timeIntervalSince1970: 1672531200), // 2023-01-01 00:00:00 UTC
            endAt: Date(timeIntervalSince1970: 1704067200), // 2024-01-01 00:00:00 UTC
            channels: ["online"],
            pinned: true
        )

        // When
        let result = try await service.updatePriceCard(request: request)

        // Then
        XCTAssertEqual(result.id, expectedPriceCard.id)
        XCTAssertEqual(result.title, expectedPriceCard.title)
        XCTAssertEqual(result.description, expectedPriceCard.description)
        XCTAssertEqual(result.dailyPrice, expectedPriceCard.dailyPrice)
        XCTAssertEqual(result.code, expectedPriceCard.code)
        XCTAssertEqual(result.color, expectedPriceCard.color)
    }

    func testDeletePriceCard_WillSucceed() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willProduce { (_, _) -> Void in
                return ()
            }

        let service = PriceCardRemoteService(localStorage: localStorage, 
                                           apiManager: apiManager)
        let request = PriceCardServiceRequest.DeletePriceCard(id: 6)

        // When/Then
        do {
            try await service.deletePriceCard(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("Delete should not throw error")
        }
    }

    func testFetchPriceCard_WhenAPIThrowsError_WillThrowError() async {
        // Given
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce { (_, _) -> LocalPriceCard in
                throw APIError.unknownError(title: "Test Error",
                                           subtitle: nil,
                                           underlying: nil)
            }

        let service = PriceCardRemoteService(localStorage: localStorage, 
                                           apiManager: apiManager)
        let request = PriceCardServiceRequest.FetchPriceCard(id: 999)

        // When/Then
        do {
            _ = try await service.fetchPriceCard(request: request)
            XCTFail("Should throw error")
        } catch let error as APIError {
            if case .unknownError(let title, _, _) = error {
                XCTAssertEqual(title, "Test Error")
            } else {
                XCTFail("Should throw APIError.unknownError")
            }
        } catch {
            XCTFail("Should throw APIError")
        }
    }

    func testFetchPriceCards_WhenAPIThrowsError_WillThrowError() async {
        // Given
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce { (_, _) -> Paginator<LocalPriceCard> in
                throw APIError.invalidURL
            }

        let service = PriceCardRemoteService(localStorage: localStorage,
                                           apiManager: apiManager)
        let request = PriceCardServiceRequest.FetchPriceCards(
            page: 1,
            perPage: 20,
            sortedBy: nil,
            sortedOrder: nil,
            hotelId: nil,
            roomTypeId: nil
        )

        // When/Then
        do {
            _ = try await service.fetchPriceCards(request: request)
            XCTFail("Should throw error")
        } catch let error as APIError {
            switch error {
            case .invalidURL:
                break
            default:
                XCTFail("Should throw APIError.invalidURL")
            }
        } catch {
            XCTFail("Should throw APIError.invalidURL")
        }
    }
} 
