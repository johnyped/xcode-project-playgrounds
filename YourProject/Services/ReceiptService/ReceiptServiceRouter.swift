//
//  ReceiptServiceRouter.swift
//  YourProject
//
//  Created by AI Assistant
//

import Alamofire
import Foundation

enum ReceiptServiceRouter: AlamofireBaseRouterProtocol {
    case fetchByHotel(request: ReceiptServiceRequest.FetchByHotel)
    case fetchByQuery(request: ReceiptServiceRequest.FetchByQuery)
    case fetchByPeriod(request: ReceiptServiceRequest.FetchByPeriod)
    case fetchByReservation(request: ReceiptServiceRequest.FetchByReservation)
    case fetchByFolioForm(request: ReceiptServiceRequest.FetchByFolioForm)
    case fetchByFinancialRecord(request: ReceiptServiceRequest.FetchByFinancialRecord)
    
    case fetchById(request: ReceiptServiceRequest.FetchById)
    
    case createFromFinancialRecord(request: ReceiptServiceRequest.CreateFromFinancialRecord)
    case createFromFolioForm(request: ReceiptServiceRequest.CreateFromFolioForm)
    case createFromFolioFormVat(request: ReceiptServiceRequest.CreateFromFolioFormVat)
    
    case cancelReceipt(request: ReceiptServiceRequest.CancelReceiptRequest)
    case voidReceipt(request: ReceiptServiceRequest.VoidReceiptRequest)
    
    case previewEmail(request: ReceiptServiceRequest.PreviewEmail)
    case previewPDF(request: ReceiptServiceRequest.PreviewPDF)
    case exportPDF(request: ReceiptServiceRequest.ExportPDF)
    case exportImage(request: ReceiptServiceRequest.ExportImage)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchByHotel:
            return "/v4/receipts"
        case .fetchByQuery:
            return "/v4/receipts/query"
        case .fetchByPeriod:
            return "/v4/receipts/period"
        case .fetchByReservation:
            return "/v4/receipts/reservation"
        case .fetchByFolioForm:
            return "/v4/receipts/folio-form"
        case .fetchByFinancialRecord:
            return "/v4/receipts/financial-record"
        case .fetchById(let request):
            return "/v4/receipts/\(request.id)"
        case .createFromFinancialRecord:
            return "/v4/receipts/financial-record"
        case .createFromFolioForm:
            return "/v4/receipts/folio-form"
        case .createFromFolioFormVat:
            return "/v4/receipts/folio-form-vat"
        case .cancelReceipt(let request):
            return "/v4/receipts/\(request.id)/cancel"
        case .voidReceipt(let request):
            return "/v4/receipts/\(request.id)/void"
        case .previewEmail(let request):
            return "/v4/receipts/\(request.id)/preview-email"
        case .previewPDF(let request):
            return "/v4/receipts/\(request.id)/preview-pdf"
        case .exportPDF(let request):
            return "/v4/receipts/\(request.id)/pdf"
        case .exportImage(let request):
            return "/v4/receipts/\(request.id)/image"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchByHotel, .fetchByQuery, .fetchByPeriod, .fetchByReservation, 
             .fetchByFolioForm, .fetchByFinancialRecord, .fetchById:
            return .get
        case .createFromFinancialRecord, .createFromFolioForm, .createFromFolioFormVat,
             .cancelReceipt, .voidReceipt, .previewEmail, .previewPDF, 
             .exportPDF, .exportImage:
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
        case .fetchByFolioForm(let request):
            return request.parameters
        case .fetchByFinancialRecord(let request):
            return request.parameters
        default:
            return nil
        }
    }

    var body: Data? {
        switch self {
        case .createFromFinancialRecord(let request):
            return request.body
        case .createFromFolioForm(let request):
            return request.body
        case .createFromFolioFormVat(let request):
            return request.body
        case .cancelReceipt(let request):
            return request.body
        case .voidReceipt(let request):
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