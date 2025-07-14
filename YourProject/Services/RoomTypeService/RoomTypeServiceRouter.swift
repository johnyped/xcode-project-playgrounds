//
//  RoomTypeServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//

import Alamofire
import Foundation

enum RoomTypeServiceRouter: AlamofireBaseRouterProtocol {
    
    case fetchRoomTypes(request: RoomTypeServiceRequest.FetchRoomTypes)
    case fetchRoomType(request: RoomTypeServiceRequest.FetchRoomType)
    case createRoomType(request: RoomTypeServiceRequest.CreateRoomType)
    case updateRoomType(request: RoomTypeServiceRequest.UpdateRoomType)
    case deleteRoomType(request: RoomTypeServiceRequest.DeleteRoomType)
    case updateRoomTypesOrder(request: RoomTypeServiceRequest.UpdateRoomTypesOrder)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchRoomTypes(_):
            return "/v4/room-types"
        case .fetchRoomType(let request):
            return "/v4/room-types/\(request.id)"
        case .createRoomType(_):
            return "/v4/room-types"
        case .updateRoomType(let request):
            return "/v4/room-types/\(request.id)"
        case .deleteRoomType(let request):
            return "/v4/room-types/\(request.id)"
        case .updateRoomTypesOrder(_):
            return "/v4/room-types/update-order"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchRoomTypes(_), .fetchRoomType(_):
            return .get
        case .createRoomType(_):
            return .post
        case .updateRoomType(_), .updateRoomTypesOrder(_):
            return .put
        case .deleteRoomType(_):
            return .delete
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchRoomTypes(let request):
            return ["hotel_id" : request.hotelId]
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .createRoomType(let request):
            return try? JSONEncoder().encode(request)
        case .updateRoomType(let request):
            return try? JSONEncoder().encode(request)
        case .updateRoomTypesOrder(let request):
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
