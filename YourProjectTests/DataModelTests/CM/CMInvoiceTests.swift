//
//  CMInvoiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import XCTest

final class CMInvoiceTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let invoice = createSampleCMInvoice()
        
        // Assert
        XCTAssertEqual(invoice.id, "24373826")
        XCTAssertEqual(invoice.description, "6 bed Wednesday, 15 January, 2020 - Thursday, 16 January, 2020")
        XCTAssertEqual(invoice.status, "")
        XCTAssertEqual(invoice.qty, 1)
        XCTAssertEqual(invoice.price, 200.00)
        XCTAssertEqual(invoice.tax, 0.00)
        XCTAssertEqual(invoice.invoiceeID, "")
        XCTAssertEqual(invoice.type, "1")
        XCTAssertEqual(invoice.type2, "0")
    }
    
    func test_initWithDifferentValues() throws {
        // Arrange & Act
        let invoice = CMInvoice(
            id: "12345",
            description: "Test room booking",
            status: "confirmed",
            qty: 2,
            price: 150.50,
            tax: 15.05,
            invoiceeID: "guest123",
            type: "2",
            type2: "1"
        )
        
        // Assert
        XCTAssertEqual(invoice.id, "12345")
        XCTAssertEqual(invoice.description, "Test room booking")
        XCTAssertEqual(invoice.status, "confirmed")
        XCTAssertEqual(invoice.qty, 2)
        XCTAssertEqual(invoice.price, 150.50)
        XCTAssertEqual(invoice.tax, 15.05)
        XCTAssertEqual(invoice.invoiceeID, "guest123")
        XCTAssertEqual(invoice.type, "2")
        XCTAssertEqual(invoice.type2, "1")
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "invoiceId": "24373826",
            "description": "6 bed Wednesday, 15 January, 2020 - Thursday, 16 January, 2020",
            "status": "",
            "qty": "1",
            "price": "200.00",
            "vatRate": "0.00",
            "invoiceeId": "",
            "type": "200",
            "type2": "0"
        }
        """.data(using: .utf8)!
        
        // Act
        let invoice = try JSONDecoder().decode(CMInvoice.self, from: json)
        
        // Assert
        XCTAssertEqual(invoice.id, "24373826")
        XCTAssertEqual(invoice.description, "6 bed Wednesday, 15 January, 2020 - Thursday, 16 January, 2020")
        XCTAssertEqual(invoice.status, "")
        XCTAssertEqual(invoice.qty, 1)
        XCTAssertEqual(invoice.price, 200.00)
        XCTAssertEqual(invoice.tax, 0.00)
        XCTAssertEqual(invoice.invoiceeID, "")
        XCTAssertEqual(invoice.type, "200")
        XCTAssertEqual(invoice.type2, "0")
    }
    
    func test_decodingFromJSONWithStringNumbers() throws {
        // Arrange
        let json = """
        {
            "invoiceId": "12345",
            "description": "Test room",
            "status": "confirmed",
            "qty": "2",
            "price": "150.50",
            "vatRate": "15.05",
            "invoiceeId": "guest123",
            "type": "200",
            "type2": "0"
        }
        """.data(using: .utf8)!
        
        // Act
        let invoice = try JSONDecoder().decode(CMInvoice.self, from: json)
        
        // Assert
        XCTAssertEqual(invoice.id, "12345")
        XCTAssertEqual(invoice.description, "Test room")
        XCTAssertEqual(invoice.status, "confirmed")
        XCTAssertEqual(invoice.qty, 2)
        XCTAssertEqual(invoice.price, 150.50)
        XCTAssertEqual(invoice.tax, 15.05)
        XCTAssertEqual(invoice.invoiceeID, "guest123")
        XCTAssertEqual(invoice.type, "200")
        XCTAssertEqual(invoice.type2, "0")
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let invoice = createSampleCMInvoice()
        
        // Act
        let encodedData = try JSONEncoder().encode(invoice)
        let decodedInvoice = try JSONDecoder().decode(CMInvoice.self, from: encodedData)
        
        // Assert
        XCTAssertEqual(decodedInvoice.id, invoice.id)
        XCTAssertEqual(decodedInvoice.description, invoice.description)
        XCTAssertEqual(decodedInvoice.status, invoice.status)
        XCTAssertEqual(decodedInvoice.qty, invoice.qty)
        XCTAssertEqual(decodedInvoice.price, invoice.price)
        XCTAssertEqual(decodedInvoice.tax, invoice.tax)
        XCTAssertEqual(decodedInvoice.invoiceeID, invoice.invoiceeID)
        XCTAssertEqual(decodedInvoice.type, invoice.type)
        XCTAssertEqual(decodedInvoice.type2, invoice.type2)
    }
    
    func test_encodingToJSONWithProperKeys() throws {
        // Arrange
        let invoice = createSampleCMInvoice()
        
        // Act
        let encodedData = try JSONEncoder().encode(invoice)
        let jsonString = String(data: encodedData, encoding: .utf8)!
        
        // Assert
        XCTAssertTrue(jsonString.contains("invoiceId"))
        XCTAssertTrue(jsonString.contains("description"))
        XCTAssertTrue(jsonString.contains("status"))
        XCTAssertTrue(jsonString.contains("qty"))
        XCTAssertTrue(jsonString.contains("price"))
        XCTAssertTrue(jsonString.contains("vatRate"))
        XCTAssertTrue(jsonString.contains("invoiceeId"))
        XCTAssertTrue(jsonString.contains("type"))
        XCTAssertTrue(jsonString.contains("type2"))
    }
    
    func test_arrayOfInvoices() throws {
        // Arrange
        let invoice1 = createSampleCMInvoice()
        let invoice2 = CMInvoice(
            id: "12345",
            description: "Second invoice",
            status: "confirmed",
            qty: 1,
            price: 100.00,
            tax: 10.00,
            invoiceeID: "guest456",
            type: "3",
            type2: "2"
        )
        let invoices = [invoice1, invoice2]
        
        // Act
        let encodedData = try JSONEncoder().encode(invoices)
        let decodedInvoices = try JSONDecoder().decode([CMInvoice].self, from: encodedData)
        
        // Assert
        XCTAssertEqual(decodedInvoices.count, 2)
        XCTAssertEqual(decodedInvoices[0].id, invoice1.id)
        XCTAssertEqual(decodedInvoices[1].id, invoice2.id)
        XCTAssertEqual(decodedInvoices[0].price, invoice1.price)
        XCTAssertEqual(decodedInvoices[1].price, invoice2.price)
        XCTAssertEqual(decodedInvoices[0].type, invoice1.type)
        XCTAssertEqual(decodedInvoices[1].type, invoice2.type)
        XCTAssertEqual(decodedInvoices[0].type2, invoice1.type2)
        XCTAssertEqual(decodedInvoices[1].type2, invoice2.type2)
    }
    
    func test_typeAndType2PropertiesFromActualJSON() throws {
        // Arrange - Using actual JSON from the API
        let json = """
        {
            "invoiceId": "24373826",
            "description": "6 bed Wednesday, 15 January, 2020 - Thursday, 16 January, 2020",
            "status": "",
            "qty": "1",
            "price": "200.00",
            "vatRate": "0.00",
            "type": "1",
            "type2": "0",
            "invoiceeId": ""
        }
        """.data(using: .utf8)!
        
        // Act
        let invoice = try JSONDecoder().decode(CMInvoice.self, from: json)
        
        // Assert
        XCTAssertEqual(invoice.type, "1")
        XCTAssertEqual(invoice.type2, "0")
        XCTAssertEqual(invoice.id, "24373826")
        XCTAssertEqual(invoice.qty, 1)
        XCTAssertEqual(invoice.price, 200.00)
    }
    
    // MARK: - Helper Methods
    
    private func createSampleCMInvoice() -> CMInvoice {
        return CMInvoice(
            id: "24373826",
            description: "6 bed Wednesday, 15 January, 2020 - Thursday, 16 January, 2020",
            status: "",
            qty: 1,
            price: 200.00,
            tax: 0.00,
            invoiceeID: "",
            type: "1",
            type2: "0"
        )
    }
} 