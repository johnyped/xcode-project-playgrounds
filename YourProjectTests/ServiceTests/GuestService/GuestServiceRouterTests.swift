//
//  GuestServiceRouterTests.swift
//  YourProject
//
//  Created by IntrodexMini on 7/6/2568 BE.
//

import XCTest
import Alamofire

final class GuestServiceRouterTests: XCTestCase {
    var baseURL: String!
    
    override func setUp() {
        super.setUp()
        baseURL = AppConfiguration.shared.baseURL
    }
    
    func testFetchGuestsByHotelRequest() throws {
        let req = GuestServiceRequest.FetchGuests(
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            hotelId: 105,
            includeHidden: true
        )
        let router = GuestServiceRouter.fetchGuestsByHotel(request: req)
        let urlRequest = try router.asURLRequest()
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        XCTAssertTrue(url.absoluteString.contains(baseURL + "/v4/guests"))
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        XCTAssertTrue(queryItems.contains { $0.name == "page" && $0.value == "1" })
        XCTAssertTrue(queryItems.contains { $0.name == "per_page" && $0.value == "20" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_by" && $0.value == "ID" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_order" && $0.value == "ASC" })
        XCTAssertTrue(queryItems.contains { $0.name == "hotel_id" && $0.value == "105" })
        XCTAssertTrue(queryItems.contains { $0.name == "include_hidden" && $0.value == "1" })
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testFetchGuestRequest() throws {
        let req = GuestServiceRequest.FetchGuest(id: 2)
        let router = GuestServiceRouter.fetchGuest(request: req)
        let urlRequest = try router.asURLRequest()
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/guests/2")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testCreateGuestRequest() throws {
        let dateOfBirth = Date(timeIntervalSince1970: 631152000) // 1990-01-01
        let req = GuestServiceRequest.CreateGuest(
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
        let router = GuestServiceRouter.createGuest(request: req)
        let urlRequest = try router.asURLRequest()
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/guests")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any]
            XCTAssertEqual(json?["first_name"] as? String, "John")
            XCTAssertEqual(json?["last_name"] as? String, "Doe")
            XCTAssertEqual(json?["gender"] as? String, "MALE")
            XCTAssertEqual(json?["date_of_birth"] as? String, "1990-01-01")
        } else {
            XCTFail("HTTP body is nil")
        }
    }
    
    func testUpdateGuestRequest() throws {
        let dateOfBirth = Date(timeIntervalSince1970: 631152000) // 1990-01-01
        let req = GuestServiceRequest.UpdateGuest(
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
        let router = GuestServiceRouter.updateGuest(request: req)
        let urlRequest = try router.asURLRequest()
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/guests/1")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.put.rawValue)
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any]
            XCTAssertEqual(json?["first_name"] as? String, "John")
            XCTAssertEqual(json?["last_name"] as? String, "Doe")
            XCTAssertEqual(json?["gender"] as? String, "MALE")
            XCTAssertEqual(json?["date_of_birth"] as? String, "1990-01-01")
            // id should not be in the JSON body
            XCTAssertNil(json?["id"])
        } else {
            XCTFail("HTTP body is nil")
        }
    }
    
    func testDeleteGuestRequest() throws {
        let req = GuestServiceRequest.DeleteGuest(id: 3)
        let router = GuestServiceRouter.deleteGuest(request: req)
        let urlRequest = try router.asURLRequest()
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/guests/3")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.delete.rawValue)
        XCTAssertNil(urlRequest.httpBody)
    }
} 
