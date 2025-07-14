//
//  ReservationItemTests.swift
//  YourProject
//
//  Created by IntrodexMini on 16/5/2568 BE.
//

import XCTest


final class ReservationItemTests: XCTestCase {
    // MARK: - Helper Methods
    
    private func sampleData() -> ReservationItem.Data {
        return ReservationItem.Data(
            isCustomRate: true,
            selectedRate: 1000,
            extraAdultRate: 200,
            extraAdultQty: 2,
            extraChildRate: 150,
            extraChildQty: 1,
            mealIncluded: true,
            adultMealLimit: 1,
            adultMealRate: 50,
            childMealLimit: 1,
            childMealRate: 30,
            extraAdultMealRate: 60,
            extraAdultMealQty: 1,
            extraChildMealRate: 40,
            extraChildMealQty: 2
        )
    }

    private func samplePriceCard() -> LocalPriceCard {
        return LocalPriceCard(
            id: 1,
            title: "Test Card",
            description: "Test Desc",
            dailyPrice: 1000,
            totalPrice: 1200,
            periodTypes: .init(),
            exceptionDates: [],
            reservableTypeId: 1,
            reservableType: .roomType,
            code: nil,
            color: nil,
            meal: .init(),
            period: nil,
            availableChannels: [],
            createdAt: Date(timeIntervalSince1970: 1000),
            updatedAt: Date(timeIntervalSince1970: 2000)
        )
    }

    private func sampleReservationItem(includePriceCard: Bool = false) throws -> ReservationItem {
        let reservedDate = try "2024-06-01".tryToDate(FormConfig.DateFormat.yyyyMMdd)
        return ReservationItem(
            id: 123,
            reservedDate: reservedDate,
            totalPrice: 2000,
            reservableType: .room,
            reservableId: 10,
            data: sampleData(),
            priceCardId: includePriceCard ? 1 : nil,
            createdAt: Date(timeIntervalSince1970: 1000),
            updatedAt: Date(timeIntervalSince1970: 2000)
        )
    }

    // MARK: - Initialization Tests
    
    func test_initWithAllProperties() throws {
        let item = try sampleReservationItem(includePriceCard: true)
        let reservedDate = try "2024-06-01".tryToDate(FormConfig.DateFormat.yyyyMMdd)
        XCTAssertEqual(item.id, 123)
        XCTAssertEqual(item.reservedDate, reservedDate)
        XCTAssertEqual(item.totalPrice, 2000)
        XCTAssertEqual(item.reservableType, .room)
        XCTAssertEqual(item.reservableId, 10)
        XCTAssertEqual(item.priceCardId, 1)
        XCTAssertEqual(item.createdAt.timeIntervalSince1970, 1000)
        XCTAssertEqual(item.updatedAt.timeIntervalSince1970, 2000)
    }

    func test_initWithOptionalPriceCardNil() throws {
        let item = try sampleReservationItem(includePriceCard: false)
        XCTAssertNil(item.priceCardId)
    }

    // MARK: - Computed Properties Tests
    
    func test_computedProperties() throws {
        let item = try sampleReservationItem()
        let data = item.data
        XCTAssertEqual(item.selectedRate, data.selectedRate)
        XCTAssertEqual(item.extraAdultTotal, data.extraAdultTotal)
        XCTAssertEqual(item.extraChildTotal, data.extraChildTotal)
        XCTAssertEqual(item.extraAdultMealTotal, data.extraAdultMealTotal)
        XCTAssertEqual(item.extraChildMealTotal, data.extraChildMealTotal)
    }

    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        let json = """
        {
            "id": 4119,
            "reserved_date": "2024-05-23",
            "total_price": "1390.77",
            "reservable_type": "ROOM",
            "data": {
                "child_meal_limit": "2",
                "adult_meal_limit": "3", 
                "extra_person_rate": "999.45",
                "child_meal_rate": "150",
                "extra_child_meal_number": "2",
                "extra_adult_meal_number": "1",
                "extra_bed_rate": "888.32",
                "extra_adult_meal_rate": "200",
                "extra_bed_number": "1",
                "is_custom_rate": true,
                "extra_person_number": "2",
                "extra_child_meal_rate": "100",
                "meal_included": true,
                "adult_meal_rate": "250",
                "price_card_rate": "1390.77"
            },
            "created_at": "2024-06-01T08:19:07.185+07:00",
            "updated_at": "2024-06-01T08:19:07.185+07:00",
            "reservable_id": 623,
            "price_card_id": null
        }
        """.data(using: .utf8)!
        let decoder = JSONDecoder()
        let item = try decoder.decode(ReservationItem.self, from: json)
        let reservedDate = try "2024-05-23".tryToDate(dateFormat: FormConfig.DateFormat.yyyyMMdd)
        
        XCTAssertEqual(item.id, 4119)
        XCTAssertEqual(item.reservedDate, reservedDate)
        XCTAssertEqual(item.totalPrice, 1390.77, accuracy: 0.001)
        XCTAssertEqual(item.reservableType, .room)
        XCTAssertEqual(item.reservableId, 623)
        XCTAssertNil(item.priceCardId)

        XCTAssertEqual(item.data.selectedRate, 1390.77, accuracy: 0.001)
        XCTAssertEqual(item.data.extraAdultRate, 888.32, accuracy: 0.001)
        XCTAssertEqual(item.data.extraChildRate, 999.45, accuracy: 0.001)
        XCTAssertEqual(item.data.extraAdultQty, 1)
        XCTAssertEqual(item.data.extraChildQty, 2)
        XCTAssertEqual(item.data.extraAdultMealQty, 1)
        XCTAssertEqual(item.data.extraChildMealQty, 2)
        XCTAssertEqual(item.data.mealIncluded, true)
        XCTAssertEqual(item.data.adultMealLimit, 3)
        XCTAssertEqual(item.data.childMealLimit, 2)
        XCTAssertEqual(item.data.adultMealRate, 250, accuracy: 0.001)
        XCTAssertEqual(item.data.childMealRate, 150, accuracy: 0.001)
        XCTAssertEqual(item.data.extraAdultMealRate, 200, accuracy: 0.001)
        XCTAssertEqual(item.data.extraChildMealRate, 100, accuracy: 0.001)
        XCTAssertEqual(item.data.isCustomRate, true)
        XCTAssertEqual(item.data.extraAdultTotal, 888.32, accuracy: 0.001)
        XCTAssertEqual(item.data.extraChildTotal, 1998.90, accuracy: 0.001)
        XCTAssertEqual(item.data.extraGuestTotal, 2887.22, accuracy: 0.001)
        XCTAssertEqual(item.data.extraGuestlMealCount, 3)
        XCTAssertEqual(item.data.extraAdultMealTotal, 200, accuracy: 0.001)
        XCTAssertEqual(item.data.extraChildMealTotal, 200, accuracy: 0.001)
        XCTAssertEqual(item.data.extraGuestMealTotal, 400, accuracy: 0.001)
        XCTAssertEqual(item.data.grandTotal, 4677.99, accuracy: 0.001)
    }

    func test_encodingToJSON() throws {
        let item = try sampleReservationItem(includePriceCard: true)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(item)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        XCTAssertTrue(jsonString.contains("\"id\" : 123"))
        XCTAssertTrue(jsonString.contains("\"reserved_date\" : \"2024-06-01\""))
        XCTAssertTrue(jsonString.contains("\"total_price\" : 2000"))
        XCTAssertTrue(jsonString.contains("\"reservable_type\" : \"ROOM\""))
        XCTAssertTrue(jsonString.contains("\"price_card_id\" : 1"))
    }
    
    // MARK: - ReservationItem.Data Tests
    func test_dataComputedProperties() {
        let data = sampleData()
        XCTAssertEqual(data.totalMealAdultCount, 2)
        XCTAssertEqual(data.totalMealChildCount, 3)
        XCTAssertEqual(data.extraAdultTotal, 400)
        XCTAssertEqual(data.extraChildTotal, 150)
        XCTAssertEqual(data.extraGuestTotal, 550)
        XCTAssertEqual(data.extraGuestlMealCount, 3)
        XCTAssertEqual(data.extraAdultMealTotal, 60)
        XCTAssertEqual(data.extraChildMealTotal, 80)
        XCTAssertEqual(data.extraGuestMealTotal, 140)
        XCTAssertEqual(data.grandTotal, 1000 + 550 + 140)
    }

    func test_dataDecodingFromJSON() throws {
        let json = """
        {
            "is_custom_rate": true,
            "price_card_rate": "1390.77",
            "extra_bed_rate": "888",
            "extra_bed_number": "2", 
            "extra_person_rate": "999",
            "extra_person_number": "1",
            "meal_included": true,
            "adult_meal_limit": "2",
            "adult_meal_rate": "100",
            "child_meal_limit": "1",
            "child_meal_rate": "50",
            "extra_adult_meal_rate": "120",
            "extra_adult_meal_number": "1",
            "extra_child_meal_rate": "60",
            "extra_child_meal_number": "2"
        }
        """
        
        let jsonData = json.data(using: .utf8)!
        let data = try JSONDecoder().decode(ReservationItem.Data.self, from: jsonData)
        
        XCTAssertTrue(data.isCustomRate)
        XCTAssertEqual(data.selectedRate, 1390.77, accuracy: 0.001)
        XCTAssertEqual(data.extraAdultRate, 888, accuracy: 0.001)
        XCTAssertEqual(data.extraAdultQty, 2)
        XCTAssertEqual(data.extraChildRate, 999, accuracy: 0.001)
        XCTAssertEqual(data.extraChildQty, 1)
        XCTAssertTrue(data.mealIncluded)
        XCTAssertEqual(data.adultMealLimit, 2)
        XCTAssertEqual(data.adultMealRate, 100, accuracy: 0.001)
        XCTAssertEqual(data.childMealLimit, 1)
        XCTAssertEqual(data.childMealRate, 50, accuracy: 0.001)
        XCTAssertEqual(data.extraAdultMealRate, 120, accuracy: 0.001)
        XCTAssertEqual(data.extraAdultMealQty, 1)
        XCTAssertEqual(data.extraChildMealRate, 60, accuracy: 0.001)
        XCTAssertEqual(data.extraChildMealQty, 2)
        
        // Test computed values
        XCTAssertEqual(data.totalMealAdultCount, 3) // adultMealLimit + extraAdultMealQty
        XCTAssertEqual(data.totalMealChildCount, 3) // childMealLimit + extraChildMealQty
        XCTAssertEqual(data.extraAdultTotal, 1776, accuracy: 0.001) // extraAdultRate * extraAdultQty
        XCTAssertEqual(data.extraChildTotal, 999, accuracy: 0.001) // extraChildRate * extraChildQty
        XCTAssertEqual(data.extraGuestTotal, 2775, accuracy: 0.001) // extraAdultTotal + extraChildTotal
        XCTAssertEqual(data.extraGuestlMealCount, 3) // extraAdultMealQty + extraChildMealQty
        XCTAssertEqual(data.extraAdultMealTotal, 120, accuracy: 0.001) // extraAdultMealRate * extraAdultMealQty
        XCTAssertEqual(data.extraChildMealTotal, 120, accuracy: 0.001) // extraChildMealRate * extraChildMealQty
        XCTAssertEqual(data.extraGuestMealTotal, 240, accuracy: 0.001) // extraAdultMealTotal + extraChildMealTotal
        XCTAssertEqual(data.grandTotal, 4405.77, accuracy: 0.001) // selectedRate + extraGuestTotal + extraGuestMealTotal
    }
    
    func test_dataEncodingToJSON() throws {
        let data = ReservationItem.Data(
            isCustomRate: true,
            selectedRate: 1234.56,
            extraAdultRate: 789.12,
            extraAdultQty: 1,
            extraChildRate: 345.67,
            extraChildQty: 2,
            mealIncluded: true,
            adultMealLimit: 2,
            adultMealRate: 123.45,
            childMealLimit: 1,
            childMealRate: 67.89,
            extraAdultMealRate: 234.56,
            extraAdultMealQty: 1,
            extraChildMealRate: 78.90,
            extraChildMealQty: 1
        )
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(data)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        
        XCTAssertTrue(jsonString.contains("\"is_custom_rate\" : true"))
        XCTAssertTrue(jsonString.contains("\"price_card_rate\" : \"1234.56\""))
        XCTAssertTrue(jsonString.contains("\"extra_bed_rate\" : \"789.12\""))
        XCTAssertTrue(jsonString.contains("\"extra_bed_number\" : \"1\""))
        XCTAssertTrue(jsonString.contains("\"extra_person_rate\" : \"345.67\""))
        XCTAssertTrue(jsonString.contains("\"extra_person_number\" : \"2\""))
        XCTAssertTrue(jsonString.contains("\"meal_included\" : true"))
        XCTAssertTrue(jsonString.contains("\"adult_meal_limit\" : \"2\""))
        XCTAssertTrue(jsonString.contains("\"adult_meal_rate\" : \"123.45\""))
        XCTAssertTrue(jsonString.contains("\"child_meal_limit\" : \"1\""))
        XCTAssertTrue(jsonString.contains("\"child_meal_rate\" : \"67.89\""))
        XCTAssertTrue(jsonString.contains("\"extra_adult_meal_rate\" : \"234.56\""))
        XCTAssertTrue(jsonString.contains("\"extra_adult_meal_number\" : \"1\""))
        XCTAssertTrue(jsonString.contains("\"extra_child_meal_rate\" : \"78.9\""))
        XCTAssertTrue(jsonString.contains("\"extra_child_meal_number\" : \"1\""))
    }
}

