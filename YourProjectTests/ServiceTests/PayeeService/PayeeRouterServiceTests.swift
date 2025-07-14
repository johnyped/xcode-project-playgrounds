//
//  PayeeRouterServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import XCTest

final class PayeeRouterServiceTests: XCTestCase {
    
    func testFetchByHotelRouter_WillHaveCorrectParameters() throws {
        // Given
        let request = PayeeServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .name,
            sortedOrder: .ascending
        )
        
        // When
        let router = PayeeServiceRouter.fetchByHotel(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/payees")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "NAME")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func testFetchByIdRouter_WillHaveCorrectPath() throws {
        // Given
        let request = PayeeServiceRequest.FetchById(id: 1)
        
        // When
        let router = PayeeServiceRouter.fetchById(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/payees/1")
        XCTAssertEqual(router.method.rawValue, "GET")
        XCTAssertNil(router.parameters)
        XCTAssertNil(router.body)
    }
    
    func testCreatePayeeRouter_WillHaveCorrectMethodAndPath() throws {
        // Given
        let request = PayeeServiceRequest.CreatePayee(
            hotelId: 105,
            name: "ค่าไฟ้า",
            memo: "electricity bill",
            buyVatType: .sevenPercent,
            sellVatType: .sevenPercent,
            accountItemCategoryId: 5,
            accountSubItemCategoryId: 1
        )
        
        // When
        let router = PayeeServiceRouter.createPayee(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/payees")
        XCTAssertEqual(router.method.rawValue, "POST")
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
    func testUpdatePayeeRouter_WillHaveCorrectMethodAndPath() throws {
        // Given
        let request = PayeeServiceRequest.UpdatePayee(
            id: 1,
            name: "ค่าไฟ้า (Updated)",
            memo: "updated electricity bill",
            buyVatType: .tenPercent,
            sellVatType: .tenPercent,
            accountItemCategoryId: 6,
            accountSubItemCategoryId: 2
        )
        
        // When
        let router = PayeeServiceRouter.updatePayee(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/payees/1")
        XCTAssertEqual(router.method.rawValue, "PUT")
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
    func testDeletePayeeRouter_WillHaveCorrectMethodAndPath() throws {
        // Given
        let request = PayeeServiceRequest.DeletePayee(id: 1)
        
        // When
        let router = PayeeServiceRouter.deletePayee(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/payees/1")
        XCTAssertEqual(router.method.rawValue, "DELETE")
        XCTAssertNil(router.parameters)
        XCTAssertNil(router.body)
    }
    
    func testFetchByHotelRouter_WithDifferentSortedBy_WillHaveCorrectParameters() throws {
        // Given
        let request = PayeeServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 2,
            perPage: .fifty,
            sortedBy: .createdAt,
            sortedOrder: .descending
        )
        
        // When
        let router = PayeeServiceRouter.fetchByHotel(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/payees")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["page"] as? Int, 2)
        XCTAssertEqual(parameters?["per_page"] as? String, "50")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "CREATED_AT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    func testFetchByHotelRouter_WithNilOptionalValues_WillHaveMinimalParameters() throws {
        // Given
        let request = PayeeServiceRequest.FetchByHotel(
            hotelId: 105,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // When
        let router = PayeeServiceRouter.fetchByHotel(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/payees")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
    }
    
    func testCreatePayeeRouter_WillHaveCorrectHeaders() throws {
        // Given
        let request = PayeeServiceRequest.CreatePayee(
            hotelId: 105,
            name: "Test Payee",
            memo: "Test memo",
            buyVatType: .noVat,
            sellVatType: .noVat,
            accountItemCategoryId: 1,
            accountSubItemCategoryId: nil
        )
        
        // When
        let router = PayeeServiceRouter.createPayee(request: request)
        
        // Then
        let headers = router.headers
        XCTAssertNotNil(headers)
        XCTAssertEqual(headers?["Content-Type"], "application/json")
    }
    
    func testUpdatePayeeRouter_WillHaveCorrectHeaders() throws {
        // Given
        let request = PayeeServiceRequest.UpdatePayee(
            id: 1,
            name: "Updated Payee",
            memo: nil,
            buyVatType: nil,
            sellVatType: nil,
            accountItemCategoryId: nil,
            accountSubItemCategoryId: nil
        )
        
        // When
        let router = PayeeServiceRouter.updatePayee(request: request)
        
        // Then
        let headers = router.headers
        XCTAssertNotNil(headers)
        XCTAssertEqual(headers?["Content-Type"], "application/json")
    }
} 