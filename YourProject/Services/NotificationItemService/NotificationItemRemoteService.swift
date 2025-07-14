//
//  NotificationItemRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol NotificationItemServiceProtocol: AnyObject {
    func fetchNotifications(request: NotificationItemServiceRequest.FetchNotifications) async throws -> Paginator<NotificationItem>
    func fetchNotification(request: NotificationItemServiceRequest.FetchNotification) async throws -> NotificationItem
    func deleteNotification(request: NotificationItemServiceRequest.DeleteNotification) async throws
    func markNotificationAsRead(request: NotificationItemServiceRequest.MarkNotificationAsRead) async throws
    func fetchNotificationCount(request: NotificationItemServiceRequest.FetchNotificationCount) async throws -> NotificationItemCount
    func markAllNotificationsAsRead(request: NotificationItemServiceRequest.MarkAllNotificationsAsRead) async throws
    func deleteAllNotifications(request: NotificationItemServiceRequest.DeleteAllNotifications) async throws
}

class NotificationItemRemoteService: NotificationItemServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchNotifications(request: NotificationItemServiceRequest.FetchNotifications) async throws -> Paginator<NotificationItem> {
        let router = NotificationItemServiceRouter.fetchNotifications(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchNotification(request: NotificationItemServiceRequest.FetchNotification) async throws -> NotificationItem {
        let router = NotificationItemServiceRouter.fetchNotification(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func deleteNotification(request: NotificationItemServiceRequest.DeleteNotification) async throws {
        let router = NotificationItemServiceRouter.deleteNotification(request: request)
        try await apiManager.requestACK(router: router,
                                        requiredAuthorization: true)
    }
    
    func markNotificationAsRead(request: NotificationItemServiceRequest.MarkNotificationAsRead) async throws {
        let router = NotificationItemServiceRouter.markNotificationAsRead(request: request)
        return try await apiManager.requestACK(router: router,
                                               requiredAuthorization: true)
    }
    
    func fetchNotificationCount(request: NotificationItemServiceRequest.FetchNotificationCount) async throws -> NotificationItemCount {
        let router = NotificationItemServiceRouter.fetchNotificationCount(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func markAllNotificationsAsRead(request: NotificationItemServiceRequest.MarkAllNotificationsAsRead) async throws {
        let router = NotificationItemServiceRouter.markAllNotificationsAsRead(request: request)
        try await apiManager.requestACK(router: router,
                                        requiredAuthorization: true)
    }
    
    func deleteAllNotifications(request: NotificationItemServiceRequest.DeleteAllNotifications) async throws {
        let router = NotificationItemServiceRouter.deleteAllNotifications(request: request)
        try await apiManager.requestACK(router: router,
                                        requiredAuthorization: true)
    }
} 
