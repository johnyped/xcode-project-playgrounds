//  HSDocumentServiceRequestTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 23/5/2568 BE.
//
import XCTest

final class HSDocumentServiceRequestTests: XCTestCase {
    
    // MARK: - FetchByFinancialRecord Tests
    
    func test_fetchByFinancialRecord_initWithRequiredProperties() throws {
        // Arrange & Act
        let request = HSDocumentServiceRequest.FetchByFinancialRecord(
            hotelId: 105,
            financialRecordId: 123,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // Assert
        XCTAssertEqual(request.hotelId, 105)
        XCTAssertEqual(request.financialRecordId, 123)
    }
    
    func test_fetchByFinancialRecord_parameters() throws {
        // Arrange
        let request = HSDocumentServiceRequest.FetchByFinancialRecord(
            hotelId: 105,
            financialRecordId: 123,
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
        XCTAssertEqual(parameters?["financial_record_id"] as? Int, 123)
    }
    
    // MARK: - FetchByAccountItem Tests
    
    func test_fetchByAccountItem_initWithRequiredProperties() throws {
        // Arrange & Act
        let request = HSDocumentServiceRequest.FetchByAccountItem(
            hotelId: 105,
            accountItemId: 456,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // Assert
        XCTAssertEqual(request.hotelId, 105)
        XCTAssertEqual(request.accountItemId, 456)
    }
    
    func test_fetchByAccountItem_parameters() throws {
        // Arrange
        let request = HSDocumentServiceRequest.FetchByAccountItem(
            hotelId: 105,
            accountItemId: 456,
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
        XCTAssertEqual(parameters?["account_item_id"] as? Int, 456)
    }
    
    // MARK: - FetchByReservation Tests
    
    func test_fetchByReservation_initWithRequiredProperties() throws {
        // Arrange & Act
        let request = HSDocumentServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 789,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // Assert
        XCTAssertEqual(request.hotelId, 105)
        XCTAssertEqual(request.reservationId, 789)
    }
    
    func test_fetchByReservation_parameters() throws {
        // Arrange
        let request = HSDocumentServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 789,
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
        XCTAssertEqual(parameters?["reservation_id"] as? Int, 789)
    }
    
    // MARK: - FetchByFileName Tests
    
    func test_fetchByFileName_initWithRequiredProperties() throws {
        // Arrange & Act
        let request = HSDocumentServiceRequest.FetchByFileName(
            hotelId: 105,
            fileName: "test_document.pdf",
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // Assert
        XCTAssertEqual(request.hotelId, 105)
        XCTAssertEqual(request.fileName, "test_document.pdf")
    }
    
    func test_fetchByFileName_parameters() throws {
        // Arrange
        let request = HSDocumentServiceRequest.FetchByFileName(
            hotelId: 105,
            fileName: "test_document.pdf",
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
        XCTAssertEqual(parameters?["file_name"] as? String, "test_document.pdf")
    }
    
    // MARK: - FetchByKind Tests
    
    func test_fetchByKind_initWithRequiredProperties() throws {
        // Arrange & Act
        let request = HSDocumentServiceRequest.FetchByKind(
            hotelId: 105,
            kind: .receiptPdf,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // Assert
        XCTAssertEqual(request.hotelId, 105)
        XCTAssertEqual(request.kind, .receiptPdf)
    }
    
    func test_fetchByKind_parameters() throws {
        // Arrange
        let request = HSDocumentServiceRequest.FetchByKind(
            hotelId: 105,
            kind: .receiptPdf,
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
        XCTAssertEqual(parameters?["kind"] as? String, "RECEIPT_PDF")
    }
    
    // MARK: - FetchGuestRegisterCardSignature Tests
    
    func test_fetchGuestRegisterCardSignature_initWithRequiredProperties() throws {
        // Arrange & Act
        let request = HSDocumentServiceRequest.FetchGuestRegisterCardSignature(
            hotelId: 105,
            guestRegisterCardId: 101
        )
        
        // Assert
        XCTAssertEqual(request.hotelId, 105)
        XCTAssertEqual(request.guestRegisterCardId, 101)
    }
    
    func test_fetchGuestRegisterCardSignature_parameters() throws {
        // Arrange
        let request = HSDocumentServiceRequest.FetchGuestRegisterCardSignature(
            hotelId: 105,
            guestRegisterCardId: 101
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["guest_register_card_id"] as? Int, 101)
    }
    
    // MARK: - CreateDocument Tests
    
    func test_createDocument_initWithRequiredProperties() throws {
        // Arrange & Act
        let request = HSDocumentServiceRequest.CreateDocument(
            hotelId: 105,
            filename: "test.pdf",
            kind: .receiptPdf,
            documentableId: 1,
            documentableType: .financialRecord,
            mimeType: "application/pdf",
            fileExtention: "pdf",
            tags: [.file],
            expiresAt: nil
        )
        
        // Assert
        XCTAssertEqual(request.hotelId, 105)
        XCTAssertEqual(request.filename, "test.pdf")
        XCTAssertEqual(request.kind, .receiptPdf)
        XCTAssertEqual(request.documentableId, 1)
        XCTAssertEqual(request.documentableType, .financialRecord)
        XCTAssertEqual(request.mimeType, "application/pdf")
        XCTAssertEqual(request.fileExtention, "pdf")
        XCTAssertEqual(request.tags, [.file])
        XCTAssertNil(request.expiresAt)
    }
    
    func test_createDocument_body() throws {
        // Arrange
        let request = HSDocumentServiceRequest.CreateDocument(
            hotelId: 105,
            filename: "test.pdf",
            kind: .receiptPdf,
            documentableId: 1,
            documentableType: .financialRecord,
            mimeType: "application/pdf",
            fileExtention: "pdf",
            tags: [.file],
            expiresAt: nil
        )
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
    }
    
    // MARK: - RequestUploadUrl Tests
    
    func test_requestUploadUrl_initWithRequiredProperties() throws {
        // Arrange & Act
        let request = HSDocumentServiceRequest.RequestUploadUrl(
            filename: "test.pdf",
            mimeType: "application/pdf"
        )
        
        // Assert
        XCTAssertEqual(request.filename, "test.pdf")
        XCTAssertEqual(request.mimeType, "application/pdf")
    }
    
    func test_requestUploadUrl_body() throws {
        // Arrange
        let request = HSDocumentServiceRequest.RequestUploadUrl(
            filename: "test.pdf",
            mimeType: "application/pdf"
        )
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
    }
    
    // MARK: - BatchDelete Tests
    
    func test_batchDelete_initWithRequiredProperties() throws {
        // Arrange & Act
        let request = HSDocumentServiceRequest.BatchDelete(
            documentIds: [1, 2, 3, 4, 5]
        )
        
        // Assert
        XCTAssertEqual(request.documentIds, [1, 2, 3, 4, 5])
    }
    
    func test_batchDelete_body() throws {
        // Arrange
        let request = HSDocumentServiceRequest.BatchDelete(
            documentIds: [1, 2, 3]
        )
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
    }
    
    // MARK: - BatchDeleteByKind Tests
    
    func test_batchDeleteByKind_initWithRequiredProperties() throws {
        // Arrange & Act
        let request = HSDocumentServiceRequest.BatchDeleteByKind(
            documentableId: 1,
            documentableType: .user,
            kind: .logoImage
        )
        
        // Assert
        XCTAssertEqual(request.documentableId, 1)
        XCTAssertEqual(request.documentableType, .user)
        XCTAssertEqual(request.kind, .logoImage)
    }
    
    func test_batchDeleteByKind_parameters() throws {
        // Arrange
        let request = HSDocumentServiceRequest.BatchDeleteByKind(
            documentableId: 1,
            documentableType: .user,
            kind: .logoImage
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["documentable_id"] as? Int, 1)
        XCTAssertEqual(parameters?["documentable_type"] as? String, "USER")
        XCTAssertEqual(parameters?["kind"] as? String, "LOGO_IMAGE")
    }
    
    // MARK: - SortedBy Enum Tests
    
    func test_sortedBy_rawValues() throws {
        XCTAssertEqual(HSDocumentServiceRequest.SortedBy.id.rawValue, "ID")
        XCTAssertEqual(HSDocumentServiceRequest.SortedBy.createdAt.rawValue, "CREATED_AT")
        XCTAssertEqual(HSDocumentServiceRequest.SortedBy.updatedAt.rawValue, "UPDATED_AT")
    }
    
    // MARK: - ByID Tests
    
    func test_byID_initWithRequiredProperties() throws {
        // Arrange & Act
        let request = HSDocumentServiceRequest.ByID(id: 123)
        
        // Assert
        XCTAssertEqual(request.id, 123)
    }
} 