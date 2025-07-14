//  HSDocumentServiceRouterTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 23/5/2568 BE.
//
import XCTest
import Alamofire

final class HSDocumentServiceRouterTests: XCTestCase {
    
    // MARK: - Domain Tests
    
    func test_domain_returnsCorrectBaseURL() throws {
        // Arrange
        let request = HSDocumentServiceRequest.FetchByFinancialRecord(
            hotelId: 105,
            financialRecordId: 123,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        let router = HSDocumentServiceRouter.fetchByFinancialRecord(request: request)
        
        // Act
        let domain = router.domain
        
        // Assert
        XCTAssertEqual(domain, AppConfiguration.shared.baseURL)
    }
    
    // MARK: - Path Tests
    
    func test_fetchByFinancialRecord_path() throws {
        // Arrange
        let request = HSDocumentServiceRequest.FetchByFinancialRecord(
            hotelId: 105,
            financialRecordId: 123,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        let router = HSDocumentServiceRouter.fetchByFinancialRecord(request: request)
        
        // Act
        let path = router.path
        
        // Assert
        XCTAssertEqual(path, "/v4/documents/financial-record")
    }
    
    func test_fetchByAccountItem_path() throws {
        // Arrange
        let request = HSDocumentServiceRequest.FetchByAccountItem(
            hotelId: 105,
            accountItemId: 456,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        let router = HSDocumentServiceRouter.fetchByAccountItem(request: request)
        
        // Act
        let path = router.path
        
        // Assert
        XCTAssertEqual(path, "/v4/documents/account-item")
    }
    
    func test_fetchByReservation_path() throws {
        // Arrange
        let request = HSDocumentServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 789,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        let router = HSDocumentServiceRouter.fetchByReservation(request: request)
        
        // Act
        let path = router.path
        
        // Assert
        XCTAssertEqual(path, "/v4/documents/reservation")
    }
    
    func test_fetchByFileName_path() throws {
        // Arrange
        let request = HSDocumentServiceRequest.FetchByFileName(
            hotelId: 105,
            fileName: "test.pdf",
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        let router = HSDocumentServiceRouter.fetchByFileName(request: request)
        
        // Act
        let path = router.path
        
        // Assert
        XCTAssertEqual(path, "/v4/documents/file-name")
    }
    
    func test_fetchByKind_path() throws {
        // Arrange
        let request = HSDocumentServiceRequest.FetchByKind(
            hotelId: 105,
            kind: .receiptPdf,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        let router = HSDocumentServiceRouter.fetchByKind(request: request)
        
        // Act
        let path = router.path
        
        // Assert
        XCTAssertEqual(path, "/v4/documents")
    }
    
    func test_fetchGuestRegisterCardSignature_path() throws {
        // Arrange
        let request = HSDocumentServiceRequest.FetchGuestRegisterCardSignature(
            hotelId: 105,
            guestRegisterCardId: 101
        )
        let router = HSDocumentServiceRouter.fetchGuestRegisterCardSignature(request: request)
        
        // Act
        let path = router.path
        
        // Assert
        XCTAssertEqual(path, "/v4/documents/guest-register-card-signature")
    }
    
    func test_fetchById_path() throws {
        // Arrange
        let request = HSDocumentServiceRequest.FetchById(id: 123)
        let router = HSDocumentServiceRouter.fetchById(request: request)
        
        // Act
        let path = router.path
        
        // Assert
        XCTAssertEqual(path, "/v4/documents/123")
    }
    
    func test_createDocument_path() throws {
        // Arrange
        let request = HSDocumentServiceRequest.CreateDocument(
            hotelId: 105,
            filename: "test.pdf",
            kind: .receiptPdf,
            documentableId: 1,
            documentableType: .financialRecord,
            mimeType: nil,
            fileExtention: nil,
            tags: [],
            expiresAt: nil
        )
        let router = HSDocumentServiceRouter.createDocument(request: request)
        
        // Act
        let path = router.path
        
        // Assert
        XCTAssertEqual(path, "/v4/documents")
    }
    
    func test_requestUploadUrl_path() throws {
        // Arrange
        let request = HSDocumentServiceRequest.RequestUploadUrl(
            filename: "test.pdf",
            mimeType: "application/pdf"
        )
        let router = HSDocumentServiceRouter.requestUploadUrl(request: request)
        
        // Act
        let path = router.path
        
        // Assert
        XCTAssertEqual(path, "/v4/documents/upload-url")
    }
    
    func test_deleteDocument_path() throws {
        // Arrange
        let request = HSDocumentServiceRequest.DeleteDocument(id: 123)
        let router = HSDocumentServiceRouter.deleteDocument(request: request)
        
        // Act
        let path = router.path
        
        // Assert
        XCTAssertEqual(path, "/v4/documents/123")
    }
    
    func test_batchDelete_path() throws {
        // Arrange
        let request = HSDocumentServiceRequest.BatchDelete(documentIds: [1, 2, 3])
        let router = HSDocumentServiceRouter.batchDelete(request: request)
        
        // Act
        let path = router.path
        
        // Assert
        XCTAssertEqual(path, "/v4/documents/batch-delete")
    }
    
    func test_batchDeleteByKind_path() throws {
        // Arrange
        let request = HSDocumentServiceRequest.BatchDeleteByKind(
            documentableId: 1,
            documentableType: .user,
            kind: .logoImage
        )
        let router = HSDocumentServiceRouter.batchDeleteByKind(request: request)
        
        // Act
        let path = router.path
        
        // Assert
        XCTAssertEqual(path, "/v4/documents/batch-delete-by-kind")
    }
    
    // MARK: - Method Tests
    
    func test_fetchByFinancialRecord_method() throws {
        // Arrange
        let request = HSDocumentServiceRequest.FetchByFinancialRecord(
            hotelId: 105,
            financialRecordId: 123,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        let router = HSDocumentServiceRouter.fetchByFinancialRecord(request: request)
        
        // Act
        let method = router.method
        
        // Assert
        XCTAssertEqual(method, .get)
    }
    
    func test_createDocument_method() throws {
        // Arrange
        let request = HSDocumentServiceRequest.CreateDocument(
            hotelId: 105,
            filename: "test.pdf",
            kind: .receiptPdf,
            documentableId: 1,
            documentableType: .financialRecord,
            mimeType: nil,
            fileExtention: nil,
            tags: [],
            expiresAt: nil
        )
        let router = HSDocumentServiceRouter.createDocument(request: request)
        
        // Act
        let method = router.method
        
        // Assert
        XCTAssertEqual(method, .post)
    }
    
    func test_requestUploadUrl_method() throws {
        // Arrange
        let request = HSDocumentServiceRequest.RequestUploadUrl(
            filename: "test.pdf",
            mimeType: "application/pdf"
        )
        let router = HSDocumentServiceRouter.requestUploadUrl(request: request)
        
        // Act
        let method = router.method
        
        // Assert
        XCTAssertEqual(method, .post)
    }
    
    func test_deleteDocument_method() throws {
        // Arrange
        let request = HSDocumentServiceRequest.DeleteDocument(id: 123)
        let router = HSDocumentServiceRouter.deleteDocument(request: request)
        
        // Act
        let method = router.method
        
        // Assert
        XCTAssertEqual(method, .delete)
    }
    
    func test_batchDelete_method() throws {
        // Arrange
        let request = HSDocumentServiceRequest.BatchDelete(documentIds: [1, 2, 3])
        let router = HSDocumentServiceRouter.batchDelete(request: request)
        
        // Act
        let method = router.method
        
        // Assert
        XCTAssertEqual(method, .delete)
    }
    
    func test_batchDeleteByKind_method() throws {
        // Arrange
        let request = HSDocumentServiceRequest.BatchDeleteByKind(
            documentableId: 1,
            documentableType: .user,
            kind: .logoImage
        )
        let router = HSDocumentServiceRouter.batchDeleteByKind(request: request)
        
        // Act
        let method = router.method
        
        // Assert
        XCTAssertEqual(method, .delete)
    }
    
    // MARK: - Headers Tests
    
    func test_createDocument_headers() throws {
        // Arrange
        let request = HSDocumentServiceRequest.CreateDocument(
            hotelId: 105,
            filename: "test.pdf",
            kind: .receiptPdf,
            documentableId: 1,
            documentableType: .financialRecord,
            mimeType: nil,
            fileExtention: nil,
            tags: [],
            expiresAt: nil
        )
        let router = HSDocumentServiceRouter.createDocument(request: request)
        
        // Act
        let headers = router.headers
        
        // Assert
        XCTAssertNotNil(headers)
        XCTAssertEqual(headers?["Content-Type"], "application/json")
    }
    
    func test_fetchByFinancialRecord_headers() throws {
        // Arrange
        let request = HSDocumentServiceRequest.FetchByFinancialRecord(
            hotelId: 105,
            financialRecordId: 123,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        let router = HSDocumentServiceRouter.fetchByFinancialRecord(request: request)
        
        // Act
        let headers = router.headers
        
        // Assert
        XCTAssertNotNil(headers)
        XCTAssertEqual(headers?["Content-Type"], "application/json")
    }
    
    func test_requestUploadUrl_headers() throws {
        // Arrange
        let request = HSDocumentServiceRequest.RequestUploadUrl(
            filename: "test.pdf",
            mimeType: "application/pdf"
        )
        let router = HSDocumentServiceRouter.requestUploadUrl(request: request)
        
        // Act
        let headers = router.headers
        
        // Assert
        XCTAssertNotNil(headers)
        XCTAssertEqual(headers?["Content-Type"], "application/json")
    }
    
    // MARK: - Parameters Tests
    
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
        let router = HSDocumentServiceRouter.fetchByFinancialRecord(request: request)
        
        // Act
        let parameters = router.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["financial_record_id"] as? Int, 123)
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
        let router = HSDocumentServiceRouter.fetchByKind(request: request)
        
        // Act
        let parameters = router.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["kind"] as? String, "RECEIPT_PDF")
    }
    
    func test_batchDeleteByKind_parameters() throws {
        // Arrange
        let request = HSDocumentServiceRequest.BatchDeleteByKind(
            documentableId: 1,
            documentableType: .user,
            kind: .logoImage
        )
        let router = HSDocumentServiceRouter.batchDeleteByKind(request: request)
        
        // Act
        let parameters = router.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["documentable_id"] as? Int, 1)
        XCTAssertEqual(parameters?["documentable_type"] as? String, "USER")
        XCTAssertEqual(parameters?["kind"] as? String, "LOGO_IMAGE")
    }
    
    // MARK: - Body Tests
    
    func test_createDocument_body() throws {
        // Arrange
        let request = HSDocumentServiceRequest.CreateDocument(
            hotelId: 105,
            filename: "test.pdf",
            kind: .receiptPdf,
            documentableId: 1,
            documentableType: .financialRecord,
            mimeType: nil,
            fileExtention: nil,
            tags: [],
            expiresAt: nil
        )
        let router = HSDocumentServiceRouter.createDocument(request: request)
        
        // Act
        let body = router.body
        
        // Assert
        XCTAssertNotNil(body)
    }
    
    func test_requestUploadUrl_body() throws {
        // Arrange
        let request = HSDocumentServiceRequest.RequestUploadUrl(
            filename: "test.pdf",
            mimeType: "application/pdf"
        )
        let router = HSDocumentServiceRouter.requestUploadUrl(request: request)
        
        // Act
        let body = router.body
        
        // Assert
        XCTAssertNotNil(body)
    }
    
    func test_batchDelete_body() throws {
        // Arrange
        let request = HSDocumentServiceRequest.BatchDelete(documentIds: [1, 2, 3])
        let router = HSDocumentServiceRouter.batchDelete(request: request)
        
        // Act
        let body = router.body
        
        // Assert
        XCTAssertNotNil(body)
    }
    
    func test_fetchById_body_isNil() throws {
        // Arrange
        let request = HSDocumentServiceRequest.FetchById(id: 123)
        let router = HSDocumentServiceRouter.fetchById(request: request)
        
        // Act
        let body = router.body
        
        // Assert
        XCTAssertNil(body)
    }
    
    // MARK: - URLRequest Tests
    
    func test_asURLRequest_fetchByFinancialRecord() throws {
        // Arrange
        let request = HSDocumentServiceRequest.FetchByFinancialRecord(
            hotelId: 105,
            financialRecordId: 123,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        let router = HSDocumentServiceRouter.fetchByFinancialRecord(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertNotNil(urlRequest.url)
        XCTAssertTrue(urlRequest.url!.absoluteString.contains("/v4/documents/financial-record"))
        XCTAssertTrue(urlRequest.url!.absoluteString.contains("hotel_id=105"))
        XCTAssertTrue(urlRequest.url!.absoluteString.contains("financial_record_id=123"))
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    func test_asURLRequest_createDocument() throws {
        // Arrange
        let request = HSDocumentServiceRequest.CreateDocument(
            hotelId: 105,
            filename: "test.pdf",
            kind: .receiptPdf,
            documentableId: 1,
            documentableType: .financialRecord,
            mimeType: nil,
            fileExtention: nil,
            tags: [],
            expiresAt: nil
        )
        let router = HSDocumentServiceRouter.createDocument(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertNotNil(urlRequest.url)
        XCTAssertTrue(urlRequest.url!.absoluteString.contains("/v4/documents"))
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertNotNil(urlRequest.httpBody)
    }
    
    func test_asURLRequest_requestUploadUrl() throws {
        // Arrange
        let request = HSDocumentServiceRequest.RequestUploadUrl(
            filename: "test.pdf",
            mimeType: "application/pdf"
        )
        let router = HSDocumentServiceRouter.requestUploadUrl(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertNotNil(urlRequest.url)
        XCTAssertTrue(urlRequest.url!.absoluteString.contains("/v4/documents/upload-url"))
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertNotNil(urlRequest.httpBody)
    }
} 