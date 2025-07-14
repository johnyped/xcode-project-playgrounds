//
//  AuthServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 30/1/2568 BE.
//

import Alamofire
import Foundation

enum AuthServiceRouter: AlamofireBaseRouterProtocol {
    
    case emailLogin(request: AuthServiceRequest.EmailLogin)
    case appleIdLogin(request: AuthServiceRequest.AppleIdLogin)
    case logout
    case refreshToken(request: AuthServiceRequest.TokenRefresh)
    case resendEmailConfirmation(request: AuthServiceRequest.ResendEmailConfirmation)
    case passwordReset(request: AuthServiceRequest.PasswordReset)
    case signup(request: AuthServiceRequest.Signup)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .emailLogin(_):
            return "/v4/auth/login"
        case .appleIdLogin(_):
            return "/v4/auth/apple-login"
        case .logout:
            return "/v4/auth/logout"
        case .refreshToken:
            return "/v4/auth/refresh"
        case .resendEmailConfirmation:
            return "/v4/auth/resend_email_confirmation"
        case .passwordReset:
            return "/v4/auth/password_reset"
        case .signup:
            return "/v4/auth/signup"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .emailLogin,
                .appleIdLogin,
                .logout,
                .refreshToken,
                .resendEmailConfirmation,
                .passwordReset,
                .signup:
            return .post
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var body: Data? {
        switch self {
        case .emailLogin(let request):
            return try? JSONEncoder().encode(request)
        case .refreshToken(let request):
            return try? JSONEncoder().encode(request)
        case .resendEmailConfirmation(let request):
            return try? JSONEncoder().encode(request)
        case .passwordReset(let request):
            return try? JSONEncoder().encode(request)
        case .signup(let request):
            return try? JSONEncoder().encode(request)
        case .appleIdLogin(let request):
            return try? JSONEncoder().encode(request)
        default:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: domain + path) else {
            throw APIError.invalidURL
        }
        
        let encoding: ParameterEncoding = (method == .get) ? URLEncoding.default : JSONEncoding.default
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        headers?.forEach {
            request.addValue($0.value,
                             forHTTPHeaderField: $0.key)
        }
        
        return try encoding.encode(request,
                                   with: parameters)
    }
    
}
