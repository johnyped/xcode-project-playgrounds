//
//  ReservationServiceRouterTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest
import Alamofire
import Mockable

final class ReservationServiceRouterTests: XCTestCase {
    
    var baseURL: String!
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()
    
    override func setUp() {
        super.setUp()
        baseURL = AppConfiguration.shared.baseURL
    }
    
    func testFetchReservationsRequest() throws {
        // Given
        let req = ReservationServiceRequest.FetchReservations(
            hotelId: 105,
            status: .confirmed,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        let router = ReservationServiceRouter.fetchReservations(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        // Check base path
        XCTAssertTrue(url.absoluteString.contains(baseURL + "/v4/reservations"))
        
        // Check individual parameters
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        XCTAssertTrue(queryItems.contains { $0.name == "page" && $0.value == "1" })
        XCTAssertTrue(queryItems.contains { $0.name == "per_page" && $0.value == "20" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_by" && $0.value == "ID" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_order" && $0.value == "ASC" })
        XCTAssertTrue(queryItems.contains { $0.name == "hotel_id" && $0.value == "105" })
        XCTAssertTrue(queryItems.contains { $0.name == "status" && $0.value == "CONFIRMED" })
        
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testFetchReservationsByFlagsRequest() throws {
        // Given
        let req = ReservationServiceRequest.FetchReservationsByFlags(
            hotelId: 105,
            flags: [.red, .blue],
            page: 1,
            perPage: .fifty,
            sortedBy: .checkInDate,
            sortedOrder: .descending
        )
        let router = ReservationServiceRouter.fetchReservationsByFlags(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertTrue(urlRequest.url?.absoluteString.contains(baseURL + "/v4/reservations/flags") == true)
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
        
        // Check individual parameters
        let urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        XCTAssertTrue(queryItems.contains { $0.name == "flags" && $0.value == "FLAG_RED,FLAG_BLUE" })
        XCTAssertTrue(queryItems.contains { $0.name == "hotel_id" && $0.value == "105" })
    }
    
    func testFetchReservationByIdRequest() throws {
        // Given
        let req = ReservationServiceRequest.FetchById(id: 123)
        let router = ReservationServiceRouter.fetchReservation(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/reservations/123")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testFetchReservationByUidRequest() throws {
        // Given
        let req = ReservationServiceRequest.FetchReservationByUid(
            hotelId: 105,
            uid: "rsvt_5la15znqpb30lz5rmqj"
        )
        let router = ReservationServiceRouter.fetchReservationByUid(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertTrue(urlRequest.url?.absoluteString.contains(baseURL + "/v4/reservations/uid") == true)
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
        
        // Check parameters
        let urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        XCTAssertTrue(queryItems.contains { $0.name == "uid" && $0.value == "rsvt_5la15znqpb30lz5rmqj" })
        XCTAssertTrue(queryItems.contains { $0.name == "hotel_id" && $0.value == "105" })
    }
    
    func testCheckInRequest() throws {
        // Given
        let req = ReservationServiceRequest.CheckIn(id: 123)
        let router = ReservationServiceRouter.checkIn(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/reservations/123/check-in")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
    }
    
    func testCheckOutRequest() throws {
        // Given
        let req = ReservationServiceRequest.CheckOut(id: 123)
        let router = ReservationServiceRouter.checkOut(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/reservations/123/check-out")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
    }
    
    func testCancelRequest() throws {
        // Given
        let req = ReservationServiceRequest.Cancel(id: 123)
        let router = ReservationServiceRouter.cancel(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/reservations/123/cancel")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
    }
    
    func testNoShowRequest() throws {
        // Given
        let req = ReservationServiceRequest.NoShow(id: 123)
        let router = ReservationServiceRouter.noShow(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/reservations/123/no-show")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
    }
    
    func testGetFirstGuestRequest() throws {
        // Given
        let req = ReservationServiceRequest.SetFirstGuest(id: 123)
        let router = ReservationServiceRouter.getFirstGuest(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/reservations/123/first-guest")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testGetConfirmationRequest() throws {
        // Given
        let req = ReservationServiceRequest.FetchConfirmation(id: 123)
        let router = ReservationServiceRouter.getConfirmation(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/reservations/123/confirmation")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    // MARK: - Helper Methods
    private func createMockReservationsPaginator() -> Paginator<Reservation> {
        let reservation = Reservation(
            id: 512,
            uid: "rsvt_5la15znqpb30lz5rmqj",
            status: .checkedOut,
            checkInDate: Date(),
            checkOutDate: Date(),
            hotelId: 105,
            creatorId: 38,
            channelId: 9,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        let reservations = Reservations(array: [reservation])
        
        return Paginator<Reservation>(
            items: reservations,
            totalItems: 1,
            totalPages: 1,
            perPage: 20,
            page: 1
        )
    }
} 
