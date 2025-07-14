//
//  SupportRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest
import Mockable

final class SupportRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchMinAppVersion_WillGetValidResponse() async throws {
        // Given
        
        let expectedSupportVersion = SupportVersion(minAppVersionString: "2.7.19")
        
        // Stub the API manager to return the expected support version
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedSupportVersion)

        let service = SupportRemoteService(localStorage: localStorage,
                                          apiManager: apiManager)

        // When
        let result = try await service.fetchMinAppVersion()

        // Then
        XCTAssertEqual(result.minAppVersion, expectedSupportVersion.minAppVersion)
        XCTAssertEqual(result.minAppVersion.raw, "2.7.19")
    }

    func testFetchMinAppVersion_WillHandleAPIError() async throws {
        // Given
        let expectedError = APIError.unknownError(title: "Stub error",
                                                  subtitle: nil,
                                                  underlying: nil)
        
        // Stub the API manager to throw an error
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any).willProduce{ a, b -> SupportVersion in
                throw expectedError
            }

        let service = SupportRemoteService(localStorage: localStorage,
                                          apiManager: apiManager)

        // When/Then
        do {
            _ = try await service.fetchMinAppVersion()
            XCTFail("Should have thrown an error")
        } catch {
            XCTAssertTrue(error is APIError)
            if let apiError = error as? APIError {
                switch apiError {
                case .unknownError(let title, _ , _):
                    XCTAssertEqual(title, "Stub error")
                default:
                    XCTFail()
                }
            }
        }
    }

    func testFetchMinAppVersion_WillReturnDifferentVersions() async throws {
        // Given
        let service = SupportRemoteService(localStorage: localStorage,
                                           apiManager: apiManager)
        
        let versions = ["1.0.0", "2.5.10", "3.1.5", "4.0.0"]
        var count = 0
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce{ a, b -> SupportVersion in
                let supportVersion = SupportVersion(minAppVersionString: versions[count])
                count += 1
                return supportVersion
            }
        
        for version in versions {
            // Given
            let expectedSupportVersion = SupportVersion(minAppVersionString: version)
                        
            // When
            let result = try await service.fetchMinAppVersion()
            
            // Then
            XCTAssertEqual(result.minAppVersion, expectedSupportVersion.minAppVersion)
            XCTAssertEqual(result.minAppVersion.raw, version)
        }
    }
} 
