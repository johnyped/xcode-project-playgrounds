//
//  ContactServiceRouterTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest

class ContactServiceRouterTests: XCTestCase {
    
    // MARK: - FetchByHotel Tests
    
    func test_fetchByHotel_hasCorrectPath() throws {
        // Arrange
        let request = ContactServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            businessType: nil,
            contactType: nil
        )
        let router = ContactServiceRouter.fetchByHotel(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/contacts")
        XCTAssertEqual(router.method.rawValue, "GET")
        XCTAssertNotNil(router.parameters)
    }
    
    // MARK: - FetchByCompany Tests
    
    func test_fetchByCompany_hasCorrectPath() throws {
        // Arrange
        let request = ContactServiceRequest.FetchByCompany(
            hotelId: 105,
            companyId: 123,
            page: 1,
            perPage: .ten,
            sortedBy: .companyName,
            sortedOrder: .ascending,
            businessType: nil,
            contactType: nil
        )
        let router = ContactServiceRouter.fetchByCompany(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/contacts/company")
        XCTAssertEqual(router.method.rawValue, "GET")
        XCTAssertNotNil(router.parameters)
    }
    
    // MARK: - FetchByCustomer Tests
    
    func test_fetchByCustomer_hasCorrectPath() throws {
        // Arrange
        let request = ContactServiceRequest.FetchByCustomer(
            hotelId: 105,
            customerId: 456,
            page: 1,
            perPage: .fifty,
            sortedBy: .createdAt,
            sortedOrder: .descending,
            businessType: nil,
            contactType: nil
        )
        let router = ContactServiceRouter.fetchByCustomer(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/contacts/customer")
        XCTAssertEqual(router.method.rawValue, "GET")
        XCTAssertNotNil(router.parameters)
    }
    
    // MARK: - FetchById Tests
    
    func test_fetchById_hasCorrectPath() throws {
        // Arrange
        let request = ContactServiceRequest.FetchById(id: 18)
        let router = ContactServiceRouter.fetchById(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/contacts/18")
        XCTAssertEqual(router.method.rawValue, "GET")
        XCTAssertNil(router.parameters)
        XCTAssertNil(router.body)
    }
    
    // MARK: - CreateContact Tests
    
    func test_createContact_hasCorrectPath() throws {
        // Arrange
        let request = ContactServiceRequest.CreateContact(
            businessType: .corporate,
            companyName: "Test Company Ltd.",
            contactType: .client,
            contactId: nil,
            address: "123 Test Street",
            branchName: "Main Branch",
            branchCode: "MB001",
            mobile: "0812345678",
            email: "test@company.com",
            phone: "021234567",
            faxNumber: nil,
            taxId: "1234567890123",
            website: "https://testcompany.com",
            creditDate: nil,
            hotelId: 105,
            customerId: nil,
            companyId: nil
        )
        let router = ContactServiceRouter.createContact(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/contacts")
        XCTAssertEqual(router.method.rawValue, "POST")
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
    // MARK: - UpdateContact Tests
    
    func test_updateContact_hasCorrectPath() throws {
        // Arrange
        let request = ContactServiceRequest.UpdateContact(
            id: 18,
            businessType: .corporate,
            companyName: "Updated Company Name",
            contactType: nil,
            contactId: nil,
            address: "Updated Address",
            branchName: nil,
            branchCode: nil,
            mobile: "0899999999",
            email: "updated@company.com",
            phone: nil,
            faxNumber: nil,
            taxId: nil,
            website: "https://updated.com",
            creditDate: nil,
            customerId: nil,
            companyId: 999
        )
        let router = ContactServiceRouter.updateContact(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/contacts/18")
        XCTAssertEqual(router.method.rawValue, "PUT")
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
    // MARK: - DeleteContact Tests
    
    func test_deleteContact_hasCorrectPath() throws {
        // Arrange
        let request = ContactServiceRequest.DeleteContact(id: 18)
        let router = ContactServiceRouter.deleteContact(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/contacts/18")
        XCTAssertEqual(router.method.rawValue, "DELETE")
        XCTAssertNil(router.parameters)
        XCTAssertNil(router.body)
    }
    
    // MARK: - Headers Tests
    
    func test_allRouters_haveCorrectHeaders() throws {
        // Arrange
        let fetchRequest = ContactServiceRequest.FetchByHotel(
            hotelId: 105,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            businessType: nil,
            contactType: nil
        )
        
        let createRequest = ContactServiceRequest.CreateContact(
            businessType: .individual,
            companyName: "Test",
            contactType: .client,
            contactId: nil,
            address: "Test Address",
            branchName: nil,
            branchCode: nil,
            mobile: nil,
            email: "test@test.com",
            phone: "0123456789",
            faxNumber: nil,
            taxId: "1234567890123",
            website: nil,
            creditDate: nil,
            hotelId: 105,
            customerId: nil,
            companyId: nil
        )
        
        let routers: [ContactServiceRouter] = [
            .fetchByHotel(request: fetchRequest),
            .createContact(request: createRequest),
            .fetchById(request: ContactServiceRequest.FetchById(id: 1)),
            .updateContact(request: ContactServiceRequest.UpdateContact(
                id: 1,
                businessType: nil,
                companyName: nil,
                contactType: nil,
                contactId: nil,
                address: nil,
                branchName: nil,
                branchCode: nil,
                mobile: nil,
                email: nil,
                phone: nil,
                faxNumber: nil,
                taxId: nil,
                website: nil,
                creditDate: nil,
                customerId: nil,
                companyId: nil
            )),
            .deleteContact(request: ContactServiceRequest.DeleteContact(id: 1))
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
        let request = ContactServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            businessType: nil,
            contactType: nil
        )
        let router = ContactServiceRouter.fetchByHotel(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertNotNil(urlRequest.url)
        XCTAssertTrue(urlRequest.url!.absoluteString.contains("/v4/contacts"))
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    func test_createContact_asURLRequest_isValid() throws {
        // Arrange
        let request = ContactServiceRequest.CreateContact(
            businessType: .corporate,
            companyName: "Test Company",
            contactType: .client,
            contactId: nil,
            address: "Test Address",
            branchName: nil,
            branchCode: nil,
            mobile: nil,
            email: "test@test.com",
            phone: "0123456789",
            faxNumber: nil,
            taxId: "1234567890123",
            website: nil,
            creditDate: nil,
            hotelId: 105,
            customerId: nil,
            companyId: nil
        )
        let router = ContactServiceRouter.createContact(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertNotNil(urlRequest.url)
        XCTAssertTrue(urlRequest.url!.absoluteString.contains("/v4/contacts"))
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertNotNil(urlRequest.httpBody)
    }
} 
