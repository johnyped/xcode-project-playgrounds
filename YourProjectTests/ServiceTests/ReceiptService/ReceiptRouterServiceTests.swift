//
//  ReceiptRouterServiceTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest


class ReceiptRouterServiceTests: XCTestCase {
    
    // MARK: - Test fetchByHotel
    
    func test_fetchByHotel_correctPath() throws {
        // Arrange
        let request = ReceiptServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        let router = ReceiptServiceRouter.fetchByHotel(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/receipts") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("hotel_id=105") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("page=1") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("per_page=20") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("sorted_by=ID") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("sorted_order=ASC") ?? false)
    }
    
    // MARK: - Test fetchByQuery
    
    func test_fetchByQuery_correctPath() throws {
        // Arrange
        let request = ReceiptServiceRequest.FetchByQuery(
            hotelId: 105,
            query: "RI20221100001",
            page: 1,
            perPage: .fifty,
            sortedBy: .number,
            sortedOrder: .descending
        )
        let router = ReceiptServiceRouter.fetchByQuery(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/receipts/query") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("hotel_id=105") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("query=RI20221100001") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("sorted_by=NUMBER") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("sorted_order=DESC") ?? false)
    }
    
    // MARK: - Test fetchByPeriod
    
    func test_fetchByPeriod_correctPath() throws {
        // Arrange
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate)!
        let period = PeriodDate(start: startDate, end: endDate)
        
        let request = ReceiptServiceRequest.FetchByPeriod(
            hotelId: 105,
            period: period,
            page: 2,
            perPage: .hundred,
            sortedBy: .paidDate,
            sortedOrder: .ascending
        )
        let router = ReceiptServiceRouter.fetchByPeriod(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/receipts/period") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("hotel_id=105") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("page=2") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("per_page=100") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("sorted_by=PAID_DATE") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("start_date=") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("end_date=") ?? false)
    }
    
    // MARK: - Test fetchByReservation
    
    func test_fetchByReservation_correctPath() throws {
        // Arrange
        let request = ReceiptServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 123,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        let router = ReceiptServiceRouter.fetchByReservation(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/receipts/reservation") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("hotel_id=105") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("reservation_id=123") ?? false)
    }
    
    // MARK: - Test fetchByFolioForm
    
    func test_fetchByFolioForm_correctPath() throws {
        // Arrange
        let request = ReceiptServiceRequest.FetchByFolioForm(
            hotelId: 105,
            folioFormId: 456,
            page: 1,
            perPage: .ten,
            sortedBy: .createdAt,
            sortedOrder: .descending
        )
        let router = ReceiptServiceRouter.fetchByFolioForm(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/receipts/folio-form") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("hotel_id=105") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("folio_form_id=456") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("sorted_by=CREATED_AT") ?? false)
    }
    
    // MARK: - Test fetchByFinancialRecord
    
    func test_fetchByFinancialRecord_correctPath() throws {
        // Arrange
        let request = ReceiptServiceRequest.FetchByFinancialRecord(
            hotelId: 105,
            financialRecordId: 789,
            page: 1,
            perPage: .twenty,
            sortedBy: .updatedAt,
            sortedOrder: .ascending
        )
        let router = ReceiptServiceRouter.fetchByFinancialRecord(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/receipts/financial-record") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("hotel_id=105") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("financial_record_id=789") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("sorted_by=UPDATED_AT") ?? false)
    }
    
    // MARK: - Test fetchById
    
    func test_fetchById_correctPath() throws {
        // Arrange
        let request = ReceiptServiceRequest.FetchById(id: 3)
        let router = ReceiptServiceRouter.fetchById(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/receipts/3") ?? false)
        XCTAssertEqual(urlRequest.httpBody, nil)
    }
    
    // MARK: - Test createFromFinancialRecord
    
    func test_createFromFinancialRecord_correctPath() throws {
        // Arrange
        let request = ReceiptServiceRequest.CreateFromFinancialRecord(
            hotelId: 105,
            financialRecordId: 789,
            payerContactId: 4,
            receiverContactId: 4,
            remark: "Test receipt",
            internalNote: "Internal note"
        )
        let router = ReceiptServiceRouter.createFromFinancialRecord(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/receipts/financial-record") ?? false)
        XCTAssertNotNil(urlRequest.httpBody)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    // MARK: - Test createFromFolioForm
    
    func test_createFromFolioForm_correctPath() throws {
        // Arrange
        let request = ReceiptServiceRequest.CreateFromFolioForm(
            hotelId: 105,
            folioFormId: 456,
            paidDate: Date(),
            payerContactId: 4,
            receiverContactId: 4,
            remark: nil,
            internalNote: nil,
            roomItemGrouped: true,
            additionalItemGrouped: false,
            otherItemGrouped: true
        )
        let router = ReceiptServiceRouter.createFromFolioForm(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/receipts/folio-form") ?? false)
        XCTAssertNotNil(urlRequest.httpBody)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    // MARK: - Test createFromFolioFormVat
    
    func test_createFromFolioFormVat_correctPath() throws {
        // Arrange
        let request = ReceiptServiceRequest.CreateFromFolioFormVat(
            hotelId: 105,
            folioFormId: 456,
            paidDate: Date(),
            payerContactId: 4,
            receiverContactId: 4,
            remark: "VAT receipt",
            internalNote: "With VAT calculations",
            roomItemGrouped: true,
            additionalItemGrouped: false,
            otherItemGrouped: true
        )
        let router = ReceiptServiceRouter.createFromFolioFormVat(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/receipts/folio-form-vat") ?? false)
        XCTAssertNotNil(urlRequest.httpBody)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    // MARK: - Test cancelReceipt
    
    func test_cancelReceipt_correctPath() throws {
        // Arrange
        let request = ReceiptServiceRequest.CancelReceiptRequest(
            id: 3,
            cancelReason: "Customer request"
        )
        let router = ReceiptServiceRouter.cancelReceipt(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/receipts/3/cancel") ?? false)
        XCTAssertNotNil(urlRequest.httpBody)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    // MARK: - Test voidReceipt
    
    func test_voidReceipt_correctPath() throws {
        // Arrange
        let request = ReceiptServiceRequest.VoidReceiptRequest(
            id: 3,
            voidReason: "Error in calculation"
        )
        let router = ReceiptServiceRouter.voidReceipt(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/receipts/3/void") ?? false)
        XCTAssertNotNil(urlRequest.httpBody)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    // MARK: - Test previewEmail
    
    func test_previewEmail_correctPath() throws {
        // Arrange
        let request = ReceiptServiceRequest.PreviewEmail(id: 3)
        let router = ReceiptServiceRouter.previewEmail(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/receipts/3/preview-email") ?? false)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    // MARK: - Test previewPDF
    
    func test_previewPDF_correctPath() throws {
        // Arrange
        let request = ReceiptServiceRequest.PreviewPDF(id: 3)
        let router = ReceiptServiceRouter.previewPDF(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/receipts/3/preview-pdf") ?? false)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    // MARK: - Test exportPDF
    
    func test_exportPDF_correctPath() throws {
        // Arrange
        let request = ReceiptServiceRequest.ExportPDF(id: 3)
        let router = ReceiptServiceRouter.exportPDF(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/receipts/3/pdf") ?? false)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    // MARK: - Test exportImage
    
    func test_exportImage_correctPath() throws {
        // Arrange
        let request = ReceiptServiceRequest.ExportImage(id: 3)
        let router = ReceiptServiceRouter.exportImage(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/receipts/3/image") ?? false)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    // MARK: - Test Request Body Content
    
    func test_createFromFinancialRecord_bodyContent() throws {
        // Arrange
        let request = ReceiptServiceRequest.CreateFromFinancialRecord(
            hotelId: 105,
            financialRecordId: 789,
            payerContactId: 4,
            receiverContactId: 4,
            remark: "Test receipt",
            internalNote: "Internal note"
        )
        let router = ReceiptServiceRouter.createFromFinancialRecord(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertNotNil(urlRequest.httpBody)
        
        if let bodyData = urlRequest.httpBody,
           let bodyDict = try JSONSerialization.jsonObject(with: bodyData) as? [String: Any] {
            XCTAssertEqual(bodyDict["hotel_id"] as? Int, 105)
            XCTAssertEqual(bodyDict["financial_record_id"] as? Int, 789)
            XCTAssertEqual(bodyDict["payer_id"] as? Int, 4)
            XCTAssertEqual(bodyDict["receiver_id"] as? Int, 4)
            XCTAssertEqual(bodyDict["remark"] as? String, "Test receipt")
            XCTAssertEqual(bodyDict["internal_note"] as? String, "Internal note")
        } else {
            XCTFail("Failed to parse request body")
        }
    }
    
    func test_cancelReceipt_bodyContent() throws {
        // Arrange
        let request = ReceiptServiceRequest.CancelReceiptRequest(
            id: 3,
            cancelReason: "Customer request"
        )
        let router = ReceiptServiceRouter.cancelReceipt(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertNotNil(urlRequest.httpBody)
        
        if let bodyData = urlRequest.httpBody,
           let bodyDict = try JSONSerialization.jsonObject(with: bodyData) as? [String: Any] {
            XCTAssertEqual(bodyDict["cancel_reason"] as? String, "Customer request")
        } else {
            XCTFail("Failed to parse request body")
        }
    }
    
    func test_voidReceipt_bodyContent() throws {
        // Arrange
        let request = ReceiptServiceRequest.VoidReceiptRequest(
            id: 3,
            voidReason: "Error in calculation"
        )
        let router = ReceiptServiceRouter.voidReceipt(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertNotNil(urlRequest.httpBody)
        
        if let bodyData = urlRequest.httpBody,
           let bodyDict = try JSONSerialization.jsonObject(with: bodyData) as? [String: Any] {
            XCTAssertEqual(bodyDict["void_reason"] as? String, "Error in calculation")
        } else {
            XCTFail("Failed to parse request body")
        }
    }
} 
