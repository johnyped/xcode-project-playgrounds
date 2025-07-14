//
//  PDPARemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest
import Mockable

final class PDPARemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchPdpas_WillGetValidResponse() async throws {
        // Given
        let expectedPdpas = Pdpas(array: [
            Pdpa(
                id: 1,
                htmlContent: Pdpa.Content(th: "นโยบายคุ้มครองข้อมูลส่วนบุคคล", 
                                         en: "Personal Data Protection Policy"),
                onDate: Date(),
                version: Version(string: "1.0")!,
                updateAt: Date()
            ),
            Pdpa(
                id: 2,
                htmlContent: Pdpa.Content(th: "เงื่อนไขการให้บริการ", 
                                         en: "Terms of Service"),
                onDate: Date(),
                version: Version(string: "2.0")!,
                updateAt: Date()
            )
        ])
        
        // Stub the API manager to return the expected pdpas
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPdpas)

        let service = PDPARemoteService(localStorage: localStorage,
                                       apiManager: apiManager)
        let request = PDPAServiceRequest.FetchPdpas(
            version: Version(string: "1.0")
        )

        // When
        let result = try await service.fetchPdpas(request: request)

        // Then
        XCTAssertEqual(result.count, expectedPdpas.count)
        XCTAssertEqual(result.first?.id, expectedPdpas.first?.id)
        XCTAssertEqual(result.first?.htmlContent.th, expectedPdpas.first?.htmlContent.th)
        XCTAssertEqual(result.first?.htmlContent.en, expectedPdpas.first?.htmlContent.en)
        XCTAssertEqual(result.first?.version, expectedPdpas.first?.version)
    }

    func testFetchPdpasWithoutVersion_WillGetValidResponse() async throws {
        // Given
        let expectedPdpas = Pdpas(array: [
            Pdpa(
                id: 1,
                htmlContent: Pdpa.Content(th: "นโยบายการใช้คุกกี้", 
                                         en: "Cookie Policy"),
                onDate: nil,
                version: Version(string: "1.5")!,
                updateAt: Date()
            )
        ])
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPdpas)

        let service = PDPARemoteService(localStorage: localStorage,
                                       apiManager: apiManager)
        let request = PDPAServiceRequest.FetchPdpas(version: nil)

        // When
        let result = try await service.fetchPdpas(request: request)

        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.id, 1)
        XCTAssertEqual(result.first?.htmlContent.th, "นโยบายการใช้คุกกี้")
        XCTAssertEqual(result.first?.htmlContent.en, "Cookie Policy")
        XCTAssertEqual(result.first?.version.raw, "1.5.0")
        XCTAssertNil(result.first?.onDate)
    }

    func testFetchPdpa_WillGetValidResponse() async throws {
        // Given
        let expectedPdpa = Pdpa(
            id: 3,
            htmlContent: Pdpa.Content(
                th: "ข้อกำหนดและเงื่อนไขในการให้บริการของโรงแรม",
                en: "Hotel Terms and Conditions of Service"
            ),
            onDate: Date(),
            version: Version(string: "3.2")!,
            updateAt: Date()
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPdpa)

        let service = PDPARemoteService(localStorage: localStorage, 
                                       apiManager: apiManager)
        let request = PDPAServiceRequest.FetchPdpa(id: 3)

        // When
        let result = try await service.fetchPdpa(request: request)

        // Then
        XCTAssertEqual(result.id, expectedPdpa.id)
        XCTAssertEqual(result.htmlContent.th, expectedPdpa.htmlContent.th)
        XCTAssertEqual(result.htmlContent.en, expectedPdpa.htmlContent.en)
        XCTAssertEqual(result.version, expectedPdpa.version)
        XCTAssertNotNil(result.onDate)
        XCTAssertNotNil(result.updateAt)
    }

    func testFetchPdpaWithPartialContent_WillGetValidResponse() async throws {
        // Given
        let expectedPdpa = Pdpa(
            id: 4,
            htmlContent: Pdpa.Content(
                th: "นโยบายความเป็นส่วนตัว",
                en: nil // Testing partial content
            ),
            onDate: nil,
            version: Version(string: "1.0")!,
            updateAt: Date()
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPdpa)

        let service = PDPARemoteService(localStorage: localStorage, 
                                       apiManager: apiManager)
        let request = PDPAServiceRequest.FetchPdpa(id: 4)

        // When
        let result = try await service.fetchPdpa(request: request)

        // Then
        XCTAssertEqual(result.id, expectedPdpa.id)
        XCTAssertEqual(result.htmlContent.th, "นโยบายความเป็นส่วนตัว")
        XCTAssertNil(result.htmlContent.en)
        XCTAssertEqual(result.version.raw, "1.0.0")
        XCTAssertNil(result.onDate)
    }

    func testFetchPdpasEmpty_WillGetEmptyResponse() async throws {
        // Given
        let expectedPdpas = Pdpas(array: [])
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPdpas)

        let service = PDPARemoteService(localStorage: localStorage,
                                       apiManager: apiManager)
        let request = PDPAServiceRequest.FetchPdpas(
            version: Version(string: "999.0")
        )

        // When
        let result = try await service.fetchPdpas(request: request)

        // Then
        XCTAssertEqual(result.count, 0)
    }

    func testFetchPdpa_WhenAPIThrowsError_WillThrowError() async {
        // Given
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce { (_, _) -> Pdpa in
                throw APIError.unknownError(title: "Test Error",
                                           subtitle: nil,
                                           underlying: nil)
            }

        let service = PDPARemoteService(localStorage: localStorage, 
                                       apiManager: apiManager)
        let request = PDPAServiceRequest.FetchPdpa(id: 999)

        // When/Then
        do {
            _ = try await service.fetchPdpa(request: request)
            XCTFail("Should throw error")
        } catch let error as APIError {
            if case .unknownError(let title, _, _) = error {
                XCTAssertEqual(title, "Test Error")
            } else {
                XCTFail("Should throw APIError.unknownError")
            }
        } catch {
            XCTFail("Should throw APIError")
        }
    }

    func testFetchPdpas_WhenAPIThrowsError_WillThrowError() async {
        // Given
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce { (_, _) -> Pdpas in
                throw APIError.invalidURL
            }

        let service = PDPARemoteService(localStorage: localStorage,
                                       apiManager: apiManager)
        let request = PDPAServiceRequest.FetchPdpas(version: nil)

        // When/Then
        do {
            _ = try await service.fetchPdpas(request: request)
            XCTFail("Should throw error")
        } catch let error as APIError {
            switch error {
            case .invalidURL:
                break
            default:
                XCTFail("Should throw APIError.invalidURL")
            }
        } catch {
            XCTFail("Should throw APIError.invalidURL")
        }
    }
} 
