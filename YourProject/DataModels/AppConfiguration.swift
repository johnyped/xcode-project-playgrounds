//
//  AppConfiguration.swift
//  YourProject
//
//  Created by IntrodexMini on 30/1/2568 BE.
//

struct AppConfiguration {
    static let shared = AppConfiguration()
    
    let baseURL: String = env.baseURL
}

extension AppConfiguration {
    enum Environment {
        case production
        case development

        var baseURL: String {
            switch self {
            case .production:
                return "https://api.introdex.com"
            case .development:                
                return "http://157.230.37.164/api"
            }
        }
    }
}

extension AppConfiguration {
    static var env: Environment {
        let stubEnv = Environment.development
        return stubEnv
    }
    
}
