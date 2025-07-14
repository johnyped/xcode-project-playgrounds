//  HSDocumentRemoteServiceTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 23/5/2568 BE.
//
import XCTest
import Mockable

final class HSDocumentRemoteServiceTests: XCTestCase {
    
    private var sut: HSDocumentRemoteService!
    
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()
    
    override func setUp() {
        super.setUp()
        sut = HSDocumentRemoteService(
            localStorage: localStorage,
            apiManager: apiManager
        )
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Initialization Tests
    
    func test_init_withProvidedDependencies() throws {
        // Arrange & Act
        let service = HSDocumentRemoteService(
            localStorage: localStorage,
            apiManager: apiManager
        )
        
        // Assert
        XCTAssertNotNil(service)
    }
    
    // MARK: - FetchByFinancialRecord Tests
    
    func test_fetchByFinancialRecord_success() async throws {
        // Arrange
        let expectedResponse = Paginator<HSDocument>(
            items: Collection<HSDocument>(array: [createSampleHSDocument()]),
            totalItems: 1,
            totalPages: 1,
            perPage: 20,
            page: 1
        )
        let request = HSDocumentServiceRequest.FetchByFinancialRecord(
            hotelId: 105,
            financialRecordId: 123,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // Act
        let result = try await sut.fetchByFinancialRecord(request: request)
        
        // Assert
        XCTAssertNotNil(result)
        XCTAssertEqual(result.totalItems, expectedResponse.totalItems)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_fetchByFinancialRecord_failure() async throws {
        // Arrange
        let error = APIError.unknownError(title: "Stub Error",
                                         subtitle: nil,
                                         underlying: nil)
        let request = HSDocumentServiceRequest.FetchByFinancialRecord(
            hotelId: 105,
            financialRecordId: 123,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce({ (a,b) -> Paginator<HSDocument> in
                throw error
            })
        
        // Act & Assert
        do {
            _ = try await sut.fetchByFinancialRecord(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error as? APIError {
            case .unknownError(let title, _, _):
                XCTAssertEqual(title, "Stub Error")
            default:
                XCTFail("Unexpected error type")
            }
        }
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - FetchByAccountItem Tests
    
    func test_fetchByAccountItem_success() async throws {
        // Arrange
        let expectedResponse = Paginator<HSDocument>(
            items: Collection<HSDocument>(array: [createSampleHSDocument()]),
            totalItems: 1,
            totalPages: 1,
            perPage: 20,
            page: 1
        )
        let request = HSDocumentServiceRequest.FetchByAccountItem(
            hotelId: 105,
            accountItemId: 456,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // Act
        let result = try await sut.fetchByAccountItem(request: request)
        
        // Assert
        XCTAssertNotNil(result)
        XCTAssertEqual(result.totalItems, expectedResponse.totalItems)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - FetchByReservation Tests
    
    func test_fetchByReservation_success() async throws {
        // Arrange
        let expectedResponse = Paginator<HSDocument>(
            items: Collection<HSDocument>(array: [createSampleHSDocument()]),
            totalItems: 1,
            totalPages: 1,
            perPage: 20,
            page: 1
        )
        let request = HSDocumentServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 789,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // Act
        let result = try await sut.fetchByReservation(request: request)
        
        // Assert
        XCTAssertNotNil(result)
        XCTAssertEqual(result.totalItems, expectedResponse.totalItems)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - FetchByFileName Tests
    
    func test_fetchByFileName_success() async throws {
        // Arrange
        let expectedResponse = Paginator<HSDocument>(
            items: Collection<HSDocument>(array: [createSampleHSDocument()]),
            totalItems: 1,
            totalPages: 1,
            perPage: 20,
            page: 1
        )
        let request = HSDocumentServiceRequest.FetchByFileName(
            hotelId: 105,
            fileName: "test.pdf",
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // Act
        let result = try await sut.fetchByFileName(request: request)
        
        // Assert
        XCTAssertNotNil(result)
        XCTAssertEqual(result.totalItems, expectedResponse.totalItems)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - FetchByKind Tests
    
    func test_fetchByKind_success() async throws {
        // Arrange
        let expectedResponse = Paginator<HSDocument>(
            items: Collection<HSDocument>(array: [createSampleHSDocument()]),
            totalItems: 1,
            totalPages: 1,
            perPage: 20,
            page: 1
        )
        let request = HSDocumentServiceRequest.FetchByKind(
            hotelId: 105,
            kind: .receiptPdf,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // Act
        let result = try await sut.fetchByKind(request: request)
        
        // Assert
        XCTAssertNotNil(result)
        XCTAssertEqual(result.totalItems, expectedResponse.totalItems)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - FetchGuestRegisterCardSignature Tests
    
    func test_fetchGuestRegisterCardSignature_success() async throws {
        // Arrange
        let expectedResponse = HSDocuments(array: [createSampleHSDocument()])
        let request = HSDocumentServiceRequest.FetchGuestRegisterCardSignature(
            hotelId: 105,
            guestRegisterCardId: 101
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // Act
        let result = try await sut.fetchGuestRegisterCardSignature(request: request)
        
        // Assert
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, expectedResponse.count)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - FetchById Tests
    
    func test_fetchById_success() async throws {
        // Arrange
        let expectedResponse = createSampleHSDocument()
        let request = HSDocumentServiceRequest.FetchById(id: 123)
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // Act
        let result = try await sut.fetchById(request: request)
        
        // Assert
        XCTAssertNotNil(result)
        XCTAssertEqual(result.id, expectedResponse.id)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - CreateDocument Tests
    
    func test_createDocument_success() async throws {
        // Arrange
        let expectedResponse = createSampleHSDocument()
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
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // Act
        let result = try await sut.createDocument(request: request)
        
        // Assert
        XCTAssertNotNil(result)
        XCTAssertEqual(result.id, expectedResponse.id)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - RequestUploadUrl Tests
    
    func test_requestUploadUrl_success() async throws {
        // Arrange
        let expectedResponse = HSDocumentServiceResponse.UploadUrl(
            uploadUrl: "https://example.com/upload",
            accessUrl: "https://example.com/access"
        )
        let request = HSDocumentServiceRequest.RequestUploadUrl(
            filename: "test.pdf",
            mimeType: "application/pdf"
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // Act
        let result = try await sut.requestUploadUrl(request: request)
        
        // Assert
        XCTAssertNotNil(result)
        XCTAssertEqual(result.uploadUrl, expectedResponse.uploadUrl)
        XCTAssertEqual(result.accessUrl, expectedResponse.accessUrl)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - DeleteDocument Tests
    
    func test_deleteDocument_success() async throws {
        // Arrange
        let request = HSDocumentServiceRequest.DeleteDocument(id: 123)
        
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())
        
        // Act & Assert
        do {
            try await sut.deleteDocument(request: request)
            // If we get here, the test passed
        } catch {
            XCTFail("Expected no error but got \(error)")
        }
        
        verify(apiManager)
            .requestACK(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - BatchDelete Tests
    
    func test_batchDelete_success() async throws {
        // Arrange
        let request = HSDocumentServiceRequest.BatchDelete(documentIds: [1, 2, 3])
        
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())
        
        // Act & Assert
        do {
            try await sut.batchDelete(request: request)
            // If we get here, the test passed
        } catch {
            XCTFail("Expected no error but got \(error)")
        }
        
        verify(apiManager)
            .requestACK(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - BatchDeleteByKind Tests
    
    func test_batchDeleteByKind_success() async throws {
        // Arrange
        let request = HSDocumentServiceRequest.BatchDeleteByKind(
            documentableId: 1,
            documentableType: .user,
            kind: .logoImage
        )
        
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())
        
        // Act & Assert
        do {
            try await sut.batchDeleteByKind(request: request)
            // If we get here, the test passed
        } catch {
            XCTFail("Expected no error but got \(error)")
        }
        
        verify(apiManager)
            .requestACK(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Helper Methods
    
    private func createSampleHSDocument() -> HSDocument {
        return HSDocument(
            id: 1,
            hotelId: 105,
            filename: "test_document.pdf",
            kind: .receiptPdf,
            documentableId: 1,
            documentableType: .financialRecord,
            downloadUrl: "https://example.com/test.pdf",
            mimeType: "application/pdf",
            extention: "pdf",
            tags: [.file],
            expiresAt: nil,
            createdAt: Date(),
            updatedAt: Date()
        )
    }
} 