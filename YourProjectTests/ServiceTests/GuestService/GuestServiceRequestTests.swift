//
//  GuestServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 7/6/2568 BE.
//

import XCTest

final class GuestServiceRequestTests: XCTestCase {
    
    func testFetchGuestsRequest_WillGenerateCorrectParameters() {
        // Given
        let request = GuestServiceRequest.FetchGuests(
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            hotelId: 105,
            includeHidden: true
        )
        
        // When
        guard let parameters = request.parameters else {
            XCTFail("Parameters should not be nil")
            return
        }
        
        // Then
        XCTAssertEqual(parameters["page"] as? Int, 1)
        XCTAssertEqual(parameters["per_page"] as? String, "20")
        XCTAssertEqual(parameters["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters["sorted_order"] as? String, "ASC")
        XCTAssertEqual(parameters["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters["include_hidden"] as? Int, 1)
    }
    
    func testFetchGuestsRequest_WithNilValues_WillGenerateMinimalParameters() {
        // Given
        let request = GuestServiceRequest.FetchGuests(
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            hotelId: nil,
            includeHidden: nil
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertTrue(parameters?.isEmpty ?? true)
    }
    
    func testFetchGuestsRequest_WithInvalidPage_WillExcludePageParameter() {
        // Given
        let request = GuestServiceRequest.FetchGuests(
            page: 0, // Invalid page
            perPage: .ten,
            sortedBy: .createdAt,
            sortedOrder: .descending,
            hotelId: 105,
            includeHidden: false
        )
        
        // When
        guard let parameters = request.parameters else {
            XCTFail("Parameters should not be nil")
            return
        }
        
        // Then
        XCTAssertNil(parameters["page"]) // Should be excluded because page < 1
        XCTAssertEqual(parameters["per_page"] as? String, "10")
        XCTAssertEqual(parameters["sorted_by"] as? String, "CREATED_AT")
        XCTAssertEqual(parameters["sorted_order"] as? String, "DESC")
        XCTAssertEqual(parameters["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters["include_hidden"] as? Int, 0)
    }
    
    func testCreateGuestRequest_WillGenerateCorrectBody() throws {
        // Given
        let dateOfBirth = Date(timeIntervalSince1970: 631152000) // 1990-01-01
        let request = GuestServiceRequest.CreateGuest(
            firstName: "John",
            lastName: "Doe",
            nationality: "THA",
            country: "THA",
            reservationId: 123,
            companyId: 456,
            hotelId: 789,
            title: "Mr.",
            middleName: "Middle",
            dateOfBirth: dateOfBirth,
            idCardNo: "1234567890123",
            passportNo: "A1234567",
            gender: .male,
            email: "john.doe@example.com",
            occupation: "Engineer",
            phone: "0812345678",
            address: "123 Main St",
            district: "District",
            province: "Province",
            zipCode: "10100",
            note: "Test note",
            nickname: "JD",
            photos: ["photo1.jpg", "photo2.jpg"],
            documentPhotos: ["doc1.jpg", "doc2.jpg"]
        )
        
        // When
        guard let body = request.body else {
            XCTFail()
            return
        }
        
        // Then
        let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any]
        
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["first_name"] as? String, "John")
        XCTAssertEqual(json?["last_name"] as? String, "Doe")
        XCTAssertEqual(json?["nationality"] as? String, "THA")
        XCTAssertEqual(json?["country"] as? String, "THA")
        XCTAssertEqual(json?["reservation_id"] as? Int, 123)
        XCTAssertEqual(json?["company_id"] as? Int, 456)
        XCTAssertEqual(json?["hotel_id"] as? Int, 789)
        XCTAssertEqual(json?["title"] as? String, "Mr.")
        XCTAssertEqual(json?["middle_name"] as? String, "Middle")
        XCTAssertEqual(json?["date_of_birth"] as? String, "1990-01-01")
        XCTAssertEqual(json?["id_card_no"] as? String, "1234567890123")
        XCTAssertEqual(json?["passport_no"] as? String, "A1234567")
        XCTAssertEqual(json?["gender"] as? String, "MALE")
        XCTAssertEqual(json?["email"] as? String, "john.doe@example.com")
        XCTAssertEqual(json?["occupation"] as? String, "Engineer")
        XCTAssertEqual(json?["phone"] as? String, "0812345678")
        XCTAssertEqual(json?["address"] as? String, "123 Main St")
        XCTAssertEqual(json?["district"] as? String, "District")
        XCTAssertEqual(json?["province"] as? String, "Province")
        XCTAssertEqual(json?["zip_code"] as? String, "10100")
        XCTAssertEqual(json?["note"] as? String, "Test note")
        XCTAssertEqual(json?["nickname"] as? String, "JD")
        XCTAssertEqual(json?["photos"] as? [String], ["photo1.jpg", "photo2.jpg"])
        XCTAssertEqual(json?["document_photos"] as? [String], ["doc1.jpg", "doc2.jpg"])
    }
    
    func testUpdateGuestRequest_WillGenerateCorrectBody() throws {
        // Given
        let dateOfBirth = Date(timeIntervalSince1970: 631152000) // 1990-01-01
        let request = GuestServiceRequest.UpdateGuest(
            id: 1,
            companyId: 456,
            title: "Mr.",
            firstName: "John",
            middleName: "Middle",
            lastName: "Doe",
            nationality: "THA",
            country: "THA",
            dateOfBirth: dateOfBirth,
            idCardNo: "1234567890123",
            passportNo: "A1234567",
            gender: .male,
            email: "john.doe@example.com",
            occupation: "Engineer",
            phone: "0812345678",
            address: "123 Main St",
            district: "District",
            province: "Province",
            zipCode: "10100",
            note: "Test note",
            nickname: "JD",
            photos: ["photo1.jpg", "photo2.jpg"],
            documentPhotos: ["doc1.jpg", "doc2.jpg"]
        )
        
        // When
        guard let body = request.body else {
            XCTFail()
            return
        }
        
        // Then
        let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any]
        
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["company_id"] as? Int, 456)
        XCTAssertEqual(json?["title"] as? String, "Mr.")
        XCTAssertEqual(json?["first_name"] as? String, "John")
        XCTAssertEqual(json?["middle_name"] as? String, "Middle")
        XCTAssertEqual(json?["last_name"] as? String, "Doe")
        XCTAssertEqual(json?["nationality"] as? String, "THA")
        XCTAssertEqual(json?["country"] as? String, "THA")
        XCTAssertEqual(json?["date_of_birth"] as? String, "1990-01-01")
        XCTAssertEqual(json?["id_card_no"] as? String, "1234567890123")
        XCTAssertEqual(json?["passport_no"] as? String, "A1234567")
        XCTAssertEqual(json?["gender"] as? String, "MALE")
        XCTAssertEqual(json?["email"] as? String, "john.doe@example.com")
        XCTAssertEqual(json?["occupation"] as? String, "Engineer")
        XCTAssertEqual(json?["phone"] as? String, "0812345678")
        XCTAssertEqual(json?["address"] as? String, "123 Main St")
        XCTAssertEqual(json?["district"] as? String, "District")
        XCTAssertEqual(json?["province"] as? String, "Province")
        XCTAssertEqual(json?["zip_code"] as? String, "10100")
        XCTAssertEqual(json?["note"] as? String, "Test note")
        XCTAssertEqual(json?["nickname"] as? String, "JD")
        XCTAssertEqual(json?["photos"] as? [String], ["photo1.jpg", "photo2.jpg"])
        XCTAssertEqual(json?["document_photos"] as? [String], ["doc1.jpg", "doc2.jpg"])
        // id should not be encoded as it's used in the URL path
        XCTAssertNil(json?["id"])
    }
    
    // MARK: - ByID Tests
    
    func testFetchGuest_WillHaveCorrectId() {
        // Given
        let request = GuestServiceRequest.FetchGuest(id: 12345)
        
        // When/Then
        XCTAssertEqual(request.id, 12345)
    }
    
    // MARK: - SortedBy Enum Tests
    
    func testSortedBy_WillHaveCorrectRawValues() {
        XCTAssertEqual(GuestServiceRequest.SortedBy.id.rawValue, "ID")
        XCTAssertEqual(GuestServiceRequest.SortedBy.createdAt.rawValue, "CREATED_AT")
        XCTAssertEqual(GuestServiceRequest.SortedBy.updatedAt.rawValue, "UPDATED_AT")
    }
} 
