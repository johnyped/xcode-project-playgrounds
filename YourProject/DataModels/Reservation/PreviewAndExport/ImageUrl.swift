//
//  ImageUrl.swift
//  YourProject
//
//  Created by IntrodexMini on 14/6/2568 BE.
//
import Foundation

struct ImageUrl: Decodable {
    let hostUrl: String
    var urlPath: String?
    
    var URL: URL? {
        guard
            let urlPath
        else { return nil }
        
        let reqUrl = hostUrl + urlPath
        
        return Foundation.URL(string: reqUrl)
    }
    
    init(hostUrl: String = AppConfiguration.shared.baseURL,
         urlPath: String) {
        self.hostUrl = hostUrl
        self.urlPath = urlPath
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        hostUrl = AppConfiguration.shared.baseURL
        urlPath = try? container.decode(String.self, forKey: .urlPath)
    }
    
    enum CodingKeys: String, CodingKey {
        case urlPath = "image_url"
    }
}

/*
 // json response
 {
 "image_url": "/folio_forms/image?token=rqbnnrVczsnvCZ0sXeMMsw"
 }
 */
