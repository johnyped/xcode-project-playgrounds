import XCTest

final class ContactTests: XCTestCase {
    // MARK: - Initialization Tests
    func test_initWithAllProperties() throws {
        // Arrange & Act
        let now = Date(timeIntervalSince1970: 1000)
        let contact = Contact(
            id: 1,
            businessType: .corporate,
            companyName: "Test Company",
            contactType: .client,
            contactId: 2,
            address: "123 Main St",
            branchName: "Branch A",
            branchCode: "001",
            mobile: "0812345678",
            email: "test@email.com",
            phone: "021234567",
            faxNumber: "021234568",
            taxId: "1234567890123",
            website: "https://example.com",
            creditDate: "2024-05-10",
            hotelId: 101,
            customerId: 3,
            companyId: 4,
            createdAt: now,
            updatedAt: now
        )
        // Assert
        XCTAssertEqual(contact.id, 1)
        XCTAssertEqual(contact.businessType, .corporate)
        XCTAssertEqual(contact.companyName, "Test Company")
        XCTAssertEqual(contact.contactType, .client)
        XCTAssertEqual(contact.contactId, 2)
        XCTAssertEqual(contact.address, "123 Main St")
        XCTAssertEqual(contact.branchName, "Branch A")
        XCTAssertEqual(contact.branchCode, "001")
        XCTAssertEqual(contact.mobile, "0812345678")
        XCTAssertEqual(contact.email, "test@email.com")
        XCTAssertEqual(contact.phone, "021234567")
        XCTAssertEqual(contact.faxNumber, "021234568")
        XCTAssertEqual(contact.taxId, "1234567890123")
        XCTAssertEqual(contact.website, "https://example.com")
        XCTAssertEqual(contact.creditDate, "2024-05-10")
        XCTAssertEqual(contact.hotelId, 101)
        XCTAssertEqual(contact.customerId, 3)
        XCTAssertEqual(contact.companyId, 4)
        XCTAssertEqual(contact.createdAt, now)
        XCTAssertEqual(contact.updatedAt, now)
    }

    func test_initWithOptionalPropertiesAsNil() throws {
        // Arrange & Act
        let now = Date(timeIntervalSince1970: 1000)
        let contact = Contact(
            id: 1,
            businessType: .individual,
            companyName: "Test Company",
            contactType: .client,
            contactId: nil,
            address: "123 Main St",
            branchName: "Branch A",
            branchCode: "001",
            mobile: nil,
            email: "test@email.com",
            phone: "021234567",
            faxNumber: nil,
            taxId: "1234567890123",
            website: nil,
            creditDate: nil,
            hotelId: 101,
            customerId: nil,
            companyId: nil,
            createdAt: now,
            updatedAt: now
        )
        // Assert
        XCTAssertNil(contact.contactId)
        XCTAssertEqual(contact.mobile, "")
        XCTAssertEqual(contact.faxNumber, "")
        XCTAssertEqual(contact.website, "")
        XCTAssertEqual(contact.creditDate, "")
        XCTAssertNil(contact.customerId)
        XCTAssertNil(contact.companyId)
        XCTAssertEqual(contact.branchName, "Branch A")
        XCTAssertEqual(contact.branchCode, "001")
        XCTAssertEqual(contact.address, "123 Main St")
        XCTAssertEqual(contact.taxId, "1234567890123")
        XCTAssertEqual(contact.email, "test@email.com")
        XCTAssertEqual(contact.phone, "021234567")
        XCTAssertEqual(contact.hotelId, 101)
        XCTAssertEqual(contact.createdAt, now)
        XCTAssertEqual(contact.updatedAt, now)
        XCTAssertEqual(contact.mobile, "")
        XCTAssertEqual(contact.faxNumber, "")
        XCTAssertEqual(contact.website, "")
        XCTAssertEqual(contact.creditDate, "")
    }

    // MARK: - Codable Tests
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 18,
            "business_type": "INDIVIDUAL",
            "company_name": "นายสมชาย ชาติทหาร",
            "contact_type": "CLIENT",
            "contact_id": null,
            "address": "พระโขนง กรุงเทพฯ",
            "branch_name": "",
            "branch_code": "",
            "mobile": null,
            "email": "abc@email.com",
            "phone": "0829282728",
            "fax_number": null,
            "tax_id": "1234567890123",
            "website": null,
            "credit_date": null,
            "created_at": "2023-06-17T22:05:26.238+07:00",
            "updated_at": "2023-08-01T11:29:05.664+07:00",
            "hotel_id": 105,
            "customer_id": null,
            "company_id": null
        }
        """.data(using: .utf8)!
        // Act
        let contact = try JSONDecoder().decode(Contact.self, from: json)
        // Assert
        XCTAssertEqual(contact.id, 18)
        XCTAssertEqual(contact.businessType, .individual)
        XCTAssertEqual(contact.companyName, "นายสมชาย ชาติทหาร")
        XCTAssertEqual(contact.contactType, .client)
        XCTAssertNil(contact.contactId)
        XCTAssertEqual(contact.address, "พระโขนง กรุงเทพฯ")
        XCTAssertEqual(contact.branchName, "")
        XCTAssertEqual(contact.branchCode, "")
        XCTAssertEqual(contact.mobile, "")
        XCTAssertEqual(contact.email, "abc@email.com")
        XCTAssertEqual(contact.phone, "0829282728")
        XCTAssertEqual(contact.faxNumber, "")
        XCTAssertEqual(contact.taxId, "1234567890123")
        XCTAssertEqual(contact.website, "")
        XCTAssertEqual(contact.creditDate, "")
        XCTAssertEqual(contact.hotelId, 105)
        XCTAssertNil(contact.customerId)
        XCTAssertNil(contact.companyId)
    }

    func test_encodingToJSON() throws {
        // Arrange
        let now = Date(timeIntervalSince1970: 1000)
        let contact = Contact(
            id: 1,
            businessType: .individual,
            companyName: "Test Company",
            contactType: .host,
            contactId: 2,
            address: "123 Main St",
            branchName: "Branch A",
            branchCode: "001",
            mobile: "0812345678",
            email: "test@email.com",
            phone: "021234567",
            faxNumber: "021234568",
            taxId: "1234567890123",
            website: "https://example.com",
            creditDate: "2024-05-10",
            hotelId: 101,
            customerId: 3,
            companyId: 4,
            createdAt: now,
            updatedAt: now
        )
        // Act
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(contact)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        // Assert
        XCTAssertTrue(jsonString.contains("\"id\" : 1"))
        XCTAssertTrue(jsonString.contains("\"business_type\" : \"INDIVIDUAL\""))
        XCTAssertTrue(jsonString.contains("\"company_name\" : \"Test Company\""))
        XCTAssertTrue(jsonString.contains("\"contact_type\" : \"HOST\""))
        XCTAssertTrue(jsonString.contains("\"contact_id\" : 2"))
        XCTAssertTrue(jsonString.contains("\"address\" : \"123 Main St\""))
        XCTAssertTrue(jsonString.contains("\"branch_name\" : \"Branch A\""))
        XCTAssertTrue(jsonString.contains("\"branch_code\" : \"001\""))
        XCTAssertTrue(jsonString.contains("\"mobile\" : \"0812345678\""))
        XCTAssertTrue(jsonString.contains("\"email\" : \"test@email.com\""))
        XCTAssertTrue(jsonString.contains("\"phone\" : \"021234567\""))
        XCTAssertTrue(jsonString.contains("\"fax_number\" : \"021234568\""))
        XCTAssertTrue(jsonString.contains("\"tax_id\" : \"1234567890123\""))
        XCTAssertTrue(jsonString.contains("\"website\" : \"https:\\/\\/example.com\""))
        XCTAssertTrue(jsonString.contains("\"credit_date\" : \"2024-05-10\""))
        XCTAssertTrue(jsonString.contains("\"hotel_id\" : 101"))
        XCTAssertTrue(jsonString.contains("\"customer_id\" : 3"))
        XCTAssertTrue(jsonString.contains("\"company_id\" : 4"))
    }
}
