//
//  PDPAServiceRouterTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest
import Alamofire
import Mockable

final class PDPAServiceRouterTests: XCTestCase {
    
    var baseURL: String!
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()
    
    override func setUp() {
        super.setUp()
        baseURL = AppConfiguration.shared.baseURL
    }
    
    func testFetchPdpasRequest() throws {
        // Given
        let req = PDPAServiceRequest.FetchPdpas(
            version: Version(string: "1.0")
        )
        let router = PDPAServiceRouter.fetchPdpas(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        // Check base path
        XCTAssertTrue(url.absoluteString.contains(baseURL + "/v4/pdpa"))
        
        // Check version parameter
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        XCTAssertTrue(queryItems.contains { $0.name == "version" && $0.value == "1.0.0" })
        
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.get.rawValue)
    }
    
    func testFetchPdpasRequestWithoutVersion() throws {
        // Given
        let req = PDPAServiceRequest.FetchPdpas(version: nil)
        let router = PDPAServiceRouter.fetchPdpas(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        // Check base path
        XCTAssertEqual(url.absoluteString, baseURL + "/v4/pdpa")
        
        // Check no query parameters
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        XCTAssertTrue(queryItems.isEmpty)
        
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.get.rawValue)
    }
    
    func testFetchPdpasRequestWithComplexVersion() throws {
        // Given
        let req = PDPAServiceRequest.FetchPdpas(
            version: Version(string: "2.1.3")
        )
        let router = PDPAServiceRouter.fetchPdpas(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        // Check version parameter with complex version
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        XCTAssertTrue(queryItems.contains { $0.name == "version" && $0.value == "2.1.3" })
        
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.get.rawValue)
    }
    
    func testFetchPdpaRequest() throws {
        // Given
        let req = PDPAServiceRequest.FetchPdpa(id: 5)
        let router = PDPAServiceRouter.fetchPdpa(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/pdpa/5")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.get.rawValue)
    }
    
    func testFetchPdpaRequestWithLargeId() throws {
        // Given
        let req = PDPAServiceRequest.FetchPdpa(id: 999999)
        let router = PDPAServiceRouter.fetchPdpa(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/pdpa/999999")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.get.rawValue)
    }
    
    func testFetchPdpaRequestWithZeroId() throws {
        // Given
        let req = PDPAServiceRequest.FetchPdpa(id: 0)
        let router = PDPAServiceRouter.fetchPdpa(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/pdpa/0")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.get.rawValue)
    }
    
    func testAllRequestsHaveCorrectHeaders() throws {
        // Given
        let fetchPdpasReq = PDPAServiceRequest.FetchPdpas(version: nil)
        let fetchPdpaReq = PDPAServiceRequest.FetchPdpa(id: 1)
        
        let fetchPdpasRouter = PDPAServiceRouter.fetchPdpas(request: fetchPdpasReq)
        let fetchPdpaRouter = PDPAServiceRouter.fetchPdpa(request: fetchPdpaReq)
        
        // When
        let fetchPdpasRequest = try fetchPdpasRouter.asURLRequest()
        let fetchPdpaRequest = try fetchPdpaRouter.asURLRequest()
        
        // Then
        XCTAssertEqual(fetchPdpasRequest.value(forHTTPHeaderField: "Content-Type"),
                       "application/json")
        XCTAssertEqual(fetchPdpaRequest.value(forHTTPHeaderField: "Content-Type"),
                       "application/json")
    }
    
    func testRequestsHaveNilHttpBody() throws {
        // Given
        let fetchPdpasReq = PDPAServiceRequest.FetchPdpas(version: Version(string: "1.0"))
        let fetchPdpaReq = PDPAServiceRequest.FetchPdpa(id: 1)
        
        let fetchPdpasRouter = PDPAServiceRouter.fetchPdpas(request: fetchPdpasReq)
        let fetchPdpaRouter = PDPAServiceRouter.fetchPdpa(request: fetchPdpaReq)
        
        // When
        let fetchPdpasRequest = try fetchPdpasRouter.asURLRequest()
        let fetchPdpaRequest = try fetchPdpaRouter.asURLRequest()
        
        // Then
        XCTAssertNil(fetchPdpasRequest.httpBody)
        XCTAssertNil(fetchPdpaRequest.httpBody)
    }
    
    func testDomainConfiguration() {
        // Given
        let req = PDPAServiceRequest.FetchPdpa(id: 1)
        let router = PDPAServiceRouter.fetchPdpa(request: req)
        
        // Then
        XCTAssertEqual(router.domain, AppConfiguration.shared.baseURL)
    }
    
    func testRouterPathsAreCorrect() {
        // Given
        let fetchPdpasReq = PDPAServiceRequest.FetchPdpas(version: nil)
        let fetchPdpaReq = PDPAServiceRequest.FetchPdpa(id: 123)
        
        let fetchPdpasRouter = PDPAServiceRouter.fetchPdpas(request: fetchPdpasReq)
        let fetchPdpaRouter = PDPAServiceRouter.fetchPdpa(request: fetchPdpaReq)
        
        // Then
        XCTAssertEqual(fetchPdpasRouter.path, "/v4/pdpa")
        XCTAssertEqual(fetchPdpaRouter.path, "/v4/pdpa/123")
    }
    
    func testHTTPMethodsAreCorrect() {
        // Given
        let fetchPdpasReq = PDPAServiceRequest.FetchPdpas(version: nil)
        let fetchPdpaReq = PDPAServiceRequest.FetchPdpa(id: 1)
        
        let fetchPdpasRouter = PDPAServiceRouter.fetchPdpas(request: fetchPdpasReq)
        let fetchPdpaRouter = PDPAServiceRouter.fetchPdpa(request: fetchPdpaReq)
        
        // Then
        XCTAssertEqual(fetchPdpasRouter.method, .get)
        XCTAssertEqual(fetchPdpaRouter.method, .get)
    }
} 
