//
//  DeviceServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import Foundation
import Alamofire

enum DeviceServiceRouter: AlamofireBaseRouterProtocol {
    
    case fetchDevices
    case createDevice(request: DeviceServiceRequest.CreateDevice)
    case fetchDevice(request: DeviceServiceRequest.FetchDevice)
    case updateDevice(request: DeviceServiceRequest.UpdateDevice)
    case deleteDevice(request: DeviceServiceRequest.DeleteDevice)
    case updateDeviceToken(request: DeviceServiceRequest.UpdateDeviceToken)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchDevices, .createDevice:
            return "/v4/devices"
        case .updateDevice(let request):
            return "/v4/devices/\(request.id)"
        case .fetchDevice(let request), .deleteDevice(let request):
            return "/v4/devices/\(request.id)"
        case .updateDeviceToken:
            return "/v4/devices/token"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchDevices, .fetchDevice:
            return .get
        case .createDevice:
            return .post
        case .updateDevice, .updateDeviceToken:
            return .put
        case .deleteDevice:
            return .delete
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .createDevice(let request):
            return request.body
        case .updateDevice(let request):
            return request.body
        case .updateDeviceToken(let request):
            return request.body
        case .fetchDevices, .fetchDevice, .deleteDevice:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: domain + path) else {
            throw APIError.invalidURL
        }
        let encoding: ParameterEncoding = (method == .get || method == .delete) ? URLEncoding.default : JSONEncoding.default
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
