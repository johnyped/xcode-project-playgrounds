//  FolioFormServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 13/6/2568 BE.
//
import Alamofire
import Foundation

enum FolioFormServiceRouter: AlamofireBaseRouterProtocol {
    case fetchByHotel(request: FolioFormServiceRequest.FetchByHotel)
    case fetchByQuery(request: FolioFormServiceRequest.FetchByQuery)
    case fetchByPeriod(request: FolioFormServiceRequest.FetchByPeriod)
    case fetchByReservation(request: FolioFormServiceRequest.FetchByReservation)

    case previewEmail(request: FolioFormServiceRequest.PreviewEmail)
    case previewPDF(request: FolioFormServiceRequest.PreviewPDF)

    case exportPDF(request: FolioFormServiceRequest.ExportPDF)
    case exportImage(request: FolioFormServiceRequest.ExportImage)    

    case fetchById(request: FolioFormServiceRequest.FetchById)
    case createFolioFormReservation(request: FolioFormServiceRequest.CreateFolioFormReservation)
    case updateFolioForm(request: FolioFormServiceRequest.UpdateFolioForm)
    case cancelFolioForm(request: FolioFormServiceRequest.CancelFolioForm)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchByHotel:
            return "/v4/folio-forms"
        case .fetchByQuery:
            return "/v4/folio-forms/query"
        case .fetchByPeriod:
            return "/v4/folio-forms/period"
        case .fetchByReservation:
            return "/v4/folio-forms/reservation"
        case .previewEmail(let request):
            return "/v4/folio-forms/\(request.id)/preview-email"
        case .previewPDF(let request):
            return "/v4/folio-forms/\(request.id)/preview-pdf"
        case .exportPDF(let request):
            return "/v4/folio-forms/\(request.id)/pdf"
        case .exportImage(let request):
            return "/v4/folio-forms/\(request.id)/image"        
        case .fetchById(let request):
            return "/v4/folio-forms/\(request.id)"
        case .createFolioFormReservation:
            return "/v4/folio-forms"
        case .updateFolioForm(let request):
            return "/v4/folio-forms/\(request.id)"
        case .cancelFolioForm(let request):
            return "/v4/folio-forms/\(request.id)/cancel"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchByHotel, .fetchByQuery, .fetchByPeriod, .fetchByReservation, .fetchById:
            return .get
        case .createFolioFormReservation:
            return .post
        case .updateFolioForm:
            return .put
        case .cancelFolioForm:
            return .post
        case .previewEmail, .previewPDF, .exportPDF, .exportImage:
            return .post
        }
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }

    var parameters: [String: Any]? {
        switch self {
        case .fetchByHotel(let request):
            return request.parameters
        case .fetchByQuery(let request):
            return request.parameters
        case .fetchByPeriod(let request):
            return request.parameters
        case .fetchByReservation(let request):
            return request.parameters
        default:
            return nil
        }
    }

    var body: Data? {
        switch self {
        case .createFolioFormReservation(let request):
            return request.body
        case .updateFolioForm(let request):
            return request.body        
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
        headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        return try encoding.encode(request, with: parameters)
    }
} 
