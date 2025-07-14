//
//  AdditionalTests.swift
//  YourProject
//
//  Created by IntrodexMini on 17/5/2568 BE.
//

import XCTest

final class AdditionalTests: XCTestCase {
    
    // MARK: - Helper Methods
   
    private func sampleAdditionalItem() -> AdditionalItem {
        return AdditionalItem(
            id: 454,
            price: 111.11,
            quantity: 1,
            totalAmount: 111.11,
            itemableId: 130,
            itemableType: .foilo,
            additionalId: 273,
            createdAt: Date(timeIntervalSince1970: 1000),
            updatedAt: Date(timeIntervalSince1970: 2000)
        )
    }
    
    private func sampleAdditional() throws -> Additional {
        let dateIssue = try "2024-04-21T00:00:00.000+07:00".tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
        let createdAt = try "2024-04-21T13:33:16.144+07:00".tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
        let updatedAt = try "2024-04-21T13:33:16.227+07:00".tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
        
        let items = AdditionalItems(array: [sampleAdditionalItem()])
        
        return Additional(id: 273,
                          hotelId: 105,
                          reservationId: 1067,
                          status: .active,
                          note: "",
                          dateIssue: dateIssue,
                          totalAmount: 111.11,
                          additionalItems: items,
                          createdAt: createdAt,
                          updatedAt: updatedAt)
    }
    
    // MARK: - Additional Tests
    
    func test_initWithAllProperties() throws {
        let additional = try sampleAdditional()
        XCTAssertEqual(additional.id, 273)
        XCTAssertEqual(additional.hotelId, 105)
        XCTAssertEqual(additional.reservationId, 1067)
        XCTAssertEqual(additional.status, .active)
        XCTAssertEqual(additional.note, "")
        XCTAssertEqual(additional.totalAmount, 111.11)
        
        // Test additional items
        XCTAssertEqual(additional.additionalItems.count, 1)
        let item = additional.additionalItems[0]
        XCTAssertEqual(item.id, 454)
        XCTAssertEqual(item.price, 111.11)
        XCTAssertEqual(item.quantity, 1)
        XCTAssertEqual(item.totalAmount, 111.11)
    }
    
    func test_decodingFromJSON() throws {
        let json = """
        {
            "id": 273,
            "hotel_id": 105,
            "reservation_id": 1067,
            "status": "ACTIVE",
            "note": "",
            "date_issue": "2024-04-21T00:00:00.000+07:00",
            "total_amount": "111.11",
            "additional_items": [
                {
                    "id": 454,
                    "price": "111.11",
                    "quantity": 1,
                    "total_amount": "111.11",
                    "itemable_id": 130,
                    "itemable_type": "FOLIO",
                    "created_at": "2024-04-21T13:33:16.191+07:00",
                    "updated_at": "2024-04-21T13:33:16.191+07:00",
                    "additional_id": 273
                }
            ],
            "created_at": "2024-04-21T13:33:16.144+07:00",
            "updated_at": "2024-04-21T13:33:16.227+07:00"
        }
        """
        
        let jsonData = json.data(using: .utf8)!
        let additional = try JSONDecoder().decode(Additional.self, from: jsonData)
        
        XCTAssertEqual(additional.id, 273)
        XCTAssertEqual(additional.hotelId, 105)
        XCTAssertEqual(additional.reservationId, 1067)
        XCTAssertEqual(additional.status, .active)
        XCTAssertEqual(additional.note, "")
        XCTAssertEqual(additional.totalAmount, 111.11)
        
        // Test additional items
        XCTAssertEqual(additional.additionalItems.count, 1)
        let item = additional.additionalItems[0]
        XCTAssertEqual(item.id, 454)
        XCTAssertEqual(item.price, 111.11)
        XCTAssertEqual(item.quantity, 1)
        XCTAssertEqual(item.totalAmount, 111.11)
        XCTAssertEqual(item.itemableId, 130)
        XCTAssertEqual(item.itemableType, .foilo)
        XCTAssertEqual(item.additionalId, 273)
    }
    
    func test_encodingToJSON() throws {
        let additional = try sampleAdditional()
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(additional)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        
        XCTAssertTrue(jsonString.contains("\"id\" : 273"))
        XCTAssertTrue(jsonString.contains("\"hotel_id\" : 105"))
        XCTAssertTrue(jsonString.contains("\"reservation_id\" : 1067"))
        XCTAssertTrue(jsonString.contains("\"status\" : \"ACTIVE\""))
        XCTAssertTrue(jsonString.contains("\"note\" : \"\""))
        XCTAssertTrue(jsonString.contains("\"total_amount\" : \"111.11\""))
        
        // Test additional items encoding
        XCTAssertTrue(jsonString.contains("\"price\" : \"111.11\""))
        XCTAssertTrue(jsonString.contains("\"quantity\" : 1"))
        XCTAssertTrue(jsonString.contains("\"itemable_type\" : \"FOLIO\""))
    }
}
