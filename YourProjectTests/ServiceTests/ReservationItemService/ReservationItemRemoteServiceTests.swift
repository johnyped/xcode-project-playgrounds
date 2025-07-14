//
//  ReservationItemRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 13/6/2568 BE.
//

import XCTest
import Mockable

final class ReservationItemRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchByReservation_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<ReservationItem>(
            items: Collection(array: []),
            totalItems: 0,
            totalPages: 0,
            perPage: 20,
            page: 1
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)

        let service = ReservationItemRemoteService(localStorage: localStorage,
                                         apiManager: apiManager)
        let request = ReservationItemServiceRequest.FetchByReservation(
            hotelId: 1,
            reservationId: 1092,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )

        // When
        let result = try await service.fetchByReservation(request: request)

        // Then
        XCTAssertEqual(result.totalItems, expectedPaginator.totalItems)
    }

    func testFetchById_WillGetValidResponse() async throws {
        // Given
        let sampleData = ReservationItem.Data(
            isCustomRate: false,
            selectedRate: 2500.0,
            extraAdultRate: 300.0,
            extraAdultQty: 1,
            extraChildRate: 150.0,
            extraChildQty: 0,
            mealIncluded: true,
            adultMealLimit: 2,
            adultMealRate: 250.0,
            childMealLimit: 1,
            childMealRate: 125.0,
            extraAdultMealRate: 250.0,
            extraAdultMealQty: 0,
            extraChildMealRate: 125.0,
            extraChildMealQty: 0
        )
        
        let expectedReservationItem = ReservationItem(
            id: 1,
            reservedDate: Date(timeIntervalSince1970: 1713158400), // 2024-04-15
            totalPrice: 2800.0,
            reservableType: .room,
            reservableId: 101,
            data: sampleData,
            priceCardId: 2,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservationItem)

        let service = ReservationItemRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = ReservationItemServiceRequest.FetchById(id: 1)

        // When
        let result = try await service.fetchById(request: request)

        // Then
        XCTAssertEqual(result.id, expectedReservationItem.id)
        XCTAssertEqual(result.reservableType, expectedReservationItem.reservableType)
        XCTAssertEqual(result.reservableId, expectedReservationItem.reservableId)
        XCTAssertEqual(result.totalPrice, expectedReservationItem.totalPrice)
    }

    func testUpdateReservationItem_WillGetValidResponse() async throws {
        // Given
        let updatedData = ReservationItem.Data(
            isCustomRate: true,
            selectedRate: 3000.0,
            extraAdultRate: 350.0,
            extraAdultQty: 2,
            extraChildRate: 175.0,
            extraChildQty: 1,
            mealIncluded: true,
            adultMealLimit: 2,
            adultMealRate: 250.0,
            childMealLimit: 1,
            childMealRate: 125.0,
            extraAdultMealRate: 250.0,
            extraAdultMealQty: 1,
            extraChildMealRate: 125.0,
            extraChildMealQty: 0
        )
        
        let expectedReservationItem = ReservationItem(
            id: 1,
            reservedDate: Date(timeIntervalSince1970: 1713158400), // 2024-04-15
            totalPrice: 4200.0,
            reservableType: .room,
            reservableId: 102,
            data: updatedData,
            priceCardId: nil,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservationItem)

        let service = ReservationItemRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = ReservationItemServiceRequest.UpdateReservationItem(
            id: 1,
            reservationId: 1092,
            reservationType: .room,
            totalPrice: 4200.0,
            priceCardId: nil,
            data: updatedData
        )

        // When
        let result = try await service.updateReservationItem(request: request)

        // Then
        XCTAssertEqual(result.id, expectedReservationItem.id)
        XCTAssertEqual(result.reservableType, expectedReservationItem.reservableType)
        XCTAssertEqual(result.reservableId, expectedReservationItem.reservableId)
        XCTAssertEqual(result.totalPrice, expectedReservationItem.totalPrice)
    }

    func testDeleteReservationItem_WillSucceed() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = ReservationItemRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = ReservationItemServiceRequest.DeleteReservationItem(id: 1)

        // When/Then
        do {
            try await service.deleteReservationItem(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("Delete should not throw error")
        }
    }

    func testReplaceReservationItems_WillGetValidResponse() async throws {
        // Given
        let sampleData = ReservationItem.Data(
            isCustomRate: false,
            selectedRate: 2500.0,
            extraAdultRate: 300.0,
            extraAdultQty: 1,
            extraChildRate: 150.0,
            extraChildQty: 0,
            mealIncluded: true,
            adultMealLimit: 2,
            adultMealRate: 250.0,
            childMealLimit: 1,
            childMealRate: 125.0,
            extraAdultMealRate: 250.0,
            extraAdultMealQty: 0,
            extraChildMealRate: 125.0,
            extraChildMealQty: 0
        )
        
        let expectedItems = [
            ReservationItem(
                id: 3,
                reservedDate: Date(timeIntervalSince1970: 1713158400), // 2024-04-15
                totalPrice: 2800.0,
                reservableType: .room,
                reservableId: 101,
                data: sampleData,
                priceCardId: 2,
                createdAt: Date(),
                updatedAt: Date()
            ),
            ReservationItem(
                id: 4,
                reservedDate: Date(timeIntervalSince1970: 1713158400), // 2024-04-15
                totalPrice: 2800.0,
                reservableType: .room,
                reservableId: 102,
                data: sampleData,
                priceCardId: 2,
                createdAt: Date(),
                updatedAt: Date()
            )
        ]
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedItems)

        let service = ReservationItemRemoteService(localStorage: localStorage, apiManager: apiManager)
        let itemData = ReservationItemServiceRequest.ReservationItemData(
            reservedDate: Date(timeIntervalSince1970: 1713158400), // 2024-04-15
            reservableType: .room,
            reservableId: 101,
            totalPrice: 2800.0,
            priceCardId: 2,
            data: sampleData
        )
        let period = PeriodDate(start: Date(), end: Calendar.current.date(byAdding: .day, value: 2, to: Date())!)
        let request = ReservationItemServiceRequest.ReplaceReservationItems(
            reservationId: 1092,
            period: period,
            items: [itemData]
        )

        // When
        let result = try await service.replaceReservationItems(request: request)

        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0].id, expectedItems[0].id)
        XCTAssertEqual(result[1].id, expectedItems[1].id)
    }
} 
