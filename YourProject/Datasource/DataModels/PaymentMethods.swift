//
//  PaymentMethod.swift
//  YourProject
//
//  Created by IntrodexMini on 14/6/2568 BE.
//
import Foundation

struct PaymentMethods: Decodable {
    
    static let shared: PaymentMethods = .init()
    
    let lists: [PaymentMethod]
    var count: Int { return lists.count }
    var first: PaymentMethod? { return lists.first }
    
    init() {
        guard
            let jsonData = JsonFile(path: "Datasource").data(from: "Other/PaymentMethods")
        else {
            self.lists = []
            return
        }
        
        self.lists = (try? JSONDecoder().decode([PaymentMethod].self,
                                                from: jsonData)) ?? []
    }
    
    init(array: [PaymentMethod]) {
        self.lists = array
    }
    
}

extension PaymentMethods {
    struct PaymentMethod: Decodable {
        let name: String
        let subMethods: [PaymentMethod]
        
        
        init(name: String,
             subMethods: [PaymentMethod] = []) {
            self.name = name
            self.subMethods = subMethods
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            name = try container.decode(String.self, forKey: .name)
            subMethods = try container.decode([PaymentMethod].self, forKey: .subMethods)
        }
        
        enum CodingKeys: String, CodingKey {
            case name
            case subMethods = "sub_methods"
        }
    }
    
}
