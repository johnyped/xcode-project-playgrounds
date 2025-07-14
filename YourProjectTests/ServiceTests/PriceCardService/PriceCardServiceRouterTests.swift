//
//  PriceCardServiceRouterTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest
import Alamofire
import Mockable

final class PriceCardServiceRouterTests: XCTestCase {
    
    var baseURL: String!
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()
    
    override func setUp() {
        super.setUp()
        baseURL = AppConfiguration.shared.baseURL
    }
    
    func testFetchPriceCardsRequest() throws {
        // Given
        let req = PriceCardServiceRequest.FetchPriceCards(
            page: 1,
            perPage: 20,
            sortedBy: "id",
            sortedOrder: "ASC",
            hotelId: 105,
            roomTypeId: 101
        )
        let router = PriceCardServiceRouter.fetchPriceCards(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        // Check base path
        XCTAssertTrue(url.absoluteString.contains(baseURL + "/v4/price-cards"))
        
        // Check individual parameters
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        XCTAssertTrue(queryItems.contains { $0.name == "page" && $0.value == "1" })
        XCTAssertTrue(queryItems.contains { $0.name == "per_page" && $0.value == "20" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_by" && $0.value == "id" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_order" && $0.value == "ASC" })
        XCTAssertTrue(queryItems.contains { $0.name == "hotel_id" && $0.value == "105" })
        XCTAssertTrue(queryItems.contains { $0.name == "room_type_id" && $0.value == "101" })
        
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testFetchPriceCardsRequestWithOptionalParameters() throws {
        // Given
        let req = PriceCardServiceRequest.FetchPriceCards(
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            hotelId: nil,
            roomTypeId: nil
        )
        let router = PriceCardServiceRouter.fetchPriceCards(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        // Check base path without parameters
        XCTAssertEqual(url.absoluteString, baseURL + "/v4/price-cards")
        
        // Check no query parameters
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        XCTAssertTrue(queryItems.isEmpty)
        
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testFetchPriceCardRequest() throws {
        // Given
        let req = PriceCardServiceRequest.FetchPriceCard(id: 42)
        let router = PriceCardServiceRouter.fetchPriceCard(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/price-cards/42")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testFetchPriceCardsByPeriodRequest() throws {
        // Given
        let startDate = Date()
        let endDate = Date().addingTimeInterval(86400 * 7)
        let req = PriceCardServiceRequest.FetchPriceCardsByPeriod(
            hotelId: 105,
            startDate: startDate,
            endDate: endDate,
            channelId: 1,
            subChannelId: 2,
            reservableTypeType: "RoomType",
            reservableTypeId: 301
        )
        let router = PriceCardServiceRouter.fetchPriceCardsByPeriod(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        // Check base path
        XCTAssertTrue(url.absoluteString.contains(baseURL + "/v4/price-cards/period"))
        
        // Check parameters
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        XCTAssertTrue(queryItems.contains { $0.name == "hotel_id" && $0.value == "105" })
        XCTAssertTrue(queryItems.contains { $0.name == "start_date" })
        XCTAssertTrue(queryItems.contains { $0.name == "end_date" })
        XCTAssertTrue(queryItems.contains { $0.name == "channel_id" && $0.value == "1" })
        XCTAssertTrue(queryItems.contains { $0.name == "sub_channel_id" && $0.value == "2" })
        XCTAssertTrue(queryItems.contains { $0.name == "reservable_type_type" && $0.value == "RoomType" })
        XCTAssertTrue(queryItems.contains { $0.name == "reservable_type_id" && $0.value == "301" })
        
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testCreatePriceCardRequest() throws {
        // Given
        let req = PriceCardServiceRequest.CreatePriceCard(
            hotelId: 105,
            title: "Test Rate",
            reservableTypeId: 101,
            reservableTypeType: "RoomType",
            price: 1500.0,
            description: "Test description",
            code: "TEST001",
            color: "#FF5733",
            periodTypes: ["Monday", "Wednesday", "Friday"],
            exceptionDates: ["2024-12-25", "2024-01-01"],
            bfIncluded: true,
            bfAdultPrice: 150.0,
            bfAdultLimit: 2,
            bfAdultExtraRate: 100.0,
            bfAdultExtraLimit: 4,
            bfChildPrice: 75.0,
            bfChildLimit: 2,
            bfChildExtraRate: 50.0,
            bfChildExtraLimit: 4,
            startAt: Date(timeIntervalSince1970: 1672531200), // 2023-01-01 00:00:00 UTC
            endAt: Date(timeIntervalSince1970: 1704067200), // 2024-01-01 00:00:00 UTC
            channels: ["online", "phone"],
            pinned: false
        )
        let router = PriceCardServiceRouter.createPriceCard(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/price-cards")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
        
        // Test body
        if let body = urlRequest.httpBody {
            do {
                if let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any] {
                    XCTAssertEqual(json["hotel_id"] as? Int, 105)
                    XCTAssertEqual(json["title"] as? String, "Test Rate")
                                          XCTAssertEqual(json["reservable_type_id"] as? Int, 101)
                      XCTAssertEqual(json["reservable_type_type"] as? String, "RoomType")
                      XCTAssertEqual(json["price"] as? String, "1500.0")
                      XCTAssertEqual(json["description"] as? String, "Test description")
                      XCTAssertEqual(json["code"] as? String, "TEST001")
                    XCTAssertEqual(json["color"] as? String, "#FF5733")
                    
                    if let periodTypes = json["period_types"] as? [String] {
                        XCTAssertEqual(periodTypes.count, 3)
                        XCTAssertTrue(periodTypes.contains("Monday"))
                        XCTAssertTrue(periodTypes.contains("Wednesday"))
                        XCTAssertTrue(periodTypes.contains("Friday"))
                    } else {
                        XCTFail("Period types should be an array of strings")
                    }
                    
                    if let exceptionDates = json["exception_dates"] as? [String] {
                        XCTAssertEqual(exceptionDates.count, 2)
                        XCTAssertTrue(exceptionDates.contains("2024-12-25"))
                        XCTAssertTrue(exceptionDates.contains("2024-01-01"))
                    } else {
                        XCTFail("Exception dates should be an array of strings")
                    }
                    
                                          XCTAssertEqual(json["bf_included"] as? Bool, true)
                      XCTAssertEqual(json["bf_adult_price"] as? String, "150.0")
                      XCTAssertEqual(json["bf_adult_limit"] as? Int, 2)
                    XCTAssertEqual(json["start_at"] as? String, "01 Jan 2023")
                    XCTAssertEqual(json["end_at"] as? String, "01 Jan 2024")
                    XCTAssertEqual(json["pinned"] as? Bool, false)
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
    
    func testUpdatePriceCardRequest() throws {
        // Given
        let req = PriceCardServiceRequest.UpdatePriceCard(
            id: 42,
            title: "Updated Rate",
            description: "Updated description",
            reservableTypeId: 201,
            reservableTypeType: "RoomType",
            price: 2000.0,
            code: "UPD001",
            color: "#FFD700",
            periodTypes: ["Weekend"],
            exceptionDates: ["2024-07-04"],
            bfIncluded: false,
            bfAdultPrice: nil,
            bfAdultLimit: nil,
            bfAdultExtraRate: nil,
            bfAdultExtraLimit: nil,
            bfChildPrice: nil,
            bfChildLimit: nil,
            bfChildExtraRate: nil,
            bfChildExtraLimit: nil,
            startAt: Date(timeIntervalSince1970: 1672531200), // 2023-01-01 00:00:00 UTC
            endAt: Date(timeIntervalSince1970: 1704067200), // 2024-01-01 00:00:00 UTC
            channels: ["online"],
            pinned: true
        )
        let router = PriceCardServiceRouter.updatePriceCard(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/price-cards/42")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.put.rawValue)
        
        // Test body
        if let body = urlRequest.httpBody {
            do {
                if let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any] {
                    XCTAssertEqual(json["title"] as? String, "Updated Rate")
                    XCTAssertEqual(json["description"] as? String, "Updated description")
                    XCTAssertEqual(json["reservable_type_id"] as? Int, 201)
                    XCTAssertEqual(json["reservable_type_type"] as? String, "RoomType")
                    XCTAssertEqual(json["price"] as? String, "2000.0")
                    XCTAssertEqual(json["code"] as? String, "UPD001")
                    XCTAssertEqual(json["color"] as? String, "#FFD700")
                    
                    if let periodTypes = json["period_types"] as? [String] {
                        XCTAssertEqual(periodTypes.count, 1)
                        XCTAssertEqual(periodTypes.first, "Weekend")
                    } else {
                        XCTFail("Period types should be an array of strings")
                    }
                    
                    if let exceptionDates = json["exception_dates"] as? [String] {
                        XCTAssertEqual(exceptionDates.count, 1)
                        XCTAssertEqual(exceptionDates.first, "2024-07-04")
                    } else {
                        XCTFail("Exception dates should be an array of strings")
                    }
                    
                    XCTAssertEqual(json["bf_included"] as? Bool, false)
                    XCTAssertEqual(json["start_at"] as? String, "01 Jan 2023")
                    XCTAssertEqual(json["end_at"] as? String, "01 Jan 2024")
                    XCTAssertEqual(json["pinned"] as? Bool, true)
                    // id should not be in the JSON body
                    XCTAssertNil(json["id"])
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
    
    func testDeletePriceCardRequest() throws {
        // Given
        let req = PriceCardServiceRequest.DeletePriceCard(id: 99)
        let router = PriceCardServiceRouter.deletePriceCard(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/price-cards/99")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.delete.rawValue)
        XCTAssertNil(urlRequest.httpBody)
    }
    
    func testAllRequestsHaveCorrectHeaders() throws {
        // Given
        let fetchReq = PriceCardServiceRequest.FetchPriceCards(page: 1, perPage: 20, sortedBy: nil, sortedOrder: nil, hotelId: nil, roomTypeId: nil)
        let fetchSingleReq = PriceCardServiceRequest.FetchPriceCard(id: 1)
        let createReq = PriceCardServiceRequest.CreatePriceCard(
            hotelId: 105,
            title: "Test",
            reservableTypeId: 101,
            reservableTypeType: "RoomType",
            price: 1000.0,
            description: nil,
            code: nil,
            color: nil,
            periodTypes: nil,
            exceptionDates: nil,
            bfIncluded: nil,
            bfAdultPrice: nil,
            bfAdultLimit: nil,
            bfAdultExtraRate: nil,
            bfAdultExtraLimit: nil,
            bfChildPrice: nil,
            bfChildLimit: nil,
            bfChildExtraRate: nil,
            bfChildExtraLimit: nil,
            startAt: Date(timeIntervalSince1970: 1672531200), // 2023-01-01 00:00:00 UTC
            endAt: Date(timeIntervalSince1970: 1704067200), // 2024-01-01 00:00:00 UTC
            channels: nil,
            pinned: nil
        )
        
        let fetchRouter = PriceCardServiceRouter.fetchPriceCards(request: fetchReq)
        let fetchSingleRouter = PriceCardServiceRouter.fetchPriceCard(request: fetchSingleReq)
        let createRouter = PriceCardServiceRouter.createPriceCard(request: createReq)
        
        // When
        let fetchRequest = try fetchRouter.asURLRequest()
        let fetchSingleRequest = try fetchSingleRouter.asURLRequest()
        let createRequest = try createRouter.asURLRequest()
        
        // Then
        XCTAssertEqual(fetchRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertEqual(fetchSingleRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertEqual(createRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    func testDomainConfiguration() {
        // Given
        let req = PriceCardServiceRequest.FetchPriceCard(id: 1)
        let router = PriceCardServiceRouter.fetchPriceCard(request: req)
        
        // Then
        XCTAssertEqual(router.domain, AppConfiguration.shared.baseURL)
    }
    
    func testRouterPathsAreCorrect() {
        // Given
        let fetchReq = PriceCardServiceRequest.FetchPriceCards(page: nil, perPage: nil, sortedBy: nil, sortedOrder: nil, hotelId: nil, roomTypeId: nil)
        let fetchSingleReq = PriceCardServiceRequest.FetchPriceCard(id: 123)
        let periodReq = PriceCardServiceRequest.FetchPriceCardsByPeriod(hotelId: 105, startDate: Date(), endDate: Date(), channelId: nil, subChannelId: nil, reservableTypeType: nil, reservableTypeId: nil)
        let createReq = PriceCardServiceRequest.CreatePriceCard(
            hotelId: 105,
            title: "Test",
            reservableTypeId: 101,
            reservableTypeType: "RoomType", 
            price: 1000.0,
            description: nil,
            code: nil,
            color: nil,
            periodTypes: nil,
            exceptionDates: nil,
            bfIncluded: nil,
            bfAdultPrice: nil,
            bfAdultLimit: nil,
            bfAdultExtraRate: nil,
            bfAdultExtraLimit: nil,
            bfChildPrice: nil,
            bfChildLimit: nil,
            bfChildExtraRate: nil,
            bfChildExtraLimit: nil,
            startAt: Date(timeIntervalSince1970: 1672531200), // 2023-01-01 00:00:00 UTC
            endAt: Date(timeIntervalSince1970: 1704067200), // 2024-01-01 00:00:00 UTC
            channels: nil,
            pinned: nil
        )
        let updateReq = PriceCardServiceRequest.UpdatePriceCard(
            id: 456,
            title: nil,
            description: nil,
            reservableTypeId: nil,
            reservableTypeType: nil,
            price: nil,
            code: nil,
            color: nil,
            periodTypes: nil,
            exceptionDates: nil,
            bfIncluded: nil,
            bfAdultPrice: nil,
            bfAdultLimit: nil,
            bfAdultExtraRate: nil,
            bfAdultExtraLimit: nil,
            bfChildPrice: nil,
            bfChildLimit: nil,
            bfChildExtraRate: nil,
            bfChildExtraLimit: nil,
            startAt: nil,
            endAt: nil,
            channels: nil,
            pinned: nil
        )
        let deleteReq = PriceCardServiceRequest.DeletePriceCard(id: 789)
        
        let fetchRouter = PriceCardServiceRouter.fetchPriceCards(request: fetchReq)
        let fetchSingleRouter = PriceCardServiceRouter.fetchPriceCard(request: fetchSingleReq)
        let periodRouter = PriceCardServiceRouter.fetchPriceCardsByPeriod(request: periodReq)
        let createRouter = PriceCardServiceRouter.createPriceCard(request: createReq)
        let updateRouter = PriceCardServiceRouter.updatePriceCard(request: updateReq)
        let deleteRouter = PriceCardServiceRouter.deletePriceCard(request: deleteReq)
        
        // Then
        XCTAssertEqual(fetchRouter.path, "/v4/price-cards")
        XCTAssertEqual(fetchSingleRouter.path, "/v4/price-cards/123")
        XCTAssertEqual(periodRouter.path, "/v4/price-cards/period")
        XCTAssertEqual(createRouter.path, "/v4/price-cards")
        XCTAssertEqual(updateRouter.path, "/v4/price-cards/456")
        XCTAssertEqual(deleteRouter.path, "/v4/price-cards/789")
    }
    
    func testHTTPMethodsAreCorrect() {
        // Given
        let fetchReq = PriceCardServiceRequest.FetchPriceCards(page: nil, perPage: nil, sortedBy: nil, sortedOrder: nil, hotelId: nil, roomTypeId: nil)
        let fetchSingleReq = PriceCardServiceRequest.FetchPriceCard(id: 1)
        let periodReq = PriceCardServiceRequest.FetchPriceCardsByPeriod(hotelId: 105, startDate: Date(), endDate: Date(), channelId: nil, subChannelId: nil, reservableTypeType: nil, reservableTypeId: nil)
        let createReq = PriceCardServiceRequest.CreatePriceCard(
            hotelId: 105,
            title: "Test",
            reservableTypeId: 101,
            reservableTypeType: "RoomType",
            price: 1000.0,
            description: nil,
            code: nil,
            color: nil,
            periodTypes: nil,
            exceptionDates: nil,
            bfIncluded: nil,
            bfAdultPrice: nil,
            bfAdultLimit: nil,
            bfAdultExtraRate: nil,
            bfAdultExtraLimit: nil,
            bfChildPrice: nil,
            bfChildLimit: nil,
            bfChildExtraRate: nil,
            bfChildExtraLimit: nil,
            startAt: Date(timeIntervalSince1970: 1672531200), // 2023-01-01 00:00:00 UTC
            endAt: Date(timeIntervalSince1970: 1704067200), // 2024-01-01 00:00:00 UTC
            channels: nil,
            pinned: nil
        )
        let updateReq = PriceCardServiceRequest.UpdatePriceCard(
            id: 1,
            title: nil,
            description: nil,
            reservableTypeId: nil,
            reservableTypeType: nil,
            price: nil,
            code: nil,
            color: nil,
            periodTypes: nil,
            exceptionDates: nil,
            bfIncluded: nil,
            bfAdultPrice: nil,
            bfAdultLimit: nil,
            bfAdultExtraRate: nil,
            bfAdultExtraLimit: nil,
            bfChildPrice: nil,
            bfChildLimit: nil,
            bfChildExtraRate: nil,
            bfChildExtraLimit: nil,
            startAt: nil,
            endAt: nil,
            channels: nil,
            pinned: nil
        )
        let deleteReq = PriceCardServiceRequest.DeletePriceCard(id: 1)
        
        let fetchRouter = PriceCardServiceRouter.fetchPriceCards(request: fetchReq)
        let fetchSingleRouter = PriceCardServiceRouter.fetchPriceCard(request: fetchSingleReq)
        let periodRouter = PriceCardServiceRouter.fetchPriceCardsByPeriod(request: periodReq)
        let createRouter = PriceCardServiceRouter.createPriceCard(request: createReq)
        let updateRouter = PriceCardServiceRouter.updatePriceCard(request: updateReq)
        let deleteRouter = PriceCardServiceRouter.deletePriceCard(request: deleteReq)
        
        // Then
        XCTAssertEqual(fetchRouter.method, .get)
        XCTAssertEqual(fetchSingleRouter.method, .get)
        XCTAssertEqual(periodRouter.method, .get)
        XCTAssertEqual(createRouter.method, .post)
        XCTAssertEqual(updateRouter.method, .put)
        XCTAssertEqual(deleteRouter.method, .delete)
    }
} 
