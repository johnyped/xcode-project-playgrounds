//
//  HSDocumentServiceResponse.swift
//  YourProject
//
//  Created by IntrodexMini on 5/7/2568 BE.
//

import Foundation

struct HSDocumentServiceResponse {
    
    struct UploadUrl: Decodable {
        let uploadUrl: String
        let accessUrl: String

        var uploadURL: URL? {
            URL(string: uploadUrl)
        }
        
        var accessURL: URL? {
            URL(string: accessUrl)
        }
        
        init(uploadUrl: String, accessUrl: String) {
            self.uploadUrl = uploadUrl
            self.accessUrl = accessUrl
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            uploadUrl = try container.decode(String.self, forKey: .uploadUrl)
            accessUrl = try container.decode(String.self, forKey: .accessUrl)
        }
        
        enum CodingKeys: String, CodingKey {
            case uploadUrl = "upload_url"
            case accessUrl = "access_url"
        }
        
    }
        
}
