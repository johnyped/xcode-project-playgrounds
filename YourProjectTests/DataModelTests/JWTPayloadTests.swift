//
//  JWTPayloadTests.swift
//  YourProject
//
//  Created by IntrodexMini on 22/2/2568 BE.
//

import XCTest

final class JWTPayloadTests: XCTestCase {
    
    func testJWTPayloadDecoding() throws {
        // Given
        let jwtToken = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiIzZTFhZmMyOTM1YzU4MGE2ZWU4ZDA4OTAwODVhMDY3NyIsImlhdCI6MTczODM2ODU3NSwiZXhwIjoxNzM4MzY5NDc1LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.rXvKtBAMq4betJrtlgh31KrZjQEE_zzp6ldqpX8x99U"
        
        // When
        let payload = try JWTPayload(jwtToken: jwtToken)
        
        // Then
        XCTAssertEqual(payload.userId, 38)
        XCTAssertNil(payload.clientId)
        XCTAssertNil(payload.staffRole)
        XCTAssertEqual(payload.accessibleHotelsIds, [107, 105])
        XCTAssertNil(payload.packageExpiresAt)
        XCTAssertEqual(payload.jti, "3e1afc2935c580a6ee8d0890085a0677")
        XCTAssertEqual(payload.iat, 1738368575)
        XCTAssertEqual(payload.exp, 1738369475)
        XCTAssertEqual(payload.sub, "hms-pms-api")
        XCTAssertEqual(payload.authMethod, "hms")
    }
    
    func testInvalidJWTToken() {
        // Given
        let invalidToken = "invalid.token.format"
        
        // Then
        XCTAssertThrowsError(try JWTPayload(jwtToken: invalidToken)) { error in
            XCTAssertEqual((error as NSError).domain, "JWTDecoding")
            XCTAssertEqual((error as NSError).code, -1)
        }
    }
}

/*
// access_token: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiIzZTFhZmMyOTM1YzU4MGE2ZWU4ZDA4OTAwODVhMDY3NyIsImlhdCI6MTczODM2ODU3NSwiZXhwIjoxNzM4MzY5NDc1LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.rXvKtBAMq4betJrtlgh31KrZjQEE_zzp6ldqpX8x99U
// payload:
{
  "user_id": 38,
  "client_id": null,
  "staff_role": null,
  "accessible_hotels_ids": [
    107,
    105
  ],
  "package_expires_at": null,
  "jti": "3e1afc2935c580a6ee8d0890085a0677",
  "iat": 1738368575,
  "exp": 1738369475,
  "sub": "hms-pms-api",
  "auth_method": "hms"
}
*/
