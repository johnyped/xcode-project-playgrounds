//
//  CompanyServiceRouterTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest

class CompanyServiceRouterTests: XCTestCase {
    
    // MARK: - FetchByHotel Tests
    
    func test_fetchByHotel_hasCorrectPath() throws {
        // Arrange
        let request = CompanyServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            query: "Test Company",
            onlyHidden: false,
            businessType: .corporate
        )
        let router = CompanyServiceRouter.fetchByHotel(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/companies")
        XCTAssertEqual(router.method.rawValue, "GET")
        XCTAssertNotNil(router.parameters)
    }
    
    // MARK: - FetchByGuest Tests
    
    func test_fetchByGuest_hasCorrectPath() throws {
        // Arrange
        let request = CompanyServiceRequest.FetchByGuest(
            guestId: 310,
            page: 1,
            perPage: .ten,
            sortedBy: .name,
            sortedOrder: .ascending,
            businessType: .corporate
        )
        let router = CompanyServiceRouter.fetchByGuest(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/companies/guest")
        XCTAssertEqual(router.method.rawValue, "GET")
        XCTAssertNotNil(router.parameters)
    }
    
    // MARK: - FetchById Tests
    
    func test_fetchById_hasCorrectPath() throws {
        // Arrange
        let request = CompanyServiceRequest.FetchById(id: 6)
        let router = CompanyServiceRouter.fetchById(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/companies/6")
        XCTAssertEqual(router.method.rawValue, "GET")
        XCTAssertNil(router.parameters)
        XCTAssertNil(router.body)
    }
    
    // MARK: - CreateCompany Tests
    
    func test_createCompany_hasCorrectPath() throws {
        // Arrange
        let request = CompanyServiceRequest.CreateCompany(
            userId: 38,
            hotelId: 105,
            businessType: .corporate,
            contactId: nil,
            name: "Test Company Ltd.",
            address: "992/1",
            district: "Bang Bua Thong",
            province: "Nonthaburi",
            zipCode: "11110",
            country: "THA",
            taxID: "9999999999999",
            branchName: "สำนักงานใหญ่",
            branchCode: "001",
            phone: "0928228229",
            fax: nil,
            email: "abc@email.com",
            taxIncluded: false,
            logoUrl: nil
        )
        let router = CompanyServiceRouter.createCompany(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/companies")
        XCTAssertEqual(router.method.rawValue, "POST")
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
    // MARK: - UpdateCompany Tests
    
    func test_updateCompany_hasCorrectPath() throws {
        // Arrange
        let request = CompanyServiceRequest.UpdateCompany(
            id: 6,
            userId: 38,
            businessType: .corporate,
            contactId: nil,
            name: "Updated Company Name",
            address: nil,
            district: nil,
            province: nil,
            zipCode: nil,
            country: nil,
            taxID: nil,
            branchName: "Updated Branch",
            branchCode: nil,
            phone: "0999999999",
            fax: nil,
            email: "updated@company.com",
            taxIncluded: true,
            logoUrl: nil
        )
        let router = CompanyServiceRouter.updateCompany(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/companies/6")
        XCTAssertEqual(router.method.rawValue, "PUT")
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
    // MARK: - HideCompany Tests
    
    func test_hideCompany_hasCorrectPath() throws {
        // Arrange
        let request = CompanyServiceRequest.HideCompany(id: 6)
        let router = CompanyServiceRouter.hideCompany(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/companies/6/hide")
        XCTAssertEqual(router.method.rawValue, "POST")
        XCTAssertNil(router.parameters)
        XCTAssertNil(router.body)
    }
    
    // MARK: - UnhideCompany Tests
    
    func test_unhideCompany_hasCorrectPath() throws {
        // Arrange
        let request = CompanyServiceRequest.UnhideCompany(id: 6)
        let router = CompanyServiceRouter.unhideCompany(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/companies/6/unhide")
        XCTAssertEqual(router.method.rawValue, "POST")
        XCTAssertNil(router.parameters)
        XCTAssertNil(router.body)
    }
    
    // MARK: - DeleteCompany Tests
    
    func test_deleteCompany_hasCorrectPath() throws {
        // Arrange
        let request = CompanyServiceRequest.DeleteCompany(id: 6)
        let router = CompanyServiceRouter.deleteCompany(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/companies/6")
        XCTAssertEqual(router.method.rawValue, "DELETE")
        XCTAssertNil(router.parameters)
        XCTAssertNil(router.body)
    }
    
    // MARK: - Headers Tests
    
    func test_allRouters_haveCorrectHeaders() throws {
        // Arrange
        let fetchRequest = CompanyServiceRequest.FetchByHotel(
            hotelId: 105,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            query: nil,
            onlyHidden: nil,
            businessType: nil
        )
        let createRequest = CompanyServiceRequest.CreateCompany(
            userId: nil,
            hotelId: 105,
            businessType: .individual,
            contactId: nil,
            name: "Test",
            address: "Test Address",
            district: "Test District",
            province: "Test Province",
            zipCode: "12345",
            country: "THA",
            taxID: "1234567890123",
            branchName: "Test Branch",
            branchCode: "001",
            phone: "0123456789",
            fax: nil,
            email: "test@test.com",
            taxIncluded: false,
            logoUrl: nil
        )
        
        let routers: [CompanyServiceRouter] = [
            .fetchByHotel(request: fetchRequest),
            .fetchByGuest(request: CompanyServiceRequest.FetchByGuest(
                guestId: 1,
                page: nil,
                perPage: nil,
                sortedBy: nil,
                sortedOrder: nil,
                businessType: nil
            )),
            .fetchById(request: CompanyServiceRequest.FetchById(id: 1)),
            .createCompany(request: createRequest),
            .updateCompany(request: CompanyServiceRequest.UpdateCompany(
                id: 1,
                userId: nil,
                businessType: nil,
                contactId: nil,
                name: nil,
                address: nil,
                district: nil,
                province: nil,
                zipCode: nil,
                country: nil,
                taxID: nil,
                branchName: nil,
                branchCode: nil,
                phone: nil,
                fax: nil,
                email: nil,
                taxIncluded: nil,
                logoUrl: nil
            )),
            .hideCompany(request: CompanyServiceRequest.HideCompany(id: 1)),
            .unhideCompany(request: CompanyServiceRequest.UnhideCompany(id: 1)),
            .deleteCompany(request: CompanyServiceRequest.DeleteCompany(id: 1))
        ]
        
        // Act & Assert
        for router in routers {
            let headers = router.headers
            XCTAssertNotNil(headers)
            XCTAssertEqual(headers?["Content-Type"], "application/json")
        }
    }
    
    // MARK: - URL Request Tests
    
    func test_fetchByHotel_asURLRequest_isValid() throws {
        // Arrange
        let request = CompanyServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            query: "Test",
            onlyHidden: false,
            businessType: .corporate
        )
        let router = CompanyServiceRouter.fetchByHotel(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertNotNil(urlRequest.url)
        XCTAssertTrue(urlRequest.url!.absoluteString.contains("/v4/companies"))
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    func test_createCompany_asURLRequest_isValid() throws {
        // Arrange
        let request = CompanyServiceRequest.CreateCompany(
            userId: nil,
            hotelId: 105,
            businessType: .corporate,
            contactId: nil,
            name: "Test Company",
            address: "Test Address",
            district: "Test District",
            province: "Test Province",
            zipCode: "12345",
            country: "THA",
            taxID: "1234567890123",
            branchName: "Test Branch",
            branchCode: "001",
            phone: "0123456789",
            fax: nil,
            email: "test@test.com",
            taxIncluded: false,
            logoUrl: nil
        )
        let router = CompanyServiceRouter.createCompany(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertNotNil(urlRequest.url)
        XCTAssertTrue(urlRequest.url!.absoluteString.contains("/v4/companies"))
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertNotNil(urlRequest.httpBody)
    }
} 
