//
//  ContactServiceRequestTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest

class ContactServiceRequestTests: XCTestCase {
    
    // MARK: - FetchByHotel Tests
    
    func test_fetchByHotel_withAllParameters_correctSerialization() throws {
        // Arrange
        let request = ContactServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            businessType: .corporate,
            contactType: .client
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
        XCTAssertEqual(parameters?["business_type"] as? String, "CORPORATE")
        XCTAssertEqual(parameters?["contact_type"] as? String, "CLIENT")
    }
    
    func test_fetchByHotel_withMinimalParameters_correctSerialization() throws {
        // Arrange
        let request = ContactServiceRequest.FetchByHotel(
            hotelId: 105,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            businessType: nil,
            contactType: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
        XCTAssertNil(parameters?["business_type"])
        XCTAssertNil(parameters?["contact_type"])
    }
    
    func test_fetchByHotel_withPageZero_excludesPageFromParameters() throws {
        // Arrange
        let request = ContactServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 0,
            perPage: .fifty,
            sortedBy: .id,
            sortedOrder: .descending,
            businessType: .individual,
            contactType: .host
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNil(parameters?["page"]) // Should be excluded because page < 1
        XCTAssertEqual(parameters?["per_page"] as? String, "50")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
        XCTAssertEqual(parameters?["business_type"] as? String, "INDIVIDUAL")
        XCTAssertEqual(parameters?["contact_type"] as? String, "HOST")
    }
    
    func test_fetchByHotel_withUpdatedAtSorting_correctSerialization() throws {
        // Arrange
        let request = ContactServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .ten,
            sortedBy: .updatedAt,
            sortedOrder: .ascending,
            businessType: nil,
            contactType: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "10")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "UPDATED_AT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
        XCTAssertNil(parameters?["business_type"])
        XCTAssertNil(parameters?["contact_type"])
    }
    
    // MARK: - FetchByCompany Tests
    
    func test_fetchByCompany_withAllParameters_correctSerialization() throws {
        // Arrange
        let request = ContactServiceRequest.FetchByCompany(
            hotelId: 105,
            companyId: 123,
            page: 2,
            perPage: .hundred,
            sortedBy: .createdAt,
            sortedOrder: .ascending,
            businessType: .corporate,
            contactType: .client
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["company_id"] as? Int, 123)
        XCTAssertEqual(parameters?["page"] as? Int, 2)
        XCTAssertEqual(parameters?["per_page"] as? String, "100")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "CREATED_AT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
        XCTAssertEqual(parameters?["business_type"] as? String, "CORPORATE")
        XCTAssertEqual(parameters?["contact_type"] as? String, "CLIENT")
    }
    
    func test_fetchByCompany_withMinimalParameters_correctSerialization() throws {
        // Arrange
        let request = ContactServiceRequest.FetchByCompany(
            hotelId: 105,
            companyId: 456,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            businessType: nil,
            contactType: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["company_id"] as? Int, 456)
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
        XCTAssertNil(parameters?["business_type"])
        XCTAssertNil(parameters?["contact_type"])
    }
    
    func test_fetchByCompany_withUpdatedAtSorting_correctSerialization() throws {
        // Arrange
        let request = ContactServiceRequest.FetchByCompany(
            hotelId: 105,
            companyId: 789,
            page: 1,
            perPage: .twenty,
            sortedBy: .updatedAt,
            sortedOrder: .descending,
            businessType: .individual,
            contactType: .host
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["company_id"] as? Int, 789)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "UPDATED_AT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
        XCTAssertEqual(parameters?["business_type"] as? String, "INDIVIDUAL")
        XCTAssertEqual(parameters?["contact_type"] as? String, "HOST")
    }
    
    // MARK: - FetchByCustomer Tests
    
    func test_fetchByCustomer_withAllParameters_correctSerialization() throws {
        // Arrange
        let request = ContactServiceRequest.FetchByCustomer(
            hotelId: 105,
            customerId: 789,
            page: 1,
            perPage: .ten,
            sortedBy: .companyName,
            sortedOrder: .descending,
            businessType: .corporate,
            contactType: .client
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["customer_id"] as? Int, 789)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "10")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "COMPANY_NAME")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
        XCTAssertEqual(parameters?["business_type"] as? String, "CORPORATE")
        XCTAssertEqual(parameters?["contact_type"] as? String, "CLIENT")
    }
    
    func test_fetchByCustomer_withMinimalParameters_correctSerialization() throws {
        // Arrange
        let request = ContactServiceRequest.FetchByCustomer(
            hotelId: 105,
            customerId: 321,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            businessType: nil,
            contactType: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["customer_id"] as? Int, 321)
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
        XCTAssertNil(parameters?["business_type"])
        XCTAssertNil(parameters?["contact_type"])
    }
    
    func test_fetchByCustomer_withAllSortingOptions_correctSerialization() throws {
        // Arrange & Act & Assert for each sorting option
        let sortingTests: [(ContactServiceRequest.SortedBy, String)] = [
            (.id, "ID"),
            (.companyName, "COMPANY_NAME"),
            (.createdAt, "CREATED_AT"),
            (.updatedAt, "UPDATED_AT")
        ]
        
        for (sortedBy, expectedValue) in sortingTests {
            let request = ContactServiceRequest.FetchByCustomer(
                hotelId: 105,
                customerId: 555,
                page: 1,
                perPage: .fifty,
                sortedBy: sortedBy,
                sortedOrder: .ascending,
                businessType: nil,
                contactType: nil
            )
            
            let parameters = request.parameters
            
            XCTAssertNotNil(parameters)
            XCTAssertEqual(parameters?["sorted_by"] as? String, expectedValue, "Failed for sortedBy: \(sortedBy)")
        }
    }
    
    // MARK: - Filter Parameters Tests
    
    func test_fetchByHotel_withFilterParameters_correctSerialization() throws {
        // Arrange
        let request = ContactServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .companyName,
            sortedOrder: .ascending,
            businessType: .individual,
            contactType: .host
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["business_type"] as? String, "INDIVIDUAL")
        XCTAssertEqual(parameters?["contact_type"] as? String, "HOST")
    }
    
    func test_fetchByCompany_withFilterParameters_correctSerialization() throws {
        // Arrange
        let request = ContactServiceRequest.FetchByCompany(
            hotelId: 105,
            companyId: 123,
            page: 1,
            perPage: .ten,
            sortedBy: .id,
            sortedOrder: .descending,
            businessType: .corporate,
            contactType: .client
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["company_id"] as? Int, 123)
        XCTAssertEqual(parameters?["business_type"] as? String, "CORPORATE")
        XCTAssertEqual(parameters?["contact_type"] as? String, "CLIENT")
    }
    
    func test_fetchByCustomer_withFilterParameters_correctSerialization() throws {
        // Arrange
        let request = ContactServiceRequest.FetchByCustomer(
            hotelId: 105,
            customerId: 456,
            page: 1,
            perPage: .fifty,
            sortedBy: .createdAt,
            sortedOrder: .ascending,
            businessType: .individual,
            contactType: .host
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["customer_id"] as? Int, 456)
        XCTAssertEqual(parameters?["business_type"] as? String, "INDIVIDUAL")
        XCTAssertEqual(parameters?["contact_type"] as? String, "HOST")
    }
    
    // MARK: - CreateContact Tests
    
    func test_createContact_withAllParameters_correctSerialization() throws {
        // Arrange
        let request = ContactServiceRequest.CreateContact(
            businessType: .corporate,
            companyName: "Test Company Ltd.",
            contactType: .client,
            contactId: 123,
            address: "123 Test Street, Bangkok",
            branchName: "Main Branch",
            branchCode: "MB001",
            mobile: "0812345678",
            email: "test@company.com",
            phone: "021234567",
            faxNumber: "021234568",
            taxId: "1234567890123",
            website: "https://testcompany.com",
            creditDate: "2024-12-31",
            hotelId: 105,
            customerId: 456,
            companyId: 789
        )
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let json = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["business_type"] as? String, "CORPORATE")
        XCTAssertEqual(json?["company_name"] as? String, "Test Company Ltd.")
        XCTAssertEqual(json?["contact_type"] as? String, "CLIENT")
        XCTAssertEqual(json?["contact_id"] as? Int, 123)
        XCTAssertEqual(json?["address"] as? String, "123 Test Street, Bangkok")
        XCTAssertEqual(json?["branch_name"] as? String, "Main Branch")
        XCTAssertEqual(json?["branch_code"] as? String, "MB001")
        XCTAssertEqual(json?["mobile"] as? String, "0812345678")
        XCTAssertEqual(json?["email"] as? String, "test@company.com")
        XCTAssertEqual(json?["phone"] as? String, "021234567")
        XCTAssertEqual(json?["fax_number"] as? String, "021234568")
        XCTAssertEqual(json?["tax_id"] as? String, "1234567890123")
        XCTAssertEqual(json?["website"] as? String, "https://testcompany.com")
        XCTAssertEqual(json?["credit_date"] as? String, "2024-12-31")
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["customer_id"] as? Int, 456)
        XCTAssertEqual(json?["company_id"] as? Int, 789)
    }
    
    func test_createContact_withMinimalParameters_correctSerialization() throws {
        // Arrange
        let request = ContactServiceRequest.CreateContact(
            businessType: .individual,
            companyName: "John Doe",
            contactType: .host,
            contactId: nil,
            address: "456 Individual Street",
            branchName: nil,
            branchCode: nil,
            mobile: nil,
            email: "john@example.com",
            phone: "0987654321",
            faxNumber: nil,
            taxId: "9876543210987",
            website: nil,
            creditDate: nil,
            hotelId: 105,
            customerId: nil,
            companyId: nil
        )
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let json = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["business_type"] as? String, "INDIVIDUAL")
        XCTAssertEqual(json?["company_name"] as? String, "John Doe")
        XCTAssertEqual(json?["contact_type"] as? String, "HOST")
        XCTAssertNil(json?["contact_id"])
        XCTAssertEqual(json?["address"] as? String, "456 Individual Street")
        XCTAssertNil(json?["branch_name"])
        XCTAssertNil(json?["branch_code"])
        XCTAssertNil(json?["mobile"])
        XCTAssertEqual(json?["email"] as? String, "john@example.com")
        XCTAssertEqual(json?["phone"] as? String, "0987654321")
        XCTAssertNil(json?["fax_number"])
        XCTAssertEqual(json?["tax_id"] as? String, "9876543210987")
        XCTAssertNil(json?["website"])
        XCTAssertNil(json?["credit_date"])
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertNil(json?["customer_id"])
        XCTAssertNil(json?["company_id"])
    }
    
    // MARK: - UpdateContact Tests
    
    func test_updateContact_withPartialParameters_correctSerialization() throws {
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
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let json = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["business_type"] as? String, "CORPORATE")
        XCTAssertEqual(json?["company_name"] as? String, "Updated Company Name")
        XCTAssertNil(json?["contact_type"])
        XCTAssertNil(json?["contact_id"])
        XCTAssertEqual(json?["address"] as? String, "Updated Address")
        XCTAssertNil(json?["branch_name"])
        XCTAssertNil(json?["branch_code"])
        XCTAssertEqual(json?["mobile"] as? String, "0899999999")
        XCTAssertEqual(json?["email"] as? String, "updated@company.com")
        XCTAssertNil(json?["phone"])
        XCTAssertNil(json?["fax_number"])
        XCTAssertNil(json?["tax_id"])
        XCTAssertEqual(json?["website"] as? String, "https://updated.com")
        XCTAssertNil(json?["credit_date"])
        XCTAssertNil(json?["customer_id"])
        XCTAssertEqual(json?["company_id"] as? Int, 999)
    }
} 
