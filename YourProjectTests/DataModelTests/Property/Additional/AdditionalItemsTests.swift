//
//  AdditionalItemsTests.swift
//  YourProject
//
//  Created by IntrodexMini on 17/5/2568 BE.
//

import XCTest

final class AdditionalItemsTests: XCTestCase {
    
    func test_decodingFromJSON() throws {
        let json = """
        [
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
            },
            {
                "id": 455,
                "price": "222.22", 
                "quantity": 2,
                "total_amount": "444.44",
                "itemable_id": 131,
                "itemable_type": "FOLIO",
                "created_at": "2024-04-21T13:33:16.191+07:00",
                "updated_at": "2024-04-21T13:33:16.191+07:00",
                "additional_id": 274
            }
        ]
        """
        
        let jsonData = json.data(using: .utf8)!
        let items = try JSONDecoder().decode(AdditionalItems.self, from: jsonData)
        
        XCTAssertEqual(items.count, 2)
        
        // Test first item
        let firstItem = items[0]
        XCTAssertEqual(firstItem.id, 454)
        XCTAssertEqual(firstItem.price, 111.11)
        XCTAssertEqual(firstItem.quantity, 1)
        XCTAssertEqual(firstItem.totalAmount, 111.11)
        XCTAssertEqual(firstItem.itemableId, 130)
        XCTAssertEqual(firstItem.itemableType, .foilo)
        XCTAssertEqual(firstItem.additionalId, 273)
        
        // Test second item
        let secondItem = items[1]
        XCTAssertEqual(secondItem.id, 455)
        XCTAssertEqual(secondItem.price, 222.22)
        XCTAssertEqual(secondItem.quantity, 2)
        XCTAssertEqual(secondItem.totalAmount, 444.44)
        XCTAssertEqual(secondItem.itemableId, 131)
        XCTAssertEqual(secondItem.itemableType, .foilo)
        XCTAssertEqual(secondItem.additionalId, 274)
    }
    
    func test_encodingToJSON() throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = FormConfig.DateFormat.datetimeISO
        dateFormatter.timeZone = TimeZone(identifier: "UTC+7")
        
        let date = dateFormatter.date(from: "2024-04-21T13:33:16.191+07:00")!
        
        let items = AdditionalItems(array:[
            AdditionalItem(
                id: 454,
                price: 111.11,
                quantity: 1,
                totalAmount: 111.11,
                itemableId: 130,
                itemableType: .foilo,
                additionalId: 273,
                createdAt: date,
                updatedAt: date
            ),
            AdditionalItem(
                id: 455,
                price: 222.22,
                quantity: 2,
                totalAmount: 444.44,
                itemableId: 131,
                itemableType: .foilo,
                additionalId: 274,
                createdAt: date,
                updatedAt: date
            )
        ])
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(items)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        
        // Test first item encoding
        XCTAssertTrue(jsonString.contains("\"id\" : 454"))
        XCTAssertTrue(jsonString.contains("\"price\" : \"111.11\""))
        XCTAssertTrue(jsonString.contains("\"quantity\" : 1"))
        XCTAssertTrue(jsonString.contains("\"total_amount\" : \"111.11\""))
        XCTAssertTrue(jsonString.contains("\"itemable_id\" : 130"))
        XCTAssertTrue(jsonString.contains("\"itemable_type\" : \"FOLIO\""))
        XCTAssertTrue(jsonString.contains("\"additional_id\" : 273"))
        
        // Test second item encoding
        XCTAssertTrue(jsonString.contains("\"id\" : 455"))
        XCTAssertTrue(jsonString.contains("\"price\" : \"222.22\""))
        XCTAssertTrue(jsonString.contains("\"quantity\" : 2"))
        XCTAssertTrue(jsonString.contains("\"total_amount\" : \"444.44\""))
        XCTAssertTrue(jsonString.contains("\"itemable_id\" : 131"))
        XCTAssertTrue(jsonString.contains("\"additional_id\" : 274"))
    }
}
