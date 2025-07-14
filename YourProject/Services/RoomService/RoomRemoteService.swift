//
//  RoomRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol RoomServiceProtocol: AnyObject {
    func fetchRooms(request: RoomServiceRequest.FetchRooms) async throws -> Rooms
    func fetchRoom(request: RoomServiceRequest.FetchRoom) async throws -> Room
    func createRoom(request: RoomServiceRequest.CreateRoom) async throws -> Room
    func updateRoom(request: RoomServiceRequest.UpdateRoom) async throws -> Room
    func deleteRoom(request: RoomServiceRequest.DeleteRoom) async throws
    func changeRoomType(request: RoomServiceRequest.ChangeRoomType) async throws -> Room
    func updateRoomsOrder(request: RoomServiceRequest.UpdateRoomsOrder) async throws
    
    func batchCreateRooms(request: RoomServiceRequest.BatchCreateRooms) async throws -> Rooms
    func batchDeleteRooms(request: RoomServiceRequest.BatchDeleteRooms) async throws
}

class RoomRemoteService: RoomServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchRooms(request: RoomServiceRequest.FetchRooms) async throws -> Rooms {
        let router = RoomServiceRouter.fetchRooms(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchRoom(request: RoomServiceRequest.FetchRoom) async throws -> Room {
        let router = RoomServiceRouter.fetchRoom(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func createRoom(request: RoomServiceRequest.CreateRoom) async throws -> Room {
        let router = RoomServiceRouter.createRoom(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func updateRoom(request: RoomServiceRequest.UpdateRoom) async throws -> Room {
        let router = RoomServiceRouter.updateRoom(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func deleteRoom(request: RoomServiceRequest.DeleteRoom) async throws {
        let router = RoomServiceRouter.deleteRoom(request: request)
        try await apiManager.requestACK(router: router,
                                        requiredAuthorization: true)
    }
    
    func changeRoomType(request: RoomServiceRequest.ChangeRoomType) async throws -> Room {
        let router = RoomServiceRouter.changeRoomType(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func updateRoomsOrder(request: RoomServiceRequest.UpdateRoomsOrder) async throws {
        let router = RoomServiceRouter.updateRoomsOrder(request: request)
        try await apiManager.requestACK(router: router,
                                        requiredAuthorization: true)
    }
    
    func batchCreateRooms(request: RoomServiceRequest.BatchCreateRooms) async throws -> Rooms {
        let router = RoomServiceRouter.batchCreateRooms(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func batchDeleteRooms(request: RoomServiceRequest.BatchDeleteRooms) async throws {
        let router = RoomServiceRouter.batchDeleteRooms(request: request)
        try await apiManager.requestACK(router: router,
                                        requiredAuthorization: true)
    }
} 
