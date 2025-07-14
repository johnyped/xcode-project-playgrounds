//
//  ReservationItemServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 13/6/2568 BE.
//

import XCTest


final class ReservationItemServiceRequestTests: XCTestCase {
    
    func testFetchByReservationRequest_WillEncodeCorrectly() throws {
        // Given
        let request = ReservationItemServiceRequest.FetchByReservation(
            hotelId: 1,
            reservationId: 1092,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 1)
        XCTAssertEqual(parameters?["reservation_id"] as? Int, 1092)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func testUpdateReservationItemRequest_WillEncodeCorrectly() throws {
        // Given
        let sampleData = ReservationItem.Data(
            isCustomRate: false,
            selectedRate: 2500.0,
            extraAdultRate: 300.0,
            extraAdultQty: 1,
            extraChildRate: 150.0,
            extraChildQty: 0,
            mealIncluded: true,
            adultMealLimit: 2,
            adultMealRate: 250.0,
            childMealLimit: 1,
            childMealRate: 125.0,
            extraAdultMealRate: 250.0,
            extraAdultMealQty: 0,
            extraChildMealRate: 125.0,
            extraChildMealQty: 0
        )
        
        let request = ReservationItemServiceRequest.UpdateReservationItem(
            id: 123,
            reservationId: 1092,
            reservationType: .room,
            totalPrice: 4200.0,
            priceCardId: 2,
            data: sampleData
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        // Verify the encoded JSON contains expected fields
        if let body = body,
           let json = try? JSONSerialization.jsonObject(with: body) as? [String: Any] {
            XCTAssertEqual(json["reservation_id"] as? Int, 1092)
            XCTAssertEqual(json["reservation_type"] as? String, "ROOM")
            XCTAssertEqual(json["total_price"] as? String, "4200.0")
            XCTAssertEqual(json["price_card_id"] as? Int, 2)
            XCTAssertNotNil(json["data"])
        } else {
            XCTFail("Failed to encode request body")
        }
    }
    
    func testReplaceReservationItemsRequest_WillEncodeCorrectly() throws {
        // Given
        let sampleData = ReservationItem.Data(
            isCustomRate: false,
            selectedRate: 2500.0,
            extraAdultRate: 300.0,
            extraAdultQty: 1,
            extraChildRate: 150.0,
            extraChildQty: 0,
            mealIncluded: true,
            adultMealLimit: 2,
            adultMealRate: 250.0,
            childMealLimit: 1,
            childMealRate: 125.0,
            extraAdultMealRate: 250.0,
            extraAdultMealQty: 0,
            extraChildMealRate: 125.0,
            extraChildMealQty: 0
        )
        
        // Use specific dates for consistent testing        
        let itemData = ReservationItemServiceRequest.ReservationItemData(
            reservedDate: Date(timeIntervalSince1970: 1713158400) , // 2024-04-15
            reservableType: .room,
            reservableId: 101,
            totalPrice: 2800.0,
            priceCardId: 2,
            data: sampleData
        )
        
        let period = PeriodDate(
            start: Date(timeIntervalSince1970: 1713158400), // 2024-04-15
            end: Date(timeIntervalSince1970: 1713331200) // 2024-04-17
        )
        
        let request = ReservationItemServiceRequest.ReplaceReservationItems(
            reservationId: 1092,
            period: period,
            items: [itemData]
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        // Verify the encoded JSON contains expected fields
        if let body = body,
           let json = try? JSONSerialization.jsonObject(with: body) as? [String: Any] {
                         XCTAssertEqual(json["reservation_id"] as? Int, 1092)
             XCTAssertEqual(json["check_in_date"] as? String, "2024-04-15")
             XCTAssertEqual(json["check_out_date"] as? String, "2024-04-17")
             XCTAssertNotNil(json["items"])
            
                         if let items = json["items"] as? [[String: Any]], let firstItem = items.first {
                 XCTAssertEqual(firstItem["reserved_date"] as? String, "2024-04-15")
                 XCTAssertEqual(firstItem["reservable_type"] as? String, "ROOM")
                 XCTAssertEqual(firstItem["reservable_id"] as? Int, 101)
                 XCTAssertEqual(firstItem["total_price"] as? String, "2800.0")
                 XCTAssertEqual(firstItem["price_card_id"] as? Int, 2)
                 XCTAssertNotNil(firstItem["data"])
             } else {
                 XCTFail("Failed to find items in encoded JSON")
             }
        } else {
            XCTFail("Failed to encode request body")
        }
    }
    
    func testReservationItemData_WillEncodeCorrectly() throws {
        // Given
        let sampleData = ReservationItem.Data(
            isCustomRate: false,
            selectedRate: 2500.0,
            extraAdultRate: 300.0,
            extraAdultQty: 1,
            extraChildRate: 150.0,
            extraChildQty: 0,
            mealIncluded: true,
            adultMealLimit: 2,
            adultMealRate: 250.0,
            childMealLimit: 1,
            childMealRate: 125.0,
            extraAdultMealRate: 250.0,
            extraAdultMealQty: 0,
            extraChildMealRate: 125.0,
            extraChildMealQty: 0
        )
        
        // Use specific date for consistent testing        
        let itemData = ReservationItemServiceRequest.ReservationItemData(
            reservedDate: Date(timeIntervalSince1970: 1713158400), // 2024-04-15
            reservableType: .room,
            reservableId: 101,
            totalPrice: 2800.0,
            priceCardId: 2,
            data: sampleData
        )
        
        // When
        let encodedData = try JSONEncoder().encode(itemData)
        let json = try JSONSerialization.jsonObject(with: encodedData) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["reserved_date"] as? String, "2024-04-15")
        XCTAssertEqual(json?["reservable_type"] as? String, "ROOM")
        XCTAssertEqual(json?["reservable_id"] as? Int, 101)
        XCTAssertEqual(json?["total_price"] as? String, "2800.0")
        XCTAssertEqual(json?["price_card_id"] as? Int, 2)
        XCTAssertNotNil(json?["data"])
    }
} 
