//
//  Pdpa.swift
//  YourProject
//
//  Created by IntrodexMini on 9/6/2568 BE.
//

import Foundation

struct Pdpa: Codable {
    let id: Int
    let htmlContent: Content
    let onDate: Date?
    let version: Version
    let updateAt: Date
    
    init(id: Int,
         htmlContent: Content,
         onDate: Date? = nil,
         version: Version,
         updateAt: Date) {
        self.id = id
        self.htmlContent = htmlContent
        self.onDate = onDate
        self.version = version
        self.updateAt = updateAt
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self,
                                       forKey: .id)
        
        self.htmlContent = try container.decode(Content.self,
                                                forKey: .content)
        
        self.onDate = try? container.decode(String.self,
                                            forKey: .onDate).tryToDate(FormConfig.DateFormat.datetimeISO)
        
        let versionRaw = try container.decode(String.self,
                                              forKey: .version)
        self.version = .init(string: versionRaw) ?? .init(string: "1")!
        
        self.updateAt = try container.decode(String.self,
                                             forKey: .updateAt).tryToDate(FormConfig.DateFormat.datetimeISO)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id,
                             forKey: .id)
        
        try container.encode(htmlContent,
                             forKey: .content)
        
        try container.encode(onDate?.toDateString(FormConfig.DateFormat.datetimeISO),
                             forKey: .onDate)
                
        try container.encode(version.minimiumrRaw,
                             forKey: .version)
        
        try container.encode(updateAt.toDateString(FormConfig.DateFormat.datetimeISO),
                             forKey: .updateAt)
    }
}

extension Pdpa {
    struct Content: Codable {
        let th: String?
        let en: String?
        
        init(th: String? = nil,
             en: String? = nil) {
            self.th = th
            self.en = en
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.th = try? container.decode(String.self,
                                            forKey: .th)
            
            self.en = try? container.decode(String.self,
                                            forKey: .en)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(th,
                                 forKey: .th)
            
            try container.encode(en,
                                 forKey: .en)
        }
        
        enum CodingKeys: String, CodingKey {
            case th
            case en
        }
    
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case content
        case onDate = "on_date"
        case version
        case updateAt = "update_at"
    }
}

extension Pdpa: Comparable {
    static func < (lhs: Pdpa, rhs: Pdpa) -> Bool {
        return lhs.version < rhs.version // This uses the `<` function defined in the `Version` Comparable conformance.
    }
    
    static func == (lhs: Pdpa, rhs: Pdpa) -> Bool {
        // You might want to compare all properties that make sense in your use case.
        // For now, let's consider two Pdpa instances equal if their versions are equal.
        return lhs.version == rhs.version
    }
}


/*
 {
         "id": 1,
         "content": {
             "th": "thai content",
             "en": "enf content"
         },
         "on_date": null,
         "version": "1.0",
         "updated_at": "2023-10-27T06:41:18.483+07:00"
     }
 */

