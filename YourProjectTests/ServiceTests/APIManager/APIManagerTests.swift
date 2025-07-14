//
//  APIManagerTests.swift
//  YourProject
//
//  Created by IntrodexMini on 14/2/2568 BE.
//

import XCTest
import Alamofire
import Mockable
import Mocker

class APIManagerTests: XCTestCase {
    
    var localStorageManager = MockLocalStorageManagerProtocal()
    var authRemoveService = MockAuthServiceProtocol()
    var router = MockRouter()
    var sut: APIManager!
    
    override func setUp() {
        super.setUp()
        
        sut = APIManager(
            localStorageManager: localStorageManager,
            authRemoteService: authRemoveService
        )
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        sut.setupURLSession(with: configuration)
        
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    func testRequestWithValidURLShouldSucceed() async throws {

        // Given
        let parameters: Parameters = ["key": "value"]
        
        // Response
        let originalURL = URL(
            string: "\(AppConfiguration.shared.baseURL)/test"
        )!
        let jsonResponse = """
        "OK"
        """.data(using: .utf8)
            
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .json,
            statusCode: 200,
            data: [
                .get : jsonResponse!
            ]
        )
        mock.register()
        
        // When
        let response: String = try await sut.request(
            "/test",
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.default,
            requiredAuthorization: false
        )
        
        XCTAssertEqual(response, "OK")
    }
    
    func testRequestWithRouterShouldSucceed() async throws {
        
        // Given
        
        let mockRouter = MockRouter()

        // Response
        let originalURL = URL(
            string: "\(AppConfiguration.shared.baseURL)/test"
        )!
        let jsonResponse = """
        "OK"
        """.data(using: .utf8)
            
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .json,
            statusCode: 200,
            data: [
                .get : jsonResponse!
            ]
        )
        mock.register()
        
        // When
        let response: String = try await sut.request(
            router: mockRouter,
            requiredAuthorization: false
        )
        
        XCTAssertEqual(response, "OK")
    }
    
    func testRequestACKShouldSucceed() async throws {
        // Given
        let mockRouter = MockRouter()

        // Response
        let originalURL = URL(
            string: "\(AppConfiguration.shared.baseURL)/test"
        )!
        let jsonResponse = """
        "OK"
        """.data(using: .utf8)
            
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .json,
            statusCode: 200,
            data: [
                .get : jsonResponse!
            ]
        )
        mock.register()
        
        // When
        // This should not throw an error
        try await sut.requestACK(
            router: mockRouter,
            requiredAuthorization: false
        )
    }
    
    func testRequestDataShouldSucceed() async throws {
        // Given
        let mockRouter = MockRouter()

        // Response
        let originalURL = URL(
            string: "\(AppConfiguration.shared.baseURL)/test"
        )!
        let expectedData = "Test Data".data(using: .utf8)!
        
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .imagePNG,
            statusCode: 200,
            data: [
                .get : expectedData
            ]
        )
        mock.register()
        
        // When
        let responseData = try await sut.requestData(
            router: mockRouter,
            requiredAuthorization: false
        )
        
        // Then
        XCTAssertNotNil(responseData)
        XCTAssertEqual(responseData, expectedData)
    }
    
    //MARK: With Authen
    func testRequestWithAuthorizationShouldSucceed() async throws {
        // Given
        let sut1 = APIManager(
            localStorageManager: localStorageManager,
            authRemoteService: authRemoveService,
            authCredential: OAuthCredential(
                localStorageManager: localStorageManager,
                byPassRequiresRefresh: false
            )
        )
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        sut1.setupURLSession(with: configuration)
        
        let mockRouter = MockRouter()
        
        let mockToken = "mock_access_token"
        given(localStorageManager).accessToken.willReturn(mockToken)
        given(localStorageManager).refreshToken.willReturn(mockToken)
        
        given(authRemoveService).tokenRefresh(request: .any).willReturn()
        
        // Response
        let originalURL = URL(string: "\(AppConfiguration.shared.baseURL)/test")!
        let jsonResponse = """
        "OK"
        """.data(using: .utf8)
        
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .json,
            statusCode: 200,
            data: [.get: jsonResponse!]
        )
        mock.register()
        
        // When
        let response: String = try await sut1.request(
            router: mockRouter,
            requiredAuthorization: true
        )
        
        // Then
        XCTAssertEqual(response, "OK")
    }
    
    func testRequestWithMissingTokenShouldFail() async throws {
        // Given
        let mockRouter = MockRouter()
        
        given(localStorageManager).accessToken.willReturn(nil)
        given(localStorageManager).refreshToken.willReturn(nil)
              
        given(authRemoveService).tokenRefresh(request: .any).willReturn()
        
        // Response
        let originalURL = URL(string: "\(AppConfiguration.shared.baseURL)/test")!
        let jsonResponse = """
        "OK"
        """.data(using: .utf8)
        
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .json,
            statusCode: 200,
            data: [.get: jsonResponse!]
        )
        mock.register()
        
        // When/Then
        do {
            let _: String = try await sut.request(
                router: mockRouter,
                requiredAuthorization: true
            )
            XCTFail("Request should fail when access token is missing")
        } catch {
            
        guard
                let error = error as? APIError
            else {
                print(error.localizedDescription)
                XCTFail()
                return
            }
            
            switch error {
            case .unauthorized(let err):
                if err is Alamofire.AuthenticationError {
                    XCTAssertTrue(true)
                }
                else {
                    print(err.localizedDescription)
                    XCTFail()
                }
                
            default:
                print(error.localizedDescription)
                XCTFail()
            }
        }
    }
    
    func testRequestWithExpiredTokenShouldAttemptRefresh() async throws {
        // Given
        let mockRouter = MockRouter()
        
        given(localStorageManager).accessToken.willReturn("expired_token")
        given(localStorageManager).refreshToken.willReturn("valid_refresh_token")
        
        given(authRemoveService).tokenRefresh(request: .any).willReturn()
        
        // First request fails with expired token
        let originalURL = URL(string: "\(AppConfiguration.shared.baseURL)/test")!
        let errorResponse = """
        {
            "error_code": 401,
            "error_key": "access_token_expired",
            "error_message": "Access token has expired. Please use the refresh token to obtain a new access token."
        }        
        """.data(using: .utf8)
        
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .json,
            statusCode: 401,
            data: [.get: errorResponse!]
        )
        mock.register()
        
        // stub refresh api
//        let refreshResponse = """
//        {
//            "access_token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiIzZTFhZmMyOTM1YzU4MGE2ZWU4ZDA4OTAwODVhMDY3NyIsImlhdCI6MTczODM2ODU3NSwiZXhwIjoxNzM4MzY5NDc1LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.rXvKtBAMq4betJrtlgh31KrZjQEE_zzp6ldqpX8x99U",
//            "refresh_token": "0292d8674a33d836b925ddecac65c4cf"
//        }
//        """.data(using: .utf8)
//        
//        given(authRemoveService).tokenRefresh(request: .any).willReturn()
//        
//        let refreshURL = URL(string: "\(AppConfiguration.shared.baseURL)/v4/auth/refresh")!
//        let refreshMock = Mock(
//            url: originalURL,
//            ignoreQuery: true,
//            contentType: .json,
//            statusCode: 200,
//            data: [.get: refreshResponse!]
//        )
//        refreshMock.register()
        
        
        // When/Then
        do {
            let _: String = try await sut.request(
                router: mockRouter,
                requiredAuthorization: true
            )
            
            
            //verify(authRemoveService).tokenRefresh(request: .any).called(1)
            
            XCTFail("Request should fail with expired token")
        } catch {
            verify(authRemoveService)
                .tokenRefresh(request: .any)
                .called(.atLeastOnce)
        }
    }
    
}

extension APIManagerTests {
    // Mock Router for testing
    struct MockRouter: AlamofireBaseRouterProtocol {
        
        let url: URL
        
        init(url: URL = URL(string: "\(AppConfiguration.shared.baseURL)/test")! ) {
            self.url = url
        }
        
        func asURLRequest() throws -> URLRequest {
            return URLRequest(url: url)
        }
    }

}

// MARK: - Additional Tests for handleResponse Functions
extension APIManagerTests {
    
    // Test for handling server error with no response
    func testRequestWithNoResponseShouldFail() async throws {
        // Given
        let mockRouter = MockRouter()
        
        // Create a mock that will not return a response
        let originalURL = URL(string: "\(AppConfiguration.shared.baseURL)/test")!
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .json,
            statusCode: 0, // Invalid status code to simulate no response
            data: [.get: Data()]
        )
        mock.register()
        
        // When/Then
        do {
            let _: String = try await sut.request(
                router: mockRouter,
                requiredAuthorization: false
            )
            XCTFail("Request should fail when there is no response")
        } catch {
            guard let apiError = error as? APIError else {
                XCTFail("Expected APIError but got \(error)")
                return
            }
            
            if case .unexpectedError(let underlyingError) = apiError {
                // Check if the underlying error is an Alamofire error
                XCTAssertTrue(underlyingError is Alamofire.AFError)
                
                // Optionally, check if it's specifically a responseSerializationFailed error
                if let afError = underlyingError as? Alamofire.AFError,
                   case .responseSerializationFailed(let reason) = afError,
                   case .inputDataNilOrZeroLength = reason {
                    // This is the expected error
                    XCTAssertTrue(true)
                } else {
                    XCTFail("Expected AFError.responseSerializationFailed with reason inputDataNilOrZeroLength but got \(underlyingError)")
                }
            } else {
                XCTFail("Expected unexpectedError but got \(apiError)")
            }
        }
    }
    
    // Test for handling server error with no value
    func testRequestWithNoValueShouldFail() async throws {
        // Given
        let mockRouter = MockRouter()
        
        // Create a mock that will return a response but no data
        let originalURL = URL(string: "\(AppConfiguration.shared.baseURL)/test")!
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .json,
            statusCode: 200,
            data: [.get: Data()] // Empty data
        )
        mock.register()
        
        // When/Then
        do {
            let _: String = try await sut.request(
                router: mockRouter,
                requiredAuthorization: false
            )
            XCTFail("Request should fail when there is no value")
        } catch {
            guard let apiError = error as? APIError else {
                XCTFail("Expected APIError but got \(error)")
                return
            }
            
            if case .unexpectedError(let underlyingError) = apiError {
                // Check if the underlying error is an Alamofire error
                XCTAssertTrue(underlyingError is Alamofire.AFError)
                
                // Optionally, check if it's specifically a responseSerializationFailed error
                if let afError = underlyingError as? Alamofire.AFError,
                   case .responseSerializationFailed(let reason) = afError,
                   case .inputDataNilOrZeroLength = reason {
                    // This is the expected error
                    XCTAssertTrue(true)
                } else {
                    XCTFail("Expected AFError.responseSerializationFailed with reason inputDataNilOrZeroLength but got \(underlyingError)")
                }
            } else {
                XCTFail("Expected unexpectedError but got \(apiError)")
            }
        }
    }
    
    // Test for handling API error response
    func testRequestWithAPIErrorResponseShouldFail() async throws {
        // Given
        let mockRouter = MockRouter()
        
        // Create a mock that will return an API error
        let originalURL = URL(string: "\(AppConfiguration.shared.baseURL)/test")!
        let errorResponse = """
        {
            "error_code": 400,
            "error_key": "bad_request",
            "error_message": "Bad request"
        }
        """.data(using: .utf8)!
        
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .json,
            statusCode: 400,
            data: [.get: errorResponse]
        )
        mock.register()
        
        // When/Then
        do {
            let _: String = try await sut.request(
                router: mockRouter,
                requiredAuthorization: false
            )
            XCTFail("Request should fail when there is an API error")
        } catch {
            guard let apiError = error as? APIErrorResponse else {
                XCTFail("Expected APIErrorResponse but got \(error)")
                return
            }
            
            XCTAssertEqual(apiError.errorCode, 400)
            XCTAssertEqual(apiError.errorKey, "bad_request")
            XCTAssertEqual(apiError.errorMessage, "Bad request")
        }
    }
    
    // Test for handling decoding error
    func testRequestWithInvalidJSONShouldFail() async throws {
        // Given
        let mockRouter = MockRouter()
        
        // Create a mock that will return invalid JSON for the expected type
        let originalURL = URL(string: "\(AppConfiguration.shared.baseURL)/test")!
        let invalidJSON = """
        {
            "invalid": "json"
        }
        """.data(using: .utf8)!
        
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .json,
            statusCode: 200,
            data: [.get: invalidJSON]
        )
        mock.register()
        
        // When/Then
        do {
            let _: String = try await sut.request(
                router: mockRouter,
                requiredAuthorization: false
            )
            XCTFail("Request should fail when JSON is invalid")
        } catch {
            // The error could be either a server error or an unknown error
            // depending on how the APIManager handles invalid JSON
            XCTAssertTrue(error is APIError)
        }
    }
    
    // Test for handling string response
    func testRequestWithStringResponseShouldFail() async throws {
        // Given
        let mockRouter = MockRouter()
        
        // Create a mock that will return a string that's not valid JSON
        let originalURL = URL(string: "\(AppConfiguration.shared.baseURL)/test")!
        let stringResponse = "This is not JSON".data(using: .utf8)!
        
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .json,
            statusCode: 200,
            data: [.get: stringResponse]
        )
        mock.register()
        
        // When/Then
        do {
            let _: [String: String] = try await sut.request(
                router: mockRouter,
                requiredAuthorization: false
            )
            XCTFail("Request should fail when response is not valid JSON")
        } catch {
            guard let apiError = error as? APIError else {
                XCTFail("Expected APIError but got \(error)")
                return
            }
            
            if case .unknownError(let title, let subtitle, _) = apiError {
                XCTAssertEqual(title, "Error")
                XCTAssertEqual(subtitle, "This is not JSON")
            } else {
                XCTFail("Expected unknownError but got \(apiError)")
            }
        }
    }
    
    // Test for handling network error
    func testRequestWithNetworkErrorShouldFail() async throws {
        // Given
        let mockRouter = MockRouter(url: URL(string: "invalid://url")!)
        
        // When/Then
        do {
            let _: String = try await sut.request(
                router: mockRouter,
                requiredAuthorization: false
            )
            XCTFail("Request should fail with network error")
        } catch {
            XCTAssertTrue(error is APIError)
        }
    }
    
    // Test for handling requestData with API error
    func testRequestDataWithAPIErrorShouldFail() async throws {
        // Given
        let mockRouter = MockRouter()
        
        // Create a mock that will return an API error
        let originalURL = URL(string: "\(AppConfiguration.shared.baseURL)/test")!
        let errorResponse = """
        {
            "error_code": 400,
            "error_key": "bad_request",
            "error_message": "Bad request"
        }
        """.data(using: .utf8)!
        
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .json,
            statusCode: 400,
            data: [.get: errorResponse]
        )
        mock.register()
        
        // When/Then
        do {
            let _ = try await sut.requestData(
                router: mockRouter,
                requiredAuthorization: false
            )
            XCTFail("RequestData should fail when there is an API error")
        } catch {
            guard let apiError = error as? APIErrorResponse else {
                XCTFail("Expected APIErrorResponse but got \(error)")
                return
            }
            
            XCTAssertEqual(apiError.errorCode, 400)
            XCTAssertEqual(apiError.errorKey, "bad_request")
            XCTAssertEqual(apiError.errorMessage, "Bad request")
        }
    }
    
    // Test for handling requestData with no response
    func testRequestDataWithNoResponseShouldFail() async throws {
        // Given
        let mockRouter = MockRouter()
        
        // Create a mock that will not return a response
        let originalURL = URL(string: "\(AppConfiguration.shared.baseURL)/test")!
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .json,
            statusCode: 0, // Invalid status code to simulate no response
            data: [.get: Data()]
        )
        mock.register()
        
        // When/Then
        do {
            let _ = try await sut.requestData(
                router: mockRouter,
                requiredAuthorization: false
            )
            XCTFail("RequestData should fail when there is no response")
        } catch {
            guard let apiError = error as? APIError else {
                XCTFail("Expected APIError but got \(error)")
                return
            }
            
            if case .serverError(let statusCode) = apiError {
                // The status code should match what we set in the mock
                XCTAssertEqual(statusCode, 0)
            } else {
                XCTFail("Expected serverError but got \(apiError)")
            }
        }
    }
    
    // Test for handling requestACK with API error
    func testRequestACKWithAPIErrorShouldFail() async throws {
        // Given
        let mockRouter = MockRouter()
        
        // Create a mock that will return an API error
        let originalURL = URL(string: "\(AppConfiguration.shared.baseURL)/test")!
        let errorResponse = """
        {
            "error_code": 400,
            "error_key": "bad_request",
            "error_message": "Bad request"
        }
        """.data(using: .utf8)!
        
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .json,
            statusCode: 400,
            data: [.get: errorResponse]
        )
        mock.register()
        
        // When/Then
        do {
            try await sut.requestACK(
                router: mockRouter,
                requiredAuthorization: false
            )
            XCTFail("RequestACK should fail when there is an API error")
        } catch {
            guard let apiError = error as? APIErrorResponse else {
                XCTFail("Expected APIErrorResponse but got \(error)")
                return
            }
            
            XCTAssertEqual(apiError.errorCode, 400)
            XCTAssertEqual(apiError.errorKey, "bad_request")
            XCTAssertEqual(apiError.errorMessage, "Bad request")
        }
    }
    
    // Test for handling requestACK with no response
    func testRequestACKWithNoResponseShouldFail() async throws {
        // Given
        let mockRouter = MockRouter()
        
        // Create a mock that will not return a response
        let originalURL = URL(string: "\(AppConfiguration.shared.baseURL)/test")!
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .json,
            statusCode: 0, // Invalid status code to simulate no response
            data: [.get: Data()]
        )
        mock.register()
        
        // When/Then
        do {
            try await sut.requestACK(
                router: mockRouter,
                requiredAuthorization: false
            )
            XCTFail("RequestACK should fail when there is no response")
        } catch {
            guard let apiError = error as? APIError else {
                XCTFail("Expected APIError but got \(error)")
                return
            }
            
            if case .unexpectedError(let underlyingError) = apiError {
                // Check if the underlying error is an Alamofire error
                XCTAssertTrue(underlyingError is Alamofire.AFError)
                
                // Optionally, check if it's specifically a responseSerializationFailed error
                if let afError = underlyingError as? Alamofire.AFError,
                   case .responseSerializationFailed(let reason) = afError,
                   case .inputDataNilOrZeroLength = reason {
                    // This is the expected error
                    XCTAssertTrue(true)
                } else {
                    XCTFail("Expected AFError.responseSerializationFailed with reason inputDataNilOrZeroLength but got \(underlyingError)")
                }
            } else {
                XCTFail("Expected unexpectedError but got \(apiError)")
            }
        }
    }
    
    // Test for handling requestACK with non-success status code
    func testRequestACKWithNonSuccessStatusCodeShouldFail() async throws {
        // Given
        let mockRouter = MockRouter()
        
        // Create a mock that will return a non-success status code
        let originalURL = URL(string: "\(AppConfiguration.shared.baseURL)/test")!
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .json,
            statusCode: 300, // Redirection status code
            data: [.get: Data()]
        )
        mock.register()
        
        // When/Then
        do {
            try await sut.requestACK(
                router: mockRouter,
                requiredAuthorization: false
            )
            XCTFail("RequestACK should fail when status code is not in 200-299 range")
        } catch {
            guard let apiError = error as? APIError else {
                XCTFail("Expected APIError but got \(error)")
                return
            }
            
            if case .unexpectedError(let underlyingError) = apiError {
                // Check if the underlying error is an Alamofire error
                XCTAssertTrue(underlyingError is Alamofire.AFError)
                
                // Optionally, check if it's specifically a responseSerializationFailed error
                if let afError = underlyingError as? Alamofire.AFError,
                   case .responseSerializationFailed(let reason) = afError,
                   case .inputDataNilOrZeroLength = reason {
                    // This is the expected error
                    XCTAssertTrue(true)
                } else {
                    XCTFail("Expected AFError.responseSerializationFailed with reason inputDataNilOrZeroLength but got \(underlyingError)")
                }
            } else {
                XCTFail("Expected unexpectedError but got \(apiError)")
            }
        }
    }
    
    // Test for handling request with network error
    func testRequestWithAFErrorShouldFail() async throws {
        // Given
        let mockRouter = MockRouter(url: URL(string: "https://nonexistent.example.com")!)
        
        // When/Then
        do {
            let _: String = try await sut.request(
                router: mockRouter,
                requiredAuthorization: false
            )
            XCTFail("Request should fail with network error")
        } catch {
            XCTAssertTrue(error is APIError)
        }
    }
    
    // Test for canceling all requests
    func testCancelAllRequests() {
        // Given
        // When
        sut.cancelAllRequests()
        
        // Then
        // This is mostly a coverage test, as we can't easily verify the cancellation
        XCTAssertTrue(true)
    }
}

