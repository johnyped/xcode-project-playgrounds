//
//  AuthServiceRouterTests.swift
//  YourProject
//
//  Created by IntrodexMini on 1/2/2568 BE.
//

import XCTest
import Alamofire
import Mockable

final class AuthServiceRouterTests: XCTestCase {
    
    var baseURL: String!
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()
    
    override func setUp() {
        super.setUp()
        baseURL = AppConfiguration.shared.baseURL
    }
    
    func testEmailLoginRequest() throws {
        // Given
        let loginRequest = AuthServiceRequest.EmailLogin(username: "test@example.com",
                                                         password: "password123")
        let router = AuthServiceRouter.emailLogin(request: loginRequest)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/auth/login")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
        
        // Test parameters
        if let body = urlRequest.httpBody {
            do {
                if let json = try JSONSerialization.jsonObject(with: body,
                                                               options: []) as? [String: Any] {
                    XCTAssertEqual(json["username"] as? String, "test@example.com")
                    XCTAssertEqual(json["password"] as? String, "password123")
                } else {
                    XCTFail("JSON is not a dictionary")
                }
            } catch {
                XCTFail("Failed to parse JSON: \(error)")
            }
        } else {
            XCTFail("HTTP body is nil")
        }
    }
    
    func testRefreshTokenRequest() throws {
        // Given
        let refreshRequest = AuthServiceRequest.TokenRefresh(token: "refresh_token_123")
        let router = AuthServiceRouter.refreshToken(request: refreshRequest)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/auth/refresh")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
        
        // Test parameters
        if let body = urlRequest.httpBody {
            do {
                if let json = try JSONSerialization.jsonObject(with: body,
                                                               options: []) as? [String: Any] {
                    XCTAssertEqual(json["refresh_token"] as? String, "refresh_token_123")
                } else {
                    XCTFail("JSON is not a dictionary")
                }
            } catch {
                XCTFail("Failed to parse JSON: \(error)")
            }
        } else {
            XCTFail("HTTP body is nil")
        }
    }
    
    func testLogoutRequest() throws {
        // Given
        let router = AuthServiceRouter.logout
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/auth/logout")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
        XCTAssertNil(urlRequest.httpBody)
    }
    
    func testAppleIdLoginRequest() throws {
        // Given
        let appleLoginRequest = AuthServiceRequest.AppleIdLogin(
            code: "apple_auth_code_123",
            firstName: "John",
            lastName: "Doe",
            email: "john.doe@example.com"
        )
        let router = AuthServiceRouter.appleIdLogin(request: appleLoginRequest)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/auth/apple-login")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
        
        // Test parameters
        if let body = urlRequest.httpBody {
            do {
                if let json = try JSONSerialization.jsonObject(with: body,
                                                               options: []) as? [String: Any] {
                    XCTAssertEqual(json["code"] as? String, "apple_auth_code_123")
                    XCTAssertEqual(json["first_name"] as? String, "John")
                    XCTAssertEqual(json["last_name"] as? String, "Doe")
                    XCTAssertEqual(json["email"] as? String, "john.doe@example.com")
                } else {
                    XCTFail("JSON is not a dictionary")
                }
            } catch {
                XCTFail("Failed to parse JSON: \(error)")
            }
        } else {
            XCTFail("HTTP body is nil")
        }
    }
    
    func testAppleIdLoginRequest_WithNilValues() throws {
        // Given
        let appleLoginRequest = AuthServiceRequest.AppleIdLogin(
            code: "apple_auth_code_123",
            firstName: nil,
            lastName: nil,
            email: nil
        )
        let router = AuthServiceRouter.appleIdLogin(request: appleLoginRequest)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/auth/apple-login")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
        
        // Test parameters
        if let body = urlRequest.httpBody {
            do {
                if let json = try JSONSerialization.jsonObject(with: body,
                                                               options: []) as? [String: Any] {
                    XCTAssertEqual(json["code"] as? String, "apple_auth_code_123")
                    XCTAssertNil(json["first_name"])
                    XCTAssertNil(json["last_name"])
                    XCTAssertNil(json["email"])
                } else {
                    XCTFail("JSON is not a dictionary")
                }
            } catch {
                XCTFail("Failed to parse JSON: \(error)")
            }
        } else {
            XCTFail("HTTP body is nil")
        }
    }
    
    func testEmailLogin_WillGetValidResponse() async throws {
        let response = AuthTokenResponse(accessToken: "access_token",
                                          refreshToken: "refresh_token")
        given(apiManager).request(router: .any,
                                  requiredAuthorization: .any).willReturn(response)
        given(localStorage).setToken(.any).willReturn()
        
        let authRemoteService = AuthRemoteService(localStorage: localStorage,
                                                  apiManager: apiManager)
        
        let loginRequest = AuthServiceRequest.EmailLogin(username: "test1@email.com",
                                                         password: "12345678")
        
        try await authRemoteService.emailLogin(request: loginRequest)
            
        
        verify(localStorage).setToken(.any).called(.atLeastOnce)
    }
        
    func testEmailLogin_WhenAPIFails_ThrowsError() async {
        // Given
        let expectedError = MockError()
        given(apiManager)
            .request(router: .any,
                     requiredAuthorization: .any)
            .willProduce { a, b -> AuthTokenResponse in
                throw expectedError
            }
        
        let authRemoteService = AuthRemoteService(localStorage: localStorage,
                                                apiManager: apiManager)

        let loginRequest = AuthServiceRequest.EmailLogin(username: "test@email.com",
                                                       password: "password")

        // When/Then
        do {
            try await authRemoteService.emailLogin(request: loginRequest)
            XCTFail("Should throw an error")
        } catch {
            if error is MockError {
                XCTAssertTrue(true)
            }
            else {
                XCTFail()
            }
        }

        verify(localStorage).setToken(.any).called(.never)
    }
    
    func testFetchTokenRefresh_WillGetValidResponse() async {
        // Given
        given(localStorage).accessToken.willReturn(nil)
        given(localStorage).refreshToken.willReturn(nil)
        
        let response = AuthTokenResponse(accessToken: "access_token",
                                          refreshToken: "refresh_token")
        given(apiManager).request(router: .any,
                                  requiredAuthorization: .any).willReturn(response)
        given(localStorage).setToken(.any).willReturn()
        
        let authRemoteService = AuthRemoteService(
            localStorage: localStorage,
            apiManager: apiManager
        )
                
        // When/Then
        do {
            let request = AuthServiceRequest.TokenRefresh(token: "refresh_token")
            try await authRemoteService.tokenRefresh(request: request)
       } catch {
           XCTFail()
        }
    }
        
    func testTokenRefresh_WhenAPIFails_ThrowsError() async {
        // Given
        let expectedError = MockError()
        given(apiManager).request(router: .any,
                                  requiredAuthorization: .any).willProduce { a, b -> AuthTokenResponse in
            throw expectedError
        }
        
        let authRemoteService = AuthRemoteService(localStorage: localStorage,
                                                  apiManager: apiManager)
        
        let request = AuthServiceRequest.TokenRefresh(token: "refresh_token")
        
        // When/Then
        do {
            try await authRemoteService.tokenRefresh(request: request)
            XCTFail("Should throw an error")
        } catch {
             if error is MockError {
                XCTAssertTrue(true)
            }
            else {
                XCTFail()
            }
        }
        
        verify(localStorage).setToken(.any).called(.never)
    }
    
    func testLogout_Success() async throws {
        // Given
        given(apiManager).requestACK(router: .any,
                                   requiredAuthorization: .any).willReturn()
        given(localStorage).clearToken().willReturn()
        
        let authRemoteService = AuthRemoteService(localStorage: localStorage,
                                                apiManager: apiManager)
        
        // When
        await authRemoteService.logout()
        
        // Then
        verify(localStorage).clearToken().called(.once)
        verify(apiManager).requestACK(router: .any,
                                      requiredAuthorization: .any).called(
                                        .atLeastOnce
                                      )
    }
   
   func testLogout_WhenAPIFails_ThrowsError() async {
       // Given
       let expectedError = MockError()
       given(apiManager).requestACK(router: .any,
                                    requiredAuthorization: .any).willProduce { a, b -> Void in
           throw expectedError
       }
       given(localStorage).clearToken().willReturn()
       
       let authRemoteService = AuthRemoteService(localStorage: localStorage,
                                               apiManager: apiManager)
       
       // When/Then
       await authRemoteService.logout()
       
       verify(localStorage).clearToken().called(.once)
   }
    
}

// MARK: - Apple ID Login Service Tests
extension AuthServiceRouterTests {
    
    func testAppleIdLogin_WillGetValidResponse() async throws {
        // Given
        let response = AuthTokenResponse(accessToken: "access_token",
                                          refreshToken: "refresh_token")
        given(apiManager).request(router: .any,
                                  requiredAuthorization: .any).willReturn(response)
        given(localStorage).setToken(.any).willReturn()
        
        let authRemoteService = AuthRemoteService(localStorage: localStorage,
                                                  apiManager: apiManager)
        
        let appleLoginRequest = AuthServiceRequest.AppleIdLogin(
            code: "apple_auth_code_123",
            firstName: "John",
            lastName: "Doe",
            email: "john.doe@example.com"
        )
        
        // When
        try await authRemoteService.appleIdLogin(request: appleLoginRequest)
        
        // Then
        verify(localStorage).setToken(.any).called(.atLeastOnce)
    }
    
    func testAppleIdLogin_WhenAPIFails_ThrowsError() async {
        // Given
        let expectedError = MockError()
        given(apiManager)
            .request(router: .any,
                     requiredAuthorization: .any)
            .willProduce { a, b -> AuthTokenResponse in
                throw expectedError
            }
        
        let authRemoteService = AuthRemoteService(localStorage: localStorage,
                                                  apiManager: apiManager)

        let appleLoginRequest = AuthServiceRequest.AppleIdLogin(
            code: "apple_auth_code_123",
            firstName: "John",
            lastName: "Doe",
            email: "john.doe@example.com"
        )

        // When/Then
        do {
            try await authRemoteService.appleIdLogin(request: appleLoginRequest)
            XCTFail("Should throw an error")
        } catch {
            if error is MockError {
                XCTAssertTrue(true)
            }
            else {
                XCTFail()
            }
        }

        verify(localStorage).setToken(.any).called(.never)
    }
    
    func testAppleIdLogin_WithMinimalData_WillGetValidResponse() async throws {
        // Given
        let response = AuthTokenResponse(accessToken: "access_token",
                                          refreshToken: "refresh_token")
        given(apiManager).request(router: .any,
                                  requiredAuthorization: .any).willReturn(response)
        given(localStorage).setToken(.any).willReturn()
        
        let authRemoteService = AuthRemoteService(localStorage: localStorage,
                                                  apiManager: apiManager)
        
        let appleLoginRequest = AuthServiceRequest.AppleIdLogin(
            code: "apple_auth_code_123",
            firstName: nil,
            lastName: nil,
            email: nil
        )
        
        // When
        try await authRemoteService.appleIdLogin(request: appleLoginRequest)
        
        // Then
        verify(localStorage).setToken(.any).called(.atLeastOnce)
    }
}

// MARK: - Helper Methods
private extension AuthServiceRouterTests {
    func parseURLEncodedBody(from data: Data?) -> [String: String]? {
        guard let data = data, !data.isEmpty,
              let bodyString = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        // For debugging
        print("HTTP Body: \(bodyString)")
        
        let components = bodyString.components(separatedBy: "&")
        var parameters: [String: String] = [:]
        
        for component in components {
            let keyValuePair = component.components(separatedBy: "=")
            if keyValuePair.count == 2 {
                let key = keyValuePair[0]
                let value = keyValuePair[1].removingPercentEncoding ?? keyValuePair[1]
                parameters[key] = value
            }
        }
        
        return parameters
    }
}

extension AuthServiceRouterTests {
    struct MockError: Error {}
}

