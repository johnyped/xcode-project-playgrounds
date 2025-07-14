//
//  FoliosTest.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import XCTest

final class FoliosTests: XCTestCase {
    
    func test_decodingFromJSON() throws {
        let json = """
        [
            {
                "id": 130,
                "name": "Room Service", 
                "amount": "111.11",
                "amount_before_vat": "111.11",
                "vat_amount": "0.0",
                "barcode": null,
                "code": null,
                "category_id": null,
                "status": "AVAILABLE",
                "description": "Dinner service",
                "vat_included": false,
                "created_at": "2024-04-21T13:33:16.191+07:00",
                "updated_at": "2024-04-21T13:33:16.191+07:00",
                "hotel_id": 105
            },
            {
                "id": 131,
                "name": "Mini Bar",
                "amount": "222.22", 
                "amount_before_vat": "222.22",
                "vat_amount": "0.0",
                "barcode": null,
                "code": null,
                "category_id": null,
                "status": "AVAILABLE",
                "description": "Beverages",
                "vat_included": false,
                "created_at": "2024-04-21T13:33:16.191+07:00",
                "updated_at": "2024-04-21T13:33:16.191+07:00",
                "hotel_id": 105
            }
        ]
        """
        
        let jsonData = json.data(using: .utf8)!
        let folios = try JSONDecoder().decode(Folios.self, from: jsonData)
        
        XCTAssertEqual(folios.count, 2)
        
        // Test first folio
        let firstFolio = folios[0]
        XCTAssertEqual(firstFolio.id, 130)
        XCTAssertEqual(firstFolio.name, "Room Service")
        XCTAssertEqual(firstFolio.description, "Dinner service")
        XCTAssertEqual(firstFolio.amount, 111.11)
        
        // Test second folio
        let secondFolio = folios[1]
        XCTAssertEqual(secondFolio.id, 131)
        XCTAssertEqual(secondFolio.name, "Mini Bar")
        XCTAssertEqual(secondFolio.description, "Beverages")
        XCTAssertEqual(secondFolio.amount, 222.22)
    }
    
    func test_encodingToJSON() throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = FormConfig.DateFormat.datetimeISO
        dateFormatter.timeZone = TimeZone(identifier: "UTC+7")
        
        let date = dateFormatter.date(from: "2024-04-21T13:33:16.191+07:00")!
        
        let folios = Folios(array: [
            Folio(
                id: 130,
                hotelId: 105,
                status: Folio.Status.available,
                name: "Room Service",
                amount: 111.11,
                amountBeforeVat: 111.11,
                vatAmount: 0.0,
                barcode: nil,
                code: nil,
                categoryId: nil,
                description: "Dinner service",
                vatIncluded: false,
                createdAt: date,
                updatedAt: date
            ),
            Folio(
                id: 131,
                hotelId: 105,
                status: Folio.Status.available,
                name: "Mini Bar",
                amount: 222.22,
                amountBeforeVat: 222.22,
                vatAmount: 0.0,
                barcode: nil,
                code: nil,
                categoryId: nil,
                description: "Beverages",
                vatIncluded: false,
                createdAt: date,
                updatedAt: date
            )
        ])
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(folios)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        
        // Test first folio encoding
        XCTAssertTrue(jsonString.contains("\"id\" : 130"))
        XCTAssertTrue(jsonString.contains("\"name\" : \"Room Service\""))
        XCTAssertTrue(jsonString.contains("\"description\" : \"Dinner service\""))
        XCTAssertTrue(jsonString.contains("\"amount\" : \"111.11\""))
        
        // Test second folio encoding
        XCTAssertTrue(jsonString.contains("\"id\" : 131"))
        XCTAssertTrue(jsonString.contains("\"name\" : \"Mini Bar\""))
        XCTAssertTrue(jsonString.contains("\"description\" : \"Beverages\""))
        XCTAssertTrue(jsonString.contains("\"amount\" : \"222.22\""))
    }
}
