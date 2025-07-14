//
//  AdditionalItemTests.swift
//  YourProject
//
//  Created by IntrodexMini on 17/5/2568 BE.
//

import XCTest

final class AdditionalItemTests: XCTestCase {
    
    func test_decodingFromJSON() throws {
        let json = """
        {
            "id": 431,
            "price": "15.0",
            "quantity": 2,
            "total_amount": "30.0",
            "itemable_id": 134,
            "itemable_type": "FOLIO",
            "created_at": "2024-03-19T05:54:36.214+07:00",
            "updated_at": "2024-03-19T05:54:36.214+07:00",
            "additional_id": 261
        }
        """
        
        let jsonData = json.data(using: .utf8)!
        let item = try JSONDecoder().decode(AdditionalItem.self, from: jsonData)
        
        XCTAssertEqual(item.id, 431)
        XCTAssertEqual(item.price, 15.0)
        XCTAssertEqual(item.quantity, 2)
        XCTAssertEqual(item.totalAmount, 30.0)
        XCTAssertEqual(item.itemableId, 134)
        XCTAssertEqual(item.itemableType, .foilo)
        XCTAssertEqual(item.additionalId, 261)
        
        let expectedCreatedAt = try "2024-03-19T05:54:36.214+07:00".tryToDate(FormConfig.DateFormat.datetimeISO)
        let expectedUpdatedAt = try "2024-03-19T05:54:36.214+07:00".tryToDate(FormConfig.DateFormat.datetimeISO)
        
        XCTAssertEqual(item.createdAt, expectedCreatedAt)
        XCTAssertEqual(item.updatedAt, expectedUpdatedAt)
    }
    
    func test_encodingToJSON() throws {        
        
        let createdAt = try "2024-03-19T05:54:36.214+07:00".tryToDate(FormConfig.DateFormat.datetimeISO)
        let updatedAt = try "2024-03-19T05:54:36.214+07:00".tryToDate(FormConfig.DateFormat.datetimeISO)
        
        let item = AdditionalItem(
            id: 431,
            price: 15.0,
            quantity: 2,
            totalAmount: 30.0,
            itemableId: 134,
            itemableType: .foilo,
            additionalId: 261,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(item)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        
        XCTAssertTrue(jsonString.contains("\"id\" : 431"))
        XCTAssertTrue(jsonString.contains("\"price\" : \"15.0\""))
        XCTAssertTrue(jsonString.contains("\"quantity\" : 2"))
        XCTAssertTrue(jsonString.contains("\"total_amount\" : \"30.0\""))
        XCTAssertTrue(jsonString.contains("\"itemable_id\" : 134"))
        XCTAssertTrue(jsonString.contains("\"itemable_type\" : \"FOLIO\""))
        XCTAssertTrue(jsonString.contains("\"additional_id\" : 261"))
        XCTAssertTrue(jsonString.contains("\"created_at\" : \"2024-03-19T05:54:36.214+07:00\""))
        XCTAssertTrue(jsonString.contains("\"updated_at\" : \"2024-03-19T05:54:36.214+07:00\""))
    }
}
