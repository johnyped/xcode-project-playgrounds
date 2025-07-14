//
//  Account.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import Foundation
import UIKit

struct Account: Codable {
    let id: Int
    let name: String
    let startBalance: Double
    let kind: Kind
    let currency: String
    let openDate: Date
    let isDefault: Bool
    let colorRef: Int
    let iconRef: Int
    let createdAt: Date
    let updatedAt: Date
    let hotelId: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case startBalance = "start_balance"
        case kind
        case currency
        case openDate = "open_date"
        case isDefault = "is_default"
        case colorRef = "color_ref"
        case iconRef = "icon_ref"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case hotelId = "hotel_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        startBalance = (try? container.decode(String.self, forKey: .startBalance).tryToDouble()) ?? 0.0
        kind = try container.decode(Kind.self, forKey: .kind)
        currency = try container.decode(String.self, forKey: .currency)
        openDate = try container.decode(String.self, forKey: .openDate).tryToDate(dateFormat: FormConfig.DateFormat.yyyyMMdd)
        isDefault = try container.decode(Bool.self, forKey: .isDefault)
        colorRef = try container.decode(Int.self, forKey: .colorRef)
        iconRef = try container.decode(Int.self, forKey: .iconRef)
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
        hotelId = try container.decode(Int.self, forKey: .hotelId)
    }
    
    init(id: Int,
         name: String,
         startBalance: Double,
         kind: Kind,
         currency: String,
         openDate: Date,
         isDefault: Bool,
         colorRef: Int,
         iconRef: Int,
         createdAt: Date,
         updatedAt: Date,
         hotelId: Int) {
        self.id = id
        self.name = name
        self.startBalance = startBalance
        self.kind = kind
        self.currency = currency
        self.openDate = openDate
        self.isDefault = isDefault
        self.colorRef = colorRef
        self.iconRef = iconRef
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.hotelId = hotelId
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(startBalance.toString(), forKey: .startBalance)
        try container.encode(kind.rawValue, forKey: .kind)
        try container.encode(currency, forKey: .currency)
        try container.encode(openDate.toDateString(FormConfig.DateFormat.yyyyMMdd), forKey: .openDate)
        try container.encode(isDefault, forKey: .isDefault)
        try container.encode(colorRef, forKey: .colorRef)
        try container.encode(iconRef, forKey: .iconRef)
        try container.encode(createdAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .updatedAt)
        try container.encode(hotelId, forKey: .hotelId)
    }
}

extension Account {  
    enum Kind: String, Codable {
        case others = "OTHERS"
        case savings = "SAVINGS"
        case loan = "LOAN"
        case investing = "INVESTING"
        case debitCard = "DEBIT_CARD"
        case creditCard = "CREDIT_CARD"
        case checking = "CHECKING"
        case cash = "CASH"
        case asset = "ASSET"
        
        var raw: String {
            switch self {
            case .others:
                return "others"
            case .savings:
                return "savings"
            case .loan:
                return "loan"
            case .investing:
                return "investing"
            case .creditCard:
                return "credit_card"
            case .debitCard:
                return "debit_card"
            case .checking:
                return "checking"
            case .asset:
                return "asset"
            case .cash:
                return "cash"
            }
        }
        
        var description: String {
            switch self {
            case .others:
                return "Others"
            case .savings:
                return "Savings"
            case .loan:
                return "Loan"
            case .investing:
                return "Investing"
            case .creditCard:
                return "Credit"
            case .debitCard:
                return "Debit"
            case .checking:
                return "Checking"
            case .asset:
                return "Asset"
            case .cash:
                return "Cash"
            }
        }
        
        var icon: UIImage? {
            switch self {
            case .others:
                return #imageLiteral(resourceName: "account_kind_other_icon.png")
            case .savings:
                return #imageLiteral(resourceName: "account_kind_saving_icon.png")
            case .loan:
                return #imageLiteral(resourceName: "account_kind_loan_icon.png")
            case .investing:
                return #imageLiteral(resourceName: "account_kind_investing_icon.png")
            case .creditCard:
                return #imageLiteral(resourceName: "account_kind_credit_icon.png")
            case .debitCard:
                return #imageLiteral(resourceName: "account_kind_debit_icon.png")
            case .checking:
                return #imageLiteral(resourceName: "account_kind_checking_icon.png")
            case .asset:
                return #imageLiteral(resourceName: "account_kind_asset_icon.png")
            case .cash:
                return #imageLiteral(resourceName: "account_kind_cash_icon.png")
            }
        }
        
    }
}

/*
 json response
 {
   "id": 1,
   "name": "บัญชี รอง",
   "start_balance": "100.0",
   "kind": "SAVINGS",
   "currency": "THB",
   "open_date": "2020-05-09",
   "is_default": false,
   "color_ref": 0,
   "icon_ref": 0,
   "created_at": "2020-05-09T11:57:30.835+07:00",
   "updated_at": "2020-06-17T14:39:16.935+07:00",
   "hotel_id": 105
 }

 */
