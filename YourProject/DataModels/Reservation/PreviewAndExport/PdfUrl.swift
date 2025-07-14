//
//  PdfUrl.swift
//  YourProject
//
//  Created by IntrodexMini on 14/6/2568 BE.
//

import Foundation

struct PdfUrl: Decodable {
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
        case urlPath = "pdf_url"
    }
}


/*
 // json response
 {
 "pdf_url": "/folio_forms/pdf?token=rqbnnrVczsnvCZ0sXeMMsw"
 }
 */
