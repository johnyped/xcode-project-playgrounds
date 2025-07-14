//
//  PropertyRuleServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest


final class PropertyRuleServiceRequestTests: XCTestCase {
    
    func testByHotelIDRequest_ShouldHaveCorrectHotelId() {
        // Given/When
        let request = PropertyRuleServiceRequest.ByHotelID(hotelId: 105)
        
        // Then
        XCTAssertEqual(request.hotelId, 105)
    }
    
    func testFetchPropertyRuleContentRequest_ShouldBeByHotelIDType() {
        // Given/When
        let request = PropertyRuleServiceRequest.FetchPropertyRuleContent(hotelId: 200)
        
        // Then
        XCTAssertEqual(request.hotelId, 200)
    }
    
    func testFetchPropertyRulePdfURLsRequest_ShouldBeByHotelIDType() {
        // Given/When
        let request = PropertyRuleServiceRequest.FetchPropertyRulePdfURLs(hotelId: 150)
        
        // Then
        XCTAssertEqual(request.hotelId, 150)
    }
    
    func testFetchPropertyRuleHTMLURLsRequest_ShouldBeByHotelIDType() {
        // Given/When
        let request = PropertyRuleServiceRequest.FetchPropertyRuleHTMLURLs(hotelId: 300)
        
        // Then
        XCTAssertEqual(request.hotelId, 300)
    }
    
    func testUpdatePropertyRuleContentRequest_ShouldHaveCorrectProperties() {
        // Given/When
        let request = PropertyRuleServiceRequest.UpdatePropertyRuleContent(
            hotelId: 105,
            thContent: "กฎของโรงแรม",
            enContent: "Hotel Rules"
        )
        
        // Then
        XCTAssertEqual(request.hotelId, 105)
        XCTAssertEqual(request.thContent, "กฎของโรงแรม")
        XCTAssertEqual(request.enContent, "Hotel Rules")
    }
    
    func testUpdatePropertyRuleContentRequest_WithNilEnContent_ShouldHaveCorrectProperties() {
        // Given/When
        let request = PropertyRuleServiceRequest.UpdatePropertyRuleContent(
            hotelId: 105,
            thContent: "เฉพาะภาษาไทย",
            enContent: nil
        )
        
        // Then
        XCTAssertEqual(request.hotelId, 105)
        XCTAssertEqual(request.thContent, "เฉพาะภาษาไทย")
        XCTAssertNil(request.enContent)
    }
    
    func testUpdatePropertyRuleContentRequest_ShouldEncodeCorrectly() throws {
        // Given
        let request = PropertyRuleServiceRequest.UpdatePropertyRuleContent(
            hotelId: 105,
            thContent: "กฎของโรงแรมทดสอบ",
            enContent: "Test Hotel Rules"
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(jsonObject)
        XCTAssertEqual(jsonObject?["hotel_id"] as? Int, 105)
        XCTAssertEqual(jsonObject?["rules_th"] as? String, "กฎของโรงแรมทดสอบ")
        XCTAssertEqual(jsonObject?["rules_en"] as? String, "Test Hotel Rules")
    }
    
    func testUpdatePropertyRuleContentRequest_WithNilValues_ShouldEncodeCorrectly() throws {
        // Given
        let request = PropertyRuleServiceRequest.UpdatePropertyRuleContent(
            hotelId: 105,
            thContent: nil,
            enContent: "English Only"
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(jsonObject)
        XCTAssertEqual(jsonObject?["hotel_id"] as? Int, 105)
        XCTAssertNil(jsonObject?["rules_th"])
        XCTAssertEqual(jsonObject?["rules_en"] as? String, "English Only")
    }
    
    func testUpdatePropertyRuleContentRequest_CodingKeys_ShouldMapCorrectly() {
        // Given
        let codingKeys = PropertyRuleServiceRequest.UpdatePropertyRuleContent.CodingKeys.self
        
        // When/Then
        XCTAssertEqual(codingKeys.hotelId.rawValue, "hotel_id")
        XCTAssertEqual(codingKeys.thContent.rawValue, "rules_th")
        XCTAssertEqual(codingKeys.enContent.rawValue, "rules_en")
    }
    
    func testByHotelIDRequest_WithDifferentHotelIds_ShouldHaveCorrectValues() {
        // Given
        let hotelIds = [1, 50, 100, 500, 1000]
        
        // When/Then
        for hotelId in hotelIds {
            let request = PropertyRuleServiceRequest.ByHotelID(hotelId: hotelId)
            XCTAssertEqual(request.hotelId, hotelId, "Hotel ID should match for \(hotelId)")
        }
    }
    
    func testUpdatePropertyRuleContentRequest_WithEmptyStrings_ShouldHaveCorrectProperties() {
        // Given/When
        let request = PropertyRuleServiceRequest.UpdatePropertyRuleContent(
            hotelId: 105,
            thContent: "",
            enContent: ""
        )
        
        // Then
        XCTAssertEqual(request.hotelId, 105)
        XCTAssertEqual(request.thContent, "")
        XCTAssertEqual(request.enContent, "")
    }
} 
