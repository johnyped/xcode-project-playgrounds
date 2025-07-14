//
//  PriceCardServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest

final class PriceCardServiceRequestTests: XCTestCase {
    
    func testFetchPriceCardsRequestWithAllParameters() {
        // Given
        let request = PriceCardServiceRequest.FetchPriceCards(
            page: 1,
            perPage: 20,
            sortedBy: "id",
            sortedOrder: "ASC",
            hotelId: 105,
            roomTypeId: 101
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? Int, 20)
        XCTAssertEqual(parameters?["sorted_by"] as? String, "id")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["room_type_id"] as? Int, 101)
        XCTAssertEqual(parameters?.count, 6)
    }
    
    func testFetchPriceCardsRequestWithNilParameters() {
        // Given
        let request = PriceCardServiceRequest.FetchPriceCards(
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            hotelId: nil,
            roomTypeId: nil
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNil(parameters)
    }
    
    func testFetchPriceCardsRequestWithPartialParameters() {
        // Given
        let request = PriceCardServiceRequest.FetchPriceCards(
            page: 2,
            perPage: nil,
            sortedBy: "title",
            sortedOrder: nil,
            hotelId: 200,
            roomTypeId: nil
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["page"] as? Int, 2)
        XCTAssertEqual(parameters?["sorted_by"] as? String, "title")
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 200)
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_order"])
        XCTAssertNil(parameters?["room_type_id"])
        XCTAssertEqual(parameters?.count, 3)
    }
    
    func testFetchPriceCardByIdRequest() {
        // Given
        let request = PriceCardServiceRequest.FetchPriceCard(id: 42)
        
        // Then
        XCTAssertEqual(request.id, 42)
    }
    
    func testFetchPriceCardsByPeriodRequestWithAllParameters() {
        // Given
        let startDate = Date()
        let endDate = Date().addingTimeInterval(86400 * 7)
        let request = PriceCardServiceRequest.FetchPriceCardsByPeriod(
            hotelId: 105,
            startDate: startDate,
            endDate: endDate,
            channelId: 1,
            subChannelId: 2,
            reservableTypeType: "RoomType",
            reservableTypeId: 301
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNotNil(parameters?["start_date"])
        XCTAssertNotNil(parameters?["end_date"])
        XCTAssertEqual(parameters?["channel_id"] as? Int, 1)
        XCTAssertEqual(parameters?["sub_channel_id"] as? Int, 2)
        XCTAssertEqual(parameters?["reservable_type_type"] as? String, "RoomType")
        XCTAssertEqual(parameters?["reservable_type_id"] as? Int, 301)
        XCTAssertEqual(parameters?.count, 7)
    }
    
    func testFetchPriceCardsByPeriodRequestWithMinimalParameters() {
        // Given
        let startDate = Date()
        let endDate = Date().addingTimeInterval(86400 * 7)
        let request = PriceCardServiceRequest.FetchPriceCardsByPeriod(
            hotelId: 105,
            startDate: startDate,
            endDate: endDate,
            channelId: nil,
            subChannelId: nil,
            reservableTypeType: nil,
            reservableTypeId: nil
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNotNil(parameters?["start_date"])
        XCTAssertNotNil(parameters?["end_date"])
        XCTAssertNil(parameters?["channel_id"])
        XCTAssertNil(parameters?["sub_channel_id"])
        XCTAssertNil(parameters?["reservable_type_type"])
        XCTAssertNil(parameters?["reservable_type_id"])
        XCTAssertEqual(parameters?.count, 3)
    }
    
    func testCreatePriceCardRequestWithAllFieldsEncoding() throws {
        // Given - Testing all possible fields populated
        let request = PriceCardServiceRequest.CreatePriceCard(
            hotelId: 105,
            title: "Premium Test Rate",
            reservableTypeId: 101,
            reservableTypeType: "RoomType",
            price: 2500.0,
            description: "Complete test description with all fields",
            code: "PREM001",
            color: "#FF5733",
            periodTypes: ["Monday", "Tuesday", "Wednesday", "Friday"],
            exceptionDates: ["2024-12-25", "2024-01-01", "2024-07-04"],
            bfIncluded: true,
            bfAdultPrice: 250.0,
            bfAdultLimit: 3,
            bfAdultExtraRate: 200.0,
            bfAdultExtraLimit: 5,
            bfChildPrice: 125.0,
            bfChildLimit: 3,
            bfChildExtraRate: 100.0,
            bfChildExtraLimit: 5,
            startAt: Date(timeIntervalSince1970: 1672531200), // 2023-01-01 00:00:00 UTC
            endAt: Date(timeIntervalSince1970: 1704067200), // 2024-01-01 00:00:00 UTC
            channels: ["online", "phone", "walk-in"],
            pinned: true
        )
        
        // When
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        
        // Then - Verify all fields are properly encoded
        if let dictionary = json as? [String: Any] {
            // Basic fields
            XCTAssertEqual(dictionary["hotel_id"] as? Int, 105)
            XCTAssertEqual(dictionary["title"] as? String, "Premium Test Rate")
            XCTAssertEqual(dictionary["reservable_type_id"] as? Int, 101)
            XCTAssertEqual(dictionary["reservable_type_type"] as? String, "RoomType")
            XCTAssertEqual(dictionary["price"] as? String, "2500.0")
            XCTAssertEqual(dictionary["description"] as? String, "Complete test description with all fields")
            XCTAssertEqual(dictionary["code"] as? String, "PREM001")
            XCTAssertEqual(dictionary["color"] as? String, "#FF5733")
            
            // Period types validation
            if let periodTypes = dictionary["period_types"] as? [String] {
                XCTAssertEqual(periodTypes.count, 4)
                XCTAssertTrue(periodTypes.contains("Monday"))
                XCTAssertTrue(periodTypes.contains("Tuesday"))
                XCTAssertTrue(periodTypes.contains("Wednesday"))
                XCTAssertTrue(periodTypes.contains("Friday"))
            } else {
                XCTFail("Period types should be an array of strings")
            }
            
            // Exception dates validation
            if let exceptionDates = dictionary["exception_dates"] as? [String] {
                XCTAssertEqual(exceptionDates.count, 3)
                XCTAssertTrue(exceptionDates.contains("2024-12-25"))
                XCTAssertTrue(exceptionDates.contains("2024-01-01"))
                XCTAssertTrue(exceptionDates.contains("2024-07-04"))
            } else {
                XCTFail("Exception dates should be an array of strings")
            }
            
            // Breakfast fields validation
            XCTAssertEqual(dictionary["bf_included"] as? Bool, true)
            XCTAssertEqual(dictionary["bf_adult_price"] as? String, "250.0")
            XCTAssertEqual(dictionary["bf_adult_limit"] as? Int, 3)
            XCTAssertEqual(dictionary["bf_adult_extra_rate"] as? String, "200.0")
            XCTAssertEqual(dictionary["bf_adult_extra_limit"] as? Int, 5)
            XCTAssertEqual(dictionary["bf_child_price"] as? String, "125.0")
            XCTAssertEqual(dictionary["bf_child_limit"] as? Int, 3)
            XCTAssertEqual(dictionary["bf_child_extra_rate"] as? String, "100.0")
            XCTAssertEqual(dictionary["bf_child_extra_limit"] as? Int, 5)
            
            // Date fields validation
            XCTAssertEqual(dictionary["start_at"] as? String, "01 Jan 2023")
            XCTAssertEqual(dictionary["end_at"] as? String, "01 Jan 2024")
            
            // Other fields validation
            XCTAssertEqual(dictionary["pinned"] as? Bool, true)
            
            // Channels validation
            if let channels = dictionary["channels"] as? [String] {
                XCTAssertEqual(channels.count, 3)
                XCTAssertTrue(channels.contains("online"))
                XCTAssertTrue(channels.contains("phone"))
                XCTAssertTrue(channels.contains("walk-in"))
            } else {
                XCTFail("Channels should be an array of strings")
            }
        } else {
            XCTFail("Encoded data should be a dictionary")
        }
    }
    
    func testCreatePriceCardRequestWithNilOptionalFields() throws {
        // Given
        let request = PriceCardServiceRequest.CreatePriceCard(
            hotelId: 105,
            title: "Minimal Rate",
            reservableTypeId: 101,
            reservableTypeType: "RoomType",
            price: 1000.0,
            description: nil,
            code: nil,
            color: nil,
            periodTypes: nil,
            exceptionDates: nil,
            bfIncluded: nil,
            bfAdultPrice: nil,
            bfAdultLimit: nil,
            bfAdultExtraRate: nil,
            bfAdultExtraLimit: nil,
            bfChildPrice: nil,
            bfChildLimit: nil,
            bfChildExtraRate: nil,
            bfChildExtraLimit: nil,
            startAt: Date(timeIntervalSince1970: 1672531200), // 2023-01-01 00:00:00 UTC
            endAt: Date(timeIntervalSince1970: 1704067200), // 2024-01-01 00:00:00 UTC
            channels: nil,
            pinned: nil
        )
        
        // When
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        
        // Then
        if let dictionary = json as? [String: Any] {
            XCTAssertEqual(dictionary["hotel_id"] as? Int, 105)
            XCTAssertEqual(dictionary["title"] as? String, "Minimal Rate")
            XCTAssertEqual(dictionary["reservable_type_id"] as? Int, 101)
            XCTAssertEqual(dictionary["reservable_type_type"] as? String, "RoomType")
            XCTAssertEqual(dictionary["price"] as? String, "1000.0")
            XCTAssertEqual(dictionary["start_at"] as? String, "01 Jan 2023")
            XCTAssertEqual(dictionary["end_at"] as? String, "01 Jan 2024")
            
            // Optional fields should be nil or not present
            XCTAssertTrue(dictionary["description"] == nil || dictionary["description"] is NSNull)
            XCTAssertTrue(dictionary["code"] == nil || dictionary["code"] is NSNull)
            XCTAssertTrue(dictionary["color"] == nil || dictionary["color"] is NSNull)
            XCTAssertTrue(dictionary["period_types"] == nil || dictionary["period_types"] is NSNull)
            XCTAssertTrue(dictionary["exception_dates"] == nil || dictionary["exception_dates"] is NSNull)
            XCTAssertTrue(dictionary["channels"] == nil || dictionary["channels"] is NSNull)
            XCTAssertTrue(dictionary["pinned"] == nil || dictionary["pinned"] is NSNull)
        } else {
            XCTFail("Encoded data should be a dictionary")
        }
    }
    
    func testUpdatePriceCardRequestWithAllFieldsEncoding() throws {
        // Given - Testing all possible fields populated
        let request = PriceCardServiceRequest.UpdatePriceCard(
            id: 42,
            title: "Completely Updated Premium Rate",
            description: "Fully updated description with all fields modified",
            reservableTypeId: 301,
            reservableTypeType: "PackageType",
            price: 3500.0,
            code: "UPD999",
            color: "#FFD700",
            periodTypes: ["Saturday", "Sunday", "Holiday"],
            exceptionDates: ["2024-04-15", "2024-09-01", "2024-11-28"],
            bfIncluded: false,
            bfAdultPrice: 180.0,
            bfAdultLimit: 4,
            bfAdultExtraRate: 150.0,
            bfAdultExtraLimit: 6,
            bfChildPrice: 90.0,
            bfChildLimit: 4,
            bfChildExtraRate: 75.0,
            bfChildExtraLimit: 6,
            startAt: Date(timeIntervalSince1970: 1672531200), // 2023-01-01 00:00:00 UTC
            endAt: Date(timeIntervalSince1970: 1704067200), // 2024-01-01 00:00:00 UTC
            channels: ["online", "phone", "agent"],
            pinned: false
        )
        
        // When
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        
        // Then - Verify all fields are properly encoded
        if let dictionary = json as? [String: Any] {
            // Basic fields
            XCTAssertEqual(dictionary["title"] as? String, "Completely Updated Premium Rate")
            XCTAssertEqual(dictionary["description"] as? String, "Fully updated description with all fields modified")
            XCTAssertEqual(dictionary["reservable_type_id"] as? Int, 301)
            XCTAssertEqual(dictionary["reservable_type_type"] as? String, "PackageType")
            XCTAssertEqual(dictionary["price"] as? String, "3500.0")
            XCTAssertEqual(dictionary["code"] as? String, "UPD999")
            XCTAssertEqual(dictionary["color"] as? String, "#FFD700")
            
            // Period types validation
            if let periodTypes = dictionary["period_types"] as? [String] {
                XCTAssertEqual(periodTypes.count, 3)
                XCTAssertTrue(periodTypes.contains("Saturday"))
                XCTAssertTrue(periodTypes.contains("Sunday"))
                XCTAssertTrue(periodTypes.contains("Holiday"))
            } else {
                XCTFail("Period types should be an array of strings")
            }
            
            // Exception dates validation
            if let exceptionDates = dictionary["exception_dates"] as? [String] {
                XCTAssertEqual(exceptionDates.count, 3)
                XCTAssertTrue(exceptionDates.contains("2024-04-15"))
                XCTAssertTrue(exceptionDates.contains("2024-09-01"))
                XCTAssertTrue(exceptionDates.contains("2024-11-28"))
            } else {
                XCTFail("Exception dates should be an array of strings")
            }
            
            // Breakfast fields validation
            XCTAssertEqual(dictionary["bf_included"] as? Bool, false)
            XCTAssertEqual(dictionary["bf_adult_price"] as? String, "180.0")
            XCTAssertEqual(dictionary["bf_adult_limit"] as? Int, 4)
            XCTAssertEqual(dictionary["bf_adult_extra_rate"] as? String, "150.0")
            XCTAssertEqual(dictionary["bf_adult_extra_limit"] as? Int, 6)
            XCTAssertEqual(dictionary["bf_child_price"] as? String, "90.0")
            XCTAssertEqual(dictionary["bf_child_limit"] as? Int, 4)
            XCTAssertEqual(dictionary["bf_child_extra_rate"] as? String, "75.0")
            XCTAssertEqual(dictionary["bf_child_extra_limit"] as? Int, 6)
            
            // Date fields validation
            XCTAssertEqual(dictionary["start_at"] as? String, "01 Jan 2023")
            XCTAssertEqual(dictionary["end_at"] as? String, "01 Jan 2024")
            
            // Other fields validation
            XCTAssertEqual(dictionary["pinned"] as? Bool, false)
            
            // id should not be in the JSON body for update requests
            XCTAssertNil(dictionary["id"])
            
            // Channels validation
            if let channels = dictionary["channels"] as? [String] {
                XCTAssertEqual(channels.count, 3)
                XCTAssertTrue(channels.contains("online"))
                XCTAssertTrue(channels.contains("phone"))
                XCTAssertTrue(channels.contains("agent"))
            } else {
                XCTFail("Channels should be an array of strings")
            }
        } else {
            XCTFail("Encoded data should be a dictionary")
        }
    }
    
    func testDeletePriceCardRequest() {
        // Given
        let request = PriceCardServiceRequest.DeletePriceCard(id: 99)
        
        // Then
        XCTAssertEqual(request.id, 99)
    }
    
    func testPriceCardRequestCodingKeys() {
        // Given & Then
        XCTAssertEqual(PriceCardServiceRequest.CreatePriceCard.CodingKeys.hotelId.rawValue, "hotel_id")
        XCTAssertEqual(PriceCardServiceRequest.CreatePriceCard.CodingKeys.reservableTypeId.rawValue, "reservable_type_id")
        XCTAssertEqual(PriceCardServiceRequest.CreatePriceCard.CodingKeys.reservableTypeType.rawValue, "reservable_type_type")
        XCTAssertEqual(PriceCardServiceRequest.CreatePriceCard.CodingKeys.periodTypes.rawValue, "period_types")
        XCTAssertEqual(PriceCardServiceRequest.CreatePriceCard.CodingKeys.exceptionDates.rawValue, "exception_dates")
        XCTAssertEqual(PriceCardServiceRequest.CreatePriceCard.CodingKeys.bfIncluded.rawValue, "bf_included")
        XCTAssertEqual(PriceCardServiceRequest.CreatePriceCard.CodingKeys.bfAdultPrice.rawValue, "bf_adult_price")
        XCTAssertEqual(PriceCardServiceRequest.CreatePriceCard.CodingKeys.bfAdultLimit.rawValue, "bf_adult_limit")
        XCTAssertEqual(PriceCardServiceRequest.CreatePriceCard.CodingKeys.bfAdultExtraRate.rawValue, "bf_adult_extra_rate")
        XCTAssertEqual(PriceCardServiceRequest.CreatePriceCard.CodingKeys.bfAdultExtraLimit.rawValue, "bf_adult_extra_limit")
        XCTAssertEqual(PriceCardServiceRequest.CreatePriceCard.CodingKeys.bfChildPrice.rawValue, "bf_child_price")
        XCTAssertEqual(PriceCardServiceRequest.CreatePriceCard.CodingKeys.bfChildLimit.rawValue, "bf_child_limit")
        XCTAssertEqual(PriceCardServiceRequest.CreatePriceCard.CodingKeys.bfChildExtraRate.rawValue, "bf_child_extra_rate")
        XCTAssertEqual(PriceCardServiceRequest.CreatePriceCard.CodingKeys.bfChildExtraLimit.rawValue, "bf_child_extra_limit")
        XCTAssertEqual(PriceCardServiceRequest.CreatePriceCard.CodingKeys.startAt.rawValue, "start_at")
        XCTAssertEqual(PriceCardServiceRequest.CreatePriceCard.CodingKeys.endAt.rawValue, "end_at")
    }
    
    func testParametersEmptyHandling() {
        // Given
        let emptyRequest = PriceCardServiceRequest.FetchPriceCards(
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            hotelId: nil,
            roomTypeId: nil
        )
        
        let nonEmptyRequest = PriceCardServiceRequest.FetchPriceCards(
            page: 1,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            hotelId: nil,
            roomTypeId: nil
        )
        
        // When & Then
        XCTAssertNil(emptyRequest.parameters)
        XCTAssertNotNil(nonEmptyRequest.parameters)
        XCTAssertEqual(nonEmptyRequest.parameters?.count, 1)
        XCTAssertEqual(nonEmptyRequest.parameters?["page"] as? Int, 1)
    }
    
    func testRequestTypeAliases() {
        // Given
        let fetchRequest = PriceCardServiceRequest.FetchPriceCard(id: 123)
        let deleteRequest = PriceCardServiceRequest.DeletePriceCard(id: 456)
        
        // Then
        XCTAssertEqual(fetchRequest.id, 123)
        XCTAssertEqual(deleteRequest.id, 456)
        
        // Test that both use the same ById struct
        XCTAssertTrue(type(of: fetchRequest) == PriceCardServiceRequest.ById.self)
        XCTAssertTrue(type(of: deleteRequest) == PriceCardServiceRequest.ById.self)
    }
} 
