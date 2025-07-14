//
//  GuestRegisterCardTests.swift
//  YourProject
//
//  Created by IntrodexMini on 18/6/2568 BE.
//

import XCTest

final class GuestRegisterCardTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let guestRegisterCard = createSampleGuestRegisterCard()
        
        // Assert
        XCTAssertEqual(guestRegisterCard.id, 17)
        XCTAssertEqual(guestRegisterCard.hotelId, 105)
        XCTAssertEqual(guestRegisterCard.guestId, 267)
        XCTAssertEqual(guestRegisterCard.reservationId, 987)
        XCTAssertEqual(guestRegisterCard.purposeOfVisit, .leisure)
        XCTAssertNotNil(guestRegisterCard.createdAt)
        XCTAssertNotNil(guestRegisterCard.updatedAt)
    }
    
    func test_initWithOptionalProperties() throws {
        // Arrange & Act
        let guestRegisterCard = createSampleGuestRegisterCard()
        
        // Assert
        XCTAssertEqual(guestRegisterCard.pdpaId, 1)
        XCTAssertNil(guestRegisterCard.fromAddress)
        XCTAssertNil(guestRegisterCard.nextAddress)
        XCTAssertNil(guestRegisterCard.remark)
        XCTAssertEqual(guestRegisterCard.fromCountry, "THA")
        XCTAssertEqual(guestRegisterCard.nextCountry, "THA")
    }
    
    func test_initWithDates() throws {
        // Arrange & Act
        let guestRegisterCard = createSampleGuestRegisterCard()
        
        // Assert
        XCTAssertNotNil(guestRegisterCard.acceptedRulesAt)
        XCTAssertNotNil(guestRegisterCard.acceptedPdpaAt)
        XCTAssertNotNil(guestRegisterCard.createdAt)
        XCTAssertNotNil(guestRegisterCard.updatedAt)
    }
    
    // MARK: - Purpose of Visit Tests
    
    func test_purposeOfVisitRawValues() throws {
        XCTAssertEqual(GuestRegisterCard.PurposeOfVisit.leisure.rawValue, "LEISURE")
        XCTAssertEqual(GuestRegisterCard.PurposeOfVisit.business.rawValue, "BUSINESS")
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 17,
            "purpose_of_visit": "LEISURE",
            "from_address": null,
            "next_address": null,
            "remark": null,
            "from_country": "THA",
            "next_country": "THA",
            "created_at": "2023-11-03T23:31:46.734+07:00",
            "updated_at": "2023-11-03T23:32:39.120+07:00",
            "accepted_rules_at": "2023-11-03T23:32:16.372+07:00",
            "accepted_pdpa_at": "2023-11-03T23:32:16.685+07:00",
            "hotel_id": 105,
            "guest_id": 267,
            "reservation_id": 987,
            "pdpa_id": 1
        }
        """.data(using: .utf8)!
        
        // Act
        let guestRegisterCard = try JSONDecoder().decode(GuestRegisterCard.self, from: json)
        
        // Assert
        XCTAssertEqual(guestRegisterCard.id, 17)
        XCTAssertEqual(guestRegisterCard.purposeOfVisit, .leisure)
        XCTAssertNil(guestRegisterCard.fromAddress)
        XCTAssertNil(guestRegisterCard.nextAddress)
        XCTAssertNil(guestRegisterCard.remark)
        XCTAssertEqual(guestRegisterCard.fromCountry, "THA")
        XCTAssertEqual(guestRegisterCard.nextCountry, "THA")
        XCTAssertNotNil(guestRegisterCard.createdAt)
        XCTAssertNotNil(guestRegisterCard.updatedAt)
        XCTAssertNotNil(guestRegisterCard.acceptedRulesAt)
        XCTAssertNotNil(guestRegisterCard.acceptedPdpaAt)
        XCTAssertEqual(guestRegisterCard.hotelId, 105)
        XCTAssertEqual(guestRegisterCard.guestId, 267)
        XCTAssertEqual(guestRegisterCard.reservationId, 987)
        XCTAssertEqual(guestRegisterCard.pdpaId, 1)
    }
    
    func test_decodingFromJSONWithNullValues() throws {
        // Arrange
        let json = """
        {
            "id": 18,
            "purpose_of_visit": "BUSINESS",
            "from_address": null,
            "next_address": null,
            "remark": null,
            "from_country": "USA",
            "next_country": "JPN",
            "created_at": "2023-11-04T10:15:30.500+07:00",
            "updated_at": "2023-11-04T10:16:45.750+07:00",
            "accepted_rules_at": null,
            "accepted_pdpa_at": null,
            "hotel_id": 106,
            "guest_id": 268,
            "reservation_id": 988,
            "pdpa_id": null
        }
        """.data(using: .utf8)!
        
        // Act
        let guestRegisterCard = try JSONDecoder().decode(GuestRegisterCard.self, from: json)
        
        // Assert
        XCTAssertEqual(guestRegisterCard.id, 18)
        XCTAssertEqual(guestRegisterCard.purposeOfVisit, .business)
        XCTAssertNil(guestRegisterCard.fromAddress)
        XCTAssertNil(guestRegisterCard.nextAddress)
        XCTAssertNil(guestRegisterCard.remark)
        XCTAssertEqual(guestRegisterCard.fromCountry, "USA")
        XCTAssertEqual(guestRegisterCard.nextCountry, "JPN")
        XCTAssertNotNil(guestRegisterCard.createdAt)
        XCTAssertNotNil(guestRegisterCard.updatedAt)
        XCTAssertNil(guestRegisterCard.acceptedRulesAt)
        XCTAssertNil(guestRegisterCard.acceptedPdpaAt)
        XCTAssertEqual(guestRegisterCard.hotelId, 106)
        XCTAssertEqual(guestRegisterCard.guestId, 268)
        XCTAssertEqual(guestRegisterCard.reservationId, 988)
        XCTAssertNil(guestRegisterCard.pdpaId)
    }
    
    func test_decodingFromJSONWithFilledValues() throws {
        // Arrange
        let json = """
        {
            "id": 19,
            "purpose_of_visit": "LEISURE",
            "from_address": "123 Main St, Bangkok, Thailand",
            "next_address": "456 Next Ave, Phuket, Thailand",
            "remark": "VIP guest with special requirements",
            "from_country": "THA",
            "next_country": "THA",
            "created_at": "2023-11-05T14:20:15.123+07:00",
            "updated_at": "2023-11-05T14:25:30.456+07:00",
            "accepted_rules_at": "2023-11-05T14:21:00.789+07:00",
            "accepted_pdpa_at": "2023-11-05T14:21:30.012+07:00",
            "hotel_id": 107,
            "guest_id": 269,
            "reservation_id": 989,
            "pdpa_id": 2
        }
        """.data(using: .utf8)!
        
        // Act
        let guestRegisterCard = try JSONDecoder().decode(GuestRegisterCard.self, from: json)
        
        // Assert
        XCTAssertEqual(guestRegisterCard.id, 19)
        XCTAssertEqual(guestRegisterCard.purposeOfVisit, .leisure)
        XCTAssertEqual(guestRegisterCard.fromAddress, "123 Main St, Bangkok, Thailand")
        XCTAssertEqual(guestRegisterCard.nextAddress, "456 Next Ave, Phuket, Thailand")
        XCTAssertEqual(guestRegisterCard.remark, "VIP guest with special requirements")
        XCTAssertEqual(guestRegisterCard.fromCountry, "THA")
        XCTAssertEqual(guestRegisterCard.nextCountry, "THA")
        XCTAssertNotNil(guestRegisterCard.createdAt)
        XCTAssertNotNil(guestRegisterCard.updatedAt)
        XCTAssertNotNil(guestRegisterCard.acceptedRulesAt)
        XCTAssertNotNil(guestRegisterCard.acceptedPdpaAt)
        XCTAssertEqual(guestRegisterCard.hotelId, 107)
        XCTAssertEqual(guestRegisterCard.guestId, 269)
        XCTAssertEqual(guestRegisterCard.reservationId, 989)
        XCTAssertEqual(guestRegisterCard.pdpaId, 2)
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let guestRegisterCard = createSampleGuestRegisterCard()
        
        // Act
        let jsonData = try JSONEncoder().encode(guestRegisterCard)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        
        // Assert
        XCTAssertTrue(jsonString.contains("\"id\":17"))
        XCTAssertTrue(jsonString.contains("\"purpose_of_visit\":\"LEISURE\""))
        XCTAssertTrue(jsonString.contains("\"from_country\":\"THA\""))
        XCTAssertTrue(jsonString.contains("\"next_country\":\"THA\""))
        XCTAssertTrue(jsonString.contains("\"hotel_id\":105"))
        XCTAssertTrue(jsonString.contains("\"guest_id\":267"))
        XCTAssertTrue(jsonString.contains("\"reservation_id\":987"))
        XCTAssertTrue(jsonString.contains("\"pdpa_id\":1"))
    }
    
    // MARK: - Edge Cases Tests
    
    func test_initWithBusinessPurpose() throws {
        // Arrange
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        // Act
        let guestRegisterCard = GuestRegisterCard(
            id: 20,
            hotelId: 108,
            guestId: 270,
            reservationId: 990,
            pdpaId: nil,
            purposeOfVisit: .business,
            fromAddress: "Business District, Bangkok",
            nextAddress: "Conference Center, Chiang Mai",
            remark: "Business traveler",
            fromCountry: "THA",
            nextCountry: "THA",
            acceptedRulesAt: dateFormatter.date(from: "2023-11-06T09:00:00.000+07:00"),
            acceptedPdpaAt: nil,
            createdAt: dateFormatter.date(from: "2023-11-06T08:30:00.000+07:00")!,
            updatedAt: dateFormatter.date(from: "2023-11-06T08:30:00.000+07:00")!
        )
        
        // Assert
        XCTAssertEqual(guestRegisterCard.id, 20)
        XCTAssertEqual(guestRegisterCard.purposeOfVisit, .business)
        XCTAssertEqual(guestRegisterCard.fromAddress, "Business District, Bangkok")
        XCTAssertEqual(guestRegisterCard.nextAddress, "Conference Center, Chiang Mai")
        XCTAssertEqual(guestRegisterCard.remark, "Business traveler")
        XCTAssertNotNil(guestRegisterCard.acceptedRulesAt)
        XCTAssertNil(guestRegisterCard.acceptedPdpaAt)
        XCTAssertNil(guestRegisterCard.pdpaId)
    }
    
    func test_initWithMinimalRequiredFields() throws {
        // Arrange
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        // Act
        let guestRegisterCard = GuestRegisterCard(
            id: 21,
            hotelId: 109,
            guestId: 271,
            reservationId: 991,
            pdpaId: nil,
            purposeOfVisit: .leisure,
            fromAddress: nil,
            nextAddress: nil,
            remark: nil,
            fromCountry: nil,
            nextCountry: nil,
            acceptedRulesAt: nil,
            acceptedPdpaAt: nil,
            createdAt: dateFormatter.date(from: "2023-11-07T10:00:00.000+07:00")!,
            updatedAt: dateFormatter.date(from: "2023-11-07T10:00:00.000+07:00")!
        )
        
        // Assert
        XCTAssertEqual(guestRegisterCard.id, 21)
        XCTAssertEqual(guestRegisterCard.hotelId, 109)
        XCTAssertEqual(guestRegisterCard.guestId, 271)
        XCTAssertEqual(guestRegisterCard.reservationId, 991)
        XCTAssertNil(guestRegisterCard.pdpaId)
        XCTAssertEqual(guestRegisterCard.purposeOfVisit, .leisure)
        XCTAssertNil(guestRegisterCard.fromAddress)
        XCTAssertNil(guestRegisterCard.nextAddress)
        XCTAssertNil(guestRegisterCard.remark)
        XCTAssertNil(guestRegisterCard.fromCountry)
        XCTAssertNil(guestRegisterCard.nextCountry)
        XCTAssertNil(guestRegisterCard.acceptedRulesAt)
        XCTAssertNil(guestRegisterCard.acceptedPdpaAt)
        XCTAssertNotNil(guestRegisterCard.createdAt)
        XCTAssertNotNil(guestRegisterCard.updatedAt)
    }
    
    // MARK: - Helper Methods
    
    private func createSampleGuestRegisterCard() -> GuestRegisterCard {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        return GuestRegisterCard(
            id: 17,
            hotelId: 105,
            guestId: 267,
            reservationId: 987,
            pdpaId: 1,
            purposeOfVisit: .leisure,
            fromAddress: nil,
            nextAddress: nil,
            remark: nil,
            fromCountry: "THA",
            nextCountry: "THA",
            acceptedRulesAt: dateFormatter.date(from: "2023-11-03T23:32:16.372+07:00"),
            acceptedPdpaAt: dateFormatter.date(from: "2023-11-03T23:32:16.685+07:00"),
            createdAt: dateFormatter.date(from: "2023-11-03T23:31:46.734+07:00")!,
            updatedAt: dateFormatter.date(from: "2023-11-03T23:32:39.120+07:00")!
        )
    }
} 
