//
//  CMRateCodesTests.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import XCTest

final class CMRateCodesTests: XCTestCase {
    
    // MARK: - CMRateCode Tests
    
    func test_cmRateCodeInitialization() throws {
        // Arrange & Act
        let rateCode = CMRateCode(name: "None Refund", code: "9705762")
        
        // Assert
        XCTAssertEqual(rateCode.name, "None Refund")
        XCTAssertEqual(rateCode.code, "9705762")
    }
    
    func test_cmRateCodeDecodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "name": "Standard",
            "code": "20774025"
        }
        """.data(using: .utf8)!
        
        // Act
        let rateCode = try JSONDecoder().decode(CMRateCode.self, from: json)
        
        // Assert
        XCTAssertEqual(rateCode.name, "Standard")
        XCTAssertEqual(rateCode.code, "20774025")
    }
    
    func test_cmRateCodeEncodingToJSON() throws {
        // Arrange
        let rateCode = CMRateCode(name: "None Refund", code: "9705762")
        
        // Act
        let encodedData = try JSONEncoder().encode(rateCode)
        let decodedRateCode = try JSONDecoder().decode(CMRateCode.self, from: encodedData)
        
        // Assert
        XCTAssertEqual(decodedRateCode.name, rateCode.name)
        XCTAssertEqual(decodedRateCode.code, rateCode.code)
    }
    
    // MARK: - CMRateCodes Tests
    
    func test_cmRateCodesDefaultInitialization() throws {
        // Arrange & Act
        let rateCodes = CMRateCodes()
        
        // Assert
        XCTAssertTrue(rateCodes.bookingcomRateCode.isEmpty)
        XCTAssertTrue(rateCodes.agodacomRateCode.isEmpty)
        XCTAssertTrue(rateCodes.ctripRateCode.isEmpty)
        XCTAssertTrue(rateCodes.expediacomRateCode.isEmpty)
        XCTAssertTrue(rateCodes.travelokacomRateCode.isEmpty)
        XCTAssertTrue(rateCodes.traviaRateCode.isEmpty)
    }
    
    func test_cmRateCodesDecodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "bookingcomRateCode": [
                {
                    "name": "None Refund",
                    "code": "9705762"
                },
                {
                    "name": "Standard",
                    "code": "20774025"
                }
            ],
            "agodacomRateCode": [],
            "ctripRateCode": [],
            "expediacomRateCode": [
                {
                    "name": "Flexible",
                    "code": "12345"
                }
            ],
            "travelokacomRateCode": [],
            "traviaRateCode": []
        }
        """.data(using: .utf8)!
        
        // Act
        let rateCodes = try JSONDecoder().decode(CMRateCodes.self, from: json)
        
        // Assert
        XCTAssertEqual(rateCodes.bookingcomRateCode.count, 2)
        XCTAssertEqual(rateCodes.bookingcomRateCode[0].name, "None Refund")
        XCTAssertEqual(rateCodes.bookingcomRateCode[0].code, "9705762")
        XCTAssertEqual(rateCodes.bookingcomRateCode[1].name, "Standard")
        XCTAssertEqual(rateCodes.bookingcomRateCode[1].code, "20774025")
        
        XCTAssertTrue(rateCodes.agodacomRateCode.isEmpty)
        XCTAssertTrue(rateCodes.ctripRateCode.isEmpty)
        XCTAssertTrue(rateCodes.travelokacomRateCode.isEmpty)
        XCTAssertTrue(rateCodes.traviaRateCode.isEmpty)
        
        XCTAssertEqual(rateCodes.expediacomRateCode.count, 1)
        XCTAssertEqual(rateCodes.expediacomRateCode[0].name, "Flexible")
        XCTAssertEqual(rateCodes.expediacomRateCode[0].code, "12345")
    }
    
    func test_cmRateCodesEncodingToJSON() throws {
        // Arrange
        let rateCodes = createSampleCMRateCodes()
        
        // Act
        let encodedData = try JSONEncoder().encode(rateCodes)
        let decodedRateCodes = try JSONDecoder().decode(CMRateCodes.self, from: encodedData)
        
        // Assert
        XCTAssertEqual(decodedRateCodes.bookingcomRateCode.count, rateCodes.bookingcomRateCode.count)
        XCTAssertEqual(decodedRateCodes.agodacomRateCode.count, rateCodes.agodacomRateCode.count)
        XCTAssertEqual(decodedRateCodes.ctripRateCode.count, rateCodes.ctripRateCode.count)
        XCTAssertEqual(decodedRateCodes.expediacomRateCode.count, rateCodes.expediacomRateCode.count)
        XCTAssertEqual(decodedRateCodes.travelokacomRateCode.count, rateCodes.travelokacomRateCode.count)
        XCTAssertEqual(decodedRateCodes.traviaRateCode.count, rateCodes.traviaRateCode.count)
        
        // Test specific values
        if !decodedRateCodes.bookingcomRateCode.isEmpty {
            XCTAssertEqual(decodedRateCodes.bookingcomRateCode[0].name, rateCodes.bookingcomRateCode[0].name)
            XCTAssertEqual(decodedRateCodes.bookingcomRateCode[0].code, rateCodes.bookingcomRateCode[0].code)
        }
    }
    
    func test_cmRateCodesWithEmptyArrays() throws {
        // Arrange
        let json = """
        {
            "bookingcomRateCode": [],
            "agodacomRateCode": [],
            "ctripRateCode": [],
            "expediacomRateCode": [],
            "travelokacomRateCode": [],
            "traviaRateCode": []
        }
        """.data(using: .utf8)!
        
        // Act
        let rateCodes = try JSONDecoder().decode(CMRateCodes.self, from: json)
        
        // Assert
        XCTAssertTrue(rateCodes.bookingcomRateCode.isEmpty)
        XCTAssertTrue(rateCodes.agodacomRateCode.isEmpty)
        XCTAssertTrue(rateCodes.ctripRateCode.isEmpty)
        XCTAssertTrue(rateCodes.expediacomRateCode.isEmpty)
        XCTAssertTrue(rateCodes.travelokacomRateCode.isEmpty)
        XCTAssertTrue(rateCodes.traviaRateCode.isEmpty)
    }
    
    func test_cmRateCodesWithMultipleChannels() throws {
        // Arrange
        let json = """
        {
            "bookingcomRateCode": [
                {
                    "name": "Booking Rate 1",
                    "code": "BK001"
                }
            ],
            "agodacomRateCode": [
                {
                    "name": "Agoda Rate 1",
                    "code": "AG001"
                },
                {
                    "name": "Agoda Rate 2",
                    "code": "AG002"
                }
            ],
            "ctripRateCode": [
                {
                    "name": "Ctrip Rate 1",
                    "code": "CT001"
                }
            ],
            "expediacomRateCode": [],
            "travelokacomRateCode": [],
            "traviaRateCode": [
                {
                    "name": "Travia Rate 1",
                    "code": "TR001"
                }
            ]
        }
        """.data(using: .utf8)!
        
        // Act
        let rateCodes = try JSONDecoder().decode(CMRateCodes.self, from: json)
        
        // Assert
        XCTAssertEqual(rateCodes.bookingcomRateCode.count, 1)
        XCTAssertEqual(rateCodes.agodacomRateCode.count, 2)
        XCTAssertEqual(rateCodes.ctripRateCode.count, 1)
        XCTAssertTrue(rateCodes.expediacomRateCode.isEmpty)
        XCTAssertTrue(rateCodes.travelokacomRateCode.isEmpty)
        XCTAssertEqual(rateCodes.traviaRateCode.count, 1)
        
        // Verify specific values
        XCTAssertEqual(rateCodes.bookingcomRateCode[0].name, "Booking Rate 1")
        XCTAssertEqual(rateCodes.bookingcomRateCode[0].code, "BK001")
        
        XCTAssertEqual(rateCodes.agodacomRateCode[0].name, "Agoda Rate 1")
        XCTAssertEqual(rateCodes.agodacomRateCode[0].code, "AG001")
        XCTAssertEqual(rateCodes.agodacomRateCode[1].name, "Agoda Rate 2")
        XCTAssertEqual(rateCodes.agodacomRateCode[1].code, "AG002")
        
        XCTAssertEqual(rateCodes.ctripRateCode[0].name, "Ctrip Rate 1")
        XCTAssertEqual(rateCodes.ctripRateCode[0].code, "CT001")
        
        XCTAssertEqual(rateCodes.traviaRateCode[0].name, "Travia Rate 1")
        XCTAssertEqual(rateCodes.traviaRateCode[0].code, "TR001")
    }
    
    // MARK: - Helper Methods
    
    private func createSampleCMRateCodes() -> CMRateCodes {
        let bookingRateCode = CMRateCode(name: "None Refund", code: "9705762")
        let standardRateCode = CMRateCode(name: "Standard", code: "20774025")
        
        return CMRateCodes(
            bookingcomRateCode: [bookingRateCode, standardRateCode],
            agodacomRateCode: [],
            ctripRateCode: [],
            expediacomRateCode: [],
            travelokacomRateCode: [],
            traviaRateCode: []
        )
    }
} 