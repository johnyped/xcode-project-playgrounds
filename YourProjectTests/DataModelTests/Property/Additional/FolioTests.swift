//
//  FolioTests.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import XCTest

final class FolioTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithAllProperties() throws {
        // Arrange & Act
        let folio = createSampleFolio()
        
        // Assert
        XCTAssertEqual(folio.id, 1)
        XCTAssertEqual(folio.name, "Test Folio")
        XCTAssertEqual(folio.amount, 500.0, accuracy: 0.001)
        XCTAssertEqual(folio.amountBeforeVat, 467.29, accuracy: 0.001)
        XCTAssertEqual(folio.vatAmount, 32.71, accuracy: 0.001)
        XCTAssertEqual(folio.barcode, "123456789")
        XCTAssertEqual(folio.code, "FOL001")
        XCTAssertEqual(folio.categoryId, 1)
        XCTAssertEqual(folio.status, Folio.Status.available)
        XCTAssertEqual(folio.description, "Test Description")
        XCTAssertTrue(folio.vatIncluded)
        XCTAssertEqual(folio.hotelId, 105)
    }
    
    func test_initWithOptionalPropertiesAsNil() throws {
        // Arrange & Act
        let folio = Folio(
            id: 1,
            hotelId: 105,
            status: Folio.Status.available,
            name: "Test Folio",
            amount: 500.0,
            amountBeforeVat: 467.29,
            vatAmount: 32.71,
            barcode: nil,
            code: nil,
            categoryId: nil,
            description: "",
            vatIncluded: true,
            createdAt: Date(timeIntervalSince1970: 1000),
            updatedAt: Date(timeIntervalSince1970: 2000)
        )
        
        // Assert
        XCTAssertNil(folio.barcode)
        XCTAssertNil(folio.code)
        XCTAssertNil(folio.categoryId)
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 115,
            "name": "รับส่ง",
            "amount": "500.0",
            "amount_before_vat": "500.0",
            "vat_amount": "0.0",
            "barcode": null,
            "code": null,
            "category_id": null,
            "status": "AVAILABLE",
            "description": "",
            "vat_included": false,
            "created_at": "2019-11-29T08:20:26.443+07:00",
            "updated_at": "2023-08-25T11:25:01.734+07:00",
            "hotel_id": 105
        }
        """.data(using: .utf8)!
        
        // Act
        let folio = try JSONDecoder().decode(Folio.self, from: json)
        
        // Assert
        XCTAssertEqual(folio.id, 115)
        XCTAssertEqual(folio.name, "รับส่ง")
        XCTAssertEqual(folio.amount, 500.0, accuracy: 0.001)
        XCTAssertEqual(folio.amountBeforeVat, 500.0, accuracy: 0.001)
        XCTAssertEqual(folio.vatAmount, 0.0, accuracy: 0.001)
        XCTAssertNil(folio.barcode)
        XCTAssertNil(folio.code)
        XCTAssertNil(folio.categoryId)
        XCTAssertEqual(folio.status, Folio.Status.available)
        XCTAssertEqual(folio.description, "")
        XCTAssertFalse(folio.vatIncluded)
        XCTAssertEqual(folio.hotelId, 105)
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let folio = createSampleFolio()
        
        // Act
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(folio)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        print(jsonString)
        
        // Assert
        XCTAssertTrue(jsonString.contains("\"id\" : 1"))
        XCTAssertTrue(jsonString.contains("\"name\" : \"Test Folio\""))
        XCTAssertTrue(jsonString.contains("\"amount\" : \"500.0\""))
        XCTAssertTrue(jsonString.contains("\"amount_before_vat\" : \"467.29\""))
        XCTAssertTrue(jsonString.contains("\"vat_amount\" : \"32.71\""))
        XCTAssertTrue(jsonString.contains("\"barcode\" : \"123456789\""))
        XCTAssertTrue(jsonString.contains("\"status\" : \"AVAILABLE\""))
        XCTAssertTrue(jsonString.contains("\"vat_included\" : true"))
        XCTAssertTrue(jsonString.contains("\"hotel_id\" : 105"))
    }
    
    // MARK: - Helper Methods
    
    private func createSampleFolio() -> Folio {
        return Folio(
            id: 1,
            hotelId: 105,
            status: Folio.Status.available,
            name: "Test Folio",
            amount: 500.0,
            amountBeforeVat: 467.29,
            vatAmount: 32.71,
            barcode: "123456789",
            code: "FOL001",
            categoryId: 1,
            description: "Test Description",
            vatIncluded: true,
            createdAt: Date(timeIntervalSince1970: 1000),
            updatedAt: Date(timeIntervalSince1970: 2000)
        )
    }
}

