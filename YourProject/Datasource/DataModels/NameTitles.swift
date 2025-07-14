//
//  NameTitleList.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//


import Foundation

struct NameTitleList: Codable {
    
    static let shared: NameTitleList = NameTitleList()
    
    let lists: [NameTitle]
    var count: Int { return lists.count }
            
    init() {
        let jsonData = JsonFile(path: "Datasource").data(from: "Other/NameTitles")
        
        guard
            let jsonData
        else {
            self.lists = []
            return
        }
        
        self.lists = (try? JSONDecoder().decode([NameTitle].self,
                                                from: jsonData)) ?? []
    }
    
    func title(key: String) -> NameTitle? {
        lists.first(where: { $0.key == key })
    }
    
}

extension NameTitleList {
    
    struct NameTitle: Codable {
        
        let enTitle: String
        let thTitle: String
        let key: String
        
        var localizeTitle: String {
//            switch Language.shared {
//            case .en:
//                return enTitle
//            case .th:
//                return thTitle
//            }
            enTitle
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(enTitle,
                                 forKey: .enTitle)
            try container.encode(thTitle,
                                 forKey: .thTitle)
            try container.encode(key,
                                 forKey: .key)
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.enTitle = try container.decode(String.self,
                                                forKey: .enTitle)
            self.thTitle = (try? container.decode(String.self,
                                                forKey: .thTitle)) ?? ""
            self.key = try container.decode(String.self,
                                            forKey: .key)
        }
        
        enum CodingKeys: String,
        CodingKey {
            case enTitle = "en_title"
            case thTitle = "th_title"
            case key
        }
        
    }
}
