//
//  BankAccountServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest

final class BankAccountServiceRequestTests: XCTestCase {
    
    func testFetchBankAccountsRequest_ToDictionary() {
        // Given
        let request = BankAccountServiceRequest.FetchBankAccounts(
            page: 1,
            perPage: 20,
            sortedBy: "ID",
            sortedOrder: "ASC",
            hotelId: 105
        )
        
        // When
        guard let parameters = request.parameters else {
            XCTFail("Parameters should not be nil")
            return
        }
        
        // Then
        XCTAssertEqual(parameters["page"] as? Int, 1)
        XCTAssertEqual(parameters["per_page"] as? Int, 20)
        XCTAssertEqual(parameters["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters["sorted_order"] as? String, "ASC")
        XCTAssertEqual(parameters["hotel_id"] as? Int, 105)
    }
    
    func testFetchBankAccountsRequest_ToDictionaryWithNilValues() {
        // Given
        let request = BankAccountServiceRequest.FetchBankAccounts(
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            hotelId: nil
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertTrue(parameters?.isEmpty ?? true)
    }
    
    func testCreateBankAccountRequest_Encoding() throws {
        // Given
        let request = BankAccountServiceRequest.CreateBankAccount(
            bankNumber: "1234567890",
            bankName: "ธนาคารกรุงเทพ",
            bankBranch: "สาขาใหญ่",
            accountName: "นายทดสอบ ระบบ",
            isDefault: true,
            hotelId: 105
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["bank_number"] as? String, "1234567890")
        XCTAssertEqual(json?["bank_name"] as? String, "ธนาคารกรุงเทพ")
        XCTAssertEqual(json?["bank_branch"] as? String, "สาขาใหญ่")
        XCTAssertEqual(json?["account_name"] as? String, "นายทดสอบ ระบบ")
        XCTAssertEqual(json?["is_default"] as? Bool, true)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
    }
    
    func testUpdateBankAccountRequest_Encoding() throws {
        // Given
        let request = BankAccountServiceRequest.UpdateBankAccount(
            id: 2,
            bankNumber: "9876543210",
            bankName: "ธนาคารกสิกรไทย",
            bankBranch: "สาขาอัพเดท",
            accountName: "นายอัพเดท ทดสอบ",
            isDefault: false
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["bank_number"] as? String, "9876543210")
        XCTAssertEqual(json?["bank_name"] as? String, "ธนาคารกสิกรไทย")
        XCTAssertEqual(json?["bank_branch"] as? String, "สาขาอัพเดท")
        XCTAssertEqual(json?["account_name"] as? String, "นายอัพเดท ทดสอบ")
        XCTAssertEqual(json?["is_default"] as? Bool, false)
        // id should not be encoded as it's used in the URL path
        XCTAssertNil(json?["id"])
    }
    
    func testUpdateBankAccountRequest_EncodingWithNilValues() throws {
        // Given
        let request = BankAccountServiceRequest.UpdateBankAccount(
            id: 3,
            bankNumber: "1111111111",
            bankName: nil,
            bankBranch: nil,
            accountName: "นายเพียงบางส่วน",
            isDefault: nil
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["bank_number"] as? String, "1111111111")
        XCTAssertEqual(json?["account_name"] as? String, "นายเพียงบางส่วน")
        // Nil values should be encoded as null or not present
        XCTAssertTrue(json?["bank_name"] == nil || json?["bank_name"] is NSNull)
        XCTAssertTrue(json?["bank_branch"] == nil || json?["bank_branch"] is NSNull)
        XCTAssertTrue(json?["is_default"] == nil || json?["is_default"] is NSNull)
    }
    
} 
