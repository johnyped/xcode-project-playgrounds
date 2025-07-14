//  SyncAllotmentRouterServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 14/1/2568 BE.
//

import XCTest

final class SyncAllotmentRouterServiceTests: XCTestCase {
    
    func testFetchByIdRouter_WillHaveCorrectPath() throws {
        // Given
        let request = SyncAllotmentServiceRequest.FetchById(id: 42)
        
        // When
        let router = SyncAllotmentServiceRouter.fetchById(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/sync-allotments/42")
        XCTAssertEqual(router.method.rawValue, "GET")
        XCTAssertNil(router.parameters)
    }
    
    func testCreateSyncAllotmentRouter_WillHaveCorrectMethodAndPath() throws {
        // Given
        let request = SyncAllotmentServiceRequest.CreateSyncAllotment(
            hotelId: 105
        )
        
        // When
        let router = SyncAllotmentServiceRouter.createSyncAllotment(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/sync-allotments")
        XCTAssertEqual(router.method.rawValue, "POST")
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
} 