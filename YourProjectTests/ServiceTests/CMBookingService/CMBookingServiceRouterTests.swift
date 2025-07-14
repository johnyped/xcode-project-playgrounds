//
//  CMBookingServiceRouterTests.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//

import XCTest
import Alamofire
import Mockable

final class CMBookingServiceRouterTests: XCTestCase {
    
    var baseURL: String!
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()
    
    override func setUp() {
        super.setUp()
        baseURL = AppConfiguration.shared.baseURL
    }
    
    func testFetchByHotelRouter_WillHaveCorrectParameters() throws {
        // Given
        let request = CMBookingServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        let router = CMBookingServiceRouter.fetchByHotel(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        // Check base path
        XCTAssertTrue(url.absoluteString.contains(baseURL + "/v4/cm-bookings"))
        
        // Check individual parameters
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        XCTAssertTrue(queryItems.contains { $0.name == "hotel_id" && $0.value == "105" })
        XCTAssertTrue(queryItems.contains { $0.name == "page" && $0.value == "1" })
        XCTAssertTrue(queryItems.contains { $0.name == "per_page" && $0.value == "20" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_by" && $0.value == "ID" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_order" && $0.value == "ASC" })
        
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testFetchByPeriodRouter_WillHaveCorrectParameters() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let endDate = Date(timeIntervalSince1970: 1609459200) // 2021-01-01
        let request = CMBookingServiceRequest.FetchByPeriod(
            hotelId: 105,
            period: .init(start: startDate,
                          end: endDate),
            includedAcknowledged: false,
            page: 2,
            perPage: .fifty,
            sortedBy: .createdAt,
            sortedOrder: .descending
        )
        let router = CMBookingServiceRouter.fetchByPeriod(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        // Check base path
        XCTAssertTrue(url.absoluteString.contains(baseURL + "/v4/cm-bookings/period"))
        
        // Check individual parameters
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        XCTAssertTrue(queryItems.contains { $0.name == "hotel_id" && $0.value == "105" })
        XCTAssertTrue(queryItems.contains { $0.name == "start_at" && $0.value == "2020-01-01" })
        XCTAssertTrue(queryItems.contains { $0.name == "end_at" && $0.value == "2021-01-01" })
        XCTAssertTrue(queryItems.contains { $0.name == "page" && $0.value == "2" })
        XCTAssertTrue(queryItems.contains { $0.name == "per_page" && $0.value == "50" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_by" && $0.value == "CREATED_AT" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_order" && $0.value == "DESC" })
        XCTAssertTrue(queryItems.contains { $0.name == "included_acknowledged" && $0.value == "0" })
        
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testFetchByStatusRouter_WillHaveCorrectParameters() throws {
        // Given
        let request = CMBookingServiceRequest.FetchByStatus(
            hotelId: 105,
            status: .confirmed,
            includedAcknowledged: true,
            page: 1,
            perPage: .ten,
            sortedBy: .updatedAt,
            sortedOrder: .ascending
        )
        let router = CMBookingServiceRouter.fetchByStatus(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        // Check base path
        XCTAssertTrue(url.absoluteString.contains(baseURL + "/v4/cm-bookings/status"))
        
        // Check individual parameters
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        XCTAssertTrue(queryItems.contains { $0.name == "hotel_id" && $0.value == "105" })
        XCTAssertTrue(queryItems.contains { $0.name == "status" && $0.value == "1" })
        XCTAssertTrue(queryItems.contains { $0.name == "page" && $0.value == "1" })
        XCTAssertTrue(queryItems.contains { $0.name == "per_page" && $0.value == "10" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_by" && $0.value == "UPDATED_AT" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_order" && $0.value == "ASC" })
        XCTAssertTrue(queryItems.contains { $0.name == "included_acknowledged" && $0.value == "1" })
        
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testFetchByKeywordRouter_WillHaveCorrectParameters() throws {
        // Given
        let request = CMBookingServiceRequest.FetchByKeyword(
            hotelId: 105,
            keyword: "THA",
            includedAcknowledged: false,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        let router = CMBookingServiceRouter.fetchByKeyword(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        // Check base path
        XCTAssertTrue(url.absoluteString.contains(baseURL + "/v4/cm-bookings/keyword"))
        
        // Check individual parameters
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        XCTAssertTrue(queryItems.contains { $0.name == "hotel_id" && $0.value == "105" })
        XCTAssertTrue(queryItems.contains { $0.name == "keyword" && $0.value == "THA" })
        XCTAssertTrue(queryItems.contains { $0.name == "page" && $0.value == "1" })
        XCTAssertTrue(queryItems.contains { $0.name == "per_page" && $0.value == "20" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_by" && $0.value == "ID" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_order" && $0.value == "ASC" })
        XCTAssertTrue(queryItems.contains { $0.name == "included_acknowledged" && $0.value == "0" })
        
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testFetchBatchRouter_WillHaveCorrectParameters() throws {
        // Given
        let request = CMBookingServiceRequest.FetchByBatchIds(
            hotelId: 105,
            ids: [1, 2, 3]
        )
        let router = CMBookingServiceRouter.fetchByBatchIds(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        // Check base path
        XCTAssertTrue(url.absoluteString.contains(baseURL + "/v4/cm-bookings/batch"))
        
        // Check individual parameters
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        XCTAssertTrue(queryItems.contains { $0.name == "hotel_id" && $0.value == "105" })
        XCTAssertTrue(queryItems.contains { $0.name == "ids" && $0.value == "1,2,3" })
        
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testFetchByIdRouter_WillHaveCorrectPath() throws {
        // Given
        let request = CMBookingServiceRequest.FetchById(id: 123)
        let router = CMBookingServiceRouter.fetchById(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/cm-bookings/123")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
        XCTAssertNil(urlRequest.httpBody)
    }
    
    func testAcknowledgeRouter_WillHaveCorrectPath() throws {
        // Given
        let request = CMBookingServiceRequest.Acknowledge(id: 456)
        let router = CMBookingServiceRouter.acknowledge(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/cm-bookings/456/acknowledge")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
        XCTAssertNil(urlRequest.httpBody)
    }
    
    func testBatchAcknowledgeRouter_WillHaveCorrectBody() throws {
        // Given
        let request = CMBookingServiceRequest.BatchAcknowledge(hotelId: 105,
                                                               ids: [789, 101112])
        let router = CMBookingServiceRouter.batchAcknowledge(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/cm-bookings/batch-acknowledge")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
        
        // Test body
        if let body = urlRequest.httpBody {
            do {
                if let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any] {
                    XCTAssertEqual(json["cm_booking_ids"] as? [Int], [789, 101112])
                } else {
                    XCTFail("JSON is not a dictionary")
                }
            } catch {
                XCTFail("Failed to parse JSON: \(error)")
            }
        } else {
            XCTFail("HTTP body is nil")
        }
    }
    
    func testSyncRouter_WillHaveCorrectBody() throws {
        // Given
        let request = CMBookingServiceRequest.Sync(
            hotelId: 105
        )
        let router = CMBookingServiceRouter.sync(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/cm-bookings/sync")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
        
        // Test body
        if let body = urlRequest.httpBody {
            do {
                if let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any] {
                    XCTAssertEqual(json["hotel_id"] as? Int, 105)
                } else {
                    XCTFail("JSON is not a dictionary")
                }
            } catch {
                XCTFail("Failed to parse JSON: \(error)")
            }
        } else {
            XCTFail("HTTP body is nil")
        }
    }
    
    func testFetchByHotelRouterWithOptionalParameters() throws {
        // Given
        let request = CMBookingServiceRequest.FetchByHotel(
            hotelId: 105,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        let router = CMBookingServiceRouter.fetchByHotel(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        // Check base path
        XCTAssertTrue(url.absoluteString.contains(baseURL + "/v4/cm-bookings"))
        
        // Check individual parameters
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        XCTAssertTrue(queryItems.contains { $0.name == "hotel_id" && $0.value == "105" })
        XCTAssertFalse(queryItems.contains { $0.name == "page" })
        XCTAssertFalse(queryItems.contains { $0.name == "per_page" })
        XCTAssertFalse(queryItems.contains { $0.name == "sorted_by" })
        XCTAssertFalse(queryItems.contains { $0.name == "sorted_order" })
        XCTAssertFalse(queryItems.contains { $0.name == "included_acknowledged" })
        
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testFetchByPeriodRouterWithOptionalParameters() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let endDate = Date(timeIntervalSince1970: 1609459200) // 2021-01-01
        let request = CMBookingServiceRequest.FetchByPeriod(
            hotelId: 105,
            period: PeriodDate.init(start: startDate,
                                    end: endDate),
            includedAcknowledged: nil,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        let router = CMBookingServiceRouter.fetchByPeriod(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        // Check base path
        XCTAssertTrue(url.absoluteString.contains(baseURL + "/v4/cm-bookings/period"))
        
        // Check individual parameters
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        XCTAssertTrue(queryItems.contains { $0.name == "hotel_id" && $0.value == "105" })
        XCTAssertTrue(queryItems.contains { $0.name == "start_at" && $0.value == "2020-01-01" })
        XCTAssertTrue(queryItems.contains { $0.name == "end_at" && $0.value == "2021-01-01" })
        XCTAssertFalse(queryItems.contains { $0.name == "page" })
        XCTAssertFalse(queryItems.contains { $0.name == "per_page" })
        XCTAssertFalse(queryItems.contains { $0.name == "sorted_by" })
        XCTAssertFalse(queryItems.contains { $0.name == "sorted_order" })
        XCTAssertFalse(queryItems.contains { $0.name == "included_acknowledged" })
        
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testAllRoutersHaveCorrectContentType() throws {
        // Test a few different router types
        let routers: [CMBookingServiceRouter] = [
            .fetchByHotel(request: CMBookingServiceRequest.FetchByHotel(
                hotelId: 105,
                page: nil,
                perPage: nil,
                sortedBy: nil,
                sortedOrder: nil
            )),
            .acknowledge(request: CMBookingServiceRequest.Acknowledge(id: 1)),
            .batchAcknowledge(request: CMBookingServiceRequest.BatchAcknowledge(hotelId: 105,
                                                                                ids: [1, 2])),
            .sync(request: CMBookingServiceRequest.Sync(
                hotelId: 105
            ))
        ]
        
        for router in routers {
            // When
            let urlRequest = try router.asURLRequest()
            
            // Then
            XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        }
    }
} 
