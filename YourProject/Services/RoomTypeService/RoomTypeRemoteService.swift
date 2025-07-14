//
//  RoomTypeRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol RoomTypeServiceProtocol: AnyObject {
    func fetchRoomTypes(request: RoomTypeServiceRequest.FetchRoomTypes) async throws -> RoomTypes
    func fetchRoomType(request: RoomTypeServiceRequest.FetchRoomType) async throws -> RoomType
    func createRoomType(request: RoomTypeServiceRequest.CreateRoomType) async throws -> RoomType
    func updateRoomType(request: RoomTypeServiceRequest.UpdateRoomType) async throws -> RoomType
    func deleteRoomType(request: RoomTypeServiceRequest.DeleteRoomType) async throws
    func updateRoomTypesOrder(request: RoomTypeServiceRequest.UpdateRoomTypesOrder) async throws
}

class RoomTypeRemoteService: RoomTypeServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchRoomTypes(request: RoomTypeServiceRequest.FetchRoomTypes) async throws -> RoomTypes {
        let router = RoomTypeServiceRouter.fetchRoomTypes(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func fetchRoomType(request: RoomTypeServiceRequest.FetchRoomType) async throws -> RoomType {
        let router = RoomTypeServiceRouter.fetchRoomType(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func createRoomType(request: RoomTypeServiceRequest.CreateRoomType) async throws -> RoomType {
        let router = RoomTypeServiceRouter.createRoomType(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func updateRoomType(request: RoomTypeServiceRequest.UpdateRoomType) async throws -> RoomType {
        let router = RoomTypeServiceRouter.updateRoomType(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func deleteRoomType(request: RoomTypeServiceRequest.DeleteRoomType) async throws {
        let router = RoomTypeServiceRouter.deleteRoomType(request: request)
        try await apiManager
            .requestACK(
                router: router,
                requiredAuthorization: true
            )
    }
    
    func updateRoomTypesOrder(request: RoomTypeServiceRequest.UpdateRoomTypesOrder) async throws {
        let router = RoomTypeServiceRouter.updateRoomTypesOrder(request: request)
        try await apiManager
            .requestACK(
                router: router,
                requiredAuthorization: true
            )
    }
}
