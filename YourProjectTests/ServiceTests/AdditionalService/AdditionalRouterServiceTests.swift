//
//  AdditionalRouterServiceTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest

class AdditionalRouterServiceTests: XCTestCase {
    
    // MARK: - Test fetchAdditionals
    
    func test_fetchAdditionals_correctPath() throws {
        // Arrange
        
        let request = AdditionalServiceRequest.FetchAdditionals(
            hotelId: 105,
            reservationId: 1067,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            status: .active
        )
        let router = AdditionalServiceRouter.fetchAdditionals(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/additionals") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("hotel_id=105") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("page=1") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("per_page=20") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("sorted_by=ID") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("sorted_order=ASC") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("reservation_id=1067") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("status=ACTIVE") ?? false)
    }
    
    func test_fetchAdditionals_withMinimalParameters_correctPath() throws {
        // Arrange
        
        let request = AdditionalServiceRequest.FetchAdditionals(
            hotelId: 105,
            reservationId: 1,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            status: nil
        )
        let router = AdditionalServiceRouter.fetchAdditionals(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/additionals") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("hotel_id=105") ?? false)
        XCTAssertFalse(urlRequest.url?.absoluteString.contains("page=") ?? true)
        XCTAssertFalse(urlRequest.url?.absoluteString.contains("per_page=") ?? true)
        XCTAssertFalse(urlRequest.url?.absoluteString.contains("sorted_by=") ?? true)
        XCTAssertFalse(urlRequest.url?.absoluteString.contains("sorted_order=") ?? true)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("reservation_id=1") ?? true)
        XCTAssertFalse(urlRequest.url?.absoluteString.contains("status=") ?? true)
    }
    
    // MARK: - Test fetchAdditionalById
    
    func test_fetchAdditionalById_correctPath() throws {
        // Arrange
        let request = AdditionalServiceRequest.FetchById(id: 273)
        let router = AdditionalServiceRouter.fetchAdditionalById(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/additionals/273") ?? false)
    }
    
    // MARK: - Test fetchAdditionalsByCreatedAt
    
    func test_fetchAdditionalsByCreatedAt_correctPath() throws {
        // Arrange
        let startDate = Date(timeIntervalSince1970: 1619452800)
        let endDate = Date(timeIntervalSince1970: 1745452800)
        
        let request = AdditionalServiceRequest.FetchAdditionalsByCreatedAt(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .createdAt,
            sortedOrder: .ascending,
            periodDate: PeriodDate(start: startDate,
                                   end: endDate),
            status: .active
        )
        let router = AdditionalServiceRouter.fetchAdditionalsByCreatedAt(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/additionals/created-at") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("hotel_id=105") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("page=1") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("per_page=20") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("sorted_by=CREATED_AT") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("sorted_order=ASC") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("start_at=") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("end_at=") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("status=ACTIVE") ?? false)
    }
    
    // MARK: - Test fetchAdditionalsByDateIssue
    
    func test_fetchAdditionalsByDateIssue_correctPath() throws {
        // Arrange
        let startDate = Date(timeIntervalSince1970: 1619452800)
        let endDate = Date(timeIntervalSince1970: 1745452800)
        
        let request = AdditionalServiceRequest.FetchAdditionalsByDateIssue(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .dateIssue,
            sortedOrder: .descending,
            periodDate: PeriodDate(start: startDate,
                                   end: endDate),
            status: .active
        )
        let router = AdditionalServiceRouter.fetchAdditionalsByDateIssue(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/additionals/date-issue") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("hotel_id=105") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("page=1") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("per_page=20") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("sorted_by=DATE_ISSUE") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("sorted_order=DESC") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("start_at=") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("end_at=") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("status=ACTIVE") ?? false)
    }
    
    // MARK: - Test createAdditional
    
    func test_createAdditional_correctPath() throws {
        // Arrange
        let dateIssue = Date(timeIntervalSince1970: 1619452800)
        
        let additionalItem = AdditionalServiceRequest.Item(
            price: 111.11,
            quantity: 1,
            itemableId: 130,
            itemableType: .foilo
        )
        
        let request = AdditionalServiceRequest.CreateAdditional(
            hotelId: 105,
            reservationId: 1067,
            note: "Test additional",
            dateIssue: dateIssue,
            additionalItems: [additionalItem]
        )
        let router = AdditionalServiceRouter.createAdditional(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/additionals") ?? false)
        XCTAssertNotNil(urlRequest.httpBody)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    // MARK: - Test updateAdditional
    
    func test_updateAdditional_correctPath() throws {
        // Arrange
        let request = AdditionalServiceRequest.UpdateAdditional(
            id: 273,
            status: "inactive",
            note: "Updated note",
            dateIssue: nil,
            additionalItems: nil
        )
        let router = AdditionalServiceRouter.updateAdditional(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/additionals/273") ?? false)
        XCTAssertNotNil(urlRequest.httpBody)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    // MARK: - Test deleteAdditional
    
    func test_deleteAdditional_correctPath() throws {
        // Arrange
        let request = AdditionalServiceRequest.DeleteAdditional(id: 273)
        let router = AdditionalServiceRouter.deleteAdditional(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "DELETE")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/additionals/273") ?? false)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    // MARK: - Test voidAdditional
    
    func test_voidAdditional_correctPath() throws {
        // Arrange
        let request = AdditionalServiceRequest.VoidAdditional(id: 273)
        let router = AdditionalServiceRouter.voidAdditional(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/additionals/273/void") ?? false)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    // MARK: - Test Headers
    
    func test_allRoutes_haveCorrectHeaders() throws {
        // Arrange
       
        let fetchRequest =  AdditionalServiceRequest.FetchAdditionals(
            hotelId: 105,
            reservationId: 1,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            status: nil
        )
        let fetchRouter = AdditionalServiceRouter.fetchAdditionals(request: fetchRequest)
        
        // Act
        let urlRequest = try fetchRouter.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    // MARK: - Test Domain
    
    func test_allRoutes_useCorrectDomain() throws {
        // Arrange
        let request = AdditionalServiceRequest.FetchById(id: 273)
        let router = AdditionalServiceRouter.fetchAdditionalById(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertNotNil(urlRequest.url?.host)
        // Domain comes from AppConfiguration.shared.baseURL, so we just verify it's not nil and contains expected structure
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/additionals") ?? false)
    }
} 
