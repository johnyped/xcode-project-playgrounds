//
//  RoomServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//

import Alamofire
import Foundation

enum RoomServiceRouter: AlamofireBaseRouterProtocol {
    
    case fetchRooms(request: RoomServiceRequest.FetchRooms)
    case fetchRoom(request: RoomServiceRequest.FetchRoom)
    case createRoom(request: RoomServiceRequest.CreateRoom)
    case updateRoom(request: RoomServiceRequest.UpdateRoom)
    case deleteRoom(request: RoomServiceRequest.DeleteRoom)
    case changeRoomType(request: RoomServiceRequest.ChangeRoomType)
    case updateRoomsOrder(request: RoomServiceRequest.UpdateRoomsOrder)
    case batchCreateRooms(request: RoomServiceRequest.BatchCreateRooms)
    case batchDeleteRooms(request: RoomServiceRequest.BatchDeleteRooms)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchRooms(_):
            return "/v4/rooms"
        case .fetchRoom(let request):
            return "/v4/rooms/\(request.id)"
        case .createRoom(_):
            return "/v4/rooms"
        case .updateRoom(let request):
            return "/v4/rooms/\(request.id)"
        case .deleteRoom(let request):
            return "/v4/rooms/\(request.id)"
        case .changeRoomType(let request):
            return "/v4/rooms/\(request.id)/change-room-type"
        case .updateRoomsOrder(_):
            return "/v4/rooms/update-order"
        case .batchCreateRooms(_):
            return "/v4/rooms/batch-create"
        case .batchDeleteRooms(_):
            return "/v4/rooms/batch-delete"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchRooms(_), .fetchRoom(_):
            return .get
        case .createRoom(_), .changeRoomType(_), .batchCreateRooms(_):
            return .post
        case .updateRoom(_), .updateRoomsOrder(_):
            return .put
        case .deleteRoom(_), .batchDeleteRooms(_):
            return .delete
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchRooms(let request):
            return request.parameters
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .createRoom(let request):
            return try? JSONEncoder().encode(request)
        case .updateRoom(let request):
            return try? JSONEncoder().encode(request)
        case .changeRoomType(let request):
            return try? JSONEncoder().encode(request)
        case .updateRoomsOrder(let request):
            return try? JSONEncoder().encode(request)
        case .batchCreateRooms(let request):
            return try? JSONEncoder().encode(request)
        case .batchDeleteRooms(let request):
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
