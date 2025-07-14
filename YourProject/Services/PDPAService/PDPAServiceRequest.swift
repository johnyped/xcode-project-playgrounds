//
//  PDPAServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//
import Foundation

struct PDPAServiceRequest {
    
    typealias FetchPdpa = ByID
    
    struct ByID {
        let id: Int
    }
    
    struct FetchPdpas {
        let version: Version?
        
        var parameters: [String: Any]? {
            var parameters: [String: Any] = [:]
            
            if let version = version?.raw {
                parameters["version"] = version
            }
            
            // if parameters is empty, return nil
            if parameters.isEmpty {
                return nil
            }
            
            return parameters
        }
        
    }
}
