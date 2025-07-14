//
//  StaffRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol StaffServiceProtocol: AnyObject {
    func fetchStaffs(request: StaffServiceRequest.FetchStaffs) async throws -> Staffs
    func fetchStaff(request: StaffServiceRequest.FetchStaff) async throws -> Staff
    func createStaff(request: StaffServiceRequest.CreateStaff) async throws -> Staff
    func updateStaff(request: StaffServiceRequest.UpdateStaff) async throws -> Staff
    func changeStaffUsername(request: StaffServiceRequest.ChangeStaffUsername) async throws -> Staff
    func deleteStaff(request: StaffServiceRequest.DeleteStaff) async throws
    
    func changeHotel(request: StaffServiceRequest.ChangeHotel) async throws -> Staff
    func changePassword(request: StaffServiceRequest.ChangePassword) async throws -> Staff
    func updateStatus(request: StaffServiceRequest.UpdateStatus) async throws -> Staff
    func verifyPin(request: StaffServiceRequest.VerifyPin) async throws
}

class StaffRemoteService: StaffServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchStaffs(request: StaffServiceRequest.FetchStaffs) async throws -> Staffs {
        let router = StaffServiceRouter.fetchStaffs(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func fetchStaff(request: StaffServiceRequest.FetchStaff) async throws -> Staff {
        let router = StaffServiceRouter.fetchStaff(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func createStaff(request: StaffServiceRequest.CreateStaff) async throws -> Staff {
        let router = StaffServiceRouter.createStaff(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func updateStaff(request: StaffServiceRequest.UpdateStaff) async throws -> Staff {
        let router = StaffServiceRouter.updateStaff(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func changeStaffUsername(request: StaffServiceRequest.ChangeStaffUsername) async throws -> Staff {
        let router = StaffServiceRouter.changeStaffUsername(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func deleteStaff(request: StaffServiceRequest.DeleteStaff) async throws {
        let router = StaffServiceRouter.deleteStaff(request: request)
        try await apiManager
            .requestACK(
                router: router,
                requiredAuthorization: true
            )
    }
    
    // Implementation of new methods
    
    func changeHotel(request: StaffServiceRequest.ChangeHotel) async throws -> Staff {
        let router = StaffServiceRouter.changeHotel(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func changePassword(request: StaffServiceRequest.ChangePassword) async throws -> Staff {
        let router = StaffServiceRouter.changePassword(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func updateStatus(request: StaffServiceRequest.UpdateStatus) async throws -> Staff {
        let router = StaffServiceRouter.updateStatus(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func verifyPin(request: StaffServiceRequest.VerifyPin) async throws {
        let router = StaffServiceRouter.verifyPin(request: request)
        return try await apiManager.requestACK(router: router,
                                               requiredAuthorization: true)
    }
} 
