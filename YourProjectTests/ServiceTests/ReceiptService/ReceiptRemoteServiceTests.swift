//
//  ReceiptRemoteServiceTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest
import Mockable


class ReceiptRemoteServiceTests: XCTestCase {
    
    var sut: ReceiptRemoteService!
    var mockAPIManager: MockAPIManagerProtocal!
    var mockLocalStorage: MockLocalStorageManagerProtocal!
    
    override func setUp() {
        super.setUp()
        mockAPIManager = MockAPIManagerProtocal()
        mockLocalStorage = MockLocalStorageManagerProtocal()
        sut = ReceiptRemoteService(localStorage: mockLocalStorage, apiManager: mockAPIManager)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIManager = nil
        mockLocalStorage = nil
        super.tearDown()
    }
    
    // MARK: - Test fetchByHotel
    
    func test_fetchByHotel_success() async throws {
        // Arrange
        let request = ReceiptServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        let expectedReceipts = createMockReceiptsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReceipts)
        
        // Act
        let result = try await sut.fetchByHotel(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems , expectedReceipts.totalItems)
        XCTAssertEqual(result.items.first?.id, expectedReceipts.items.first?.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_fetchByHotel_failure() async throws {
        // Arrange
        let request = ReceiptServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        let error = APIError.unknownError(title: "Stub Error",
                                          subtitle: nil,
                                          underlying: nil)
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce{ (a,b) -> Paginator<Receipt> in
                throw error
            }
        
        // Act & Assert
        do {
            _ = try await sut.fetchByHotel(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error as? APIError {
            case .unknownError(let title, _ , _):
                XCTAssertEqual(title, "Stub Error")
            default:
                XCTFail("Unexpected error type")
            }
        }
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchByQuery
    
    func test_fetchByQuery_success() async throws {
        // Arrange
        let request = ReceiptServiceRequest.FetchByQuery(
            hotelId: 105,
            query: "RI20221100001",
            page: 1,
            perPage: .twenty,
            sortedBy: .number,
            sortedOrder: .descending
        )
        
        let expectedReceipts = createMockReceiptsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReceipts)
        
        // Act
        let result = try await sut.fetchByQuery(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedReceipts.totalItems)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchByPeriod
    
    func test_fetchByPeriod_success() async throws {
        // Arrange
        let startDate = Date(timeIntervalSince1970: 1669075200)
        let endDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate)!
        let period = PeriodDate(start: startDate, end: endDate)
        
        let request = ReceiptServiceRequest.FetchByPeriod(
            hotelId: 105,
            period: period,
            page: 1,
            perPage: .fifty,
            sortedBy: .paidDate,
            sortedOrder: .ascending
        )
        
        let expectedReceipts = createMockReceiptsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReceipts)
        
        // Act
        let result = try await sut.fetchByPeriod(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedReceipts.totalItems)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchByReservation
    
    func test_fetchByReservation_success() async throws {
        // Arrange
        let request = ReceiptServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 123,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        let expectedReceipts = createMockReceiptsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReceipts)
        
        // Act
        let result = try await sut.fetchByReservation(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedReceipts.totalItems)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchByFolioForm
    
    func test_fetchByFolioForm_success() async throws {
        // Arrange
        let request = ReceiptServiceRequest.FetchByFolioForm(
            hotelId: 105,
            folioFormId: 456,
            page: 1,
            perPage: .ten,
            sortedBy: .createdAt,
            sortedOrder: .descending
        )
        
        let expectedReceipts = createMockReceiptsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReceipts)
        
        // Act
        let result = try await sut.fetchByFolioForm(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedReceipts.totalItems)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchByFinancialRecord
    
    func test_fetchByFinancialRecord_success() async throws {
        // Arrange
        let request = ReceiptServiceRequest.FetchByFinancialRecord(
            hotelId: 105,
            financialRecordId: 789,
            page: 1,
            perPage: .hundred,
            sortedBy: .updatedAt,
            sortedOrder: .ascending
        )
        
        let expectedReceipts = createMockReceiptsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReceipts)
        
        // Act
        let result = try await sut.fetchByFinancialRecord(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedReceipts.totalItems)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchById
    
    func test_fetchById_success() async throws {
        // Arrange
        let request = ReceiptServiceRequest.FetchById(id: 3)
        let expectedReceipt = createMockReceipt()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReceipt)
        
        // Act
        let result = try await sut.fetchById(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedReceipt.id)        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test createFromFinancialRecord
    
    func test_createFromFinancialRecord_success() async throws {
        // Arrange
        let request = ReceiptServiceRequest.CreateFromFinancialRecord(
            hotelId: 105,
            financialRecordId: 789,
            payerContactId: 4,
            receiverContactId: 4,
            remark: "Test receipt",
            internalNote: "Internal note"
        )
        
        let expectedReceipt = createMockReceipt()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReceipt)
        
        // Act
        let result = try await sut.createFromFinancialRecord(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedReceipt.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test createFromFolioForm
    
    func test_createFromFolioForm_success() async throws {
        // Arrange
        let request = ReceiptServiceRequest.CreateFromFolioForm(
            hotelId: 105,
            folioFormId: 456,
            paidDate: Date(timeIntervalSince1970: 1669075200),
            payerContactId: 4,
            receiverContactId: 4,
            remark: nil,
            internalNote: nil,
            roomItemGrouped: true,
            additionalItemGrouped: false,
            otherItemGrouped: true
        )
        
        let expectedReceipt = createMockReceipt()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReceipt)
        
        // Act
        let result = try await sut.createFromFolioForm(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedReceipt.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test createFromFolioFormVat
    
    func test_createFromFolioFormVat_success() async throws {
        // Arrange
        let request = ReceiptServiceRequest.CreateFromFolioFormVat(
            hotelId: 105,
            folioFormId: 456,
            paidDate: Date(timeIntervalSince1970: 1669075200),
            payerContactId: 4,
            receiverContactId: 4,
            remark: "VAT receipt",
            internalNote: "With VAT calculations",
            roomItemGrouped: true,
            additionalItemGrouped: false,
            otherItemGrouped: true
        )
        
        let expectedReceipt = createMockReceipt()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReceipt)
        
        // Act
        let result = try await sut.createFromFolioFormVat(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedReceipt.id)
        XCTAssertEqual(result.vatIncluded, true)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test cancelReceipt
    
    func test_cancelReceipt_success() async throws {
        // Arrange
        let request = ReceiptServiceRequest.CancelReceiptRequest(
            id: 3,
            cancelReason: "Customer request"
        )
        
        let expectedReceipt = createMockCancelledReceipt()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReceipt)
        
        // Act
        let result = try await sut.cancelReceipt(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedReceipt.id)
        XCTAssertEqual(result.status, .cancelled)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test voidReceipt
    
    func test_voidReceipt_success() async throws {
        // Arrange
        let request = ReceiptServiceRequest.VoidReceiptRequest(
            id: 3,
            voidReason: "Error in calculation"
        )
        
        let expectedReceipt = createMockVoidedReceipt()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReceipt)
        
        // Act
        let result = try await sut.voidReceipt(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedReceipt.id)
        XCTAssertEqual(result.status, .void)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test previewEmail
    
    func test_previewEmail_success() async throws {
        // Arrange
        let request = ReceiptServiceRequest.PreviewEmail(id: 3)
        let previewUrl = PreviewUrl(
            hostUrl: "https://example.com",
            createdAt: Date(),
            urlPath: "/receipts/3/preview-email?token=abc123"
        )
        let expectedPreview = ReceiptServiceResponse.PreviewEmail(info: previewUrl)
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPreview)
        
        // Act
        let result = try await sut.previewEmail(request: request)
        
        // Assert
        XCTAssertEqual(result.info.urlPath, expectedPreview.info.urlPath)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test previewPDF
    
    func test_previewPDF_success() async throws {
        // Arrange
        let request = ReceiptServiceRequest.PreviewPDF(id: 3)
        let previewUrl = PreviewUrl(
            hostUrl: "https://example.com",
            createdAt: Date(),
            urlPath: "/receipts/3/preview-pdf?token=abc123"
        )
        let expectedPreview = ReceiptServiceResponse.PreviewPDF(info: previewUrl)
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPreview)
        
        // Act
        let result = try await sut.previewPDF(request: request)
        
        // Assert
        XCTAssertEqual(result.info.urlPath, expectedPreview.info.urlPath)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test exportPDF
    
    func test_exportPDF_success() async throws {
        // Arrange
        let request = ReceiptServiceRequest.ExportPDF(id: 3)
        let expectedPdfUrl = PdfUrl(hostUrl: "https://example.com",
                                    urlPath: "/receipts/3/pdf?token=abc123")
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPdfUrl)
        
        // Act
        let result = try await sut.exportPDF(request: request)
        
        // Assert
        XCTAssertEqual(result.urlPath, expectedPdfUrl.urlPath)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test exportImage
    
    func test_exportImage_success() async throws {
        // Arrange
        let request = ReceiptServiceRequest.ExportImage(id: 3)
        let expectedImageUrl = ImageUrl(hostUrl: "https://example.com",
                                        urlPath: "/receipts/3/image?token=abc123")
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedImageUrl)
        
        // Act
        let result = try await sut.exportImage(request: request)
        
        // Assert
        XCTAssertEqual(result.urlPath, expectedImageUrl.urlPath)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Helper Methods
    
    private func createMockReceiptsPaginator() -> Paginator<Receipt> {
        let receipts = [createMockReceipt()]
        return Paginator(
            items: Collection(array: receipts),
            totalItems: 1,
            totalPages: 1,
            perPage: 20,
            page: 1
        )
    }
    
    private func createMockReceipt() -> Receipt {
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
            paidDate: Date(timeIntervalSince1970: 1669075200),
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
            createdAt: Date(timeIntervalSince1970: 1669075200),
            updatedAt: Date(timeIntervalSince1970: 1669075200)
        )
    }
    
    private func createMockCancelledReceipt() -> Receipt {
        var receipt = createMockReceipt()
        return Receipt(
            id: receipt.id,
            status: .cancelled,
            number: receipt.number,
            vatIncluded: receipt.vatIncluded,
            vatPercentage: receipt.vatPercentage,
            withholdingTaxIncluded: receipt.withholdingTaxIncluded,
            withholdingTaxPercentage: receipt.withholdingTaxPercentage,
            occupiedTotalAmount: receipt.occupiedTotalAmount,
            additionalTotalAmount: receipt.additionalTotalAmount,
            totalAmount: receipt.totalAmount,
            amountBeforeVat: receipt.amountBeforeVat,
            vatAmount: receipt.vatAmount,
            holdingTaxAmount: receipt.holdingTaxAmount,
            totalReceiveAmount: receipt.totalReceiveAmount,
            paidBeforeAmount: receipt.paidBeforeAmount,
            paidDate: receipt.paidDate,
            currency: receipt.currency,
            remark: receipt.remark,
            internalNote: receipt.internalNote,
            voidReason: receipt.voidReason,
            voidedAt: receipt.voidedAt,
            cancelledAt: Date(),
            cancelReason: "Customer request",
            paidAt: receipt.paidAt,
            hotelId: receipt.hotelId,
            userId: receipt.userId,
            folioFormId: receipt.folioFormId,
            payerContactId: receipt.payerContactId,
            receiverContactId: receipt.receiverContactId,
            financialRecordIds: receipt.financialRecordIds,
            createdAt: receipt.createdAt,
            updatedAt: receipt.updatedAt
        )
    }
    
    private func createMockVoidedReceipt() -> Receipt {
        var receipt = createMockReceipt()
        return Receipt(
            id: receipt.id,
            status: .void,
            number: receipt.number,
            vatIncluded: receipt.vatIncluded,
            vatPercentage: receipt.vatPercentage,
            withholdingTaxIncluded: receipt.withholdingTaxIncluded,
            withholdingTaxPercentage: receipt.withholdingTaxPercentage,
            occupiedTotalAmount: receipt.occupiedTotalAmount,
            additionalTotalAmount: receipt.additionalTotalAmount,
            totalAmount: receipt.totalAmount,
            amountBeforeVat: receipt.amountBeforeVat,
            vatAmount: receipt.vatAmount,
            holdingTaxAmount: receipt.holdingTaxAmount,
            totalReceiveAmount: receipt.totalReceiveAmount,
            paidBeforeAmount: receipt.paidBeforeAmount,
            paidDate: receipt.paidDate,
            currency: receipt.currency,
            remark: receipt.remark,
            internalNote: receipt.internalNote,
            voidReason: "Error in calculation",
            voidedAt: Date(),
            cancelledAt: receipt.cancelledAt,
            cancelReason: receipt.cancelReason,
            paidAt: receipt.paidAt,
            hotelId: receipt.hotelId,
            userId: receipt.userId,
            folioFormId: receipt.folioFormId,
            payerContactId: receipt.payerContactId,
            receiverContactId: receipt.receiverContactId,
            financialRecordIds: receipt.financialRecordIds,
            createdAt: receipt.createdAt,
            updatedAt: receipt.updatedAt,
        )
    }
} 
