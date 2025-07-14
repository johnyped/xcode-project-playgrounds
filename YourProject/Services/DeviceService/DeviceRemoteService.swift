//
//  DeviceRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol DeviceRemoteServiceProtocol {
    func fetchDevices() async throws -> Devices
    func createDevice(request: DeviceServiceRequest.CreateDevice) async throws -> Device
    func fetchDevice(request: DeviceServiceRequest.FetchDevice) async throws -> Device
    func updateDevice(request: DeviceServiceRequest.UpdateDevice) async throws -> Device
    func deleteDevice(request: DeviceServiceRequest.DeleteDevice) async throws
    func updateDeviceToken(request: DeviceServiceRequest.UpdateDeviceToken) async throws -> Device
}

class DeviceRemoteService: DeviceRemoteServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(apiManager: APIManagerProtocal, localStorageManager: LocalStorageManagerProtocal) {
        self.apiManager = apiManager
        self.localStorage = localStorageManager
    }
    
    func fetchDevices() async throws -> Devices {
        let router = DeviceServiceRouter.fetchDevices
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createDevice(request: DeviceServiceRequest.CreateDevice) async throws -> Device {
        let router = DeviceServiceRouter.createDevice(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchDevice(request: DeviceServiceRequest.FetchDevice) async throws -> Device {
        let router = DeviceServiceRouter.fetchDevice(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateDevice(request: DeviceServiceRequest.UpdateDevice) async throws -> Device {
        let router = DeviceServiceRouter.updateDevice(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func deleteDevice(request: DeviceServiceRequest.DeleteDevice) async throws {
        let router = DeviceServiceRouter.deleteDevice(request: request)
        try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
    
    func updateDeviceToken(request: DeviceServiceRequest.UpdateDeviceToken) async throws -> Device {
        let router = DeviceServiceRouter.updateDeviceToken(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
} 
