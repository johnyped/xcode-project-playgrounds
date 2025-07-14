//  CMChannelRouterServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 14/1/2568 BE.
//

import XCTest

final class CMChannelRouterServiceTests: XCTestCase {
    
    func testFetchByHotelRouter_WillHaveCorrectParameters() throws {
        // Given
        let request = CMChannelServiceRequest.FetchByHotel(hotelId: 105)
        
        // When
        let router = CMChannelServiceRouter.fetchByHotel(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/cm-channels")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
    }
} 