//
//  ReceiptServiceResponse.swift
//  YourProject
//
//  Created by AI Assistant
//

import Foundation

struct ReceiptServiceResponse {
    
    struct PreviewEmail: Decodable {
        let info: PreviewUrl
        
        init(info: PreviewUrl) {
            self.info = info
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            info = try container.decode(PreviewUrl.self, forKey: .info)
        }
        
        enum CodingKeys: String, CodingKey {
            case info = "preview_email_info"
        }
    }
    
    struct PreviewPDF: Decodable {
        let info: PreviewUrl
        
        init(info: PreviewUrl) {
            self.info = info
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            info = try container.decode(PreviewUrl.self, forKey: .info)
        }
        
        
        enum CodingKeys: String, CodingKey {
            case info = "preview_pdf_info"
        }
        
    }
    
}
