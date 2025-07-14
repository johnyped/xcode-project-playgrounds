//
//  CMChannel.swift
//  YourProject
//
//  Created by IntrodexMini on 9/7/2568 BE.
//

import Foundation

struct CMChannel: Codable {
    let id: Int
    let name: String
    let channelId: Int
    let subChannelId: Int?
    
    init(id: Int,
         name: String,
         channelId: Int,
         subChannelId: Int?) {
        self.id = id
        self.name = name
        self.channelId = channelId
        self.subChannelId = subChannelId
    }
        
    //decode
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.channelId = try container.decode(Int.self, forKey: .channelId)
        self.subChannelId = try container.decodeIfPresent(Int.self, forKey: .subChannelId)
    }
    
    //encode
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(channelId, forKey: .channelId)
        try container.encodeIfPresent(subChannelId, forKey: .subChannelId)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case channelId = "channel_id"
        case subChannelId = "sub_channel_id"
    }
}
