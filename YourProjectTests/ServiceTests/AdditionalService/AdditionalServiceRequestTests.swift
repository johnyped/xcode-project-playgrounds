//
//  AdditionalServiceRequestTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest

class AdditionalServiceRequestTests: XCTestCase {
    
    // MARK: - FetchAdditionals Tests
    
    func test_fetchAdditionals_withAllParameters_correctSerialization() throws {
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
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
        XCTAssertEqual(parameters?["reservation_id"] as? Int, 1067)
        XCTAssertEqual(parameters?["status"] as? String, "ACTIVE")
    }
    
    func test_fetchAdditionals_withMinimalParameters_correctSerialization() throws {
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
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
        XCTAssertEqual(parameters?["reservation_id"] as? Int, 1)
        XCTAssertNil(parameters?["status"])
    }
    
    func test_fetchAdditionals_withInvalidPage_excludesPageFromParameters() throws {
        // Arrange
        let request = AdditionalServiceRequest.FetchAdditionals(
            hotelId: 105,
            reservationId: 1067,
            page: 0, // Invalid page
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            status: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNil(parameters?["page"]) // Should be nil for invalid page
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
        XCTAssertEqual(parameters?["reservation_id"] as? Int, 1067)
        XCTAssertNil(parameters?["status"])
    }
    
    // MARK: - FetchAdditionalsByCreatedAt Tests
    
    func test_fetchAdditionalsByCreatedAt_withAllParameters_correctSerialization() throws {
        // Arrange
        let startDate = Date(timeIntervalSince1970: 1619452800) // 2021-04-26T20:20:00
        let endDate = Date(timeIntervalSince1970: 1745452800)   // 2025-04-27T20:20:00
        
        let request = AdditionalServiceRequest.FetchAdditionalsByCreatedAt(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .createdAt,
            sortedOrder: .ascending,
            periodDate: PeriodDate(start: startDate, end: endDate),
            status: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "CREATED_AT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
        XCTAssertNotNil(parameters?["start_at"])
        XCTAssertNotNil(parameters?["end_at"])
    }
    
    // MARK: - FetchAdditionalsByDateIssue Tests
    
    func test_fetchAdditionalsByDateIssue_withAllParameters_correctSerialization() throws {
        // Arrange
        let startDate = Date(timeIntervalSince1970: 1619452800) // 2021-04-26T20:20:00
        let endDate = Date(timeIntervalSince1970: 1745452800)   // 2025-04-27T20:20:00
        
       
        let request =  AdditionalServiceRequest.FetchAdditionalsByDateIssue(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .dateIssue,
            sortedOrder: .descending,
            periodDate: PeriodDate(start: startDate, end: endDate),
            status: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "DATE_ISSUE")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
        XCTAssertNotNil(parameters?["start_at"])
        XCTAssertNotNil(parameters?["end_at"])
    }
    
    // MARK: - CreateAdditional Tests
    
    func test_createAdditional_correctSerialization() throws {
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
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        // Decode the body to verify content
        let decodedData = try JSONSerialization.jsonObject(with: body!) as? [String: Any]
        XCTAssertNotNil(decodedData)
        XCTAssertEqual(decodedData?["hotel_id"] as? Int, 105)
        XCTAssertEqual(decodedData?["reservation_id"] as? Int, 1067)
        XCTAssertEqual(decodedData?["note"] as? String, "Test additional")
        XCTAssertNotNil(decodedData?["date_issue"])
        
        let items = decodedData?["additional_items"] as? [[String: Any]]
        XCTAssertNotNil(items)
        XCTAssertEqual(items?.count, 1)
        XCTAssertEqual(items?[0]["price"] as? String, "111.11")
        XCTAssertEqual(items?[0]["quantity"] as? Int, 1)
        XCTAssertEqual(items?[0]["itemable_id"] as? Int, 130)
        XCTAssertEqual(items?[0]["itemable_type"] as? String, "FOLIO")
    }
    
    // MARK: - UpdateAdditional Tests
    
    func test_updateAdditional_withPartialParameters_correctSerialization() throws {
        // Arrange
        let request = AdditionalServiceRequest.UpdateAdditional(
            id: 273,
            status: "inactive",
            note: "Updated note",
            dateIssue: nil,
            additionalItems: nil
        )
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        // Decode the body to verify content
        let decodedData = try JSONSerialization.jsonObject(with: body!) as? [String: Any]
        XCTAssertNotNil(decodedData)
        XCTAssertEqual(decodedData?["status"] as? String, "inactive")
        XCTAssertEqual(decodedData?["note"] as? String, "Updated note")
        XCTAssertNil(decodedData?["date_issue"])
        XCTAssertNil(decodedData?["additional_items"])
    }
    
    func test_updateAdditional_withAllParameters_correctSerialization() throws {
        // Arrange
        let dateIssue = Date(timeIntervalSince1970: 1619452800)
        let additionalItem = AdditionalServiceRequest.Item(
            price: 222.22,
            quantity: 2,
            itemableId: 131,
            itemableType: .foilo
        )
        
        let request = AdditionalServiceRequest.UpdateAdditional(
            id: 273,
            status: "active",
            note: "Updated additional",
            dateIssue: dateIssue,
            additionalItems: [additionalItem]
        )
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        // Decode the body to verify content
        let decodedData = try JSONSerialization.jsonObject(with: body!) as? [String: Any]
        XCTAssertNotNil(decodedData)
        XCTAssertEqual(decodedData?["status"] as? String, "active")
        XCTAssertEqual(decodedData?["note"] as? String, "Updated additional")
        XCTAssertNotNil(decodedData?["date_issue"])
        
        let items = decodedData?["additional_items"] as? [[String: Any]]
        XCTAssertNotNil(items)
        XCTAssertEqual(items?.count, 1)
        XCTAssertEqual(items?[0]["price"] as? String, "222.22")
        XCTAssertEqual(items?[0]["quantity"] as? Int, 2)
        XCTAssertEqual(items?[0]["itemable_id"] as? Int, 131)
        XCTAssertEqual(items?[0]["itemable_type"] as? String, "FOLIO")
    }
    
    // MARK: - Item Tests
    
    func test_item_correctSerialization() throws {
        // Arrange
        let item = AdditionalServiceRequest.Item(
            price: 15.0,
            quantity: 2,
            itemableId: 134,
            itemableType: .foilo
        )
        
        // Act
        let encoder = JSONEncoder()
        let data = try encoder.encode(item)
        let decodedData = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(decodedData)
        XCTAssertEqual(decodedData?["price"] as? String, "15.0")
        XCTAssertEqual(decodedData?["quantity"] as? Int, 2)
        XCTAssertEqual(decodedData?["itemable_id"] as? Int, 134)
        XCTAssertEqual(decodedData?["itemable_type"] as? String, "FOLIO")
        XCTAssertEqual(decodedData?["total_amount"] as? String, "30.0") // 15.0 * 2
    }
} 
