//
//  StaffServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//

import Alamofire
import Foundation

enum StaffServiceRouter: AlamofireBaseRouterProtocol {
    
    case fetchStaffs(request: StaffServiceRequest.FetchStaffs)
    case fetchStaff(request: StaffServiceRequest.FetchStaff)
    case createStaff(request: StaffServiceRequest.CreateStaff)
    case updateStaff(request: StaffServiceRequest.UpdateStaff)
    case changeStaffUsername(request: StaffServiceRequest.ChangeStaffUsername)
    case deleteStaff(request: StaffServiceRequest.DeleteStaff)
    case changeHotel(request: StaffServiceRequest.ChangeHotel)
    case changePassword(request: StaffServiceRequest.ChangePassword)
    case updateStatus(request: StaffServiceRequest.UpdateStatus)
    case verifyPin(request: StaffServiceRequest.VerifyPin)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchStaffs(_):
            return "/v4/staffs"
        case .fetchStaff(let request):
            return "/v4/staffs/\(request.id)"
        case .createStaff(_):
            return "/v4/staffs"
        case .updateStaff(let request):
            return "/v4/staffs/\(request.id)"
        case .changeStaffUsername(let request):
            return "/v4/staffs/\(request.id)/change-username"
        case .deleteStaff(let request):
            return "/v4/staffs/\(request.id)"
        case .changeHotel(let request):
            return "/v4/staffs/\(request.id)/change-hotel"
        case .changePassword(let request):
            return "/v4/staffs/\(request.id)/change-password"
        case .updateStatus(let request):
            return "/v4/staffs/\(request.id)/status"
        case .verifyPin(let request):
            return "/v4/staffs/\(request.id)/verify-pin"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchStaffs(_), .fetchStaff(_):
            return .get
        case .createStaff(_), .verifyPin(_):
            return .post
        case .updateStaff(_), .changeHotel(_), .changePassword(_), .updateStatus(_), .changeStaffUsername(_):
            return .put
        case .deleteStaff(_):
            return .delete
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchStaffs(let request):
            return request.parameters
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .createStaff(let request):
            return try? JSONEncoder().encode(request)
        case .updateStaff(let request):
            return try? JSONEncoder().encode(request)
        case .changeStaffUsername(let request):
            return try? JSONEncoder().encode(request)
        case .changeHotel(let request):
            return try? JSONEncoder().encode(request)
        case .changePassword(let request):
            return try? JSONEncoder().encode(request)
        case .updateStatus(let request):
            return try? JSONEncoder().encode(request)
        case .verifyPin(let request):
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
