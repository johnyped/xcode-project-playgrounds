//
//  PropertyRuleRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest
import Mockable


final class PropertyRuleRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchPropertyRuleContent_WillGetValidResponse() async throws {
        // Given
        let expectedPropertyRule = PropertyRule(
            htmlContent: PropertyRule.Content(th: "กฎของโรงแรม",
                                              en: "Hotel Rules"),
            updatedAt: Date()
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPropertyRule)

        let service = PropertyRuleRemoteService(localStorage: localStorage,
                                               apiManager: apiManager)
        let request = PropertyRuleServiceRequest.FetchPropertyRuleContent(hotelId: 105)

        // When
        let result = try await service.fetchPropertyRuleContent(request: request)

        // Then
        XCTAssertEqual(result.htmlContent.th, expectedPropertyRule.htmlContent.th)
        XCTAssertEqual(result.htmlContent.en, expectedPropertyRule.htmlContent.en)
        XCTAssertNotNil(result.updatedAt)
    }

    func testFetchPropertyRulePdfURLs_WillGetValidResponse() async throws {
        // Given
        let expectedPdfURL = PropertyRule.PdfURL(
            th: "/hotels/rules/pdf?locale=th&token=mIA-TFQNHdhfprawJowi8g",
            en: "/hotels/rules/pdf?locale=en&token=mIA-TFQNHdhfprawJowi8g"
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPdfURL)

        let service = PropertyRuleRemoteService(localStorage: localStorage, 
                                               apiManager: apiManager)
        let request = PropertyRuleServiceRequest.FetchPropertyRulePdfURLs(hotelId: 105)

        // When
        let result = try await service.fetchPropertyRulePdfURLs(request: request)

        // Then
        XCTAssertEqual(result.th, expectedPdfURL.th)
        XCTAssertEqual(result.en, expectedPdfURL.en)
        XCTAssertNotNil(result.thURL)
        XCTAssertNotNil(result.enURL)
    }

    func testFetchPropertyRuleHTMLURLs_WillGetValidResponse() async throws {
        // Given
        let expectedHtmlURL = PropertyRule.HtmlURL(
            th: "/hotels/rules/html?locale=th&token=abc123",
            en: "/hotels/rules/html?locale=en&token=abc123"
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedHtmlURL)

        let service = PropertyRuleRemoteService(localStorage: localStorage, 
                                               apiManager: apiManager)
        let request = PropertyRuleServiceRequest.FetchPropertyRuleHTMLURLs(hotelId: 105)

        // When
        let result = try await service.fetchPropertyRuleHTMLURLs(request: request)

        // Then
        XCTAssertEqual(result.th, expectedHtmlURL.th)
        XCTAssertEqual(result.en, expectedHtmlURL.en)
        XCTAssertNotNil(result.thURL)
        XCTAssertNotNil(result.enURL)
    }

    func testUpdatePropertyRuleContent_WillGetValidResponse() async throws {
        // Given
        let expectedPropertyRule = PropertyRule(
            htmlContent: PropertyRule.Content(
                th: "กฎของโรงแรมที่อัพเดทแล้ว", 
                en: "Updated Hotel Rules"
            ),
            updatedAt: Date()
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPropertyRule)

        let service = PropertyRuleRemoteService(localStorage: localStorage, 
                                               apiManager: apiManager)
        let request = PropertyRuleServiceRequest.UpdatePropertyRuleContent(
            hotelId: 105,
            thContent: "กฎของโรงแรมที่อัพเดทแล้ว",
            enContent: "Updated Hotel Rules"
        )

        // When
        let result = try await service.updatePropertyRuleContent(request: request)

        // Then
        XCTAssertEqual(result.htmlContent.th, expectedPropertyRule.htmlContent.th)
        XCTAssertEqual(result.htmlContent.en, expectedPropertyRule.htmlContent.en)
        XCTAssertNotNil(result.updatedAt)
    }

    func testUpdatePropertyRuleContent_WithPartialData_WillGetValidResponse() async throws {
        // Given
        let expectedPropertyRule = PropertyRule(
            htmlContent: PropertyRule.Content(
                th: "เฉพาะภาษาไทยเท่านั้น", 
                en: nil
            ),
            updatedAt: Date()
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPropertyRule)

        let service = PropertyRuleRemoteService(localStorage: localStorage, 
                                               apiManager: apiManager)
        let request = PropertyRuleServiceRequest.UpdatePropertyRuleContent(
            hotelId: 105,
            thContent: "เฉพาะภาษาไทยเท่านั้น",
            enContent: nil
        )

        // When
        let result = try await service.updatePropertyRuleContent(request: request)

        // Then
        XCTAssertEqual(result.htmlContent.th, expectedPropertyRule.htmlContent.th)
        XCTAssertNil(result.htmlContent.en)
        XCTAssertNotNil(result.updatedAt)
    }

    func testFetchPropertyRuleContent_WithDifferentHotelId_WillGetValidResponse() async throws {
        // Given
        let expectedPropertyRule = PropertyRule(
            htmlContent: PropertyRule.Content(th: "กฎโรงแรมอื่น", en: "Other Hotel Rules"),
            updatedAt: Date()
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPropertyRule)

        let service = PropertyRuleRemoteService(localStorage: localStorage,
                                               apiManager: apiManager)
        let request = PropertyRuleServiceRequest.FetchPropertyRuleContent(hotelId: 200)

        // When
        let result = try await service.fetchPropertyRuleContent(request: request)

        // Then
        XCTAssertEqual(result.htmlContent.th, expectedPropertyRule.htmlContent.th)
        XCTAssertEqual(result.htmlContent.en, expectedPropertyRule.htmlContent.en)
    }
} 
