//  CalendarEventRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 7/7/2568 BE.
//

import Foundation
import Mockable

@Mockable
protocol CalendarEventServiceProtocol: AnyObject {    
    func fetchByDay(request: CalendarEventServiceRequest.FetchByDay) async throws -> CalendarEvents
    func fetchByMonth(request: CalendarEventServiceRequest.FetchByMonth) async throws -> CalendarEvents
    
    func fetchById(request: CalendarEventServiceRequest.FetchById) async throws -> CalendarEvent
    func createCalendarEvent(request: CalendarEventServiceRequest.CreateCalendarEvent) async throws -> CalendarEvent
    func updateCalendarEvent(request: CalendarEventServiceRequest.UpdateCalendarEvent) async throws -> CalendarEvent
    func deleteCalendarEvent(request: CalendarEventServiceRequest.DeleteCalendarEvent) async throws
}

class CalendarEventRemoteService: CalendarEventServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchByDay(request: CalendarEventServiceRequest.FetchByDay) async throws -> CalendarEvents {
        let router = CalendarEventServiceRouter.fetchByDay(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByMonth(request: CalendarEventServiceRequest.FetchByMonth) async throws -> CalendarEvents {
        let router = CalendarEventServiceRouter.fetchByMonth(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchById(request: CalendarEventServiceRequest.FetchById) async throws -> CalendarEvent {
        let router = CalendarEventServiceRouter.fetchById(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createCalendarEvent(request: CalendarEventServiceRequest.CreateCalendarEvent) async throws -> CalendarEvent {
        let router = CalendarEventServiceRouter.createCalendarEvent(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateCalendarEvent(request: CalendarEventServiceRequest.UpdateCalendarEvent) async throws -> CalendarEvent {
        let router = CalendarEventServiceRouter.updateCalendarEvent(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func deleteCalendarEvent(request: CalendarEventServiceRequest.DeleteCalendarEvent) async throws {
        let router = CalendarEventServiceRouter.deleteCalendarEvent(request: request)
        return try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
} 