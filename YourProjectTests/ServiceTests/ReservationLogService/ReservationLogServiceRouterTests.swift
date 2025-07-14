//  ReservationLogServiceRouterTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 23/5/2568 BE.
//
import XCTest
import Alamofire

final class ReservationLogServiceRouterTests: XCTestCase {
    
    // MARK: - Domain Tests
    
    func test_domain_returnsCorrectBaseURL() throws {
        // Arrange
        let request = ReservationLogServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 1092            
        )
        let router = ReservationLogServiceRouter.fetchByReservation(request: request)
        
        // Act
        let domain = router.domain
        
        // Assert
        XCTAssertEqual(domain, AppConfiguration.shared.baseURL)
    }
    
    // MARK: - Path Tests
    
    func test_fetchByReservation_path() throws {
        // Arrange
        let request = ReservationLogServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 1092            
        )
        let router = ReservationLogServiceRouter.fetchByReservation(request: request)
        
        // Act
        let path = router.path
        
        // Assert
        XCTAssertEqual(path, "/v4/reservation-logs")
    }
    
    // MARK: - Method Tests
    
    func test_fetchByReservation_method() throws {
        // Arrange
        let request = ReservationLogServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 1092            
        )
        let router = ReservationLogServiceRouter.fetchByReservation(request: request)
        
        // Act
        let method = router.method
        
        // Assert
        XCTAssertEqual(method, .get)
    }
    
    // MARK: - Headers Tests
    
    func test_headers() throws {
        // Arrange
        let request = ReservationLogServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 1092            
        )
        let router = ReservationLogServiceRouter.fetchByReservation(request: request)
        
        // Act
        let headers = router.headers
        
        // Assert
        XCTAssertNotNil(headers)
        XCTAssertEqual(headers?["Content-Type"], "application/json")
    }
    
    // MARK: - Parameters Tests
    
    func test_fetchByReservation_parameters() throws {
        // Arrange
        let request = ReservationLogServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 1092                   
        )
        let router = ReservationLogServiceRouter.fetchByReservation(request: request)
        
        // Act
        let parameters = router.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["reservation_id"] as? Int, 1092)        
    }    
    
    // MARK: - Body Tests
    
    func test_body_isNil() throws {
        // Arrange
        let request = ReservationLogServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 1092            
        )
        let router = ReservationLogServiceRouter.fetchByReservation(request: request)
        
        // Act
        let body = router.body
        
        // Assert
        XCTAssertNil(body)
    }
    
    // MARK: - URLRequest Tests
    
    func test_asURLRequest_fetchByReservation() throws {
        // Arrange
        let request = ReservationLogServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 1092            
        )
        let router = ReservationLogServiceRouter.fetchByReservation(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertNotNil(urlRequest.url)
        XCTAssertTrue(urlRequest.url!.absoluteString.contains("/v4/reservation-logs"))
        XCTAssertTrue(urlRequest.url!.absoluteString.contains("hotel_id=105"))
        XCTAssertTrue(urlRequest.url!.absoluteString.contains("reservation_id=1092"))
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    // MARK: - Helper Methods
    
    private func createPeriodDate() -> PeriodDate {
        let startDate = createDate(year: 2024, month: 6, day: 1)
        let endDate = createDate(year: 2024, month: 6, day: 30)
        return PeriodDate(start: startDate, end: endDate)
    }
    
    private func createDate(year: Int, month: Int, day: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.timeZone = TimeZone(secondsFromGMT: 0)
        return Calendar.current.date(from: components) ?? Date()
    }
} 