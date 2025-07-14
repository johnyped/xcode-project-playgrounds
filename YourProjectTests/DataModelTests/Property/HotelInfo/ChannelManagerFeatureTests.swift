//
//  ChannelManagerTests.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import Testing
import Foundation

struct ChannelManagerFeatureTests {
    
    // MARK: - Decode Tests
    
    @Test("Test decoding valid channel manager data")
    func testDecodeValidData() throws {
        // Arrange
        let json = """
        {
            "enabled": true,
            "otas": [
                {
                    "ota_name": "booking.com",
                    "beds24_id": null,
                    "enabled_sync_allotment": false,
                    "enabled_sync_rate": false
                },
                {
                    "ota_name": "agoda",
                    "beds24_id": "123",
                    "enabled_sync_allotment": true,
                    "enabled_sync_rate": true
                }
            ],
            "ota_rate_codes": {
                "bookingcomRateCode": [
                    {
                        "code": "20774025",
                        "name": "None Refund"
                    },
                    {
                        "code": "9705762",
                        "name": "Standard"
                    }
                ],
                "agodacomRateCode": [
                    {
                        "code": "A20774025",
                        "name": "Agoda"
                    }
                ]
            }
        }
        """
        
        let jsonData = json.data(using: .utf8)!
        
        // Act
        let feature = try JSONDecoder().decode(ChannelManagerFeature.self, from: jsonData)
        
        // Assert
        assert(feature.enabled == true)
        assert(feature.otas.count == 2)
        
        // Verify first OTA
        assert(feature.otas[0].otaName == "booking.com")
        assert(feature.otas[0].beds24Id == nil)
        assert(feature.otas[0].enabledSyncAllotment == false)
        assert(feature.otas[0].enabledSyncRate == false)
        
        // Verify second OTA
        assert(feature.otas[1].otaName == "agoda")
        assert(feature.otas[1].beds24Id == "123")
        assert(feature.otas[1].enabledSyncAllotment == true)
        assert(feature.otas[1].enabledSyncRate == true)
        
        // Verify rate codes
        assert(feature.otaRateCodes.count == 2)
        assert(feature.otaRateCodes["bookingcomRateCode"]?.rateCodes.count == 2)
        assert(feature.otaRateCodes["agodacomRateCode"]?.rateCodes.count == 1)
    }
    
    @Test("Test decoding minimal channel manager data")
    func testDecodeMinimalData() throws {
        // Arrange
        let json = """
        {
            "enabled": false
        }
        """
        
        let jsonData = json.data(using: .utf8)!
        
        // Act
        let feature = try JSONDecoder().decode(ChannelManagerFeature.self, from: jsonData)
        
        // Assert
        assert(feature.enabled == false)
        assert(feature.otas.isEmpty)
        assert(feature.otaRateCodes.isEmpty)
    }
    
    @Test("Test decoding invalid channel manager data throws error")
    func testDecodeInvalidData() throws {
        // Arrange
        let json = """
        {
            "invalid": true
        }
        """
        
        let jsonData = json.data(using: .utf8)!
        
        // Act & Assert
        var didThrow = false
        do {
            _ = try JSONDecoder().decode(ChannelManagerFeature.self, from: jsonData)
        } catch {
            didThrow = true
        }
        assert(didThrow)
    }
    
    // MARK: - Encode Tests
    
    @Test("Test encoding and decoding channel manager feature")
    func testEncode() throws {
        // Arrange
        let otas = [
            Ota(otaName: "test_ota", beds24Id: "123", enabledSyncAllotment: true, enabledSyncRate: false)
        ]
        
        let rateCodes = [
            RateCode(code: "TEST1", name: "Test Rate")
        ]
        
        let rateCodeList = RateCodeList(rateCodes: rateCodes)
        let otaRateCodes = ["testRateCode": rateCodeList]
        
        let feature = ChannelManagerFeature(enabled: true, otas: otas, otaRateCodes: otaRateCodes)
        
        // Act
        let encodedData = try JSONEncoder().encode(feature)
        let decodedFeature = try JSONDecoder().decode(ChannelManagerFeature.self, from: encodedData)
        
        // Assert
        assert(decodedFeature.enabled == feature.enabled)
        assert(decodedFeature.otas.count == feature.otas.count)
        assert(decodedFeature.otaRateCodes.count == feature.otaRateCodes.count)
        
        // Verify OTA details
        assert(decodedFeature.otas[0].otaName == "test_ota")
        assert(decodedFeature.otas[0].beds24Id == "123")
        assert(decodedFeature.otas[0].enabledSyncAllotment == true)
        assert(decodedFeature.otas[0].enabledSyncRate == false)
        
        // Verify rate codes
        let decodedRateCodes = decodedFeature.otaRateCodes["testRateCode"]?.rateCodes
        assert(decodedRateCodes?.count == 1)
        assert(decodedRateCodes?[0].code == "TEST1")
        assert(decodedRateCodes?[0].name == "Test Rate")
    }
}

