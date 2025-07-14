//
//  Beds24Channels.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//

import Foundation

struct Beds24Channels: Codable {
    
    static let shared: Beds24Channels = .init()
    
    let lists: [Beds24Channel]
    var count: Int { return lists.count }
    
    var avilabelChannels: Set<LocalPriceCard.AvailabelChannel> {
        Set(lists.map({
            .init(channelID: $0.hmsChannelID,
                  subChannelID: $0.hmsSubChannelID)
        }))
    }
    
    init() {
        guard
            let jsonData = JsonFile(path: "Datasource").data(from: "Beds24/Channels")
        else {
            self.lists = []
            return
        }
        
        do {
            let result = try JSONDecoder().decode([Beds24Channel].self,
                                                  from: jsonData)
            
            lists = result
        } catch {
            lists = []
        }
        
    }
    
    init(lists: [Beds24Channel]) {
        self.lists = lists
    }
    
    func first(beds24RateKey: String) -> Beds24Channels.Beds24Channel? {
        lists.first(where: { $0.beds24RateKey == beds24RateKey })
    }
    
    func first(referer: String) -> Beds24Channels.Beds24Channel? {
        lists.first(where: {
            $0.beds24Properties.referer == referer ||
            $0.beds24Properties.refererEditable == referer
        })
    }
    
    func first(apiSource: Int) -> Beds24Channels.Beds24Channel? {
        lists.first(where: { $0.beds24Properties.apiSource == apiSource })
    }
    
    func filter(channelID: Int,
                subChannelID: Int?) -> Self {
        if let subChannelID {
            let result = lists.filter({ $0.hmsChannelID == channelID &&
                $0.hmsSubChannelID == subChannelID })
            return .init(lists: result)
        }
        
        let result = lists.filter({ $0.hmsChannelID == channelID })
        return .init(lists: result)
    }
    
    func first(channelKey: String) -> Beds24Channel? {
        lists.first(where: { $0.beds24RateKey == channelKey })
    }
    
    func toFirstGroupChannels() -> GroupChannel? {
        guard let firstChannelID = lists.first?.hmsChannelID else { return nil }
        
        let subChannelIDs: [Int] = lists.filter({
            $0.hmsChannelID == firstChannelID
        }).map({ $0.hmsSubChannelID })
        
        return .init(channalID: firstChannelID,
                     subChannelIDs: subChannelIDs)
    }
    
}

extension Beds24Channels {
    struct GroupChannel {
        let channalID: Int
        let subChannelIDs: [Int]
    }
    
    struct Beds24Channel: Codable {
        let id: Int
        let name: String
        
        let hmsChannelID: Int
        let hmsSubChannelID: Int
        
        let beds24RateKey: String?
        let beds24RateCodeKey: String?
        let beds24Properties: Beds24Properties
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            
            case hmsChannelID = "hms_channel_id"
            case hmsSubChannelID = "hms_sub_channel_id"
            
            case beds24RateKey = "beds24_rate_key"
            case beds24RateCodeKey = "beds24_rate_code_key"
            case beds24Properties = "beds24_properties"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.id = try container.decode(Int.self, forKey: .id)
            self.name = try container.decode(String.self, forKey: .name)
            
            self.hmsChannelID = try container.decode(Int.self, forKey: .hmsChannelID)
            self.hmsSubChannelID = try container.decode(Int.self, forKey: .hmsSubChannelID)
            
            self.beds24RateKey = try? container.decode(String.self, forKey: .beds24RateKey)
            self.beds24RateCodeKey = try? container.decode(String.self, forKey: .beds24RateCodeKey)
            
            self.beds24Properties = try container.decode(Beds24Properties.self, forKey: .beds24Properties)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(id, forKey: .id)
            try container.encode(name, forKey: .name)
            
            try container.encode(hmsChannelID, forKey: .hmsChannelID)
            try container.encode(hmsSubChannelID, forKey: .hmsSubChannelID)
            
            try container.encode(beds24RateKey, forKey: .beds24RateKey)
            try container.encode(beds24RateCodeKey, forKey: .beds24RateCodeKey)
            try container.encode(beds24Properties, forKey: .beds24Properties)
        }
        
    }
    
    struct Beds24Properties: Codable {
        let referer: String
        let refererEditable: String
        let apiSource: Int?
        
        enum CodingKeys: String, CodingKey {
            case referer
            case refererEditable = "refererEditable"
            case apiSource = "apiSource"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.referer = try container.decode(String.self, forKey: .referer)
            self.refererEditable = try container.decode(String.self, forKey: .refererEditable)
            self.apiSource = try? container.decode(Int.self, forKey: .apiSource)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(referer, forKey: .referer)
            try container.encode(refererEditable, forKey: .refererEditable)
            try container.encode(apiSource, forKey: .apiSource)
        }
    }
    
}
