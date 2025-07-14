//
//  BankAccountServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//
import Foundation

struct BankAccountServiceRequest {
    
    typealias FetchBankAccount = ByID
    typealias DeleteBankAccount = ByID
    typealias SetDefaultBankAccount = ByID

    struct ByID {
        let id: Int
    }
    
    struct FetchBankAccounts: Encodable {
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?
        let hotelId: Int?
        
        var parameters: [String: Any]? {
            var dict: [String: Any] = [:]
            if let page = page { dict["page"] = page }
            if let perPage = perPage { dict["per_page"] = perPage }
            if let sortedBy = sortedBy { dict["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { dict["sorted_order"] = sortedOrder }
            if let hotelId = hotelId { dict["hotel_id"] = hotelId }
            return dict
        }
                
    }    
    
    struct CreateBankAccount: Encodable {
        let bankNumber: String
        let bankName: String
        let bankBranch: String
        let accountName: String
        let isDefault: Bool
        let hotelId: Int
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }

        enum CodingKeys: String, CodingKey {
            case bankNumber = "bank_number"
            case bankName = "bank_name"
            case bankBranch = "bank_branch"
            case accountName = "account_name"
            case isDefault = "is_default"
            case hotelId = "hotel_id"
        }
    }
    
    struct UpdateBankAccount: Encodable {
        let id: Int
        let bankNumber: String?
        let bankName: String?
        let bankBranch: String?
        let accountName: String?
        let isDefault: Bool?

        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
        
        enum CodingKeys: String, CodingKey {
            case bankNumber = "bank_number"
            case bankName = "bank_name"
            case bankBranch = "bank_branch"
            case accountName = "account_name"
            case isDefault = "is_default"
            // id is not encoded as it's used in the URL path
        }
    }
    
}
