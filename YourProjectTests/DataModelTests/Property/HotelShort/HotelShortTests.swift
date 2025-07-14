//
//  HotelShortTests.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import XCTest

final class HotelShortTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithAllProperties() throws {
        // Arrange & Act
        let hotel = createSampleHotel()
        
        // Assert
        XCTAssertEqual(hotel.id, 1)
        XCTAssertEqual(hotel.name, "Test Hotel")
        XCTAssertEqual(hotel.quote, "Great hotel")
        XCTAssertEqual(hotel.hotelLogo300, "logo.jpg")
        XCTAssertEqual(hotel.headerLogoPhotos, ["header1.jpg", "header2.jpg"])
        XCTAssertEqual(hotel.bannerImage, "banner.jpg")
        XCTAssertEqual(hotel.logoImage, "logo.jpg")
        XCTAssertEqual(hotel.createdAt.timeIntervalSince1970, 1000)
        XCTAssertEqual(hotel.updatedAt.timeIntervalSince1970, 2000)
    }
    
    func test_initWithOptionalPropertiesAsNil() throws {
        // Arrange & Act
        let hotel = HotelShort(
            id: 1,
            status: .created,
            name: "Test Hotel",
            quote: nil,
            hotelLogo300: nil,
            headerLogoPhotos: [],
            bannerImage: nil,
            logoImage: nil,
            createdAt: Date(timeIntervalSince1970: 1000),
            updatedAt: Date(timeIntervalSince1970: 2000)
        )
        
        // Assert
        XCTAssertNil(hotel.quote)
        XCTAssertNil(hotel.hotelLogo300)
        XCTAssertTrue(hotel.headerLogoPhotos.isEmpty)
        XCTAssertNil(hotel.bannerImage)
        XCTAssertNil(hotel.logoImage)
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 107,
            "status": "CREATED",
            "name": "HMS2",
            "hotel_logo_300": null,
            "header_logo_photos": [],
            "quote": null,
            "logo_image": null,
            "banner_image": null,
            "created_at": "2021-11-13T16:23:50.637+07:00",
            "updated_at": "2021-11-13T16:23:50.637+07:00"
        }
        """.data(using: .utf8)!
        
        // Act
        let hotel = try JSONDecoder().decode(HotelShort.self, from: json)
        
        // Assert
        XCTAssertEqual(hotel.id, 107)
        XCTAssertEqual(hotel.name, "HMS2")
        XCTAssertNil(hotel.hotelLogo300)
        XCTAssertTrue(hotel.headerLogoPhotos.isEmpty)
        XCTAssertNil(hotel.quote)
        XCTAssertNil(hotel.logoImage)
        XCTAssertNil(hotel.bannerImage)
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let hotel = createSampleHotel()
        
        // Act
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(hotel)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        
        // Assert
        XCTAssertTrue(jsonString.contains("\"id\" : 1"))
        XCTAssertTrue(jsonString.contains("\"name\" : \"Test Hotel\""))
        XCTAssertTrue(jsonString.contains("\"quote\" : \"Great hotel\""))
        XCTAssertTrue(jsonString.contains("\"hotel_logo_300\" : \"logo.jpg\""))
        XCTAssertTrue(jsonString.contains("\"header_logo_photos\" : ["))
        XCTAssertTrue(jsonString.contains("\"banner_image\" : \"banner.jpg\""))
        XCTAssertTrue(jsonString.contains("\"logo_image\" : \"logo.jpg\""))
    }
    
    // MARK: - Helper Methods
    
    private func createSampleHotel() -> HotelShort {
        return HotelShort(
            id: 1,
            status: .created,
            name: "Test Hotel",
            quote: "Great hotel",
            hotelLogo300: "logo.jpg",
            headerLogoPhotos: ["header1.jpg", "header2.jpg"],
            bannerImage: "banner.jpg",
            logoImage: "logo.jpg",
            createdAt: Date(timeIntervalSince1970: 1000),
            updatedAt: Date(timeIntervalSince1970: 2000)
        )
    }
}

