//  FolioFormServiceResponse.swift
//  YourProject
//
//  Created by IntrodexMini on 13/6/2568 BE.
//
import Foundation

struct FolioFormServiceResponse {
    
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
