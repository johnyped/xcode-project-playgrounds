//
//  ReceiptTests.swift
//  YourProject
//
//  Created by IntrodexMini on 16/6/2568 BE.
//

import Foundation
import XCTest

final class ReceiptTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let receipt = createSampleReceipt()
        
        // Assert
        XCTAssertEqual(receipt.id, 3)
        XCTAssertEqual(receipt.status, .paid)
        XCTAssertEqual(receipt.number, "RI20221100001")
        XCTAssertEqual(receipt.vatIncluded, true)
        XCTAssertEqual(receipt.vatPercentage, 7.0)
        XCTAssertEqual(receipt.withholdingTaxIncluded, true)
        XCTAssertEqual(receipt.withholdingTaxPercentage, 3.0)
        XCTAssertEqual(receipt.occupiedTotalAmount, 500.0)
        XCTAssertEqual(receipt.additionalTotalAmount, 0.0)
        XCTAssertEqual(receipt.totalAmount, 500.0)
        XCTAssertEqual(receipt.amountBeforeVat, 467.29)
        XCTAssertEqual(receipt.vatAmount, 32.71)
        XCTAssertEqual(receipt.holdingTaxAmount, 14.02)
        XCTAssertEqual(receipt.totalReceiveAmount, 500.0)
        XCTAssertEqual(receipt.paidBeforeAmount, 0.0)
        XCTAssertEqual(receipt.currency, "THB")
        XCTAssertEqual(receipt.hotelId, 105)
        XCTAssertEqual(receipt.userId, 38)
        XCTAssertEqual(receipt.payerContactId, 4)
        XCTAssertEqual(receipt.receiverContactId, 4)
        XCTAssertEqual(receipt.financialRecordIds, [1, 2, 3])
    }
    
    func test_initWithOptionalProperties() throws {
        // Arrange & Act
        let receipt = createSampleReceipt()
        
        // Assert
        XCTAssertNil(receipt.voidReason)
        XCTAssertNil(receipt.voidedAt)
        XCTAssertNil(receipt.cancelledAt)
        XCTAssertNil(receipt.cancelReason)
        XCTAssertNil(receipt.paidAt)
        XCTAssertNil(receipt.remark)
        XCTAssertNil(receipt.internalNote)
        XCTAssertNil(receipt.folioFormId)
    }
    
    func test_initWithDates() throws {
        // Arrange & Act
        let receipt = createSampleReceipt()
        
        // Assert
        XCTAssertNotNil(receipt.paidDate)
        XCTAssertNotNil(receipt.createdAt)
        XCTAssertNotNil(receipt.updatedAt)
        XCTAssertEqual(receipt.paidDate.toDateString(FormConfig.DateFormat.yyyyMMdd), "2022-11-22")
    }
    
    // MARK: - Status Tests
    
    func test_statusDescription() throws {
        XCTAssertEqual(Receipt.Status.paid.description, "Paid")
        XCTAssertEqual(Receipt.Status.void.description, "Voided")
        XCTAssertEqual(Receipt.Status.cancelled.description, "Cancelled")
    }
    
    func test_statusRawValues() throws {
        XCTAssertEqual(Receipt.Status.paid.rawValue, "PAID")
        XCTAssertEqual(Receipt.Status.void.rawValue, "VOID")
        XCTAssertEqual(Receipt.Status.cancelled.rawValue, "CANCELLED")
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 3,
            "status": "PAID",
            "void_reason": null,
            "voided_at": null,
            "cancelled_at": null,
            "cancel_reason": null,
            "paid_at": null,
            "number": "RI20221100001",
            "vat_included": true,
            "vat_percentage": "7.0",
            "withholding_tax_included": true,
            "withholding_tax_percentage": "3.0",
            "occupied_total_amount": "500.0",
            "additional_total_amount": "0.0",
            "total_amount": "500.0",
            "amount_before_vat": "467.29",
            "vat_amount": "32.71",
            "holding_tax_amount": "14.02",
            "total_receive_amount": "500.0",
            "paid_before_amount": "0.0",
            "paid_date": "2022-11-22",
            "currency": "THB",
            "remark": null,
            "internal_note": null,
            "created_at": "2022-11-23T00:32:36.664+07:00",
            "updated_at": "2023-07-31T12:29:27.040+07:00",
            "hotel_id": 105,
            "user_id": 38,
            "folio_form_id": null,
            "payer_contact_id": 4,
            "receiver_contact_id": 4,
            "financial_record_ids": [1,2,3]
        }
        """.data(using: .utf8)!
        
        // Act
        let receipt = try JSONDecoder().decode(Receipt.self, from: json)
        
        // Assert
        XCTAssertEqual(receipt.id, 3)
        XCTAssertEqual(receipt.status, .paid)
        XCTAssertNil(receipt.voidReason)
        XCTAssertNil(receipt.voidedAt)
        XCTAssertNil(receipt.cancelledAt)
        XCTAssertNil(receipt.cancelReason)
        XCTAssertNil(receipt.paidAt)
        XCTAssertEqual(receipt.number, "RI20221100001")
        XCTAssertEqual(receipt.vatIncluded, true)
        XCTAssertEqual(receipt.vatPercentage, 7.0)
        XCTAssertEqual(receipt.withholdingTaxIncluded, true)
        XCTAssertEqual(receipt.withholdingTaxPercentage, 3.0)
        XCTAssertEqual(receipt.occupiedTotalAmount, 500.0)
        XCTAssertEqual(receipt.additionalTotalAmount, 0.0)
        XCTAssertEqual(receipt.totalAmount, 500.0)
        XCTAssertEqual(receipt.amountBeforeVat, 467.29)
        XCTAssertEqual(receipt.vatAmount, 32.71)
        XCTAssertEqual(receipt.holdingTaxAmount, 14.02)
        XCTAssertEqual(receipt.totalReceiveAmount, 500.0)
        XCTAssertEqual(receipt.paidBeforeAmount, 0.0)
        XCTAssertEqual(receipt.paidDate.toDateString(FormConfig.DateFormat.yyyyMMdd), "2022-11-22")
        XCTAssertEqual(receipt.currency, "THB")
        XCTAssertNil(receipt.remark)
        XCTAssertNil(receipt.internalNote)
        XCTAssertNotNil(receipt.createdAt)
        XCTAssertNotNil(receipt.updatedAt)
        XCTAssertEqual(receipt.hotelId, 105)
        XCTAssertEqual(receipt.userId, 38)
        XCTAssertNil(receipt.folioFormId)
        XCTAssertEqual(receipt.payerContactId, 4)
        XCTAssertEqual(receipt.receiverContactId, 4)
        XCTAssertEqual(receipt.financialRecordIds, [1, 2, 3])
    }
    
    func test_decodingWithVoidedStatus() throws {
        // Arrange
        let json = """
        {
            "id": 4,
            "status": "VOID",
            "void_reason": "Customer request",
            "voided_at": "2022-11-23T10:30:00.000+07:00",
            "cancelled_at": null,
            "cancel_reason": null,
            "paid_at": "2022-11-22T14:30:00.000+07:00",
            "number": "RI20221100002",
            "vat_included": true,
            "vat_percentage": "7.0",
            "withholding_tax_included": false,
            "withholding_tax_percentage": "0.0",
            "occupied_total_amount": "1000.0",
            "additional_total_amount": "100.0",
            "total_amount": "1100.0",
            "amount_before_vat": "1028.04",
            "vat_amount": "71.96",
            "holding_tax_amount": "0.0",
            "total_receive_amount": "1100.0",
            "paid_before_amount": "0.0",
            "paid_date": "2022-11-23",
            "currency": "THB",
            "remark": "Test remark",
            "internal_note": "Internal note for testing",
            "created_at": "2022-11-23T00:32:36.664+07:00",
            "updated_at": "2023-07-31T12:29:27.040+07:00",
            "hotel_id": 105,
            "user_id": 38,
            "folio_form_id": 123,
            "payer_contact_id": 5,
            "receiver_contact_id": 6,
            "financial_record_ids": [4,5,6,7]
        }
        """.data(using: .utf8)!
        
        // Act
        let receipt = try JSONDecoder().decode(Receipt.self, from: json)
        
        // Assert
        XCTAssertEqual(receipt.id, 4)
        XCTAssertEqual(receipt.status, .void)
        XCTAssertEqual(receipt.voidReason, "Customer request")
        XCTAssertNotNil(receipt.voidedAt)
        XCTAssertNotNil(receipt.paidAt)
        XCTAssertEqual(receipt.withholdingTaxIncluded, false)
        XCTAssertEqual(receipt.remark, "Test remark")
        XCTAssertEqual(receipt.internalNote, "Internal note for testing")
        XCTAssertEqual(receipt.folioFormId, 123)
        XCTAssertEqual(receipt.payerContactId, 5)
        XCTAssertEqual(receipt.receiverContactId, 6)
        XCTAssertEqual(receipt.financialRecordIds, [4, 5, 6, 7])
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let receipt = createSampleReceipt()
        
        // Act
        let encoder = JSONEncoder()
        let data = try encoder.encode(receipt)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["id"] as? Int, 3)
        XCTAssertEqual(json?["status"] as? String, "PAID")
        XCTAssertEqual(json?["number"] as? String, "RI20221100001")
        XCTAssertEqual(json?["vat_included"] as? Bool, true)
        XCTAssertEqual(json?["vat_percentage"] as? String, "7.0")
        XCTAssertEqual(json?["currency"] as? String, "THB")
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["user_id"] as? Int, 38)
        
        let financialRecordIds = json?["financial_record_ids"] as? [Int]
        XCTAssertEqual(financialRecordIds, [1, 2, 3])
    }
    
    // MARK: - Edge Cases Tests
    
    func test_decodingWithCancelledStatus() throws {
        // Arrange
        let json = """
        {
            "id": 5,
            "status": "CANCELLED",
            "void_reason": null,
            "voided_at": null,
            "cancelled_at": "2022-11-24T16:45:00.000+07:00",
            "cancel_reason": "Booking cancelled by guest",
            "paid_at": null,
            "number": "RI20221100003",
            "vat_included": false,
            "vat_percentage": "0.0",
            "withholding_tax_included": false,
            "withholding_tax_percentage": "0.0",
            "occupied_total_amount": "750.0",
            "additional_total_amount": "50.0",
            "total_amount": "800.0",
            "amount_before_vat": "800.0",
            "vat_amount": "0.0",
            "holding_tax_amount": "0.0",
            "total_receive_amount": "800.0",
            "paid_before_amount": "200.0",
            "paid_date": "2022-11-24",
            "currency": "USD",
            "remark": null,
            "internal_note": null,
            "created_at": "2022-11-24T00:32:36.664+07:00",
            "updated_at": "2022-11-24T16:45:30.040+07:00",
            "hotel_id": 106,
            "user_id": 39,
            "folio_form_id": null,
            "payer_contact_id": 7,
            "receiver_contact_id": 8,
            "financial_record_ids": []
        }
        """.data(using: .utf8)!
        
        // Act
        let receipt = try JSONDecoder().decode(Receipt.self, from: json)
        
        // Assert
        XCTAssertEqual(receipt.id, 5)
        XCTAssertEqual(receipt.status, .cancelled)
        XCTAssertNotNil(receipt.cancelledAt)
        XCTAssertEqual(receipt.cancelReason, "Booking cancelled by guest")
        XCTAssertEqual(receipt.vatIncluded, false)
        XCTAssertEqual(receipt.withholdingTaxIncluded, false)
        XCTAssertEqual(receipt.currency, "USD")
        XCTAssertEqual(receipt.paidBeforeAmount, 200.0)
        XCTAssertTrue(receipt.financialRecordIds.isEmpty)
    }
    
    // MARK: - Helper Methods
    
    private func createSampleReceipt() -> Receipt {
        return Receipt(
            id: 3,
            status: .paid,
            number: "RI20221100001",
            vatIncluded: true,
            vatPercentage: 7.0,
            withholdingTaxIncluded: true,
            withholdingTaxPercentage: 3.0,
            occupiedTotalAmount: 500.0,
            additionalTotalAmount: 0.0,
            totalAmount: 500.0,
            amountBeforeVat: 467.29,
            vatAmount: 32.71,
            holdingTaxAmount: 14.02,
            totalReceiveAmount: 500.0,
            paidBeforeAmount: 0.0,
            paidDate: Date(timeIntervalSince1970: 1669075200), // 2022-11-22
            currency: "THB",
            remark: nil,
            internalNote: nil,
            voidReason: nil,
            voidedAt: nil,
            cancelledAt: nil,
            cancelReason: nil,
            paidAt: nil,
            hotelId: 105,
            userId: 38,
            folioFormId: nil,
            payerContactId: 4,
            receiverContactId: 4,
            financialRecordIds: [1, 2, 3],
            createdAt: Date(timeIntervalSince1970: 1669139556.664), // 2022-11-23T00:32:36.664+07:00
            updatedAt: Date(timeIntervalSince1970: 1690781367.040)  // 2023-07-31T12:29:27.040+07:00
        )
    }
    
    private func createSampleReceiptWithAllFields() -> Receipt {
        return Receipt(
            id: 10,
            status: .void,
            number: "RI20221100010",
            vatIncluded: true,
            vatPercentage: 10.0,
            withholdingTaxIncluded: true,
            withholdingTaxPercentage: 5.0,
            occupiedTotalAmount: 2000.0,
            additionalTotalAmount: 300.0,
            totalAmount: 2300.0,
            amountBeforeVat: 2090.91,
            vatAmount: 209.09,
            holdingTaxAmount: 104.55,
            totalReceiveAmount: 2300.0,
            paidBeforeAmount: 500.0,
            paidDate: Date(timeIntervalSince1970: 1669161600), // 2022-11-24
            currency: "THB",
            remark: "Test remark for all fields",
            internalNote: "Internal test note",
            voidReason: "Test void reason",
            voidedAt: Date(timeIntervalSince1970: 1669347000), // 2022-11-25T10:30:00.000+07:00
            cancelledAt: nil,
            cancelReason: nil,
            paidAt: Date(timeIntervalSince1970: 1669279800), // 2022-11-24T15:30:00.000+07:00
            hotelId: 107,
            userId: 40,
            folioFormId: 999,
            payerContactId: 10,
            receiverContactId: 11,
            financialRecordIds: [10, 11, 12, 13, 14],
            createdAt: Date(timeIntervalSince1970: 1669225956.664), // 2022-11-24T00:32:36.664+07:00
            updatedAt: Date(timeIntervalSince1970: 1669354167.040), // 2022-11-25T12:29:27.040+07:00
        )
    }
} 
