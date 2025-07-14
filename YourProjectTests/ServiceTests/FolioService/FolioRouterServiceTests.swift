//
//  FolioServiceRouterTests.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//


import XCTest
import Alamofire
import Mockable

final class FolioServiceRouterTests: XCTestCase {
    
    var baseURL: String!
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()
    
    override func setUp() {
        super.setUp()
        baseURL = AppConfiguration.shared.baseURL
    }
    
    func testFetchFoliosRequest() throws {
        // Given
        let req = FolioServiceRequest.FetchFolios(
            hotelId: 101,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            status: .available,
            vatOption: .excludedVat
        )
        let router = FolioServiceRouter.fetchFolios(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/folios?hotel_id=101&page=1&per_page=20&sorted_by=ID&sorted_order=ASC&status=AVAILABLE&vat_option=EXCLUDED_VAT")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.get.rawValue)
    }
    
    func testFetchFoliosByCategory() throws {
        // Given
        let req = FolioServiceRequest.FetchFoliosByCategory(
            hotelId: 101,
            categoryId: 5
        )
        let router = FolioServiceRouter.fetchFoliosByCategory(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/folios/category?category_id=5&hotel_id=101")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.get.rawValue)
    }

    func testFetchFolioRequest() throws {
        // Given
        let req = FolioServiceRequest.FetchFolio(id: 1)
        let router = FolioServiceRouter.fetchFolio(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/folios/1")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.get.rawValue)
    }
    
    func testCreateFolioRequest() throws {
        // Given
        let req = FolioServiceRequest.CreateFolio(hotelId: 101,
                                                  name: "Name A",
                                                  amount: 123.45,
                                                  description: nil,
                                                  categoryId: 1,
                                                  amountVatOption: .excludedVat)
        let router = FolioServiceRouter.createFolio(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/folios")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.post.rawValue)
        
        // Test parameters
        if let body = urlRequest.httpBody {
            do {
                if let json = try JSONSerialization.jsonObject(with: body,
                                                               options: []) as? [String: Any] {
                    print(json)
                    XCTAssertEqual(json["hotel_id"] as? Int, 101)
                    XCTAssertEqual(json["amount"] as? String, "123.45")
                    XCTAssertEqual(json["category_id"] as? Int, 1)
                    XCTAssertEqual(json["amount_vat_option"] as? String, "EXCLUDED_VAT")
                    XCTAssertEqual(json["name"] as? String, "Name A")
                    XCTAssertEqual(json["description"] as? String, nil)                    
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
    
    func testUpdateFolioRequest() throws {
        // Given
        let req = FolioServiceRequest.UpdateFolio(
            id: 1,
            name: "Updated Name",
            amount: 200.0,
            description: "Updated Description",
            categoryId: 2,
            amountVatOption: .includedVat
        )
        let router = FolioServiceRouter.updateFolio(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/folios/1")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.put.rawValue)
        
        // Test body
        if let body = urlRequest.httpBody {
            do {
                if let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any] {
                    XCTAssertEqual(json["name"] as? String, "Updated Name")
                    XCTAssertEqual(json["amount"] as? String, "200.0")
                    XCTAssertEqual(json["description"] as? String, "Updated Description")
                    XCTAssertEqual(json["category_id"] as? Int, 2)
                    XCTAssertEqual(json["amount_vat_option"] as? String, "INCLUDED_VAT")
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
    
    func testDeleteFolioRequest() throws {
        // Given
        let req = FolioServiceRequest.DeleteFolio(id: 1)
        let router = FolioServiceRouter.deleteFolio(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/folios/1")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.delete.rawValue)
        XCTAssertNil(urlRequest.httpBody)
    }
    
    
}
