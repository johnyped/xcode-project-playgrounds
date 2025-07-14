//
//  CompanyServiceRequestTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest

class CompanyServiceRequestTests: XCTestCase {
    
    // MARK: - FetchByHotel Tests
    
    func test_fetchByHotel_withAllParameters_correctSerialization() throws {
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
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
        XCTAssertEqual(parameters?["query"] as? String, "Test Company")
        XCTAssertEqual(parameters?["only_hidden"] as? Bool, false)
        XCTAssertEqual(parameters?["business_type"] as? String, "CORPORATE")
    }
    
    func test_fetchByHotel_withMinimalParameters_correctSerialization() throws {
        // Arrange
        let request = CompanyServiceRequest.FetchByHotel(
            hotelId: 105,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            query: nil,
            onlyHidden: nil,
            businessType: nil
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
        XCTAssertNil(parameters?["query"])
        XCTAssertNil(parameters?["only_hidden"])
        XCTAssertNil(parameters?["business_type"])
    }
    
    func test_fetchByHotel_withPageZero_excludesPageFromParameters() throws {
        // Arrange
        let request = CompanyServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 0,
            perPage: .fifty,
            sortedBy: .name,
            sortedOrder: .descending,
            query: "Search Term",
            onlyHidden: true,
            businessType: .individual
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNil(parameters?["page"]) // Should be excluded because page < 1
        XCTAssertEqual(parameters?["per_page"] as? String, "50")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "NAME")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
        XCTAssertEqual(parameters?["query"] as? String, "Search Term")
        XCTAssertEqual(parameters?["only_hidden"] as? Bool, true)
        XCTAssertEqual(parameters?["business_type"] as? String, "INDIVIDUAL")
    }
    
    // MARK: - FetchByGuest Tests
    
    func test_fetchByGuest_withAllParameters_correctSerialization() throws {
        // Arrange
        let request = CompanyServiceRequest.FetchByGuest(
            guestId: 310,
            page: 2,
            perPage: .hundred,
            sortedBy: .createdAt,
            sortedOrder: .ascending,
            businessType: .corporate
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["guest_id"] as? Int, 310)
        XCTAssertEqual(parameters?["page"] as? Int, 2)
        XCTAssertEqual(parameters?["per_page"] as? String, "100")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "CREATED_AT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
        XCTAssertEqual(parameters?["business_type"] as? String, "CORPORATE")
    }
    
    func test_fetchByGuest_withMinimalParameters_correctSerialization() throws {
        // Arrange
        let request = CompanyServiceRequest.FetchByGuest(
            guestId: 456,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            businessType: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["guest_id"] as? Int, 456)
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
        XCTAssertNil(parameters?["business_type"])
    }
    
    // MARK: - CreateCompany Tests
    
    func test_createCompany_withAllParameters_correctSerialization() throws {
        // Arrange
        let request = CompanyServiceRequest.CreateCompany(
            userId: 38,
            hotelId: 105,
            businessType: .corporate,
            contactId: 123,
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
            fax: "2222222222",
            email: "abc@email.com",
            taxIncluded: false,
            logoUrl: "https://example.com/logo.png"
        )
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let json = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["user_id"] as? Int, 38)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["business_type"] as? String, "CORPORATE")
        XCTAssertEqual(json?["contact_id"] as? Int, 123)
        XCTAssertEqual(json?["name"] as? String, "Test Company Ltd.")
        XCTAssertEqual(json?["address"] as? String, "992/1")
        XCTAssertEqual(json?["district"] as? String, "Bang Bua Thong")
        XCTAssertEqual(json?["province"] as? String, "Nonthaburi")
        XCTAssertEqual(json?["zip_code"] as? String, "11110")
        XCTAssertEqual(json?["country"] as? String, "THA")
        XCTAssertEqual(json?["tax_id"] as? String, "9999999999999")
        XCTAssertEqual(json?["branch_name"] as? String, "สำนักงานใหญ่")
        XCTAssertEqual(json?["branch_code"] as? String, "001")
        XCTAssertEqual(json?["phone"] as? String, "0928228229")
        XCTAssertEqual(json?["fax"] as? String, "2222222222")
        XCTAssertEqual(json?["email"] as? String, "abc@email.com")
        XCTAssertEqual(json?["tax_included"] as? Bool, false)
        XCTAssertEqual(json?["company_logo"] as? String, "https://example.com/logo.png")
    }
    
    func test_createCompany_withMinimalParameters_correctSerialization() throws {
        // Arrange
        let request = CompanyServiceRequest.CreateCompany(
            userId: nil,
            hotelId: 105,
            businessType: .individual,
            contactId: nil,
            name: "Individual Company",
            address: "123 Individual Street",
            district: "Test District",
            province: "Test Province",
            zipCode: "12345",
            country: "THA",
            taxID: "1234567890123",
            branchName: "Main Branch",
            branchCode: "001",
            phone: "0987654321",
            fax: nil,
            email: "individual@example.com",
            taxIncluded: true,
            logoUrl: nil
        )
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let json = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertNil(json?["user_id"])
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["business_type"] as? String, "INDIVIDUAL")
        XCTAssertNil(json?["contact_id"])
        XCTAssertEqual(json?["name"] as? String, "Individual Company")
        XCTAssertEqual(json?["address"] as? String, "123 Individual Street")
        XCTAssertEqual(json?["district"] as? String, "Test District")
        XCTAssertEqual(json?["province"] as? String, "Test Province")
        XCTAssertEqual(json?["zip_code"] as? String, "12345")
        XCTAssertEqual(json?["country"] as? String, "THA")
        XCTAssertEqual(json?["tax_id"] as? String, "1234567890123")
        XCTAssertEqual(json?["branch_name"] as? String, "Main Branch")
        XCTAssertEqual(json?["branch_code"] as? String, "001")
        XCTAssertEqual(json?["phone"] as? String, "0987654321")
        XCTAssertNil(json?["fax"])
        XCTAssertEqual(json?["email"] as? String, "individual@example.com")
        XCTAssertEqual(json?["tax_included"] as? Bool, true)
        XCTAssertNil(json?["company_logo"])
    }
    
    // MARK: - UpdateCompany Tests
    
    func test_updateCompany_withPartialParameters_correctSerialization() throws {
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
            logoUrl: "https://updated.com/logo.png"
        )
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let json = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["user_id"] as? Int, 38)
        XCTAssertEqual(json?["business_type"] as? String, "CORPORATE")
        XCTAssertNil(json?["contact_id"])
        XCTAssertEqual(json?["name"] as? String, "Updated Company Name")
        XCTAssertNil(json?["address"])
        XCTAssertNil(json?["district"])
        XCTAssertNil(json?["province"])
        XCTAssertNil(json?["zip_code"])
        XCTAssertNil(json?["country"])
        XCTAssertNil(json?["tax_id"])
        XCTAssertEqual(json?["branch_name"] as? String, "Updated Branch")
        XCTAssertNil(json?["branch_code"])
        XCTAssertEqual(json?["phone"] as? String, "0999999999")
        XCTAssertNil(json?["fax"])
        XCTAssertEqual(json?["email"] as? String, "updated@company.com")
        XCTAssertEqual(json?["tax_included"] as? Bool, true)
        XCTAssertEqual(json?["company_logo"] as? String, "https://updated.com/logo.png")
    }
} 
