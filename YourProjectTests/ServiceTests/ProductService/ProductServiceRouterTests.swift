//
//  ProductServiceRouterTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest
import Alamofire

class ProductServiceRouterTests: XCTestCase {
    
    private let testBaseURL = AppConfiguration.shared.baseURL
    
    override func setUp() {
        super.setUp()        
    }
    
    // MARK: - Test fetchByHotel
    
    func testFetchByHotel_PathAndMethod() {
        // Given
        let request = ProductServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .name,
            sortedOrder: .ascending,
            categoryId: 1,
            query: "test"
        )
        let router = ProductServiceRouter.fetchByHotel(request: request)
        
        // When & Then
        XCTAssertEqual(router.path, "/v4/products")
        XCTAssertEqual(router.method, .get)
        XCTAssertEqual(router.domain, testBaseURL)
    }
    
    func testFetchByHotel_Headers() {
        // Given
        let request = ProductServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .name,
            sortedOrder: .ascending,
            categoryId: 1,
            query: "test"
        )
        let router = ProductServiceRouter.fetchByHotel(request: request)
        
        // When
        let headers = router.headers
        
        // Then
        XCTAssertNotNil(headers)
        XCTAssertEqual(headers?["Content-Type"], "application/json")
    }
    
    func testFetchByHotel_Parameters() {
        // Given
        let request = ProductServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .name,
            sortedOrder: .ascending,
            categoryId: 1,
            query: "test"
        )
        let router = ProductServiceRouter.fetchByHotel(request: request)
        
        // When
        let parameters = router.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "NAME")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
        XCTAssertEqual(parameters?["category_id"] as? Int, 1)
        XCTAssertEqual(parameters?["q"] as? String, "test")
    }
    
    func testFetchByHotel_URLRequest() throws {
        // Given
        let request = ProductServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .name,
            sortedOrder: .ascending,
            categoryId: 1,
            query: "test"
        )
        let router = ProductServiceRouter.fetchByHotel(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertNotNil(urlRequest.url)
        XCTAssertTrue(urlRequest.url!.absoluteString.hasPrefix(testBaseURL))
        XCTAssertTrue(urlRequest.url!.absoluteString.contains("/v4/products"))
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    // MARK: - Test fetchById
    
    func testFetchById_PathAndMethod() {
        // Given
        let request = ProductServiceRequest.FetchById(id: 123)
        let router = ProductServiceRouter.fetchById(request: request)
        
        // When & Then
        XCTAssertEqual(router.path, "/v4/products/123")
        XCTAssertEqual(router.method, .get)
        XCTAssertNil(router.parameters)
        XCTAssertNil(router.body)
    }
    
    func testFetchById_URLRequest() throws {
        // Given
        let request = ProductServiceRequest.FetchById(id: 456)
        let router = ProductServiceRouter.fetchById(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertNotNil(urlRequest.url)
        XCTAssertEqual(urlRequest.url!.absoluteString, "\(testBaseURL)/v4/products/456")
        XCTAssertEqual(urlRequest.httpMethod, "GET")
    }
    
    // MARK: - Test createProduct
    
    func testCreateProduct_PathAndMethod() {
        // Given
        let request = ProductServiceRequest.CreateProduct(
            hotelId: 105,
            name: "New Product",
            description: "Test Description",
            barcode: "123456789",
            code: "PROD001",
            categoryId: 1,
            sellingPrice: 100.0,
            sellingVatOption: .excludedVat,
            buyingPrice: 80.0,
            buyingVatOption: .includedVat
        )
        let router = ProductServiceRouter.createProduct(request: request)
        
        // When & Then
        XCTAssertEqual(router.path, "/v4/products")
        XCTAssertEqual(router.method, .post)
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
    func testCreateProduct_Body() throws {
        // Given
        let request = ProductServiceRequest.CreateProduct(
            hotelId: 105,
            name: "New Product", 
            description: "Test Description",
            barcode: "123456789",
            code: "PROD001",
            categoryId: 1,
            sellingPrice: 100.0,
            sellingVatOption: .excludedVat,
            buyingPrice: 80.0,
            buyingVatOption: .includedVat
        )
        let router = ProductServiceRouter.createProduct(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertNotNil(urlRequest.httpBody)
        
        if let bodyData = urlRequest.httpBody,
           let bodyDict = try JSONSerialization.jsonObject(with: bodyData) as? [String: Any] {
            XCTAssertEqual(bodyDict["hotel_id"] as? Int, 105)
            XCTAssertEqual(bodyDict["name"] as? String, "New Product")
            XCTAssertEqual(bodyDict["description"] as? String, "Test Description")
            XCTAssertEqual(bodyDict["barcode"] as? String, "123456789")
            XCTAssertEqual(bodyDict["code"] as? String, "PROD001")
            XCTAssertEqual(bodyDict["category_id"] as? Int, 1)
            XCTAssertEqual(bodyDict["selling_price"] as? String, "100.0")
            XCTAssertEqual(bodyDict["selling_vat_option"] as? String, "EXCLUDED_VAT")
            XCTAssertEqual(bodyDict["buying_price"] as? String, "80.0")
            XCTAssertEqual(bodyDict["buying_vat_option"] as? String, "INCLUDED_VAT")
        } else {
            XCTFail("Failed to parse request body")
        }
    }
    
    // MARK: - Test updateProduct
    
    func testUpdateProduct_PathAndMethod() {
        // Given
        let request = ProductServiceRequest.UpdateProduct(
            id: 789,
            hotelId: 105,
            name: "Updated Product",
            description: "Updated Description",
            barcode: "987654321",
            code: "UPROD001",
            categoryId: 2,
            sellingPrice: 120.0,
            sellingVatOption: .includedVat,
            buyingPrice: 90.0,
            buyingVatOption: .excludedVat
        )
        let router = ProductServiceRouter.updateProduct(request: request)
        
        // When & Then
        XCTAssertEqual(router.path, "/v4/products/789")
        XCTAssertEqual(router.method, .put)
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
    func testUpdateProduct_URLRequest() throws {
        // Given
        let request = ProductServiceRequest.UpdateProduct(
            id: 999,
            hotelId: 105,
            name: "Updated Product",
            description: "Updated Description",
            barcode: nil,
            code: nil,
            categoryId: nil,
            sellingPrice: 50.0,
            sellingVatOption: .includedVat,
            buyingPrice: 40.0,
            buyingVatOption: .excludedVat
        )
        let router = ProductServiceRouter.updateProduct(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertNotNil(urlRequest.url)
        XCTAssertEqual(urlRequest.url!.absoluteString, "\(testBaseURL)/v4/products/999")
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertNotNil(urlRequest.httpBody)
    }
    
    // MARK: - Test deleteProduct
    
    func testDeleteProduct_PathAndMethod() {
        // Given
        let request = ProductServiceRequest.DeleteProduct(id: 555)
        let router = ProductServiceRouter.deleteProduct(request: request)
        
        // When & Then
        XCTAssertEqual(router.path, "/v4/products/555")
        XCTAssertEqual(router.method, .delete)
        XCTAssertNil(router.parameters)
        XCTAssertNil(router.body)
    }
    
    func testDeleteProduct_URLRequest() throws {
        // Given
        let request = ProductServiceRequest.DeleteProduct(id: 777)
        let router = ProductServiceRouter.deleteProduct(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertNotNil(urlRequest.url)
        XCTAssertEqual(urlRequest.url!.absoluteString, "\(testBaseURL)/v4/products/777")
        XCTAssertEqual(urlRequest.httpMethod, "DELETE")
        XCTAssertNil(urlRequest.httpBody)
    }
} 
