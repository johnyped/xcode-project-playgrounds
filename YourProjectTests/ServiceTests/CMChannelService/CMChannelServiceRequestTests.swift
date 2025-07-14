//  CMChannelServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 14/1/2568 BE.
//

import XCTest

final class CMChannelServiceRequestTests: XCTestCase {
    
    // MARK: - FetchByHotel Tests
    
    func testFetchByHotel_WillGenerateCorrectParameters() throws {
        // Given
        let request = CMChannelServiceRequest.FetchByHotel(hotelId: 105)
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
    }
    
    func testFetchByHotel_WithDifferentHotelId_WillGenerateCorrectParameters() throws {
        // Given
        let request = CMChannelServiceRequest.FetchByHotel(hotelId: 42)
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 42)
    }
} 