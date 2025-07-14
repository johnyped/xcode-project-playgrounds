//
//  DeviceServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//
import Foundation

struct DeviceServiceRequest {
    
    typealias FetchDevice = ByID
    typealias DeleteDevice = ByID
    
    struct ByID {
        let id: Int
    }    
    
    struct CreateDevice: Encodable {
        let uuid: String
        let token: String
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
        
        enum CodingKeys: String, CodingKey {
            case uuid
            case token
        }
    }
    
    struct UpdateDevice: Encodable {
        let id: Int
        let uuid: String?
        let token: String?
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
        
        enum CodingKeys: String, CodingKey {
            case uuid
            case token
            // id is not encoded as it's used in the URL path
        }
    }
    
    struct UpdateDeviceToken: Encodable {
        let token: String
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
        
        enum CodingKeys: String, CodingKey {
            case token
        }
    }
} 
