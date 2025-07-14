//
//  FinancialRecordRouterServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 13/6/2568 BE.
//

import XCTest

final class FinancialRecordRouterServiceTests: XCTestCase {
    
    func testFetchByHotelRouter_WillHaveCorrectParameters() throws {
        // Given
        let request = FinancialRecordServiceRequest.FetchByHotel(
            hotelId: 1,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // When
        let router = FinancialRecordServiceRouter.fetchByHotel(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/financial-records")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 1)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func testFetchByPeriodRouter_WillHaveCorrectParameters() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let endDate = Date(timeIntervalSince1970: 1735689600) // 2025-01-01
        let period = PeriodDate(start: startDate, end: endDate)
        
        let request = FinancialRecordServiceRequest.FetchByPeriod(
            hotelId: 1,
            period: period,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .descending
        )
        
        // When
        let router = FinancialRecordServiceRouter.fetchByPeriod(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/financial-records/period")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 1)
        XCTAssertEqual(parameters?["start_date"] as? String, "2020-01-01")
        XCTAssertEqual(parameters?["end_date"] as? String, "2025-01-01")
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    func testFetchByReservationRouter_WillHaveCorrectParameters() throws {
        // Given
        let request = FinancialRecordServiceRequest.FetchByReservation(
            hotelId: 1,
            reservationId: 1061,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // When
        let router = FinancialRecordServiceRouter.fetchByReservation(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/financial-records/reservation")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 1)
        XCTAssertEqual(parameters?["reservation_id"] as? Int, 1061)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func testFetchByCreatedAtRouter_WillHaveCorrectParameters() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1714129200) // 2025-04-26T20:20:00+07:00 equivalent
        let endDate = Date(timeIntervalSince1970: 1714215600) // 2025-04-27T20:20:00+07:00 equivalent  
        let periodDate = PeriodDate(start: startDate, end: endDate)
        
        let request = FinancialRecordServiceRequest.FetchByCreatedAt(
            hotelId: 1,
            periodDate: periodDate,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // When
        let router = FinancialRecordServiceRouter.fetchByCreatedAt(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/financial-records/created-at")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 1)
        XCTAssertNotNil(parameters?["start_at"])
        XCTAssertNotNil(parameters?["end_at"])
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func testFetchByAccountItemRouter_WillHaveCorrectParameters() throws {
        // Given
        let request = FinancialRecordServiceRequest.FetchByAccountItem(
            hotelId: 1,
            accountItemId: 2,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // When
        let router = FinancialRecordServiceRouter.fetchByAccountItem(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/financial-records/account-item")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 1)
        XCTAssertEqual(parameters?["account_item_id"] as? Int, 2)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func testFetchByIdRouter_WillHaveCorrectPath() throws {
        // Given
        let request = FinancialRecordServiceRequest.FetchById(id: 439)
        
        // When
        let router = FinancialRecordServiceRouter.fetchById(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/financial-records/439")
        XCTAssertEqual(router.method.rawValue, "GET")
        XCTAssertNil(router.parameters)
    }
    
    func testCreateFinancialRecordRouter_WillHaveCorrectMethodAndPath() throws {
        // Given
        let timestamp = Date(timeIntervalSince1970: 1713254537) // 2024-04-16T15:52:17.285+07:00 equivalent
        let request = FinancialRecordServiceRequest.CreateFinancialRecord(
            hotelId: 105,
            name: "NEW PAYMENT",
            paymentMethod: "Credit Card",
            note: "Test payment",
            timestamp: timestamp,
            amount: 1500.0,
            recordableId: 1070,
            recordableType: .reservation,
            bankAccountId: nil
        )
        
        // When
        let router = FinancialRecordServiceRouter.createFinancialRecord(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/financial-records")
        XCTAssertEqual(router.method.rawValue, "POST")
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
    func testUpdateFinancialRecordRouter_WillHaveCorrectMethodAndPath() throws {
        // Given
        let request = FinancialRecordServiceRequest.UpdateFinancialRecord(
            id: 439,
            name: "UPDATED PAYMENT",
            paymentMethod: "Cash",
            note: "Updated note",
            timestamp: nil,
            amount: 2000.0,
            recordableId: nil,
            recordableType: nil,
            bankAccountId: nil
        )
        
        // When
        let router = FinancialRecordServiceRouter.updateFinancialRecord(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/financial-records/439")
        XCTAssertEqual(router.method.rawValue, "PUT")
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
    func testDeleteFinancialRecordRouter_WillHaveCorrectMethodAndPath() throws {
        // Given
        let request = FinancialRecordServiceRequest.DeleteFinancialRecord(id: 439)
        
        // When
        let router = FinancialRecordServiceRouter.deleteFinancialRecord(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/financial-records/439")
        XCTAssertEqual(router.method.rawValue, "DELETE")
        XCTAssertNil(router.parameters)
        XCTAssertNil(router.body)
    }
    
} 
