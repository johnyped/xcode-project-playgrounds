//
//  ReservableDateRangeServiceRouterTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 5/7/2568 BE.
//

import XCTest


final class ReservableDateRangeServiceRouterTests: XCTestCase {
    
    func test_fetchReservableDateRanges_WillReturnCorrectPath() throws {
        // Arrange
        let request = ReservableDateRangeServiceRequest.FetchReservableDateRanges(
            hotelId: 123,
            period: .init(start: Date(), 
                          end: Date()),
            roomIds: nil
        )
        
        // Act
        let router = ReservableDateRangeServiceRouter.fetchReservableDateRanges(request: request)
        
        // Assert
        XCTAssertEqual(router.path, "/v4/reservable-date-ranges")
    }
    
    func test_fetchReservableDateRanges_WillReturnGETMethod() throws {
        // Arrange
        let request = ReservableDateRangeServiceRequest.FetchReservableDateRanges(
            hotelId: 123,
            period: .init(start: Date(), 
                          end: Date()),
            roomIds: nil
        )
        
        // Act
        let router = ReservableDateRangeServiceRouter.fetchReservableDateRanges(request: request)
        
        // Assert
        XCTAssertEqual(router.method, .get)
    }
    
    func test_fetchReservableDateRanges_WillReturnCorrectHeaders() throws {
        // Arrange
        let request = ReservableDateRangeServiceRequest.FetchReservableDateRanges(
            hotelId: 123,
            period: .init(start: Date(), 
                          end: Date()),
            roomIds: nil
        )
        
        // Act
        let router = ReservableDateRangeServiceRouter.fetchReservableDateRanges(request: request)
        
        // Assert
        XCTAssertEqual(router.headers?["Content-Type"], "application/json")
    }
    
    func test_fetchReservableDateRanges_WillReturnCorrectParameters() throws {
        // Arrange
        let hotelId = 456
        let checkInDate = Date(timeIntervalSince1970: 1719446400) // 2024-06-27
        let checkOutDate = Date(timeIntervalSince1970: 1719705600) // 2024-06-30
        let roomIds = [101, 102]
        
        let request = ReservableDateRangeServiceRequest.FetchReservableDateRanges(
            hotelId: hotelId,
            period: .init(start: checkInDate,
                          end: checkOutDate),            
            roomIds: roomIds
        )
        
        // Act
        let router = ReservableDateRangeServiceRouter.fetchReservableDateRanges(request: request)
        
        // Assert
        XCTAssertNotNil(router.parameters)
        XCTAssertEqual(router.parameters?["hotel_id"] as? Int, hotelId)
        XCTAssertEqual(router.parameters?["check_in_date"] as? String, "2024-06-27")
        XCTAssertEqual(router.parameters?["check_out_date"] as? String, "2024-06-30")
        XCTAssertEqual(router.parameters?["room_ids"] as? String, "101,102")
    }
    
    func test_fetchReservableDateRanges_WillReturnNilBody() throws {
        // Arrange
        let request = ReservableDateRangeServiceRequest.FetchReservableDateRanges(
            hotelId: 123,
            period: .init(start: Date(), 
                          end: Date()),
            roomIds: nil
        )
        
        // Act
        let router = ReservableDateRangeServiceRouter.fetchReservableDateRanges(request: request)
        
        // Assert
        XCTAssertNil(router.body)
    }
    
    func test_fetchReservableDateRanges_WillReturnCorrectDomain() throws {
        // Arrange
        let request = ReservableDateRangeServiceRequest.FetchReservableDateRanges(
            hotelId: 123,
            period: .init(start: Date(), 
                          end: Date()),
            roomIds: nil
        )
        
        // Act
        let router = ReservableDateRangeServiceRouter.fetchReservableDateRanges(request: request)
        
        // Assert
        XCTAssertEqual(router.domain, AppConfiguration.shared.baseURL)
    }
    
    func test_fetchReservableDateRanges_URLRequest_WillBeCreatedCorrectly() throws {
        // Arrange
        let hotelId = 789
        let checkInDate = Date(timeIntervalSince1970: 1719446400) // 2024-06-27
        let checkOutDate = Date(timeIntervalSince1970: 1719705600) // 2024-06-30
        let roomIds = [200, 201, 202]
        
        let request = ReservableDateRangeServiceRequest.FetchReservableDateRanges(
            hotelId: hotelId,
            period: .init(start: checkInDate,
                          end: checkOutDate),            
            roomIds: roomIds
        )
        
        // Act
        let router = ReservableDateRangeServiceRouter.fetchReservableDateRanges(request: request)
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertNil(urlRequest.httpBody)
        
        // Check URL contains correct parameters
        let urlString = urlRequest.url?.absoluteString
        XCTAssertNotNil(urlString)
        XCTAssertTrue(urlString?.contains("hotel_id=789") ?? false)
        XCTAssertTrue(urlString?.contains("check_in_date=2024-06-27") ?? false)
        XCTAssertTrue(urlString?.contains("check_out_date=2024-06-30") ?? false)
        XCTAssertTrue(urlString?.contains("room_ids=200%2C201%2C202") ?? false)
    }
    
    func test_fetchReservableDateRanges_URLRequest_WithoutRoomIds_WillBeCreatedCorrectly() throws {
        // Arrange
        let hotelId = 999
        let checkInDate = Date(timeIntervalSince1970: 1719446400) // 2024-06-27
        let checkOutDate = Date(timeIntervalSince1970: 1719705600) // 2024-06-30
        
        let request = ReservableDateRangeServiceRequest.FetchReservableDateRanges(
            hotelId: hotelId,
            period: .init(start: checkInDate,
                          end: checkOutDate),            
            roomIds: nil
        )
        
        // Act
        let router = ReservableDateRangeServiceRouter.fetchReservableDateRanges(request: request)
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertNil(urlRequest.httpBody)
        
        // Check URL contains correct parameters
        let urlString = urlRequest.url?.absoluteString
        XCTAssertNotNil(urlString)
        XCTAssertTrue(urlString?.contains("hotel_id=999") ?? false)
        XCTAssertTrue(urlString?.contains("check_in_date=2024-06-27") ?? false)
        XCTAssertTrue(urlString?.contains("check_out_date=2024-06-30") ?? false)
        XCTAssertFalse(urlString?.contains("room_ids") ?? true)
    }
    
    func test_fetchReservableDateRanges_URLRequest_WithPeriodDate_WillBeCreatedCorrectly() throws {
        // Arrange
        let hotelId = 555
        let startDate = Date(timeIntervalSince1970: 1719446400) // 2024-06-27
        let endDate = Date(timeIntervalSince1970: 1719705600) // 2024-06-30
        let period = PeriodDate(start: startDate, end: endDate)
        let roomIds = [300]
        
        let request = ReservableDateRangeServiceRequest.FetchReservableDateRanges(
            hotelId: hotelId,
            period: period,
            roomIds: roomIds
        )
        
        // Act
        let router = ReservableDateRangeServiceRouter.fetchReservableDateRanges(request: request)
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertNil(urlRequest.httpBody)
        
        // Check URL contains correct parameters
        let urlString = urlRequest.url?.absoluteString
        XCTAssertNotNil(urlString)
        XCTAssertTrue(urlString?.contains("hotel_id=555") ?? false)
        XCTAssertTrue(urlString?.contains("check_in_date=2024-06-27") ?? false)
        XCTAssertTrue(urlString?.contains("check_out_date=2024-06-30") ?? false)
        XCTAssertTrue(urlString?.contains("room_ids=300") ?? false)
    }
} 
