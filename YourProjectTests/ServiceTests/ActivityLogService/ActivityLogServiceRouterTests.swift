//
//  ActivityLogServiceRouterTests.swift
//  YourProject
//
//  Created by IntrodexMini on 1/7/2568 BE.
//

import XCTest

final class ActivityLogServiceRouterTests: XCTestCase {
    
    func testFetchCreatorByFinancialRecordRouter_WillHaveCorrectParameters() throws {
        // Given
        let request = ActivityLogServiceRequest.FetchCreatorByFinancialRecord(
            hotelId: 105,
            financialRecordId: 440
        )
        
        // When
        let router = ActivityLogServiceRouter.fetchCreatorByFinancialRecord(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/activity-logs/creator/financial-record")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["financial_record_id"] as? Int, 440)
    }
    
    func testFetchCreatorByReservationRouter_WillHaveCorrectParameters() throws {
        // Given
        let request = ActivityLogServiceRequest.FetchCreatorByReservation(
            hotelId: 105,
            reservationId: 273
        )
        
        // When
        let router = ActivityLogServiceRouter.fetchCreatorByReservation(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/activity-logs/creator/reservation")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["reservation_id"] as? Int, 273)
    }
    
    func testFetchCreatorByAdditionalRouter_WillHaveCorrectParameters() throws {
        // Given
        let request = ActivityLogServiceRequest.FetchCreatorByAdditional(
            hotelId: 105,
            additionalId: 273
        )
        
        // When
        let router = ActivityLogServiceRouter.fetchCreatorByAdditional(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/activity-logs/creator/additional")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["additional_id"] as? Int, 273)
    }
    
    func testFetchCreatorByAccountRouter_WillHaveCorrectParameters() throws {
        // Given
        let request = ActivityLogServiceRequest.FetchCreatorByAccount(
            hotelId: 105,
            accountId: 1
        )
        
        // When
        let router = ActivityLogServiceRouter.fetchCreatorByAccount(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/activity-logs/creator/account")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["account_id"] as? Int, 1)
    }
    
    func testFetchCreatorByAccountItemRouter_WillHaveCorrectParameters() throws {
        // Given
        let request = ActivityLogServiceRequest.FetchCreatorByAccountItem(
            hotelId: 105,
            accountItemId: 1
        )
        
        // When
        let router = ActivityLogServiceRouter.fetchCreatorByAccountItem(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/activity-logs/creator/account-item")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["account_item_id"] as? Int, 1)
    }
    
    // MARK: - Domain and Headers Tests
    
    func testAllRouters_WillHaveCorrectDomainAndHeaders() throws {
        // Given
        let requests = [
            ActivityLogServiceRouter.fetchCreatorByFinancialRecord(
                request: ActivityLogServiceRequest.FetchCreatorByFinancialRecord(hotelId: 1, financialRecordId: 1)
            ),
            ActivityLogServiceRouter.fetchCreatorByReservation(
                request: ActivityLogServiceRequest.FetchCreatorByReservation(hotelId: 1, reservationId: 1)
            ),
            ActivityLogServiceRouter.fetchCreatorByAdditional(
                request: ActivityLogServiceRequest.FetchCreatorByAdditional(hotelId: 1, additionalId: 1)
            ),
            ActivityLogServiceRouter.fetchCreatorByAccount(
                request: ActivityLogServiceRequest.FetchCreatorByAccount(hotelId: 1, accountId: 1)
            ),
            ActivityLogServiceRouter.fetchCreatorByAccountItem(
                request: ActivityLogServiceRequest.FetchCreatorByAccountItem(hotelId: 1, accountItemId: 1)
            )
        ]
        
        // When & Then
        for router in requests {
            XCTAssertNotNil(router.domain)
            XCTAssertEqual(router.headers?["Content-Type"], "application/json")
            XCTAssertNil(router.body)
        }
    }
    
    // MARK: - URL Request Generation Tests
    
    func testFetchCreatorByFinancialRecordRouter_WillGenerateValidURLRequest() throws {
        // Given
        let request = ActivityLogServiceRequest.FetchCreatorByFinancialRecord(
            hotelId: 42,
            financialRecordId: 999
        )
        let router = ActivityLogServiceRouter.fetchCreatorByFinancialRecord(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertNotNil(urlRequest.url)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/activity-logs/creator/financial-record") == true)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("hotel_id=42") == true)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("financial_record_id=999") == true)
    }
} 