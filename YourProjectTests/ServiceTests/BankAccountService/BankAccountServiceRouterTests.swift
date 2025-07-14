//
//  BankAccountServiceRouterTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest
import Alamofire
import Mockable

final class BankAccountServiceRouterTests: XCTestCase {
    
    var baseURL: String!
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()
    
    override func setUp() {
        super.setUp()
        baseURL = AppConfiguration.shared.baseURL
    }
    
    func testFetchBankAccountsRequest() throws {
        // Given
        let req = BankAccountServiceRequest.FetchBankAccounts(
            page: 1,
            perPage: 20,
            sortedBy: "ID",
            sortedOrder: "ASC",
            hotelId: 105
        )
        let router = BankAccountServiceRouter.fetchBankAccounts(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        // Check base path
        XCTAssertTrue(url.absoluteString.contains(baseURL + "/v4/bank-accounts"))
        
        // Check individual parameters
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        XCTAssertTrue(queryItems.contains { $0.name == "page" && $0.value == "1" })
        XCTAssertTrue(queryItems.contains { $0.name == "per_page" && $0.value == "20" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_by" && $0.value == "ID" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_order" && $0.value == "ASC" })
        XCTAssertTrue(queryItems.contains { $0.name == "hotel_id" && $0.value == "105" })
        
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.get.rawValue)
    }
    
    func testFetchBankAccountRequest() throws {
        // Given
        let req = BankAccountServiceRequest.FetchBankAccount(id: 2)
        let router = BankAccountServiceRouter.fetchBankAccount(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/bank-accounts/2")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.get.rawValue)
    }
    
    func testCreateBankAccountRequest() throws {
        // Given
        let req = BankAccountServiceRequest.CreateBankAccount(
            bankNumber: "1234567890",
            bankName: "ธนาคารกรุงเทพ",
            bankBranch: "สาขาใหญ่",
            accountName: "นายทดสอบ ระบบ",
            isDefault: true,
            hotelId: 105
        )
        let router = BankAccountServiceRouter.createBankAccount(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/bank-accounts")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.post.rawValue)
        
        // Test parameters
        if let body = urlRequest.httpBody {
            do {
                if let json = try JSONSerialization.jsonObject(with: body,
                                                               options: []) as? [String: Any] {
                    print(json)
                    XCTAssertEqual(json["bank_number"] as? String, "1234567890")
                    XCTAssertEqual(json["bank_name"] as? String, "ธนาคารกรุงเทพ")
                    XCTAssertEqual(json["bank_branch"] as? String, "สาขาใหญ่")
                    XCTAssertEqual(json["account_name"] as? String, "นายทดสอบ ระบบ")
                    XCTAssertEqual(json["is_default"] as? Bool, true)
                    XCTAssertEqual(json["hotel_id"] as? Int, 105)
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
    
    func testUpdateBankAccountRequest() throws {
        // Given
        let req = BankAccountServiceRequest.UpdateBankAccount(
            id: 2,
            bankNumber: "9876543210",
            bankName: "ธนาคารกสิกรไทย",
            bankBranch: "สาขาอัพเดท",
            accountName: "นายอัพเดท ทดสอบ",
            isDefault: false
        )
        let router = BankAccountServiceRouter.updateBankAccount(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/bank-accounts/2")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.put.rawValue)
        
        // Test body
        if let body = urlRequest.httpBody {
            do {
                if let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any] {
                    XCTAssertEqual(json["bank_number"] as? String, "9876543210")
                    XCTAssertEqual(json["bank_name"] as? String, "ธนาคารกสิกรไทย")
                    XCTAssertEqual(json["bank_branch"] as? String, "สาขาอัพเดท")
                    XCTAssertEqual(json["account_name"] as? String, "นายอัพเดท ทดสอบ")
                    XCTAssertEqual(json["is_default"] as? Bool, false)
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
    
    func testDeleteBankAccountRequest() throws {
        // Given
        let req = BankAccountServiceRequest.DeleteBankAccount(id: 3)
        let router = BankAccountServiceRouter.deleteBankAccount(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/bank-accounts/3")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.delete.rawValue)
        XCTAssertNil(urlRequest.httpBody)
    }
    
    func testSetDefaultBankAccountRequest() throws {
        // Given
        let req = BankAccountServiceRequest.SetDefaultBankAccount(id: 5)
        let router = BankAccountServiceRouter.setDefaultBankAccount(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/bank-accounts/5/default")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.post.rawValue)
        XCTAssertNil(urlRequest.httpBody)
    }
    
    func testFetchBankAccountsRequestWithOptionalParameters() throws {
        // Given
        let req = BankAccountServiceRequest.FetchBankAccounts(
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            hotelId: nil
        )
        let router = BankAccountServiceRouter.fetchBankAccounts(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        // Check base path (should not have query parameters)
        XCTAssertEqual(url.absoluteString, baseURL + "/v4/bank-accounts")
        
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.get.rawValue)
    }
    
    func testUpdateBankAccountRequestWithPartialData() throws {
        // Given
        let req = BankAccountServiceRequest.UpdateBankAccount(
            id: 4,
            bankNumber: "1111111111",
            bankName: nil,
            bankBranch: nil,
            accountName: "นายเพียงบางส่วน",
            isDefault: nil
        )
        let router = BankAccountServiceRouter.updateBankAccount(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/bank-accounts/4")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.put.rawValue)
        
        // Test body with partial data
        if let body = urlRequest.httpBody {
            do {
                if let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any] {
                    XCTAssertEqual(json["bank_number"] as? String, "1111111111")
                    XCTAssertEqual(json["account_name"] as? String, "นายเพียงบางส่วน")
                    // Nil values should not be present in JSON
                    XCTAssertTrue(json["bank_name"] == nil || json["bank_name"] is NSNull)
                    XCTAssertTrue(json["bank_branch"] == nil || json["bank_branch"] is NSNull)
                    XCTAssertTrue(json["is_default"] == nil || json["is_default"] is NSNull)
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
} 
