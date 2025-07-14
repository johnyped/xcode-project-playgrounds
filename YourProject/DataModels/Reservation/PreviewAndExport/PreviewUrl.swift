//
//  PreviewEmailInfo.swift
//  YourProject
//
//  Created by IntrodexMini on 14/6/2568 BE.
//

import Foundation

struct PreviewUrl: Decodable {
    
    let hostUrl: String
    let createdAt: Date
    let urlPath: String?
    
    var URL: URL? {
        guard
            let urlPath
        else { return nil }
        
        let reqUrl = hostUrl + urlPath
        
        return Foundation.URL(string: reqUrl)
    }
    
    init(hostUrl: String = AppConfiguration.shared.baseURL,
        createdAt: Date,
         urlPath: String) {
        self.hostUrl = hostUrl
        self.createdAt = createdAt
        self.urlPath = urlPath
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        hostUrl = AppConfiguration.shared.baseURL
        createdAt = try container.decode(String.self,
                                         forKey: .createdAt).tryToDate(FormConfig.DateFormat.datetimeISO)
        urlPath = try? container.decode(String.self, forKey: .urlPath)
    }
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case urlPath = "url"
    }
    
}

/*
 //json response
 {
    "created_at": "2023-06-10T15:16:06.902+07:00",
    "url": "/folio_forms/preview-email?token=2q9JfKU09_RrDuK-Qx42jQ"
 }
 */

