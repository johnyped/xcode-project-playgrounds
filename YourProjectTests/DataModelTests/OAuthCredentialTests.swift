//
//  OAuthCredentialTests.swift
//  YourProject
//
//  Created by IntrodexMini on 22/2/2568 BE.
//

import XCTest
import Alamofire
import Mockable

final class OAuthCredentialTests: XCTestCase {
    
    let mockLocalStorgeManager = MockLocalStorageManagerProtocal()
    
    // Valid token that expires at timestamp 1738369475 (Feb 1, 2025)
    let validToken = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiIzZTFhZmMyOTM1YzU4MGE2ZWU4ZDA4OTAwODVhMDY3NyIsImlhdCI6MTczODM2ODU3NSwiZXhwIjoxNzM4MzY5NDc1LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.rXvKtBAMq4betJrtlgh31KrZjQEE_zzp6ldqpX8x99U"
    
    override func setUp() {
        super.setUp()
        // Reset the date provider before each test
        OAuthCredential.currentDate = { Date() }
    }
    
    
    func testRequiresRefreshWithValidToken() {
        // Given
        given(mockLocalStorgeManager).accessToken.willReturn(validToken)
        given(mockLocalStorgeManager).refreshToken.willReturn("dummy-refresh-token")
            
        let credential = OAuthCredential(
            localStorageManager: mockLocalStorgeManager
        )
        
        // Mock current date to be well before expiration (1 hour before)
        let mockDate = Date(timeIntervalSince1970: 1738369475 - 3600)
        OAuthCredential.currentDate = { mockDate }
        
        // Then
        XCTAssertFalse(credential.requiresRefresh, "Token should not require refresh when well within validity period")
    }
    
    func testRequiresRefreshWithNearExpirationToken() {
        // Given
        given(mockLocalStorgeManager).accessToken.willReturn(validToken)
        given(mockLocalStorgeManager).refreshToken.willReturn("dummy-refresh-token")
            
        let credential = OAuthCredential(
            localStorageManager: mockLocalStorgeManager
        )
        
        // Mock current date to be 4 minutes before expiration (within 5-minute buffer)
        let mockDate = Date(timeIntervalSince1970: 1738369475 - 240)
        OAuthCredential.currentDate = { mockDate }
        
        // Then
        XCTAssertTrue(credential.requiresRefresh, "Token should require refresh when within 5-minute buffer before expiration")
    }
    
    func testRequiresRefreshWithExpiredToken() {
        // Given
        given(mockLocalStorgeManager).accessToken.willReturn(validToken)
        given(mockLocalStorgeManager).refreshToken.willReturn("dummy-refresh-token")
            
        let credential = OAuthCredential(
            localStorageManager: mockLocalStorgeManager
        )
        
        // Mock current date to be after expiration
        let mockDate = Date(timeIntervalSince1970: 1738369475 + 3600)
        OAuthCredential.currentDate = { mockDate }
        
        // Then
        XCTAssertTrue(credential.requiresRefresh, "Token should require refresh when expired")
    }
    
    func testRequiresRefreshWithInvalidToken() {
        // Given
        given(mockLocalStorgeManager).accessToken.willReturn("invalid-token")
        given(mockLocalStorgeManager).refreshToken.willReturn("dummy-refresh-token")
            
        let credential = OAuthCredential(
            localStorageManager: mockLocalStorgeManager
        )
        
        // Then
        XCTAssertTrue(credential.requiresRefresh, "Invalid token should require refresh")
    }
}

