//
//  GuestRegisterCardRouterServiceTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest

class GuestRegisterCardRouterServiceTests: XCTestCase {
    
    // MARK: - Test fetchGuestRegisterCards
    
    func test_fetchGuestRegisterCards_correctPath() throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.FetchGuestRegisterCards(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        let router = GuestRegisterCardServiceRouter.fetchGuestRegisterCards(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/guest-register-cards") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("hotel_id=105") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("page=1") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("per_page=20") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("sorted_by=ID") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("sorted_order=ASC") ?? false)
    }
    
    func test_fetchGuestRegisterCards_withMinimalParameters_correctPath() throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.FetchGuestRegisterCards(
            hotelId: 105,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        let router = GuestRegisterCardServiceRouter.fetchGuestRegisterCards(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/guest-register-cards") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("hotel_id=105") ?? false)
        XCTAssertFalse(urlRequest.url?.absoluteString.contains("page=") ?? true)
        XCTAssertFalse(urlRequest.url?.absoluteString.contains("per_page=") ?? true)
        XCTAssertFalse(urlRequest.url?.absoluteString.contains("sorted_by=") ?? true)
        XCTAssertFalse(urlRequest.url?.absoluteString.contains("sorted_order=") ?? true)
    }
    
    // MARK: - Test fetchByGuest
    
    func test_fetchByGuest_correctPath() throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.FetchByGuest(
            hotelId: 105,
            customerId: 267,
            page: 1,
            perPage: .fifty,
            sortedBy: .createdAt,
            sortedOrder: .descending
        )
        let router = GuestRegisterCardServiceRouter.fetchByGuest(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/guest-register-cards/guest") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("hotel_id=105") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("customer_id=267") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("page=1") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("per_page=50") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("sorted_by=CREATED_AT") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("sorted_order=DESC") ?? false)
    }
    
    // MARK: - Test fetchByReservation
    
    func test_fetchByReservation_correctPath() throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 987,
            page: 1,
            perPage: .ten,
            sortedBy: .updatedAt,
            sortedOrder: .ascending
        )
        let router = GuestRegisterCardServiceRouter.fetchByReservation(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/guest-register-cards/reservation") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("hotel_id=105") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("reservation_id=987") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("page=1") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("per_page=10") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("sorted_by=UPDATED_AT") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("sorted_order=ASC") ?? false)
    }
    
    // MARK: - Test fetchByPeriod
    
    func test_fetchByPeriod_correctPath() throws {
        // Arrange
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate)!
        let period = PeriodDate(start: startDate, end: endDate)
        
        let request = GuestRegisterCardServiceRequest.FetchByPeriod(
            hotelId: 105,
            period: period,
            page: 1,
            perPage: .hundred,
            sortedBy: .id,
            sortedOrder: .descending
        )
        let router = GuestRegisterCardServiceRouter.fetchByPeriod(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/guest-register-cards/period") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("hotel_id=105") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("start_date=") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("end_date=") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("page=1") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("per_page=100") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("sorted_by=ID") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("sorted_order=DESC") ?? false)
    }
    
    // MARK: - Test fetchGuestRegisterCardById
    
    func test_fetchGuestRegisterCardById_correctPath() throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.FetchById(id: 17)
        let router = GuestRegisterCardServiceRouter.fetchGuestRegisterCardById(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/guest-register-cards/17") ?? false)
    }
    
    // MARK: - Test updateGuestRegisterCard
    
    func test_updateGuestRegisterCard_correctPath() throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.UpdateRequest(
            id: 17,
            purposeOfVisit: .business,
            fromAddress: "Test address",
            fromCountry: "THA",
            nextAddress: "Next address",
            nextCountry: "THA",
            remark: "Test remark"
        )
        let router = GuestRegisterCardServiceRouter.updateGuestRegisterCard(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/guest-register-cards/17") ?? false)
        XCTAssertNotNil(urlRequest.httpBody)
        
        let json = try JSONSerialization.jsonObject(with: urlRequest.httpBody!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["purpose_of_visit"] as? String, "BUSINESS")
        XCTAssertEqual(json?["from_address"] as? String, "Test address")
        XCTAssertEqual(json?["from_country"] as? String, "THA")
        XCTAssertEqual(json?["next_address"] as? String, "Next address")
        XCTAssertEqual(json?["next_country"] as? String, "THA")
        XCTAssertEqual(json?["remark"] as? String, "Test remark")
    }
    
    // MARK: - Test deleteGuestRegisterCard
    
    func test_deleteGuestRegisterCard_correctPath() throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.DeleteGuestRegisterCard(id: 17)
        let router = GuestRegisterCardServiceRouter.deleteGuestRegisterCard(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "DELETE")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/guest-register-cards/17") ?? false)
    }
    
    // MARK: - Test acceptPdpa
    
    func test_acceptPdpa_correctPath() throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.AcceptPdpa(id: 17)
        let router = GuestRegisterCardServiceRouter.acceptPdpa(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/guest-register-cards/17/accept-pdpa") ?? false)
    }
    
    // MARK: - Test acceptRules
    
    func test_acceptRules_correctPath() throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.AcceptRules(id: 17)
        let router = GuestRegisterCardServiceRouter.acceptRules(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/guest-register-cards/17/accept-rules") ?? false)
    }
} 
