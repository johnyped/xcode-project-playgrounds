//
//  PropertyRule.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import Foundation

struct PropertyRule: Codable {
   
    let htmlContent: Content
    let updatedAt: Date?
    
    init (htmlContent: Content,
          updatedAt: Date? = nil) {
        self.htmlContent = htmlContent
        self.updatedAt = updatedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.htmlContent = try container.decode(Content.self,
                                            forKey: .content)
        
        self.updatedAt = try container.decode(String.self,
                                              forKey: .rulesUpdatedAt).toDate(FormConfig.DateFormat.datetimeISO)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(htmlContent,
                             forKey: .content)
        
        try container.encode(updatedAt?.toDateString(FormConfig.DateFormat.datetimeISO),
                             forKey: .rulesUpdatedAt)
    }
    
}

extension PropertyRule {
    struct Content: Codable {
        let th: String?
        let en: String?
    }
    
    enum CodingKeys: String, CodingKey {
        case content
        case rulesUpdatedAt = "rules_updated_at"
    }
}

extension PropertyRule {

    struct HtmlURL: Codable {
        private(set) var baseURL: String = AppConfiguration.shared.baseURL
        let th: String?
        let en: String?
        
        var thURL: URL? {
            guard
                let _urlPath = th
            else { return nil }
            
            let reqUrl = baseURL + _urlPath
            
            return Foundation.URL(string: reqUrl)
        }
        
        var enURL: URL? {
            guard
                let _urlPath = en
            else { return nil }
            
            let reqUrl = baseURL + _urlPath
            
            return Foundation.URL(string: reqUrl)
        }
        
        enum CodingKeys: String, CodingKey {
            case th = "th_url"
            case en = "en_url"
        }
        
        init(baseURL: String = AppConfiguration.shared.baseURL,
             th: String? = nil,
             en: String? = nil) {
            self.baseURL = baseURL
            self.en = en
            self.th = th
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.th = try container.decode(String.self,
                                           forKey: .th)
            
            self.en = try container.decode(String.self,
                                           forKey: .en)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(th,
                                 forKey: .th)
            
            try container.encode(en,
                                 forKey: .en)
        }
        
    }
    
    struct PdfURL: Codable {
        private(set) var baseURL: String = AppConfiguration.shared.baseURL
        let th: String?
        let en: String?
        
        var thURL: URL? {
            guard
                let _urlPath = th
            else { return nil }
            
            let reqUrl = baseURL + _urlPath
            
            return Foundation.URL(string: reqUrl)
        }
        
        var enURL: URL? {
            guard
                let _urlPath = en
            else { return nil }
            
            let reqUrl = baseURL + _urlPath
            
            return Foundation.URL(string: reqUrl)
        }
        
        enum CodingKeys: String, CodingKey {
            case th = "th_url"
            case en = "en_url"
        }
        
        init(baseURL: String = AppConfiguration.shared.baseURL,
             th: String? = nil,
             en: String? = nil) {
            self.baseURL = baseURL
            self.en = en
            self.th = th
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.th = try container.decode(String.self,
                                           forKey: .th)
            
            self.en = try container.decode(String.self,
                                           forKey: .en)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(th,
                                 forKey: .th)
            
            try container.encode(en,
                                 forKey: .en)
        }
        
    }
}




/*
 json response
 {
     "th_url": "/hotels/rules/pdf?locale=th&token=mIA-TFQNHdhfprawJowi8g",
     "en_url": "/hotels/rules/pdf?locale=en&token=mIA-TFQNHdhfprawJowi8g"
 }
 */
