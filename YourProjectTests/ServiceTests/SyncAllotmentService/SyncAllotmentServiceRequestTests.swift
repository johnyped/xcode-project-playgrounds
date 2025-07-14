//  SyncAllotmentServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 14/1/2568 BE.
//

import XCTest

final class SyncAllotmentServiceRequestTests: XCTestCase {
      
    
    // MARK: - CreateSyncAllotment Tests
    
    func testCreateSyncAllotment_WillGenerateCorrectBody() throws {
        // Given
        let request = SyncAllotmentServiceRequest.CreateSyncAllotment(
            hotelId: 105
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
    }
    
} 
