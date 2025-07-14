//
//  BookingChannelServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import Alamofire
import Foundation

enum BookingChannelServiceRouter: AlamofireBaseRouterProtocol {
    
    case fetchChannels
    case fetchChannel(request: BookingChannelServiceRequest.FetchChannel)
    case createChannel(request: BookingChannelServiceRequest.CreateChannel)
    case updateChannel(request: BookingChannelServiceRequest.UpdateChannel)
    case deleteChannel(request: BookingChannelServiceRequest.DeleteChannel)
    case fetchSubChannels(request: BookingChannelServiceRequest.FetchSubChannels)
    case createSubChannel(request: BookingChannelServiceRequest.CreateSubChannel)
    case updateSubChannel(request: BookingChannelServiceRequest.UpdateSubChannel)
    case deleteSubChannel(request: BookingChannelServiceRequest.DeleteSubChannel)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchChannels:
            return "/v4/channels"
        case .fetchChannel(let request):
            return "/v4/channels/\(request.id)"
        case .createChannel(_):
            return "/v4/channels"
        case .updateChannel(let request):
            return "/v4/channels/\(request.id)"
        case .deleteChannel(let request):
            return "/v4/channels/\(request.id)"
        case .fetchSubChannels(let request):
            return "/v4/channels/\(request.id)/sub-channels"
        case .createSubChannel(let request):
            return "/v4/channels/\(request.channelId)/sub-channels"
        case .updateSubChannel(let request):
            return "/v4/channels/\(request.channelId)/sub-channels/\(request.subChannelId)"
        case .deleteSubChannel(let request):
            return "/v4/channels/\(request.channelId)/sub-channels/\(request.subChannelId)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchChannels, .fetchChannel(_), .fetchSubChannels(_):
            return .get
        case .createChannel(_), .createSubChannel(_):
            return .post
        case .updateChannel(_), .updateSubChannel(_):
            return .put
        case .deleteChannel(_), .deleteSubChannel(_):
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
        case .createChannel(let request):
            return try? JSONEncoder().encode(request)
        case .updateChannel(let request):
            return try? JSONEncoder().encode(request)
        case .createSubChannel(let request):
            return try? JSONEncoder().encode(request)
        case .updateSubChannel(let request):
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
