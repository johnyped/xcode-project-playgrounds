//
//  ProductUnitServiceRouterTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest
import Alamofire


class ProductUnitServiceRouterTests: XCTestCase {
    
    private let testBaseURL = AppConfiguration.shared.baseURL
    
    override func setUp() {
        super.setUp()        
    }
    
    // MARK: - Test fetchByHotel
    
    func testFetchByHotel_PathAndMethod() {
        // Given
        let request = ProductUnitServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .unit,
            sortedOrder: .ascending,
            kind: nil,
            query: nil
        )
        let router = ProductUnitServiceRouter.fetchByHotel(request: request)
        
        // When & Then
        XCTAssertEqual(router.path, "/v4/product-units")
        XCTAssertEqual(router.method, .get)
        XCTAssertEqual(router.domain, testBaseURL)
    }
    
    func testFetchByHotel_Headers() {
        // Given
        let request = ProductUnitServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .unit,
            sortedOrder: .ascending,
            kind: nil,
            query: nil
        )
        let router = ProductUnitServiceRouter.fetchByHotel(request: request)
        
        // When
        let headers = router.headers
        
        // Then
        XCTAssertNotNil(headers)
        XCTAssertEqual(headers?["Content-Type"], "application/json")
    }
    
    func testFetchByHotel_Parameters() {
        // Given
        let request = ProductUnitServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .unit,
            sortedOrder: .ascending,
            kind: nil,
            query: nil
        )
        let router = ProductUnitServiceRouter.fetchByHotel(request: request)
        
        // When
        let parameters = router.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "UNIT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func testFetchByHotel_URLRequest() throws {
        // Given
        let request = ProductUnitServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .unit,
            sortedOrder: .ascending,
            kind: nil,
            query: nil
        )
        let router = ProductUnitServiceRouter.fetchByHotel(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertNotNil(urlRequest.url)
        XCTAssertTrue(urlRequest.url!.absoluteString.hasPrefix(testBaseURL))
        XCTAssertTrue(urlRequest.url!.absoluteString.contains("/v4/product-units"))
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    // MARK: - Test fetchById
    
    func testFetchById_PathAndMethod() {
        // Given
        let request = ProductUnitServiceRequest.FetchById(id: 123)
        let router = ProductUnitServiceRouter.fetchById(request: request)
        
        // When & Then
        XCTAssertEqual(router.path, "/v4/product-units/123")
        XCTAssertEqual(router.method, .get)
        XCTAssertNil(router.parameters)
        XCTAssertNil(router.body)
    }
    
    func testFetchById_URLRequest() throws {
        // Given
        let request = ProductUnitServiceRequest.FetchById(id: 456)
        let router = ProductUnitServiceRouter.fetchById(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertNotNil(urlRequest.url)
        XCTAssertEqual(urlRequest.url!.absoluteString, "\(testBaseURL)/v4/product-units/456")
        XCTAssertEqual(urlRequest.httpMethod, "GET")
    }
    
    // MARK: - Test createProductUnit
    
    func testCreateProductUnit_PathAndMethod() {
        // Given
        let request = ProductUnitServiceRequest.CreateProductUnit(
            hotelId: 105,
            unit: "piece",
            kind: .product
        )
        let router = ProductUnitServiceRouter.createProductUnit(request: request)
        
        // When & Then
        XCTAssertEqual(router.path, "/v4/product-units")
        XCTAssertEqual(router.method, .post)
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
    func testCreateProductUnit_Body() throws {
        // Given
        let request = ProductUnitServiceRequest.CreateProductUnit(
            hotelId: 105,
            unit: "liter",
            kind: .service
        )
        let router = ProductUnitServiceRouter.createProductUnit(request: request)
        
        // When
        let bodyData = router.body
        
        // Then
        XCTAssertNotNil(bodyData)
        let json = try JSONSerialization.jsonObject(with: bodyData!, options: []) as? [String: Any]
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["unit"] as? String, "liter")
        XCTAssertEqual(json?["kind"] as? String, "SERVICE")
    }
    
    func testCreateProductUnit_URLRequest() throws {
        // Given
        let request = ProductUnitServiceRequest.CreateProductUnit(
            hotelId: 105,
            unit: "gram",
            kind: .product
        )
        let router = ProductUnitServiceRouter.createProductUnit(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertNotNil(urlRequest.url)
        XCTAssertEqual(urlRequest.url!.absoluteString, "\(testBaseURL)/v4/product-units")
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertNotNil(urlRequest.httpBody)
    }
    
    // MARK: - Test updateProductUnit
    
    func testUpdateProductUnit_PathAndMethod() {
        // Given
        let request = ProductUnitServiceRequest.UpdateProductUnit(
            id: 789,
            hotelId: 105,
            unit: "meter",
            kind: .product
        )
        let router = ProductUnitServiceRouter.updateProductUnit(request: request)
        
        // When & Then
        XCTAssertEqual(router.path, "/v4/product-units/789")
        XCTAssertEqual(router.method, .put)
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
    func testUpdateProductUnit_Body() throws {
        // Given
        let request = ProductUnitServiceRequest.UpdateProductUnit(
            id: 1,
            hotelId: 105,
            unit: "kilogram",
            kind: .service
        )
        let router = ProductUnitServiceRouter.updateProductUnit(request: request)
        
        // When
        let bodyData = router.body
        
        // Then
        XCTAssertNotNil(bodyData)
        let json = try JSONSerialization.jsonObject(with: bodyData!, options: []) as? [String: Any]
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["unit"] as? String, "kilogram")
        XCTAssertEqual(json?["kind"] as? String, "SERVICE")
    }
    
    // MARK: - Test deleteProductUnit
    
    func testDeleteProductUnit_PathAndMethod() {
        // Given
        let request = ProductUnitServiceRequest.DeleteProductUnit(id: 999)
        let router = ProductUnitServiceRouter.deleteProductUnit(request: request)
        
        // When & Then
        XCTAssertEqual(router.path, "/v4/product-units/999")
        XCTAssertEqual(router.method, .delete)
        XCTAssertNil(router.parameters)
        XCTAssertNil(router.body)
    }
    
    func testDeleteProductUnit_URLRequest() throws {
        // Given
        let request = ProductUnitServiceRequest.DeleteProductUnit(id: 888)
        let router = ProductUnitServiceRouter.deleteProductUnit(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertNotNil(urlRequest.url)
        XCTAssertEqual(urlRequest.url!.absoluteString, "\(testBaseURL)/v4/product-units/888")
        XCTAssertEqual(urlRequest.httpMethod, "DELETE")
        XCTAssertNil(urlRequest.httpBody)
    }
    
    // MARK: - Test fetchByHotel with filters
    
    func testFetchByHotel_WithKindFilter_Parameters() {
        // Given
        let request = ProductUnitServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .unit,
            sortedOrder: .ascending,
            kind: .product,
            query: nil
        )
        let router = ProductUnitServiceRouter.fetchByHotel(request: request)
        
        // When
        let parameters = router.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["kind"] as? String, "PRODUCT")
        XCTAssertNil(parameters?["q"])
    }
    
    func testFetchByHotel_WithQueryFilter_Parameters() {
        // Given
        let request = ProductUnitServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .fifty,
            sortedBy: .unit,
            sortedOrder: .descending,
            kind: nil,
            query: "piece"
        )
        let router = ProductUnitServiceRouter.fetchByHotel(request: request)
        
        // When
        let parameters = router.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNil(parameters?["kind"])
        XCTAssertEqual(parameters?["q"] as? String, "piece")
    }
    
    func testFetchByHotel_WithBothFilters_Parameters() {
        // Given
        let request = ProductUnitServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 2,
            perPage: .hundred,
            sortedBy: .kind,
            sortedOrder: .ascending,
            kind: .service,
            query: "hour"
        )
        let router = ProductUnitServiceRouter.fetchByHotel(request: request)
        
        // When
        let parameters = router.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["page"] as? Int, 2)
        XCTAssertEqual(parameters?["per_page"] as? String, "100")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "KIND")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
        XCTAssertEqual(parameters?["kind"] as? String, "SERVICE")
        XCTAssertEqual(parameters?["q"] as? String, "hour")
    }
    
    // MARK: - Test Headers for All Cases
    
    func testHeaders_ConsistentAcrossAllCases() {
        let testCases: [ProductUnitServiceRouter] = [
            .fetchByHotel(request: ProductUnitServiceRequest.FetchByHotel(hotelId: 105, page: nil, perPage: nil, sortedBy: nil, sortedOrder: nil, kind: nil, query: nil)),
            .fetchById(request: ProductUnitServiceRequest.FetchById(id: 1)),
            .createProductUnit(request: ProductUnitServiceRequest.CreateProductUnit(hotelId: 105, unit: "test", kind: .product)),
            .updateProductUnit(request: ProductUnitServiceRequest.UpdateProductUnit(id: 1, hotelId: 105, unit: "test", kind: .product)),
            .deleteProductUnit(request: ProductUnitServiceRequest.DeleteProductUnit(id: 1))
        ]
        
        for router in testCases {
            let headers = router.headers
            XCTAssertNotNil(headers)
            XCTAssertEqual(headers?["Content-Type"], "application/json")
        }
    }
} 
