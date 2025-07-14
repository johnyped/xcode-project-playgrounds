//
//  MeServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//

import Foundation
import Alamofire

enum MeServiceRouter: AlamofireBaseRouterProtocol {
    
    case fetchProfile
    case updateProfile(request: MeServiceRequest.UpdateProfile)
    case changeEmail(request: MeServiceRequest.ChangeEmail)
    case changePassword(request: MeServiceRequest.ChangePassword)
    case verification(request: MeServiceRequest.Verification)
    
    case fetchDevices
    
    case getNotificationSettings
    case updateNotificationSettings(request: MeServiceRequest.NotificationSettings)
    
    case emailLoginResendCode(request: MeServiceRequest.EmailLoginResendCode)
    case emailLoginLink(request: MeServiceRequest.EmailLoginLink)
    case emailLoginSendCode(request: MeServiceRequest.EmailLoginSendCode)
    
    case appleLoginLink(request: MeServiceRequest.AppleLoginLink)
    case appleLoginUnlink(request: MeServiceRequest.AppleLoginUnlink)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchProfile:
            return "/v4/me/profile"
        case .updateProfile(_):
            return "/v4/me"
        case .changeEmail(_):
            return "/v4/me/change-email"
        case .changePassword(_):
            return "/v4/me/change-password"
        case .verification(_):
            return "/v4/me/verification"
        case .getNotificationSettings, .updateNotificationSettings:
            return "/v4/me/notification-settings"
        case .emailLoginResendCode:
            return "/v4/me/email-login/resend-code"
        case .emailLoginLink:
            return "/v4/me/email-login/link"
        case .emailLoginSendCode:
            return "/v4/me/email-login/send-code"
        case .appleLoginLink:
            return "/v4/me/apple-login/link"
        case .appleLoginUnlink:
            return "/v4/me/apple-login/unlink"
        case .fetchDevices:
            return "/v4/me/devices"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchProfile:
            return .get
        case .updateProfile(_):
            return .put
        case .changeEmail(_):
            return .post
        case .changePassword(_):
            return .put
        case .verification(_):
            return .post
        case .getNotificationSettings:
            return .get
        case .updateNotificationSettings:
            return .put
        case .emailLoginResendCode, .emailLoginLink, .emailLoginSendCode, .appleLoginLink, .appleLoginUnlink:
            return .post
        case .fetchDevices:
            return .get
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var body: Data? {
        switch self {
        case .updateProfile(let request):
            return try? JSONEncoder().encode(request)
        case .changeEmail(let request):
            return try? JSONEncoder().encode(request)
        case .changePassword(let request):
            return try? JSONEncoder().encode(request)
        case .verification(let request):
            return try? JSONEncoder().encode(request)
        case .updateNotificationSettings(let request):
            return try? JSONEncoder().encode(request)
        case .emailLoginResendCode(let request):
            return try? JSONEncoder().encode(request)
        case .emailLoginLink(let request):
            return try? JSONEncoder().encode(request)
        case .emailLoginSendCode(let request):
            return try? JSONEncoder().encode(request)
        case .appleLoginLink(let request):
            return try? JSONEncoder().encode(request)
        case .appleLoginUnlink(let request):
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
