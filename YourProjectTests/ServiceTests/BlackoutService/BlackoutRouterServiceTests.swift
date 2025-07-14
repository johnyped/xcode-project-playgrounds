//
//  BlackoutRouterServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 5/7/2568 BE.
//

import XCTest

final class BlackoutRouterServiceTests: XCTestCase {
    
    func testFetchByPeriodRouter_WillHaveCorrectParameters() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let endDate = Date(timeIntervalSince1970: 1735689600) // 2025-01-01
        let period = PeriodDate(start: startDate, end: endDate)
        
        let request = BlackoutServiceRequest.FetchByPeriod(
            hotelId: 105,
            period: period,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // When
        let router = BlackoutServiceRouter.fetchByPeriod(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/blackout-units/period")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["start_date"] as? String, "2020-01-01")
        XCTAssertEqual(parameters?["end_date"] as? String, "2025-01-01")
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func testFetchByIdRouter_WillHaveCorrectPath() throws {
        // Given
        let request = BlackoutServiceRequest.FetchById(id: 172)
        
        // When
        let router = BlackoutServiceRouter.fetchById(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/blackout-units/172")
        XCTAssertEqual(router.method.rawValue, "GET")
        XCTAssertNil(router.parameters)
    }
    
    func testCreateBlackoutUnitRouter_WillHaveCorrectMethodAndPath() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1716926400) // 2024-05-29
        let endDate = Date(timeIntervalSince1970: 1717012800) // 2024-05-30
        
        let request = BlackoutServiceRequest.CreateBlackoutUnit(
            hotelId: 105,
            unitableId: 620,
            unitableType: .room,
            period: .init(start: startDate,
                          end: endDate),
            removesDate: nil,
            note: "Test blackout",
            emoji: "🚫",
            quantity: 1
        )
        
        // When
        let router = BlackoutServiceRouter.createBlackoutUnit(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/blackout-units")
        XCTAssertEqual(router.method.rawValue, "POST")
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
    func testUpdateBlackoutUnitRouter_WillHaveCorrectMethodAndPath() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1716926400) // 2024-05-29
        
        let request = BlackoutServiceRequest.UpdateBlackoutUnit(
            id: 172,
            note: nil,
            emoji: "Updated note",
            removesDate: nil
        )
        
        // When
        let router = BlackoutServiceRouter.updateBlackoutUnit(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/blackout-units/172")
        XCTAssertEqual(router.method.rawValue, "PUT")
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
    func testDeleteBlackoutUnitRouter_WillHaveCorrectMethodAndPath() throws {
        // Given
        let request = BlackoutServiceRequest.DeleteBlackoutUnit(id: 172)
        
        // When
        let router = BlackoutServiceRouter.deleteBlackoutUnit(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/blackout-units/172")
        XCTAssertEqual(router.method.rawValue, "DELETE")
        XCTAssertNil(router.parameters)
        XCTAssertNil(router.body)
    }
    
    func testBatchCreateBlackoutUnitsRouter_WillHaveCorrectMethodAndPath() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1716926400) // 2024-05-29
        let endDate = Date(timeIntervalSince1970: 1717012800) // 2024-05-30
        
        let blackoutUnit1 = BlackoutServiceRequest.BatchBlackoutUnit(
            unitableId: 620,
            unitableType: .room,
            period: .init(start: startDate,
                          end: endDate),
            removesDate: nil,
            note: "Batch test 1",
            emoji: nil,
            quantity: 1
        )
        
        let blackoutUnit2 = BlackoutServiceRequest.BatchBlackoutUnit(
            unitableId: 621,
            unitableType: .room,
            period: .init(start: startDate,
                          end: endDate),
            removesDate: nil,
            note: "Batch test 2",
            emoji: nil,
            quantity: 1
        )
        
        let request = BlackoutServiceRequest.BatchCreateBlackoutUnits(
            hotelId: 105,
            blackoutUnits: [blackoutUnit1, blackoutUnit2]
        )
        
        // When
        let router = BlackoutServiceRouter.batchCreateBlackoutUnits(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/blackout-units/batch-create")
        XCTAssertEqual(router.method.rawValue, "POST")
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
    func testBatchDeleteBlackoutUnitsRouter_WillHaveCorrectParameters() throws {
        // Given
        let request = BlackoutServiceRequest.BatchDeleteBlackoutUnits(
            hotelId: 105,
            ids: [172, 173, 174]
        )
        
        // When
        let router = BlackoutServiceRouter.batchDeleteBlackoutUnits(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/blackout-units/batch-delete")
        XCTAssertEqual(router.method.rawValue, "DELETE")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["blackout_unit_ids"] as? [Int], [172, 173, 174])
        XCTAssertNil(router.body)
    }
    
} 
