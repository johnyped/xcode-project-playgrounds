//
//  OAuthCredential.swift
//  YourProject
//
//  Created by IntrodexMini on 22/2/2568 BE.
//

import Foundation
import Alamofire

struct OAuthCredential: AuthenticationCredential {
    // Add date provider type and static property
    typealias DateProvider = () -> Date
    static var currentDate: DateProvider = { Date() }
    
    let localStorageManager: LocalStorageManagerProtocal
    let byPassRequiresRefresh: Bool?
    
    var accessToken: String {
        localStorageManager.accessToken ?? ""
    }
        
    var refreshToken: String {
        localStorageManager.refreshToken ?? ""
    }
    
    var requiresRefresh: Bool {
        if let byPassRequiresRefresh {
            return byPassRequiresRefresh
        }
        
        do {
            let payload = try JWTPayload(jwtToken: accessToken)
            let expirationDate = Date(timeIntervalSince1970: TimeInterval(payload.exp))
            let bufferInterval: TimeInterval = 300 // 5 minutes in seconds
            let shouldRefreshDate = expirationDate.addingTimeInterval(-bufferInterval)
            
            return Self.currentDate() >= shouldRefreshDate
        } catch {
            // If we can't decode the token, assume it needs refresh
            return true
        }
    }
    
    init(
        localStorageManager: LocalStorageManagerProtocal = LocalStorageManager(),
        byPassRequiresRefresh: Bool? = nil
    ) {
        self.localStorageManager = localStorageManager
        self.byPassRequiresRefresh = byPassRequiresRefresh
    }
}

class OAuthAuthenticator: Authenticator {
    private let localStorageManager: LocalStorageManagerProtocal
    private let authRemoteService: AuthServiceProtocol        
    
    init(localStorageManager: LocalStorageManagerProtocal,
         authRemoteService: AuthServiceProtocol) {
        self.localStorageManager = localStorageManager
        self.authRemoteService = authRemoteService
    }
    
    func apply(_ credential: OAuthCredential, to urlRequest: inout URLRequest) {
        print(">>> Adding Authorization header to URLRequest")
        urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
    }
    
    func refresh(_ credential: OAuthCredential,
                 for session: Session,
                 completion: @escaping (Result<OAuthCredential, Error>) -> Void) {
        guard
            let _ = localStorageManager.accessToken,
            let _ = localStorageManager.refreshToken
        else {
//            let error = APIError.unauthorized(
//                error: APIErrorResponse.AuthErrorKey
//                    .missingRefreshToken.apiErrorResponse)
            let error = Alamofire.AuthenticationError.missingCredential
            completion(.failure(error))
            return
        }
        print(">>> Refreshing OAuth token...")
        Task {
            do {
                try await authRemoteService.tokenRefresh(
                    request: .init(token: credential.refreshToken)
                )
                
                // Create new credential with updated tokens
                let newCredential = OAuthCredential(localStorageManager: localStorageManager)
                
                completion(.success(newCredential))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func didRequest(_ urlRequest: URLRequest,
                   with response: HTTPURLResponse,
                   failDueToAuthenticationError error: Error) -> Bool {
        print(">>> Authentication error: \(error)")
        return response.statusCode == 401
    }
    
    func isRequest(_ urlRequest: URLRequest,
                  authenticatedWith credential: OAuthCredential) -> Bool {
        print(">>> Checking if request is authenticated...")
        let bearerToken = HTTPHeader.authorization(bearerToken: credential.accessToken).value
        return urlRequest.headers["Authorization"] == bearerToken
    }
}
