//
//  ReceiptServiceRequestTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest


class ReceiptServiceRequestTests: XCTestCase {
    
    // MARK: - FetchByHotel Tests
    
    func test_fetchByHotel_withAllParameters_correctSerialization() throws {
        // Arrange
        let request = ReceiptServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func test_fetchByHotel_withMinimalParameters_correctSerialization() throws {
        // Arrange
        let request = ReceiptServiceRequest.FetchByHotel(
            hotelId: 105,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
    }
    
    func test_fetchByHotel_withPageZero_excludesPageFromParameters() throws {
        // Arrange
        let request = ReceiptServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 0,
            perPage: .fifty,
            sortedBy: .number,
            sortedOrder: .descending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNil(parameters?["page"]) // Should be excluded because page < 1
        XCTAssertEqual(parameters?["per_page"] as? String, "50")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "NUMBER")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    // MARK: - FetchByQuery Tests
    
    func test_fetchByQuery_withAllParameters_correctSerialization() throws {
        // Arrange
        let request = ReceiptServiceRequest.FetchByQuery(
            hotelId: 105,
            query: "RI20221100001",
            page: 2,
            perPage: .hundred,
            sortedBy: .createdAt,
            sortedOrder: .ascending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["query"] as? String, "RI20221100001")
        XCTAssertEqual(parameters?["page"] as? Int, 2)
        XCTAssertEqual(parameters?["per_page"] as? String, "100")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "CREATED_AT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func test_fetchByQuery_withMinimalParameters_correctSerialization() throws {
        // Arrange
        let request = ReceiptServiceRequest.FetchByQuery(
            hotelId: 105,
            query: "receipt",
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["query"] as? String, "receipt")
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
    }
    
    // MARK: - FetchByPeriod Tests
    
    func test_fetchByPeriod_withAllParameters_correctSerialization() throws {
        // Arrange
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate)!
        let period = PeriodDate(start: startDate, end: endDate)
        
        let request = ReceiptServiceRequest.FetchByPeriod(
            hotelId: 105,
            period: period,
            page: 1,
            perPage: .ten,
            sortedBy: .paidDate,
            sortedOrder: .descending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNotNil(parameters?["start_date"] as? String)
        XCTAssertNotNil(parameters?["end_date"] as? String)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "10")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "PAID_DATE")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    func test_fetchByPeriod_withMinimalParameters_correctSerialization() throws {
        // Arrange
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
        let period = PeriodDate(start: startDate, end: endDate)
        
        let request = ReceiptServiceRequest.FetchByPeriod(
            hotelId: 105,
            period: period,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNotNil(parameters?["start_date"] as? String)
        XCTAssertNotNil(parameters?["end_date"] as? String)
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
    }
    
    // MARK: - FetchByReservation Tests
    
    func test_fetchByReservation_withAllParameters_correctSerialization() throws {
        // Arrange
        let request = ReceiptServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 123,
            page: 1,
            perPage: .twenty,
            sortedBy: .updatedAt,
            sortedOrder: .ascending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["reservation_id"] as? Int, 123)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "UPDATED_AT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func test_fetchByReservation_withMinimalParameters_correctSerialization() throws {
        // Arrange
        let request = ReceiptServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 456,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["reservation_id"] as? Int, 456)
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
    }
    
    // MARK: - FetchByFolioForm Tests
    
    func test_fetchByFolioForm_withAllParameters_correctSerialization() throws {
        // Arrange
        let request = ReceiptServiceRequest.FetchByFolioForm(
            hotelId: 105,
            folioFormId: 789,
            page: 2,
            perPage: .fifty,
            sortedBy: .id,
            sortedOrder: .descending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["folio_form_id"] as? Int, 789)
        XCTAssertEqual(parameters?["page"] as? Int, 2)
        XCTAssertEqual(parameters?["per_page"] as? String, "50")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    // MARK: - FetchByFinancialRecord Tests
    
    func test_fetchByFinancialRecord_withAllParameters_correctSerialization() throws {
        // Arrange
        let request = ReceiptServiceRequest.FetchByFinancialRecord(
            hotelId: 105,
            financialRecordId: 321,
            page: 3,
            perPage: .hundred,
            sortedBy: .number,
            sortedOrder: .ascending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["financial_record_id"] as? Int, 321)
        XCTAssertEqual(parameters?["page"] as? Int, 3)
        XCTAssertEqual(parameters?["per_page"] as? String, "100")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "NUMBER")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    // MARK: - CreateFromFinancialRecord Tests
    
    func test_createFromFinancialRecord_withAllParameters_correctBodySerialization() throws {
        // Arrange
        let request = ReceiptServiceRequest.CreateFromFinancialRecord(
            hotelId: 105,
            financialRecordId: 789,
            payerContactId: 4,
            receiverContactId: 5,
            remark: "Test receipt",
            internalNote: "Internal note for testing"
        )
        
        // Act
        let bodyData = request.body
        
        // Assert
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["financial_record_id"] as? Int, 789)
        XCTAssertEqual(json?["payer_id"] as? Int, 4)
        XCTAssertEqual(json?["receiver_id"] as? Int, 5)
        XCTAssertEqual(json?["remark"] as? String, "Test receipt")
        XCTAssertEqual(json?["internal_note"] as? String, "Internal note for testing")
    }
    
    func test_createFromFinancialRecord_withMinimalParameters_correctBodySerialization() throws {
        // Arrange
        let request = ReceiptServiceRequest.CreateFromFinancialRecord(
            hotelId: 105,
            financialRecordId: 789,
            payerContactId: 4,
            receiverContactId: 4,
            remark: nil,
            internalNote: nil
        )
        
        // Act
        let bodyData = request.body
        
        // Assert
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["financial_record_id"] as? Int, 789)
        XCTAssertEqual(json?["payer_id"] as? Int, 4)
        XCTAssertEqual(json?["receiver_id"] as? Int, 4)
        
        // Nil values should be present in JSON as NSNull or excluded
        let remarkExists = json?.keys.contains("remark") ?? false
        let noteExists = json?.keys.contains("internal_note") ?? false
        if remarkExists {
            XCTAssertTrue(json?["remark"] is NSNull)
        }
        if noteExists {
            XCTAssertTrue(json?["internal_note"] is NSNull)
        }
    }
    
    // MARK: - CreateFromFolioForm Tests
    
    func test_createFromFolioForm_withAllParameters_correctBodySerialization() throws {
        // Arrange
        let request = ReceiptServiceRequest.CreateFromFolioForm(hotelId: 105,
         folioFormId: 456,
          paidDate: Date(timeIntervalSince1970: 1704067200), // January 1, 2024 00:00:00 UTC
           payerContactId: 4, 
           receiverContactId: 6,
            remark: "Folio form receipt",
             internalNote: "Generated from folio form", 
             roomItemGrouped: true, 
             additionalItemGrouped: true, 
             otherItemGrouped: true)
        
        // Act
        let bodyData = request.body
        
        // Assert
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["folio_form_id"] as? Int, 456)
        XCTAssertEqual(json?["paid_date"] as? String, "2024-01-01")
        XCTAssertEqual(json?["payer_id"] as? Int, 4)
        XCTAssertEqual(json?["receiver_id"] as? Int, 6)
        XCTAssertEqual(json?["remark"] as? String, "Folio form receipt")
        XCTAssertEqual(json?["internal_note"] as? String, "Generated from folio form")
        XCTAssertEqual(json?["room_item_grouped"] as? Bool, true)
        XCTAssertEqual(json?["additional_item_grouped"] as? Bool, true)
        XCTAssertEqual(json?["other_item_grouped"] as? Bool, true)
    }
    
    // MARK: - CreateFromFolioFormVat Tests
    
    func test_createFromFolioFormVat_withAllParameters_correctBodySerialization() throws {
        // Arrange
        let request = ReceiptServiceRequest.CreateFromFolioFormVat(
            hotelId: 105,
            folioFormId: 456,
            paidDate: Date(timeIntervalSince1970: 1704067200), // January 1, 2024 00:00:00 UTC
            payerContactId: 4,
            receiverContactId: 4,
            remark: "VAT receipt",
            internalNote: "With VAT calculations",
            roomItemGrouped: true,
            additionalItemGrouped: true,
            otherItemGrouped: true
        )
        
        
        // Act
        let bodyData = request.body
        
        // Assert
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["folio_form_id"] as? Int, 456)
        XCTAssertEqual(json?["paid_date"] as? String, "2024-01-01")
        XCTAssertEqual(json?["payer_id"] as? Int, 4)
        XCTAssertEqual(json?["receiver_id"] as? Int, 4)
        XCTAssertEqual(json?["remark"] as? String, "VAT receipt")
        XCTAssertEqual(json?["internal_note"] as? String, "With VAT calculations")
        XCTAssertEqual(json?["room_item_grouped"] as? Bool, true)
        XCTAssertEqual(json?["additional_item_grouped"] as? Bool, true)
        XCTAssertEqual(json?["other_item_grouped"] as? Bool, true)
    }
    
    func test_createFromFolioFormVat_withMinimalVat_correctBodySerialization() throws {
        // Arrange
        let request = ReceiptServiceRequest.CreateFromFolioFormVat(
            hotelId: 105,
            folioFormId: 456,
            paidDate: Date(timeIntervalSince1970: 1704067200), // January 1, 2024 00:00:00 UTC
            payerContactId: 4,
            receiverContactId: 4,
            remark: "VAT receipt",
            internalNote: "With VAT calculations",
            roomItemGrouped: true,
            additionalItemGrouped: true,
            otherItemGrouped: true
        )
        
        // Act
        let bodyData = request.body
        
        // Assert
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["folio_form_id"] as? Int, 456)
        XCTAssertEqual(json?["paid_date"] as? String, "2024-01-01")
        XCTAssertEqual(json?["payer_id"] as? Int, 4)
        XCTAssertEqual(json?["receiver_id"] as? Int, 4)
        XCTAssertEqual(json?["remark"] as? String, "VAT receipt")
        XCTAssertEqual(json?["internal_note"] as? String, "With VAT calculations")
        XCTAssertEqual(json?["room_item_grouped"] as? Bool, true)
        XCTAssertEqual(json?["additional_item_grouped"] as? Bool, true)
        XCTAssertEqual(json?["other_item_grouped"] as? Bool, true)
    }
    
    // MARK: - VoidReceiptRequest Tests
    
    func test_voidReceiptRequest_correctBodySerialization() throws {
        // Arrange
        let request = ReceiptServiceRequest.VoidReceiptRequest(
            id: 3,
            voidReason: "Error in calculation"
        )
        
        // Act
        let bodyData = request.body
        
        // Assert
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["void_reason"] as? String, "Error in calculation")
        
        // ID should not be in the body (it's in the URL path)
        XCTAssertNil(json?["id"])
    }
    
    func test_voidReceiptRequest_encoding_excludesId() throws {
        // Arrange
        let request = ReceiptServiceRequest.VoidReceiptRequest(
            id: 3,
            voidReason: "System error"
        )
        
        // Act
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["void_reason"] as? String, "System error")
        XCTAssertNil(json?["id"]) // Should be excluded from encoding
    }
    
    // MARK: - CancelReceiptRequest Tests
    
    func test_cancelReceiptRequest_correctBodySerialization() throws {
        // Arrange
        let request = ReceiptServiceRequest.CancelReceiptRequest(
            id: 3,
            cancelReason: "Customer request"
        )
        
        // Act
        let bodyData = request.body
        
        // Assert
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["cancel_reason"] as? String, "Customer request")
        
        // ID should not be in the body (it's in the URL path)
        XCTAssertNil(json?["id"])
    }
    
    func test_cancelReceiptRequest_encoding_excludesId() throws {
        // Arrange
        let request = ReceiptServiceRequest.CancelReceiptRequest(
            id: 3,
            cancelReason: "Duplicate receipt"
        )
        
        // Act
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["cancel_reason"] as? String, "Duplicate receipt")
        XCTAssertNil(json?["id"]) // Should be excluded from encoding
    }
    
    // MARK: - SortedBy Enum Tests
    
    func test_sortedByEnum_allCases_correctRawValues() {
        // Assert
        XCTAssertEqual(ReceiptServiceRequest.SortedBy.id.rawValue, "ID")
        XCTAssertEqual(ReceiptServiceRequest.SortedBy.number.rawValue, "NUMBER")
        XCTAssertEqual(ReceiptServiceRequest.SortedBy.createdAt.rawValue, "CREATED_AT")
        XCTAssertEqual(ReceiptServiceRequest.SortedBy.updatedAt.rawValue, "UPDATED_AT")
        XCTAssertEqual(ReceiptServiceRequest.SortedBy.paidDate.rawValue, "PAID_DATE")
    }
    
    // MARK: - ByID Tests
    
    func test_byID_initialization() {
        // Arrange & Act
        let request = ReceiptServiceRequest.ByID(id: 123)
        
        // Assert
        XCTAssertEqual(request.id, 123)
    }
    
    // MARK: - TypeAlias Tests
    
    func test_typeAliases_correctTypes() {
        // Arrange & Act
        let fetchById: ReceiptServiceRequest.FetchById = ReceiptServiceRequest.ByID(id: 1)
        let cancelReceipt: ReceiptServiceRequest.CancelReceipt = ReceiptServiceRequest.ByID(id: 2)
        let voidReceipt: ReceiptServiceRequest.VoidReceipt = ReceiptServiceRequest.ByID(id: 3)
        let previewEmail: ReceiptServiceRequest.PreviewEmail = ReceiptServiceRequest.ByID(id: 4)
        let previewPDF: ReceiptServiceRequest.PreviewPDF = ReceiptServiceRequest.ByID(id: 5)
        let exportPDF: ReceiptServiceRequest.ExportPDF = ReceiptServiceRequest.ByID(id: 6)
        let exportImage: ReceiptServiceRequest.ExportImage = ReceiptServiceRequest.ByID(id: 7)
        
        // Assert - TypeAliases should work correctly
        XCTAssertEqual(fetchById.id, 1)
        XCTAssertEqual(cancelReceipt.id, 2)
        XCTAssertEqual(voidReceipt.id, 3)
        XCTAssertEqual(previewEmail.id, 4)
        XCTAssertEqual(previewPDF.id, 5)
        XCTAssertEqual(exportPDF.id, 6)
        XCTAssertEqual(exportImage.id, 7)
    }
    
    // MARK: - Edge Cases
    
    func test_fetchRequest_withInvalidPage_excludesFromParameters() throws {
        // Arrange
        let request = ReceiptServiceRequest.FetchByHotel(
            hotelId: 105,
            page: -1, // Invalid page
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertNil(parameters?["page"]) // Should be excluded because page < 1
    }
    
    func test_createRequest_withEmptyStrings_includesInBody() throws {
        // Arrange
        let request = ReceiptServiceRequest.CreateFromFinancialRecord(
            hotelId: 105,
            financialRecordId: 789,
            payerContactId: 4,
            receiverContactId: 4,
            remark: "",
            internalNote: ""
        )
        
        // Act
        let bodyData = request.body
        
        // Assert
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["remark"] as? String, "")
        XCTAssertEqual(json?["internal_note"] as? String, "")
    }
} 
