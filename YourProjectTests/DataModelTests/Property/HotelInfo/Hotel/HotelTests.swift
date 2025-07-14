//
//  HotelTests.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import XCTest

final class HotelTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithAllProperties() throws {
        // Arrange & Act
        let hotel = createSampleHotel()
        
        // Assert
        XCTAssertEqual(hotel.id, 105)
        XCTAssertEqual(hotel.name, "โอมเมดเสตย์")
        XCTAssertEqual(hotel.status, .created)
        XCTAssertEqual(hotel.information, "dddddddd")
        XCTAssertEqual(hotel.address, "127/4 ถ. สุขุมวิท แขวง พระโขนงเหนือ เขตวัฒนา กรุงเทพมหานคร 10110 ประเทศไทย")
        XCTAssertEqual(hotel.geolocation, "test geolocation")
        XCTAssertEqual(hotel.phone, "0223232655")
        XCTAssertEqual(hotel.policies, "test policies")
        XCTAssertEqual(hotel.email, "asdd@asd.com")
        XCTAssertEqual(hotel.website, "https://test.com")
        XCTAssertEqual(hotel.workingTime, "09:00-18:00")
        XCTAssertEqual(hotel.checkInTime, "14:00")
        XCTAssertEqual(hotel.checkOutTime, "12:00")
        XCTAssertEqual(hotel.note, "test note")
        XCTAssertEqual(hotel.hotelLogo300, "logo300.jpg")
        XCTAssertEqual(hotel.taxNumber, "1234567890123")
        XCTAssertEqual(hotel.photos, ["photo1.jpg", "photo2.jpg"])
        XCTAssertEqual(hotel.headerLogoPhotos, ["header1.jpg", "header2.jpg"])
        XCTAssertEqual(hotel.tags, ["luxury", "business"])
        XCTAssertEqual(hotel.quote, "ฟกฟกไฟหกฟกหก")
        XCTAssertEqual(hotel.termAndCondition, "344r///ำ  sdfdsf  ")
        XCTAssertEqual(hotel.latitude, "13.706704797987564")
        XCTAssertEqual(hotel.longitude, "100.60173992067575")
        XCTAssertEqual(hotel.logoImage, "logo.jpg")
        XCTAssertEqual(hotel.bannerImage, "banner.jpg")
        XCTAssertEqual(hotel.createdAt.timeIntervalSince1970, 1000)
        XCTAssertEqual(hotel.updatedAt.timeIntervalSince1970, 2000)
    }
    
    func test_initWithOptionalPropertiesAsNil() throws {
        // Arrange & Act
        let hotel = Hotel(
            id: 1,
            name: "Test Hotel",
            status: .created,
            information: "Test Information",
            address: "Test Address",
            geolocation: nil,
            phone: nil,
            policies: nil,
            email: nil,
            website: nil,
            workingTime: nil,
            checkInTime: nil,
            checkOutTime: nil,
            note: nil,
            hotelLogo300: nil,
            taxNumber: nil,
            photos: [],
            headerLogoPhotos: [],
            tags: [],
            quote: nil,
            termAndCondition: nil,
            latitude: nil,
            longitude: nil,
            logoImage: nil,
            bannerImage: nil,
            createdAt: Date(timeIntervalSince1970: 1000),
            updatedAt: Date(timeIntervalSince1970: 2000)
        )
        
        // Assert
        XCTAssertNil(hotel.geolocation)
        XCTAssertNil(hotel.phone)
        XCTAssertNil(hotel.policies)
        XCTAssertNil(hotel.email)
        XCTAssertNil(hotel.website)
        XCTAssertNil(hotel.workingTime)
        XCTAssertNil(hotel.checkInTime)
        XCTAssertNil(hotel.checkOutTime)
        XCTAssertNil(hotel.note)
        XCTAssertNil(hotel.hotelLogo300)
        XCTAssertNil(hotel.taxNumber)
        XCTAssertTrue(hotel.photos.isEmpty)
        XCTAssertTrue(hotel.headerLogoPhotos.isEmpty)
        XCTAssertTrue(hotel.tags.isEmpty)
        XCTAssertNil(hotel.quote)
        XCTAssertNil(hotel.termAndCondition)
        XCTAssertNil(hotel.latitude)
        XCTAssertNil(hotel.longitude)
        XCTAssertNil(hotel.logoImage)
        XCTAssertNil(hotel.bannerImage)
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 105,
            "name": "โอมเมดเสตย์",
            "status": "CREATED",
            "information": "dddddddd",
            "address": "127/4 ถ. สุขุมวิท แขวง พระโขนงเหนือ เขตวัฒนา กรุงเทพมหานคร 10110 ประเทศไทย",
            "geolocation": null,
            "phone": "0223232655",
            "policies": null,
            "email": "asdd@asd.com",
            "website": null,
            "working_time": "",
            "check_in_time": "1",
            "check_out_time": "2",
            "note": null,
            "hotel_logo_300": null,
            "tax_number": null,
            "photos": [],
            "header_logo_photos": [],
            "tags": [],
            "quote": "ฟกฟกไฟหกฟกหก",
            "term_and_condition": "344r///ำ  sdfdsf  ",
            "latitude": "13.706704797987564",
            "longitude": "100.60173992067575",
            "logo_image": "https://hms-heroku.s3.ap-southeast-1.amazonaws.com/documents/c3b43969-ac5b-4099-9351-6607cd778475/BFD53D03-8E67-491B-BCF7-45C3D0B8451C.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2I7XJ7WJNRHU7NRV%2F20250509%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250509T010227Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=aad33c5b285172985dd43619af1af64ad821a4f98a3206b12ed864b00b20b8c0",
            "banner_image": null,
            "created_at": "2019-11-19T17:08:46.877+07:00",
            "updated_at": "2024-05-11T06:13:49.864+07:00"
        }
        """.data(using: .utf8)!
        
        // Act
        let hotel = try JSONDecoder().decode(Hotel.self, from: json)
        
        // Assert
        XCTAssertEqual(hotel.id, 105)
        XCTAssertEqual(hotel.name, "โอมเมดเสตย์")
        XCTAssertEqual(hotel.status, .created)
        XCTAssertEqual(hotel.information, "dddddddd")
        XCTAssertEqual(hotel.address, "127/4 ถ. สุขุมวิท แขวง พระโขนงเหนือ เขตวัฒนา กรุงเทพมหานคร 10110 ประเทศไทย")
        XCTAssertNil(hotel.geolocation)
        XCTAssertEqual(hotel.phone, "0223232655")
        XCTAssertNil(hotel.policies)
        XCTAssertEqual(hotel.email, "asdd@asd.com")
        XCTAssertNil(hotel.website)
        XCTAssertEqual(hotel.workingTime, "")
        XCTAssertEqual(hotel.checkInTime, "1")
        XCTAssertEqual(hotel.checkOutTime, "2")
        XCTAssertNil(hotel.note)
        XCTAssertNil(hotel.hotelLogo300)
        XCTAssertNil(hotel.taxNumber)
        XCTAssertTrue(hotel.photos.isEmpty)
        XCTAssertTrue(hotel.headerLogoPhotos.isEmpty)
        XCTAssertTrue(hotel.tags.isEmpty)
        XCTAssertEqual(hotel.quote, "ฟกฟกไฟหกฟกหก")
        XCTAssertEqual(hotel.termAndCondition, "344r///ำ  sdfdsf  ")
        XCTAssertEqual(hotel.latitude, "13.706704797987564")
        XCTAssertEqual(hotel.longitude, "100.60173992067575")
        XCTAssertTrue(hotel.logoImage?.contains("hms-heroku.s3.ap-southeast-1.amazonaws.com") == true)
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
        XCTAssertTrue(jsonString.contains("\"id\" : 105"))
        XCTAssertTrue(jsonString.contains("\"name\" : \"โอมเมดเสตย์\""))
        XCTAssertTrue(jsonString.contains("\"status\" : \"CREATED\""))
        XCTAssertTrue(jsonString.contains("\"information\" : \"dddddddd\""))
        XCTAssertTrue(jsonString.contains("\"address\" : \"127\\/4 ถ. สุขุมวิท แขวง พระโขนงเหนือ เขตวัฒนา กรุงเทพมหานคร 10110 ประเทศไทย\""))
        XCTAssertTrue(jsonString.contains("\"geolocation\" : \"test geolocation\""))
        XCTAssertTrue(jsonString.contains("\"phone\" : \"0223232655\""))
        XCTAssertTrue(jsonString.contains("\"policies\" : \"test policies\""))
        XCTAssertTrue(jsonString.contains("\"email\" : \"asdd@asd.com\""))
        XCTAssertTrue(jsonString.contains("\"website\" : \"https:\\/\\/test.com\""))
        XCTAssertTrue(jsonString.contains("\"working_time\" : \"09:00-18:00\""))
        XCTAssertTrue(jsonString.contains("\"check_in_time\" : \"14:00\""))
        XCTAssertTrue(jsonString.contains("\"check_out_time\" : \"12:00\""))
        XCTAssertTrue(jsonString.contains("\"note\" : \"test note\""))
        XCTAssertTrue(jsonString.contains("\"hotel_logo_300\" : \"logo300.jpg\""))
        XCTAssertTrue(jsonString.contains("\"tax_number\" : \"1234567890123\""))
        XCTAssertTrue(jsonString.contains("\"photos\" : ["))
        XCTAssertTrue(jsonString.contains("\"header_logo_photos\" : ["))
        XCTAssertTrue(jsonString.contains("\"tags\" : ["))
        XCTAssertTrue(jsonString.contains("\"quote\" : \"ฟกฟกไฟหกฟกหก\""))
        XCTAssertTrue(jsonString.contains("\"term_and_condition\" : \"344r\\/\\/\\/ำ  sdfdsf  \""))
        XCTAssertTrue(jsonString.contains("\"latitude\" : \"13.706704797987564\""))
        XCTAssertTrue(jsonString.contains("\"longitude\" : \"100.60173992067575\""))
        XCTAssertTrue(jsonString.contains("\"logo_image\" : \"logo.jpg\""))
        XCTAssertTrue(jsonString.contains("\"banner_image\" : \"banner.jpg\""))
    }
    
    // MARK: - Helper Methods
    
    private func createSampleHotel() -> Hotel {
        return Hotel(
            id: 105,
            name: "โอมเมดเสตย์",
            status: .created,
            information: "dddddddd",
            address: "127/4 ถ. สุขุมวิท แขวง พระโขนงเหนือ เขตวัฒนา กรุงเทพมหานคร 10110 ประเทศไทย",
            geolocation: "test geolocation",
            phone: "0223232655",
            policies: "test policies",
            email: "asdd@asd.com",
            website: "https://test.com",
            workingTime: "09:00-18:00",
            checkInTime: "14:00",
            checkOutTime: "12:00",
            note: "test note",
            hotelLogo300: "logo300.jpg",
            taxNumber: "1234567890123",
            photos: ["photo1.jpg", "photo2.jpg"],
            headerLogoPhotos: ["header1.jpg", "header2.jpg"],
            tags: ["luxury", "business"],
            quote: "ฟกฟกไฟหกฟกหก",
            termAndCondition: "344r///ำ  sdfdsf  ",
            latitude: "13.706704797987564",
            longitude: "100.60173992067575",
            logoImage: "logo.jpg",
            bannerImage: "banner.jpg",
            createdAt: Date(timeIntervalSince1970: 1000),
            updatedAt: Date(timeIntervalSince1970: 2000)
        )
    }
} 
