//
//  AccountServiceResponse.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import Foundation

struct AccountServiceResponse {
    
    struct BalanceInfo: Decodable {
        let id: Int
        let name: String
        let balance: Double

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case balance
        }

        init(id: Int, name:
             String, balance: Double) {
            self.id = id
            self.name = name
            self.balance = balance
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(Int.self, forKey: .id)
            name = try container.decode(String.self, forKey: .name)
            balance = (try? container.decode(String.self, forKey: .balance).tryToDouble()) ?? 0
        }
        
        
        /*
         {
             id: 1,
             "name": "บัญชี รอง",
             "balance": "-372.3499999999999"
         }
         */
    }
} 
