//  HSDocumentServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 23/5/2568 BE.
//
import Alamofire
import Foundation

enum HSDocumentServiceRouter: AlamofireBaseRouterProtocol {
    case fetchByFinancialRecord(request: HSDocumentServiceRequest.FetchByFinancialRecord)
    case fetchByAccountItem(request: HSDocumentServiceRequest.FetchByAccountItem)
    case fetchByReservation(request: HSDocumentServiceRequest.FetchByReservation)
    case fetchByFileName(request: HSDocumentServiceRequest.FetchByFileName)
    case fetchByKind(request: HSDocumentServiceRequest.FetchByKind)
    case fetchGuestRegisterCardSignature(request: HSDocumentServiceRequest.FetchGuestRegisterCardSignature)
    
    case fetchById(request: HSDocumentServiceRequest.FetchById)
    case createDocument(request: HSDocumentServiceRequest.CreateDocument)
    case requestUploadUrl(request: HSDocumentServiceRequest.RequestUploadUrl)
    case deleteDocument(request: HSDocumentServiceRequest.DeleteDocument)
    case batchDelete(request: HSDocumentServiceRequest.BatchDelete)
    case batchDeleteByKind(request: HSDocumentServiceRequest.BatchDeleteByKind)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchByFinancialRecord:
            return "/v4/documents/financial-record"
        case .fetchByAccountItem:
            return "/v4/documents/account-item"
        case .fetchByReservation:
            return "/v4/documents/reservation"
        case .fetchByFileName:
            return "/v4/documents/file-name"
        case .fetchByKind:
            return "/v4/documents"
        case .fetchGuestRegisterCardSignature:
            return "/v4/documents/guest-register-card-signature"
        case .fetchById(let request):
            return "/v4/documents/\(request.id)"
        case .createDocument:
            return "/v4/documents"
        case .requestUploadUrl:
            return "/v4/documents/upload-url"
        case .deleteDocument(let request):
            return "/v4/documents/\(request.id)"
        case .batchDelete:
            return "/v4/documents/batch-delete"
        case .batchDeleteByKind:
            return "/v4/documents/batch-delete-by-kind"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchByFinancialRecord, .fetchByAccountItem, .fetchByReservation, .fetchByFileName, .fetchByKind, .fetchGuestRegisterCardSignature, .fetchById:
            return .get
        case .createDocument:
            return .post
        case .deleteDocument, .batchDeleteByKind, .batchDelete:
            return .delete
        case .requestUploadUrl:
            return .post
        }
    }

    var headers: [String: String]? {
        switch self {      
        default:
            return [
                "Content-Type": "application/json"
            ]
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .fetchByFinancialRecord(let request):
            return request.parameters
        case .fetchByAccountItem(let request):
            return request.parameters
        case .fetchByReservation(let request):
            return request.parameters
        case .fetchByFileName(let request):
            return request.parameters
        case .fetchByKind(let request):
            return request.parameters
        case .fetchGuestRegisterCardSignature(let request):
            return request.parameters
        case .batchDeleteByKind(let request):
            return request.parameters
        default:
            return nil
        }
    }

    var body: Data? {
        switch self {
        case .createDocument(let request):
            return request.body        
        case .batchDelete(let request):
            return request.body
        case .requestUploadUrl(let request):
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
