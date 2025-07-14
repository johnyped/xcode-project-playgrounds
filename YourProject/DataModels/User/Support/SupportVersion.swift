//
//  SupportVersion.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import Foundation

struct SupportVersion: Codable {
    
    let minAppVersion: Version
    
    enum CodingKeys: String, CodingKey {
        case minAppVersion = "supported_minimum_api_version"
    }

    init(minAppVersion: Version) {
        self.minAppVersion = minAppVersion
    }

    init(minAppVersionString: String) {
        self.minAppVersion = Version(string: minAppVersionString) ?? ._1_0_0
    }

    //decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let minAppVersion = try container.decode(String.self, forKey: .minAppVersion)
        self.minAppVersion = Version(string: minAppVersion) ?? ._1_0_0
    }
    
    //encoder
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(minAppVersion.minimiumrRaw, forKey: .minAppVersion)
    }
    
}

/*
 {
     "supported_minimum_api_version": "2.7.19"
 }
 */
