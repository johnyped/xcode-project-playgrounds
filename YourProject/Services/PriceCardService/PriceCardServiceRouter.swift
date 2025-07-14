//
//  PriceCardServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import Alamofire
import Foundation

enum PriceCardServiceRouter: AlamofireBaseRouterProtocol {
    
    case fetchPriceCards(request: PriceCardServiceRequest.FetchPriceCards)
    case fetchPriceCard(request: PriceCardServiceRequest.FetchPriceCard)
    case fetchPriceCardsByPeriod(request: PriceCardServiceRequest.FetchPriceCardsByPeriod)
    case createPriceCard(request: PriceCardServiceRequest.CreatePriceCard)
    case updatePriceCard(request: PriceCardServiceRequest.UpdatePriceCard)
    case deletePriceCard(request: PriceCardServiceRequest.DeletePriceCard)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchPriceCards:
            return "/v4/price-cards"
        case .fetchPriceCard(let request):
            return "/v4/price-cards/\(request.id)"
        case .fetchPriceCardsByPeriod:
            return "/v4/price-cards/period"
        case .createPriceCard:
            return "/v4/price-cards"
        case .updatePriceCard(let request):
            return "/v4/price-cards/\(request.id)"
        case .deletePriceCard(let request):
            return "/v4/price-cards/\(request.id)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchPriceCards, .fetchPriceCard, .fetchPriceCardsByPeriod:
            return .get
        case .createPriceCard:
            return .post
        case .updatePriceCard:
            return .put
        case .deletePriceCard:
            return .delete
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchPriceCards(let request):
            return request.parameters
        case .fetchPriceCardsByPeriod(let request):
            return request.parameters
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .createPriceCard(let request):
            return try? JSONEncoder().encode(request)
        case .updatePriceCard(let request):
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
