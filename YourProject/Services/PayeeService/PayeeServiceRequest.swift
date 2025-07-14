//
//  PayeeServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import Foundation

struct PayeeServiceRequest {
    typealias FetchById = ByID
    typealias DeletePayee = ByID
    
    struct ByID { let id: Int }
    
    enum SortedBy: String {
        case id = "ID"
        case name = "NAME"
        case createdAt = "CREATED_AT"
        case updatedAt = "UPDATED_AT"
    }
    
    struct FetchByHotel: Encodable {
        let hotelId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            if let page = page, page >= 1 {
                try container.encode(page, forKey: .page)
            }
            if let perPage = perPage {
                try container.encode(perPage.rawValue, forKey: .perPage)
            }
            if let sortedBy = sortedBy {
                try container.encode(sortedBy.rawValue, forKey: .sortedBy)
            }
            if let sortedOrder = sortedOrder {
                try container.encode(sortedOrder.rawValue, forKey: .sortedOrder)
            }
        }
    }
    
    struct CreatePayee: Encodable {
        let hotelId: Int
        let name: String
        let memo: String?
        let buyVatType: Payee.VatType
        let sellVatType: Payee.VatType
        let accountItemCategoryId: Int
        let accountSubItemCategoryId: Int?
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        init(hotelId: Int,
             name: String,
             memo: String? = nil,
             buyVatType: Payee.VatType,
             sellVatType: Payee.VatType,
             accountItemCategoryId: Int,
             accountSubItemCategoryId: Int? = nil) {
            self.hotelId = hotelId
            self.name = name
            self.memo = memo
            self.buyVatType = buyVatType
            self.sellVatType = sellVatType
            self.accountItemCategoryId = accountItemCategoryId
            self.accountSubItemCategoryId = accountSubItemCategoryId
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case name
            case memo
            case buyVatType = "buy_vat_type"
            case sellVatType = "sell_vat_type"
            case accountItemCategoryId = "account_item_category_id"
            case accountSubItemCategoryId = "account_sub_item_category_id"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(name, forKey: .name)
            try container.encodeIfPresent(memo, forKey: .memo)
            try container.encode(buyVatType.rawValue, forKey: .buyVatType)
            try container.encode(sellVatType.rawValue, forKey: .sellVatType)
            try container.encode(accountItemCategoryId, forKey: .accountItemCategoryId)
            try container.encodeIfPresent(accountSubItemCategoryId, forKey: .accountSubItemCategoryId)
        }
    }
    
    struct UpdatePayee: Encodable {
        let id: Int
        let name: String?
        let memo: String?
        let buyVatType: Payee.VatType?
        let sellVatType: Payee.VatType?
        let accountItemCategoryId: Int?
        let accountSubItemCategoryId: Int?
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        init(id: Int,
             name: String?,
             memo: String?,
             buyVatType: Payee.VatType?,
             sellVatType: Payee.VatType?,
             accountItemCategoryId: Int?,
             accountSubItemCategoryId: Int?) {
            self.id = id
            self.name = name
            self.memo = memo
            self.buyVatType = buyVatType
            self.sellVatType = sellVatType
            self.accountItemCategoryId = accountItemCategoryId
            self.accountSubItemCategoryId = accountSubItemCategoryId
        }
        
        enum CodingKeys: String, CodingKey {
            case name
            case memo
            case buyVatType = "buy_vat_type"
            case sellVatType = "sell_vat_type"
            case accountItemCategoryId = "account_item_category_id"
            case accountSubItemCategoryId = "account_sub_item_category_id"
            // id is not encoded as it's used in the URL path
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(name, forKey: .name)
            try container.encodeIfPresent(memo, forKey: .memo)
            if let buyVatType = buyVatType {
                try container.encode(buyVatType.rawValue, forKey: .buyVatType)
            }
            if let sellVatType = sellVatType {
                try container.encode(sellVatType.rawValue, forKey: .sellVatType)
            }
            try container.encodeIfPresent(accountItemCategoryId, forKey: .accountItemCategoryId)
            try container.encodeIfPresent(accountSubItemCategoryId, forKey: .accountSubItemCategoryId)
        }
    }
} 