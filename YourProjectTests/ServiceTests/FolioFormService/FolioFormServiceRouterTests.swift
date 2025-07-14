//
//  FolioFormServiceRouterTests.swift
//  YourProject
//
//  Created by IntrodexMini on 13/6/2568 BE.
//

import XCTest
import Alamofire
import Mockable

final class FolioFormServiceRouterTests: XCTestCase {
    
    var baseURL: String!
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()
    
    override func setUp() {
        super.setUp()
        baseURL = AppConfiguration.shared.baseURL
    }
    
    func testFetchByHotelRequest() throws {
        // Given
        let req = FolioFormServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        let router = FolioFormServiceRouter.fetchByHotel(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        // Check base path
        XCTAssertTrue(url.absoluteString.contains(baseURL + "/v4/folio-forms"))
        
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
    
    func testFetchByQueryRequest() throws {
        // Given
        let req = FolioFormServiceRequest.FetchByQuery(
            hotelId: 105,
            query: "test query",
            page: 2,
            perPage: .ten,
            sortedBy: .createdAt,
            sortedOrder: .descending
        )
        let router = FolioFormServiceRouter.fetchByQuery(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        // Check base path
        XCTAssertTrue(url.absoluteString.contains(baseURL + "/v4/folio-forms/query"))
        
        // Check individual parameters
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        XCTAssertTrue(queryItems.contains { $0.name == "hotel_id" && $0.value == "105" })
        XCTAssertTrue(queryItems.contains { $0.name == "query" && $0.value == "test query" })
        XCTAssertTrue(queryItems.contains { $0.name == "page" && $0.value == "2" })
        XCTAssertTrue(queryItems.contains { $0.name == "per_page" && $0.value == "10" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_by" && $0.value == "CREATED_AT" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_order" && $0.value == "DESC" })
        
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testFetchByPeriodRequest() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1704067200) // 2024-01-01
        let endDate = Date(timeIntervalSince1970: 1735689600) // 2025-01-01
        let period = PeriodDate(start: startDate, end: endDate)
        
        let req = FolioFormServiceRequest.FetchByPeriod(
            hotelId: 105,
            period: period,
            page: 1,
            perPage: .fifty,
            sortedBy: .updatedAt,
            sortedOrder: .ascending
        )
        let router = FolioFormServiceRouter.fetchByPeriod(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        // Check base path
        XCTAssertTrue(url.absoluteString.contains(baseURL + "/v4/folio-forms/period"))
        
        // Check individual parameters
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        XCTAssertTrue(queryItems.contains { $0.name == "hotel_id" && $0.value == "105" })
        XCTAssertTrue(queryItems.contains { $0.name == "start_date" && $0.value == "2024-01-01" })
        XCTAssertTrue(queryItems.contains { $0.name == "end_date" && $0.value == "2025-01-01" })
        XCTAssertTrue(queryItems.contains { $0.name == "page" && $0.value == "1" })
        XCTAssertTrue(queryItems.contains { $0.name == "per_page" && $0.value == "50" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_by" && $0.value == "UPDATED_AT" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_order" && $0.value == "ASC" })
        
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testFetchByReservationRequest() throws {
        // Given
        let req = FolioFormServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 512,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        let router = FolioFormServiceRouter.fetchByReservation(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        // Check base path
        XCTAssertTrue(url.absoluteString.contains(baseURL + "/v4/folio-forms/reservation"))
        
        // Check individual parameters
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        XCTAssertTrue(queryItems.contains { $0.name == "hotel_id" && $0.value == "105" })
        XCTAssertTrue(queryItems.contains { $0.name == "reservation_id" && $0.value == "512" })
        XCTAssertTrue(queryItems.contains { $0.name == "page" && $0.value == "1" })
        XCTAssertTrue(queryItems.contains { $0.name == "per_page" && $0.value == "20" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_by" && $0.value == "ID" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_order" && $0.value == "ASC" })
        
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testFetchByIdRequest() throws {
        // Given
        let req = FolioFormServiceRequest.FetchById(id: 1)
        let router = FolioFormServiceRouter.fetchById(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/folio-forms/1")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
        XCTAssertNil(urlRequest.httpBody)
    }
    
    func testCreateFolioFormReservationRequest() throws {
        // Given
        let req = FolioFormServiceRequest.CreateFolioFormReservation(
            hotelId: 105,
            reservationId: 179,
            hotelContactId: 8,
            customerContactId: 6,
            vatIncluded: false,
            remark: "test remark",
            internalNote: "test internal note",
            paymentInfo: "2, 2 (111-1-11111-2)",
            groupRoomCharge: true,
            groupAdditionalItem: false
        )
        let router = FolioFormServiceRouter.createFolioFormReservation(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/folio-forms")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
        
        // Test parameters
        if let body = urlRequest.httpBody {
            do {
                if let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any] {
                    XCTAssertEqual(json["hotel_id"] as? Int, 105)
                    XCTAssertEqual(json["reservation_id"] as? Int, 179)
                    XCTAssertEqual(json["hotel_contact_id"] as? Int, 8)
                    XCTAssertEqual(json["customer_contact_id"] as? Int, 6)
                    XCTAssertEqual(json["vat_included"] as? Bool, false)
                    XCTAssertEqual(json["remark"] as? String, "test remark")
                    XCTAssertEqual(json["internal_note"] as? String, "test internal note")
                    XCTAssertEqual(json["payment_info"] as? String, "2, 2 (111-1-11111-2)")
                    XCTAssertEqual(json["group_room_charge"] as? Bool, true)
                    XCTAssertEqual(json["group_additional_item"] as? Bool, false)
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
    
    func testUpdateFolioFormRequest() throws {
        // Given
        let req = FolioFormServiceRequest.UpdateFolioForm(
            id: 1,
            hotelContactId: 9,
            customerContactId: 7,
            remark: "updated remark",
            internalNote: "updated internal note",
            paymentInfo: "updated payment info",
            groupRoomCharge: false,
            groupAdditionalItem: true
        )
        let router = FolioFormServiceRouter.updateFolioForm(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/folio-forms/1")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.put.rawValue)
        
        // Test body
        if let body = urlRequest.httpBody {
            do {
                if let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any] {
                    XCTAssertEqual(json["hotel_contact_id"] as? Int, 9)
                    XCTAssertEqual(json["customer_contact_id"] as? Int, 7)
                    XCTAssertEqual(json["remark"] as? String, "updated remark")
                    XCTAssertEqual(json["internal_note"] as? String, "updated internal note")
                    XCTAssertEqual(json["payment_info"] as? String, "updated payment info")
                    XCTAssertEqual(json["group_room_charge"] as? Bool, false)
                    XCTAssertEqual(json["group_additional_item"] as? Bool, true)
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
    
    func testCancelFolioFormRequest() throws {
        // Given
        let req = FolioFormServiceRequest.CancelFolioForm(id: 2)
        let router = FolioFormServiceRouter.cancelFolioForm(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/folio-forms/2/cancel")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
        XCTAssertNil(urlRequest.httpBody)
    }
    
    func testPreviewEmailRequest() throws {
        // Given
        let req = FolioFormServiceRequest.PreviewEmail(id: 3)
        let router = FolioFormServiceRouter.previewEmail(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/folio-forms/3/preview-email")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
        XCTAssertNil(urlRequest.httpBody)
    }
    
    func testPreviewPDFRequest() throws {
        // Given
        let req = FolioFormServiceRequest.PreviewPDF(id: 4)
        let router = FolioFormServiceRouter.previewPDF(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/folio-forms/4/preview-pdf")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
        XCTAssertNil(urlRequest.httpBody)
    }
    
    func testExportPDFRequest() throws {
        // Given
        let req = FolioFormServiceRequest.ExportPDF(id: 5)
        let router = FolioFormServiceRouter.exportPDF(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/folio-forms/5/pdf")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
        XCTAssertNil(urlRequest.httpBody)
    }
    
    func testExportImageRequest() throws {
        // Given
        let req = FolioFormServiceRequest.ExportImage(id: 6)
        let router = FolioFormServiceRouter.exportImage(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/folio-forms/6/image")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
        XCTAssertNil(urlRequest.httpBody)
    }
    
    func testFetchByHotelRequestWithOptionalParameters() throws {
        // Given
        let req = FolioFormServiceRequest.FetchByHotel(
            hotelId: 105,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        let router = FolioFormServiceRouter.fetchByHotel(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        // Check that only hotel_id parameter is present
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        XCTAssertTrue(queryItems.contains { $0.name == "hotel_id" && $0.value == "105" })
        XCTAssertFalse(queryItems.contains { $0.name == "page" })
        XCTAssertFalse(queryItems.contains { $0.name == "per_page" })
        XCTAssertFalse(queryItems.contains { $0.name == "sorted_by" })
        XCTAssertFalse(queryItems.contains { $0.name == "sorted_order" })
        
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
} 
