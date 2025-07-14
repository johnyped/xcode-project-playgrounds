//
//  FolioRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import XCTest
import Mockable

final class FolioRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchFolios_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<Folio>(
            items: Collection(array: []),
            totalItems: 0,
            totalPages: 0,
            perPage: 20,
            page: 1
        )
        // Stub the API manager to return the expected paginator
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)

        let service = FolioRemoteService(localStorage: localStorage,
                                         apiManager: apiManager)
        let request = FolioServiceRequest.FetchFolios(
            hotelId: 1,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            status: .available,
            vatOption: .includedVat
        )

        // When
        let result = try await service.fetchFolios(request: request)

        // Then
        XCTAssertEqual(result.totalItems,
                       expectedPaginator.totalItems)
    }

    func testFetchFolio_WillGetValidResponse() async throws {
        // Given
        let expectedFolio = Folio(
            id: 1,
            hotelId: 101,
            status: Folio.Status.available,
            name: "Test Folio",
            amount: 100.0,
            amountBeforeVat: 93.46,
            vatAmount: 6.54,
            barcode: nil,
            code: nil,
            categoryId: 1,
            description: "Test Description",
            vatIncluded: true,
            createdAt: Date(timeIntervalSince1970: 1714857600),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedFolio)

        let service = FolioRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = FolioServiceRequest.FetchFolio(id: 1)

        // When
        let result = try await service.fetchFolio(request: request)

        // Then
        XCTAssertEqual(result.id, expectedFolio.id)
        XCTAssertEqual(result.name, expectedFolio.name)
    }

    func testCreateFolio_WillGetValidResponse() async throws {
        // Given
        let expectedFolio = Folio(
            id: 2,
            hotelId: 102,
            status: Folio.Status.available,
            name: "Created Folio",
            amount: 200.0,
            amountBeforeVat: 186.92,
            vatAmount: 13.08,
            barcode: nil,
            code: nil,
            categoryId: 2,
            description: "Created Description",
            vatIncluded: false,
            createdAt: Date(timeIntervalSince1970: 1714857600),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedFolio)

        let service = FolioRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = FolioServiceRequest.CreateFolio(
            hotelId: 102,
            name: "Created Folio",
            amount: 200.0,
            description: "Created Description",
            categoryId: 2,
            amountVatOption: .includedVat
        )

        // When
        let result = try await service.createFolio(request: request)

        // Then
        XCTAssertEqual(result.id, expectedFolio.id)
        XCTAssertEqual(result.name, expectedFolio.name)
    }

    func testUpdateFolio_WillGetValidResponse() async throws {
        // Given
        let expectedFolio = Folio(
            id: 3,
            hotelId: 103,
            status: Folio.Status.available,
            name: "Updated Folio",
            amount: 300.0,
            amountBeforeVat: 280.39,
            vatAmount: 19.61,
            barcode: nil,
            code: nil,
            categoryId: 3,
            description: "Updated Description",
            vatIncluded: true,
            createdAt: Date(timeIntervalSince1970: 1714857600),
            updatedAt: Date(timeIntervalSince1970: 1714857600)
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedFolio)

        let service = FolioRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = FolioServiceRequest.UpdateFolio(
            id: 3,
            name: "Updated Folio",
            amount: 300.0,
            description: "Updated Description",
            categoryId: 3,
            amountVatOption: .includedVat
        )

        // When
        let result = try await service.updateFolio(request: request)

        // Then
        XCTAssertEqual(result.id, expectedFolio.id)
        XCTAssertEqual(result.name, expectedFolio.name)
    }

    func testFetchFoliosByCategory_WillGetValidResponse() async throws {
        // Given
        let folio1 = Folio(
            id: 1,
            hotelId: 101,
            status: Folio.Status.available,
            name: "Category Test Folio 1",
            amount: 150.0,
            amountBeforeVat: 140.19,
            vatAmount: 9.81,
            barcode: nil,
            code: nil,
            categoryId: 5,
            description: "Test folio for category 5",
            vatIncluded: true,
            createdAt: Date(timeIntervalSince1970: 1714857600),
            updatedAt: Date(timeIntervalSince1970: 1714857600)
        )
        
        let folio2 = Folio(
            id: 2,
            hotelId: 101,
            status: Folio.Status.available,
            name: "Category Test Folio 2",
            amount: 250.0,
            amountBeforeVat: 233.64,
            vatAmount: 16.36,
            barcode: nil,
            code: nil,
            categoryId: 5,
            description: "Another test folio for category 5",
            vatIncluded: true,
            createdAt: Date(timeIntervalSince1970: 1714857600),
            updatedAt: Date(timeIntervalSince1970: 1714857600)
        )
        
        let expectedFolios = Collection(array: [folio1, folio2])
        
        // Stub the API manager to return the expected folios
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedFolios)

        let service = FolioRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = FolioServiceRequest.FetchFoliosByCategory(
            hotelId: 101,
            categoryId: 5
        )

        // When
        let result = try await service.fetchFoliosByCategory(request: request)

        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0].id, folio1.id)
        XCTAssertEqual(result[0].name, folio1.name)
        XCTAssertEqual(result[0].categoryId, 5)
        XCTAssertEqual(result[1].id, folio2.id)
        XCTAssertEqual(result[1].name, folio2.name)
        XCTAssertEqual(result[1].categoryId, 5)
    }

    func testDeleteFolio_WillSucceed() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = FolioRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = FolioServiceRequest.DeleteFolio(id: 4)

        // When/Then
        do {
            try await service.deleteFolio(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("Delete should not throw error")
        }
    }
}
