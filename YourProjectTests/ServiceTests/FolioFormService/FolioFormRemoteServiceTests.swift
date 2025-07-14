//
//  FolioFormRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 13/6/2568 BE.
//

import XCTest
import Mockable

final class FolioFormRemoteServiceTests: XCTestCase {
    
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()
    lazy var service = FolioFormRemoteService(localStorage: localStorage,
                                              apiManager: apiManager)
    let mockHostUrl = "https://mock.com"
    
    override func setUp() {
        super.setUp()
    }
    
    // MARK: - FetchByHotel Tests
    
    func testFetchByHotel_Success() async throws {
        // Given
        let request = FolioFormServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        let expectedResponse = createMockPaginator()
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // When
        let result = try await service.fetchByHotel(request: request)
        
        // Then
        XCTAssertEqual(result.totalItems, expectedResponse.totalItems)
        XCTAssertEqual(result.items.first?.id, expectedResponse.items.first?.id)
        XCTAssertEqual(result.page, expectedResponse.page)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func testFetchByHotel_Failure() async throws {
        // Given
        let request = FolioFormServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        let expectError = APIError.unknownError(title: "Stub Error",
                                          subtitle: nil,
                                          underlying: nil)
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any).willProduce{ (a,b) -> Paginator<FolioForm> in
                 throw expectError
            }
            
        
        // When & Then
        do {
            _ = try await service.fetchByHotel(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error as? APIError {
            case .unknownError(let title, _ , _):
                XCTAssertEqual(title, "Stub Error")
            default:
                XCTFail()
            }
            
        }
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - FetchByQuery Tests
    
    func testFetchByQuery_Success() async throws {
        // Given
        let request = FolioFormServiceRequest.FetchByQuery(
            hotelId: 105,
            query: "test query",
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        let expectedResponse = createMockPaginator()
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // When
        let result = try await service.fetchByQuery(request: request)
        
        // Then
        XCTAssertEqual(result.totalItems, expectedResponse.totalItems)
        XCTAssertEqual(result.items.first?.id, expectedResponse.items.first?.id)
        XCTAssertEqual(result.page, expectedResponse.page)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - FetchByPeriod Tests
    
    func testFetchByPeriod_Success() async throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1704067200) // 2024-01-01
        let endDate = Date(timeIntervalSince1970: 1735689600) // 2024-12-31
        let period = PeriodDate(start: startDate, end: endDate)
        
        let request = FolioFormServiceRequest.FetchByPeriod(
            hotelId: 105,
            period: period,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        let expectedResponse = createMockPaginator()
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // When
        let result = try await service.fetchByPeriod(request: request)
        
        // Then
        XCTAssertEqual(result.totalItems, expectedResponse.totalItems)
        XCTAssertEqual(result.items.first?.id, expectedResponse.items.first?.id)
        XCTAssertEqual(result.page, expectedResponse.page)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - FetchByReservation Tests
    
    func testFetchByReservation_Success() async throws {
        // Given
        let request = FolioFormServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 512,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        let expectedResponse: FolioForms = .init(array: [
            createMockFolioForm(status: .active)
        ])
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // When
        let result = try await service.fetchByReservation(request: request)
        
        // Then
        XCTAssertEqual(result.count, expectedResponse.count)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - FetchById Tests
    
    func testFetchById_Success() async throws {
        // Given
        let request = FolioFormServiceRequest.FetchById(id: 1)
        let expectedResponse = createMockFolioForm()
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // When
        let result = try await service.fetchById(request: request)
        
        // Then
        XCTAssertEqual(result.id, expectedResponse.id)
        XCTAssertEqual(result.status, expectedResponse.status)
        XCTAssertEqual(result.number, expectedResponse.number)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func testFetchById_Failure() async throws {
        // Given
        let request = FolioFormServiceRequest.FetchById(id: 999)
        
        let expectError = APIError.unknownError(title: "Stub Error",
                                          subtitle: nil,
                                          underlying: nil)
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any).willProduce{ (a,b) -> FolioForm in
                throw expectError
            }
        
        // When & Then
        do {
            _ = try await service.fetchById(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error as? APIError {
            case .unknownError(let title, _ , _):
                XCTAssertEqual(title, "Stub Error")
            default:
                XCTFail()
            }
            
        }
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - CreateFolioFormReservation Tests
    
    func testCreateFolioFormReservation_Success() async throws {
        // Given
        let request = FolioFormServiceRequest.CreateFolioFormReservation(
            hotelId: 105,
            reservationId: 179,
            hotelContactId: 8,
            customerContactId: 6,
            vatIncluded: false,
            remark: "test remark",
            internalNote: "test internal note",
            paymentInfo: "2, 2 (111-1-11111-2)",
            groupRoomCharge: true,
            groupAdditionalItem: false
        )
        let expectedResponse = createMockFolioForm()
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // When
        let result = try await service.createFolioFormReservation(request: request)
        
        // Then
        XCTAssertEqual(result.id, expectedResponse.id)
        XCTAssertEqual(result.status, expectedResponse.status)
        XCTAssertEqual(result.number, expectedResponse.number)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func testCreateFolioFormReservation_Failure() async throws {
        // Given
        let request = FolioFormServiceRequest.CreateFolioFormReservation(
            hotelId: 105,
            reservationId: 179,
            hotelContactId: 8,
            customerContactId: 6,
            vatIncluded: false,
            remark: "test remark",
            internalNote: "test internal note",
            paymentInfo: "2, 2 (111-1-11111-2)",
            groupRoomCharge: true,
            groupAdditionalItem: false
        )
        
        let expectError = APIError.unknownError(title: "Stub Error",
                                                subtitle: nil,
                                                underlying: nil)
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce{ (a,b) -> FolioForm in
                throw expectError
            }
        
        // When & Then
        do {
            _ = try await service.createFolioFormReservation(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error as? APIError {
            case .unknownError(let title, _ , _):
                XCTAssertEqual(title, "Stub Error")
            default:
                XCTFail()
            }
            
        }
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - UpdateFolioForm Tests
    
    func testUpdateFolioForm_Success() async throws {
        // Given
        let request = FolioFormServiceRequest.UpdateFolioForm(
            id: 1,
            hotelContactId: 9,
            customerContactId: 7,
            remark: "updated remark",
            internalNote: "updated internal note",
            paymentInfo: "updated payment info",
            groupRoomCharge: false,
            groupAdditionalItem: true
        )
        let expectedResponse = createMockFolioForm()
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // When
        let result = try await service.updateFolioForm(request: request)
        
        // Then
        XCTAssertEqual(result.id, expectedResponse.id)
        XCTAssertEqual(result.status, expectedResponse.status)
        XCTAssertEqual(result.number, expectedResponse.number)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func testUpdateFolioForm_Failure() async throws {
        // Given
        let request = FolioFormServiceRequest.UpdateFolioForm(
            id: 999,
            hotelContactId: 9,
            customerContactId: 7,
            remark: "updated remark",
            internalNote: "updated internal note",
            paymentInfo: "updated payment info",
            groupRoomCharge: false,
            groupAdditionalItem: true
        )
        
        let expectError = APIError.unknownError(title: "Stub Error",
                                          subtitle: nil,
                                          underlying: nil)

        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce{ (a,b) -> FolioForm in
                throw expectError
            }
        
        // When & Then
        do {
            _ = try await service.updateFolioForm(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error as? APIError {
            case .unknownError(let title, _ , _):
                XCTAssertEqual(title, "Stub Error")
            default:
                XCTFail()
            }
            
        }
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - CancelFolioForm Tests
    
    func testCancelFolioForm_Success() async throws {
        // Given
        let request = FolioFormServiceRequest.CancelFolioForm(id: 1)
        let expectedResponse = createMockFolioForm(status: .cancelled)
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // When
        let result = try await service.cancelFolioForm(request: request)
        
        // Then
        XCTAssertEqual(result.id, expectedResponse.id)
        XCTAssertEqual(result.status, .cancelled)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - PreviewEmail Tests
    
    func testPreviewEmail_Success() async throws {
        // Given
        let request = FolioFormServiceRequest.PreviewEmail(id: 1)
        
        let expectedResponse = FolioFormServiceResponse.PreviewEmail(info: PreviewUrl(hostUrl: mockHostUrl,
                                                                                      createdAt: Date(timeIntervalSince1970: 1686636000), // June 13, 2023 12:00:00 PM UTC
                                                                                      urlPath: "/mock/preview/email"))
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // When
        let result = try await service.previewEmail(request: request)
        
        // Then
        XCTAssertEqual(result.info.createdAt, expectedResponse.info.createdAt)
        XCTAssertEqual(result.info.urlPath, expectedResponse.info.urlPath)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - PreviewPDF Tests
    
    func testPreviewPDF_Success() async throws {
        // Given
        let request = FolioFormServiceRequest.PreviewPDF(id: 1)
        
        let expectedResponse = FolioFormServiceResponse.PreviewPDF(info: PreviewUrl(hostUrl: mockHostUrl,
                                                                                    createdAt: Date().addingTimeInterval(1000),
                                                                                    urlPath: "/mock/preview/pdf"))
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // When
        let result = try await service.previewPDF(request: request)
        
        // Then
        XCTAssertEqual(result.info.createdAt, expectedResponse.info.createdAt)
        XCTAssertEqual(result.info.urlPath, expectedResponse.info.urlPath)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - ExportPDF Tests
    
    func testExportPDF_Success() async throws {
        // Given
        let request = FolioFormServiceRequest.ExportPDF(id: 1)
        
        let expectedResponse = PdfUrl(hostUrl: mockHostUrl,
                                      urlPath: "/pdf/1.pdf")
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // When
        let result = try await service.exportPDF(request: request)
        
        // Then
        XCTAssertEqual(result.urlPath, expectedResponse.urlPath)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - ExportImage Tests
    
    func testExportImage_Success() async throws {
        // Given
        let request = FolioFormServiceRequest.ExportImage(id: 1)
        
        let expectedResponse = ImageUrl(hostUrl: mockHostUrl,
                                        urlPath: "/image/1.png")
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // When
        let result = try await service.exportImage(request: request)
        
        // Then
        XCTAssertEqual(result.urlPath, expectedResponse.urlPath)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Helper Methods
    
    private func createMockFolioForm(status: FolioForm.Status = .active) -> FolioForm {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        return FolioForm(
            id: 1,
            status: status,
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
            canceledAt: status == .cancelled ? dateFormatter.date(from: "2023-06-10T14:35:57.177+07:00") : nil,
            createdAt: dateFormatter.date(from: "2023-06-09T13:31:11.727+07:00")!,
            updatedAt: dateFormatter.date(from: "2023-09-12T17:39:27.760+07:00")!
        )
    }
    
    private func createMockPaginator() -> Paginator<FolioForm> {
        let array = [createMockFolioForm()]
        let collection = FolioForms(array: array)
        
        return .init(items: collection,
                     totalItems: 1,
                     totalPages: 1,
                     perPage: 20,
                     page: 1)
    }
} 
