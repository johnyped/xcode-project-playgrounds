//
//  PropertyRuleRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol PropertyRuleServiceProtocol: AnyObject {
    func fetchPropertyRuleContent(request: PropertyRuleServiceRequest.FetchPropertyRuleContent) async throws -> PropertyRule
    func fetchPropertyRulePdfURLs(request: PropertyRuleServiceRequest.FetchPropertyRulePdfURLs) async throws -> PropertyRule.PdfURL
    func fetchPropertyRuleHTMLURLs(request: PropertyRuleServiceRequest.FetchPropertyRuleHTMLURLs) async throws -> PropertyRule.HtmlURL
    func updatePropertyRuleContent(request: PropertyRuleServiceRequest.UpdatePropertyRuleContent) async throws -> PropertyRule
}

class PropertyRuleRemoteService: PropertyRuleServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchPropertyRuleContent(request: PropertyRuleServiceRequest.FetchPropertyRuleContent) async throws -> PropertyRule {
        let router = PropertyRuleServiceRouter.fetchPropertyRuleContent(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchPropertyRulePdfURLs(request: PropertyRuleServiceRequest.FetchPropertyRulePdfURLs) async throws -> PropertyRule.PdfURL {
        let router = PropertyRuleServiceRouter.fetchPropertyRulePdfURLs(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchPropertyRuleHTMLURLs(request: PropertyRuleServiceRequest.FetchPropertyRuleHTMLURLs) async throws -> PropertyRule.HtmlURL {
        let router = PropertyRuleServiceRouter.fetchPropertyRuleHTMLURLs(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func updatePropertyRuleContent(request: PropertyRuleServiceRequest.UpdatePropertyRuleContent) async throws -> PropertyRule {
        let router = PropertyRuleServiceRouter.updatePropertyRuleContent(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
} 
