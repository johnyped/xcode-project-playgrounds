//
//  GuestRegisterCardServiceRequestTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest

class GuestRegisterCardServiceRequestTests: XCTestCase {
    
    // MARK: - FetchGuestRegisterCards Tests
    
    func test_fetchGuestRegisterCards_withAllParameters_correctSerialization() throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.FetchGuestRegisterCards(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func test_fetchGuestRegisterCards_withMinimalParameters_correctSerialization() throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.FetchGuestRegisterCards(
            hotelId: 105,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
    }
    
    // MARK: - FetchByGuest Tests
    
    func test_fetchByGuest_withAllParameters_correctSerialization() throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.FetchByGuest(
            hotelId: 105,
            customerId: 267,
            page: 1,
            perPage: .fifty,
            sortedBy: .createdAt,
            sortedOrder: .descending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["customer_id"] as? Int, 267)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "50")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "CREATED_AT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    func test_fetchByGuest_withMinimalParameters_correctSerialization() throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.FetchByGuest(
            hotelId: 105,
            customerId: 267,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["customer_id"] as? Int, 267)
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
    }
    
    // MARK: - FetchByReservation Tests
    
    func test_fetchByReservation_withAllParameters_correctSerialization() throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 987,
            page: 1,
            perPage: .ten,
            sortedBy: .updatedAt,
            sortedOrder: .ascending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["reservation_id"] as? Int, 987)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "10")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "UPDATED_AT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    // MARK: - FetchByPeriod Tests
    
    func test_fetchByPeriod_withAllParameters_correctSerialization() throws {
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
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNotNil(parameters?["start_date"])
        XCTAssertNotNil(parameters?["end_date"])
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "100")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    // MARK: - UpdateRequest Tests
    
    func test_updateRequest_withAllFields_correctSerialization() throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.UpdateRequest(
            id: 17,
            purposeOfVisit: .leisure,
            fromAddress: "123 Main St",
            fromCountry: "THA",
            nextAddress: "456 Oak Ave",
            nextCountry: "THA",
            remark: "Test remark"
        )
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let json = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["purpose_of_visit"] as? String, "LEISURE")
        XCTAssertEqual(json?["from_address"] as? String, "123 Main St")
        XCTAssertEqual(json?["from_country"] as? String, "THA")
        XCTAssertEqual(json?["next_address"] as? String, "456 Oak Ave")
        XCTAssertEqual(json?["next_country"] as? String, "THA")
        XCTAssertEqual(json?["remark"] as? String, "Test remark")
    }
    
    func test_updateRequest_withMinimalFields_correctSerialization() throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.UpdateRequest(
            id: 17,
            purposeOfVisit: nil,
            fromAddress: nil,
            fromCountry: nil,
            nextAddress: nil,
            nextCountry: nil,
            remark: nil
        )
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let json = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertNil(json?["purpose_of_visit"])
        XCTAssertNil(json?["from_address"])
        XCTAssertNil(json?["from_country"])
        XCTAssertNil(json?["next_address"])
        XCTAssertNil(json?["next_country"])
        XCTAssertNil(json?["remark"])
    }
} 
