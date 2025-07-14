//
//  PropertyRuleServiceRouterTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest
import Alamofire


final class PropertyRuleServiceRouterTests: XCTestCase {
    
    func testFetchPropertyRuleContentRouter_ShouldReturnCorrectURL() {
        // Given
        let request = PropertyRuleServiceRequest.FetchPropertyRuleContent(hotelId: 105)
        let router = PropertyRuleServiceRouter.fetchPropertyRuleContent(request: request)
        
        // When
        let urlRequest = try? router.asURLRequest()
        
        // Then
        XCTAssertNotNil(urlRequest)
        XCTAssertTrue(urlRequest?.url?.absoluteString.contains("/v4/property-rules") ?? false)
        XCTAssertEqual(urlRequest?.httpMethod, "GET")
        
        // Verify parameters
        let components = URLComponents(url: urlRequest!.url!, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems
        let hotelIdItem = queryItems?.first { $0.name == "hotel_id" }
        XCTAssertEqual(hotelIdItem?.value, "105")
    }
    
    func testFetchPropertyRulePdfURLsRouter_ShouldReturnCorrectURL() {
        // Given
        let request = PropertyRuleServiceRequest.FetchPropertyRulePdfURLs(hotelId: 200)
        let router = PropertyRuleServiceRouter.fetchPropertyRulePdfURLs(request: request)
        
        // When
        let urlRequest = try? router.asURLRequest()
        
        // Then
        XCTAssertNotNil(urlRequest)
        XCTAssertTrue(urlRequest?.url?.absoluteString.contains("/v4/property-rules") ?? false)
        XCTAssertEqual(urlRequest?.httpMethod, "GET")
        
        // Verify parameters
        let components = URLComponents(url: urlRequest!.url!, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems
        let hotelIdItem = queryItems?.first { $0.name == "hotel_id" }
        XCTAssertEqual(hotelIdItem?.value, "200")
    }
    
    func testFetchPropertyRuleHTMLURLsRouter_ShouldReturnCorrectURL() {
        // Given
        let request = PropertyRuleServiceRequest.FetchPropertyRuleHTMLURLs(hotelId: 150)
        let router = PropertyRuleServiceRouter.fetchPropertyRuleHTMLURLs(request: request)
        
        // When
        let urlRequest = try? router.asURLRequest()
        
        // Then
        XCTAssertNotNil(urlRequest)
        XCTAssertTrue(urlRequest?.url?.absoluteString.contains("/v4/property-rules") ?? false)
        XCTAssertEqual(urlRequest?.httpMethod, "GET")
        
        // Verify parameters
        let components = URLComponents(url: urlRequest!.url!, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems
        let hotelIdItem = queryItems?.first { $0.name == "hotel_id" }
        XCTAssertEqual(hotelIdItem?.value, "150")
    }
    
    func testUpdatePropertyRuleContentRouter_ShouldReturnCorrectURL() {
        // Given
        let request = PropertyRuleServiceRequest.UpdatePropertyRuleContent(
            hotelId: 105,
            thContent: "กฎของโรงแรม",
            enContent: "Hotel Rules"
        )
        let router = PropertyRuleServiceRouter.updatePropertyRuleContent(request: request)
        
        // When
        let urlRequest = try? router.asURLRequest()
        
        // Then
        XCTAssertNotNil(urlRequest)
        XCTAssertTrue(urlRequest?.url?.absoluteString.contains("/v4/property-rules") ?? false)
        XCTAssertEqual(urlRequest?.httpMethod, "PUT")
    }
    
    func testUpdatePropertyRuleContentRouter_ShouldHaveCorrectJSONBody() throws {
        // Given
        let request = PropertyRuleServiceRequest.UpdatePropertyRuleContent(
            hotelId: 105,
            thContent: "กฎของโรงแรมใหม่",
            enContent: "New Hotel Rules"
        )
        let router = PropertyRuleServiceRouter.updatePropertyRuleContent(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertNotNil(urlRequest.httpBody)
        
        let jsonData = urlRequest.httpBody!
        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
        
        XCTAssertNotNil(jsonObject)
        XCTAssertEqual(jsonObject?["hotel_id"] as? Int, 105)
        XCTAssertEqual(jsonObject?["rules_th"] as? String, "กฎของโรงแรมใหม่")
        XCTAssertEqual(jsonObject?["rules_en"] as? String, "New Hotel Rules")
    }
    
    func testUpdatePropertyRuleContentRouter_WithPartialContent_ShouldHaveCorrectJSONBody() throws {
        // Given
        let request = PropertyRuleServiceRequest.UpdatePropertyRuleContent(
            hotelId: 105,
            thContent: "เฉพาะภาษาไทย",
            enContent: nil
        )
        let router = PropertyRuleServiceRouter.updatePropertyRuleContent(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertNotNil(urlRequest.httpBody)
        
        let jsonData = urlRequest.httpBody!
        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
        
        XCTAssertNotNil(jsonObject)
        XCTAssertEqual(jsonObject?["hotel_id"] as? Int, 105)
        XCTAssertEqual(jsonObject?["rules_th"] as? String, "เฉพาะภาษาไทย")
        XCTAssertNil(jsonObject?["rules_en"])
    }
    
    func testAllFetchRouters_ShouldHaveGETMethod() {
        // Given
        let contentRequest = PropertyRuleServiceRequest.FetchPropertyRuleContent(hotelId: 105)
        let pdfRequest = PropertyRuleServiceRequest.FetchPropertyRulePdfURLs(hotelId: 105)
        let htmlRequest = PropertyRuleServiceRequest.FetchPropertyRuleHTMLURLs(hotelId: 105)
        
        let contentRouter = PropertyRuleServiceRouter.fetchPropertyRuleContent(request: contentRequest)
        let pdfRouter = PropertyRuleServiceRouter.fetchPropertyRulePdfURLs(request: pdfRequest)
        let htmlRouter = PropertyRuleServiceRouter.fetchPropertyRuleHTMLURLs(request: htmlRequest)
        
        // When/Then
        XCTAssertEqual(contentRouter.method, .get)
        XCTAssertEqual(pdfRouter.method, .get)
        XCTAssertEqual(htmlRouter.method, .get)
    }
    
    func testUpdateRouter_ShouldHavePUTMethod() {
        // Given
        let request = PropertyRuleServiceRequest.UpdatePropertyRuleContent(
            hotelId: 105,
            thContent: "Test",
            enContent: "Test"
        )
        let router = PropertyRuleServiceRouter.updatePropertyRuleContent(request: request)
        
        // When/Then
        XCTAssertEqual(router.method, .put)
    }
    
    func testRouterPaths_ShouldBeConsistent() {
        // Given
        let request = PropertyRuleServiceRequest.FetchPropertyRuleContent(hotelId: 105)
        let updateRequest = PropertyRuleServiceRequest.UpdatePropertyRuleContent(
            hotelId: 105,
            thContent: "test",
            enContent: "test"
        )
        
        let fetchRouter = PropertyRuleServiceRouter.fetchPropertyRuleContent(request: request)
        let updateRouter = PropertyRuleServiceRouter.updatePropertyRuleContent(request: updateRequest)
        
        // When/Then
        XCTAssertEqual(fetchRouter.path, "/v4/property-rules")
        XCTAssertEqual(updateRouter.path, "/v4/property-rules")
    }
} 
