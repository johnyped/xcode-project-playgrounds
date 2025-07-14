//
//  ReservationItemServiceRouterTests.swift
//  YourProject
//
//  Created by IntrodexMini on 13/6/2568 BE.
//

import XCTest

final class ReservationItemServiceRouterTests: XCTestCase {
    
    func testFetchByReservationRouter_WillHaveCorrectParameters() throws {
        // Given
        let request = ReservationItemServiceRequest.FetchByReservation(
            hotelId: 1,
            reservationId: 1092,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // When
        let router = ReservationItemServiceRouter.fetchByReservation(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/reservation-items")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 1)
        XCTAssertEqual(parameters?["reservation_id"] as? Int, 1092)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func testFetchByIdRouter_WillHaveCorrectPath() throws {
        // Given
        let request = ReservationItemServiceRequest.FetchById(id: 123)
        
        // When
        let router = ReservationItemServiceRouter.fetchById(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/reservation-items/123")
        XCTAssertEqual(router.method.rawValue, "GET")
        XCTAssertNil(router.parameters)
        XCTAssertNil(router.body)
    }
    
    func testUpdateReservationItemRouter_WillHaveCorrectMethodAndPath() throws {
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
        
        let request = ReservationItemServiceRequest.UpdateReservationItem(
            id: 123,
            reservationId: 1092,
            reservationType: .room,
            totalPrice: 4200.0,
            priceCardId: nil,
            data: updatedData
        )
        
        // When
        let router = ReservationItemServiceRouter.updateReservationItem(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/reservation-items/123")
        XCTAssertEqual(router.method.rawValue, "PUT")
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
    func testDeleteReservationItemRouter_WillHaveCorrectMethodAndPath() throws {
        // Given
        let request = ReservationItemServiceRequest.DeleteReservationItem(id: 123)
        
        // When
        let router = ReservationItemServiceRouter.deleteReservationItem(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/reservation-items/123")
        XCTAssertEqual(router.method.rawValue, "DELETE")
        XCTAssertNil(router.parameters)
        XCTAssertNil(router.body)
    }
    
    func testReplaceReservationItemsRouter_WillHaveCorrectMethodAndPath() throws {
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
        
        // Use specific dates for consistent testing        
        let itemData = ReservationItemServiceRequest.ReservationItemData(
            reservedDate: Date(timeIntervalSince1970: 1713158400), // 2024-04-15
            reservableType: .room,
            reservableId: 101,
            totalPrice: 2800.0,
            priceCardId: 2,
            data: sampleData
        )
        
        let period = PeriodDate(start: Date(timeIntervalSince1970: 1713158400), // 2024-04-15
            end: Date(timeIntervalSince1970: 1713331200) // 2024-04-17
        )
        
        let request = ReservationItemServiceRequest.ReplaceReservationItems(
            reservationId: 1,
            period: period,
            items: [itemData]
        )
        
        // When
        let router = ReservationItemServiceRouter.replaceReservationItems(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/reservation-items/replace")
        XCTAssertEqual(router.method.rawValue, "PUT")
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
} 
