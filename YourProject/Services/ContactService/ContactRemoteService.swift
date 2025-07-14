//
//  ContactRemoteService.swift
//  YourProject
//
//  Created by AI Assistant
//

import Foundation
import Mockable

@Mockable
protocol ContactServiceProtocol: AnyObject {
    func fetchByHotel(request: ContactServiceRequest.FetchByHotel) async throws -> Paginator<Contact>
    func fetchByCompany(request: ContactServiceRequest.FetchByCompany) async throws -> Paginator<Contact>
    func fetchByCustomer(request: ContactServiceRequest.FetchByCustomer) async throws -> Paginator<Contact>
    
    func fetchById(request: ContactServiceRequest.FetchById) async throws -> Contact
    func createContact(request: ContactServiceRequest.CreateContact) async throws -> Contact
    func updateContact(request: ContactServiceRequest.UpdateContact) async throws -> Contact
    func deleteContact(request: ContactServiceRequest.DeleteContact) async throws -> Contact
}

class ContactRemoteService: ContactServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchByHotel(request: ContactServiceRequest.FetchByHotel) async throws -> Paginator<Contact> {
        let router = ContactServiceRouter.fetchByHotel(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByCompany(request: ContactServiceRequest.FetchByCompany) async throws -> Paginator<Contact> {
        let router = ContactServiceRouter.fetchByCompany(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByCustomer(request: ContactServiceRequest.FetchByCustomer) async throws -> Paginator<Contact> {
        let router = ContactServiceRouter.fetchByCustomer(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchById(request: ContactServiceRequest.FetchById) async throws -> Contact {
        let router = ContactServiceRouter.fetchById(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createContact(request: ContactServiceRequest.CreateContact) async throws -> Contact {
        let router = ContactServiceRouter.createContact(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateContact(request: ContactServiceRequest.UpdateContact) async throws -> Contact {
        let router = ContactServiceRouter.updateContact(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func deleteContact(request: ContactServiceRequest.DeleteContact) async throws -> Contact {
        let router = ContactServiceRouter.deleteContact(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
} 
