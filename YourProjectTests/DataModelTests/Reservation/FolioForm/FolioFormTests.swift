//
//  FolioFormTests.swift
//  YourProject
//
//  Created by IntrodexMini on 13/6/2568 BE.
//

import XCTest

final class FolioFormTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let folioForm = createSampleFolioForm()
        
        // Assert
        XCTAssertEqual(folioForm.id, 1)
        XCTAssertEqual(folioForm.status, .active)
        XCTAssertEqual(folioForm.number, "F20230600001")
        XCTAssertEqual(folioForm.vatIncluded, false)
        XCTAssertEqual(folioForm.vatPercentage, 7)
        XCTAssertEqual(folioForm.occupiedTotalAmount, 1500.0)
        XCTAssertEqual(folioForm.additionalTotalAmount, 0.0)
        XCTAssertEqual(folioForm.totalAmount, 1500.0)
        XCTAssertEqual(folioForm.amountBeforeVat, 0.0)
        XCTAssertEqual(folioForm.vatAmount, 0.0)
        XCTAssertEqual(folioForm.paidBeforeAmount, 0.0)
        XCTAssertEqual(folioForm.remainAmount, 1500.0)
        XCTAssertEqual(folioForm.remark, "testrrrsss")
        XCTAssertEqual(folioForm.internalNote, "testrrrwww")
        XCTAssertEqual(folioForm.paymentInfo, "2, 2 (111-1-11111-2)")
        XCTAssertEqual(folioForm.groupRoomCharge, true)
        XCTAssertEqual(folioForm.groupAdditionalItem, false)
        XCTAssertEqual(folioForm.receiptIds, [])
        XCTAssertEqual(folioForm.hotelId, 105)
        XCTAssertEqual(folioForm.hotelContactId, 8)
        XCTAssertEqual(folioForm.customerContactId, 6)
    }
    
    func test_initWithOptionalProperties() throws {
        // Arrange & Act
        let folioForm = createSampleFolioForm()
        
        // Assert
        XCTAssertNil(folioForm.canceledAt)
    }
    
    func test_initWithDates() throws {
        // Arrange & Act
        let folioForm = createSampleFolioForm()
        
        // Assert
        XCTAssertNotNil(folioForm.createdAt)
        XCTAssertNotNil(folioForm.updatedAt)
        XCTAssertNil(folioForm.canceledAt)
    }
    
    // MARK: - Status Tests
    
    func test_statusDescription() throws {
        XCTAssertEqual(FolioForm.Status.active.title, "Active")
        XCTAssertEqual(FolioForm.Status.cancelled.title, "Cancelled")
    }
    
    func test_statusRawValues() throws {
        XCTAssertEqual(FolioForm.Status.active.rawValue, "ACTIVE")
        XCTAssertEqual(FolioForm.Status.cancelled.rawValue, "CANCELLED")
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 1,
            "status": "ACTIVE",
            "cancelled_at": null,
            "number": "F20230600001",
            "vat_included": false,
            "vat_percentage": 7,
            "occupied_total_amount": "1500.0",
            "additional_total_amount": "0.0",
            "total_amount": "1500.0",
            "amount_before_vat": "0.0",
            "vat_amount": "0.0",
            "paid_before_amount": "0.0",
            "remain_amount": "1500.0",
            "remark": "testrrrsss",
            "internal_note": "testrrrwww",
            "payment_info": "2, 2 (111-1-11111-2)",
            "group_room_charge": true,
            "group_additional_item": false,
            "created_at": "2023-06-09T13:31:11.727+07:00",
            "updated_at": "2023-09-12T17:39:27.760+07:00",
            "receipt_ids": [],
            "hotel_id": 105,
            "hotel_contact_id": 8,
            "customer_contact_id": 6
        }
        """.data(using: .utf8)!
        
        // Act
        let folioForm = try JSONDecoder().decode(FolioForm.self, from: json)
        
        // Assert
        XCTAssertEqual(folioForm.id, 1)
        XCTAssertEqual(folioForm.status, .active)
        XCTAssertEqual(folioForm.number, "F20230600001")
        XCTAssertEqual(folioForm.vatIncluded, false)
        XCTAssertEqual(folioForm.vatPercentage, 7)
        XCTAssertEqual(folioForm.occupiedTotalAmount, 1500.0)
        XCTAssertEqual(folioForm.additionalTotalAmount, 0.0)
        XCTAssertEqual(folioForm.totalAmount, 1500.0)
        XCTAssertEqual(folioForm.amountBeforeVat, 0.0)
        XCTAssertEqual(folioForm.vatAmount, 0.0)
        XCTAssertEqual(folioForm.paidBeforeAmount, 0.0)
        XCTAssertEqual(folioForm.remainAmount, 1500.0)
        XCTAssertEqual(folioForm.remark, "testrrrsss")
        XCTAssertEqual(folioForm.internalNote, "testrrrwww")
        XCTAssertEqual(folioForm.paymentInfo, "2, 2 (111-1-11111-2)")
        XCTAssertEqual(folioForm.groupRoomCharge, true)
        XCTAssertEqual(folioForm.groupAdditionalItem, false)
        XCTAssertEqual(folioForm.receiptIds, [])
        XCTAssertEqual(folioForm.hotelId, 105)
        XCTAssertEqual(folioForm.hotelContactId, 8)
        XCTAssertEqual(folioForm.customerContactId, 6)
        XCTAssertNil(folioForm.canceledAt)
        XCTAssertNotNil(folioForm.createdAt)
        XCTAssertNotNil(folioForm.updatedAt)
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let folioForm = createSampleFolioForm()
        
        // Act
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(folioForm)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        
        // Assert
        XCTAssertTrue(jsonString.contains("\"id\" : 1"))
        XCTAssertTrue(jsonString.contains("\"status\" : \"ACTIVE\""))
        XCTAssertTrue(jsonString.contains("\"number\" : \"F20230600001\""))
        XCTAssertTrue(jsonString.contains("\"vat_included\" : false"))
        XCTAssertTrue(jsonString.contains("\"vat_percentage\" : 7"))
        XCTAssertTrue(jsonString.contains("\"occupied_total_amount\" : \"1500.0\""))
        XCTAssertTrue(jsonString.contains("\"additional_total_amount\" : \"0.0\""))
        XCTAssertTrue(jsonString.contains("\"total_amount\" : \"1500.0\""))
        XCTAssertTrue(jsonString.contains("\"amount_before_vat\" : \"0.0\""))
        XCTAssertTrue(jsonString.contains("\"vat_amount\" : \"0.0\""))
        XCTAssertTrue(jsonString.contains("\"paid_before_amount\" : \"0.0\""))
        XCTAssertTrue(jsonString.contains("\"remain_amount\" : \"1500.0\""))
        XCTAssertTrue(jsonString.contains("\"remark\" : \"testrrrsss\""))
        XCTAssertTrue(jsonString.contains("\"internal_note\" : \"testrrrwww\""))
        XCTAssertTrue(jsonString.contains("\"payment_info\" : \"2, 2 (111-1-11111-2)\""))
        XCTAssertTrue(jsonString.contains("\"group_room_charge\" : true"))
        XCTAssertTrue(jsonString.contains("\"group_additional_item\" : false"))
        XCTAssertTrue(jsonString.contains("\"hotel_id\" : 105"))
        XCTAssertTrue(jsonString.contains("\"hotel_contact_id\" : 8"))
        XCTAssertTrue(jsonString.contains("\"customer_contact_id\" : 6"))
    }
    
    func test_decodingFromJSONWithCancelledStatus() throws {
        // Arrange
        let json = """
        {
            "id": 2,
            "status": "CANCELLED",
            "cancelled_at": "2023-06-10T14:35:57.177+07:00",
            "number": "F20230600002",
            "vat_included": true,
            "vat_percentage": 10,
            "occupied_total_amount": "2000.0",
            "additional_total_amount": "100.0",
            "total_amount": "2100.0",
            "amount_before_vat": "1909.09",
            "vat_amount": "190.91",
            "paid_before_amount": "500.0",
            "remain_amount": "1600.0",
            "remark": "cancelled order",
            "internal_note": "cancelled by customer",
            "payment_info": "3, 3 (222-2-22222-3)",
            "group_room_charge": false,
            "group_additional_item": true,
            "created_at": "2023-06-09T13:31:11.727+07:00",
            "updated_at": "2023-09-12T17:39:27.760+07:00",
            "receipt_ids": [1, 2, 3],
            "hotel_id": 106,
            "hotel_contact_id": 9,
            "customer_contact_id": 7
        }
        """.data(using: .utf8)!
        
        // Act
        let folioForm = try JSONDecoder().decode(FolioForm.self, from: json)
        
        // Assert
        XCTAssertEqual(folioForm.id, 2)
        XCTAssertEqual(folioForm.status, .cancelled)
        XCTAssertEqual(folioForm.number, "F20230600002")
        XCTAssertEqual(folioForm.vatIncluded, true)
        XCTAssertEqual(folioForm.vatPercentage, 10)
        XCTAssertEqual(folioForm.occupiedTotalAmount, 2000.0)
        XCTAssertEqual(folioForm.additionalTotalAmount, 100.0)
        XCTAssertEqual(folioForm.totalAmount, 2100.0)
        XCTAssertEqual(folioForm.amountBeforeVat, 1909.09)
        XCTAssertEqual(folioForm.vatAmount, 190.91)
        XCTAssertEqual(folioForm.paidBeforeAmount, 500.0)
        XCTAssertEqual(folioForm.remainAmount, 1600.0)
        XCTAssertEqual(folioForm.remark, "cancelled order")
        XCTAssertEqual(folioForm.internalNote, "cancelled by customer")
        XCTAssertEqual(folioForm.paymentInfo, "3, 3 (222-2-22222-3)")
        XCTAssertEqual(folioForm.groupRoomCharge, false)
        XCTAssertEqual(folioForm.groupAdditionalItem, true)
        XCTAssertEqual(folioForm.receiptIds, [1, 2, 3])
        XCTAssertEqual(folioForm.hotelId, 106)
        XCTAssertEqual(folioForm.hotelContactId, 9)
        XCTAssertEqual(folioForm.customerContactId, 7)
        XCTAssertNotNil(folioForm.canceledAt)
        XCTAssertNotNil(folioForm.createdAt)
        XCTAssertNotNil(folioForm.updatedAt)
    }

    // MARK: - Helper Methods
    
    private func createSampleFolioForm() -> FolioForm {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        return FolioForm(
            id: 1,
            status: .active,
            number: "F20230600001",
            vatIncluded: false,
            vatPercentage: 7,
            occupiedTotalAmount: 1500.0,
            additionalTotalAmount: 0.0,
            totalAmount: 1500.0,
            amountBeforeVat: 0.0,
            vatAmount: 0.0,
            paidBeforeAmount: 0.0,
            remainAmount: 1500.0,
            remark: "testrrrsss",
            internalNote: "testrrrwww",
            paymentInfo: "2, 2 (111-1-11111-2)",
            groupRoomCharge: true,
            groupAdditionalItem: false,
            receiptIds: [],
            hotelId: 105,
            hotelContactId: 8,
            customerContactId: 6,
            canceledAt: nil,
            createdAt: dateFormatter.date(from: "2023-06-09T13:31:11.727+07:00")!,
            updatedAt: dateFormatter.date(from: "2023-09-12T17:39:27.760+07:00")!
        )
    }
} 
