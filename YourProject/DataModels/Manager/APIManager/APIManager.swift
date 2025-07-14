//
//  APIManager.swift
//  YourProject
//
//  Created by IntrodexMini on 30/1/2568 BE.
//

import Foundation
import Alamofire
import Mockable

enum APIError: Error, LocalizedError {
    case invalidURL
    case unauthorized(error: Error)
    case networkError(error: Error)
    case decodingError(error: Error)
    case httpError(error: Error)
    case serverError(statusCode: Int)
    case unexpectedError(error: Error)
    case unknownError(title: String? = nil,
                      subtitle: String? = nil,
                      underlying: Error? = nil)
}

enum AuthorizationType {
    case bearer(token: String)
}


@Mockable
protocol AlamofireBaseRouterProtocol {
    func asURLRequest() throws -> URLRequest
}

@Mockable
protocol APIManagerProtocal: AnyObject {
    
    func request<T>(
        _ url: String,
        method: HTTPMethod,
        parameters: Parameters?,
        encoding: ParameterEncoding,
        requiredAuthorization: Bool
    ) async throws -> T where T: Decodable
    
    func request<T>(
        router: AlamofireBaseRouterProtocol,
        requiredAuthorization: Bool
    ) async throws -> T where T: Decodable
    
    func requestACK(
        router: AlamofireBaseRouterProtocol,
        requiredAuthorization: Bool
    ) async throws
    
    func requestData(
        router: AlamofireBaseRouterProtocol,
        requiredAuthorization: Bool
    ) async throws -> Data?
    
    func cancelAllRequests()
}

class APIManager: APIManagerProtocal {
    
    static let shared = APIManager()
    
    var baseURL: String {
        AppConfiguration.shared.baseURL
    }
    
    private var session: Session
    private var authSession: Session
    
    private let localStorageManager: LocalStorageManagerProtocal
    private let authRemoteService: AuthServiceProtocol
    private let authInterceptor: AuthenticationInterceptor<OAuthAuthenticator>
    private let authenticator: OAuthAuthenticator
    
    init(localStorageManager: LocalStorageManagerProtocal = LocalStorageManager(),
         authRemoteService: AuthServiceProtocol = AuthRemoteService(),
         authCredential: OAuthCredential = OAuthCredential()) {
        self.localStorageManager = localStorageManager
        self.authRemoteService = authRemoteService
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 300
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        // Initialize the OAuth authenticator
        self.authenticator = OAuthAuthenticator(
            localStorageManager: localStorageManager,
            authRemoteService: authRemoteService
        )
        
        // Create the authentication interceptor
        //let authCredential = OAuthCredential(localStorageManager: localStorageManager)
        self.authInterceptor = AuthenticationInterceptor(
            authenticator: authenticator,
            credential: authCredential
        )
        
        authSession = Session(
            configuration: configuration,
            interceptor: authInterceptor
        )
        
        session = Session(configuration: configuration)
    }
    
    /// For setup Units or UI tests
    func setupURLSession(with configuration: URLSessionConfiguration) {
        self.authSession = Session(
            configuration: configuration,
            interceptor: authInterceptor
        )
        authSession.sessionConfiguration.timeoutIntervalForRequest = 30
        authSession.sessionConfiguration.timeoutIntervalForResource = 30
        
        session = Session(configuration: configuration)
        session.sessionConfiguration.timeoutIntervalForRequest = 30
        session.sessionConfiguration.timeoutIntervalForResource = 30
       
    }
    
    func request<T>(
        _ url: String,
        method: Alamofire.HTTPMethod,
        parameters: Alamofire.Parameters?,
        encoding: any Alamofire.ParameterEncoding,
        requiredAuthorization: Bool
    ) async throws -> T where T : Decodable {
        
        let session = self.session(requiredAuthorization: requiredAuthorization)
        let reqPath = fullPath(path: url)
        
        let response = await session.request(reqPath,
                                             method: method,
                                             parameters: parameters,
                                             encoding: encoding)
            .serializingData()
            .response
        
        return try handleResponse(response)
    }
    
    func request<T: Decodable>(
        router: AlamofireBaseRouterProtocol,
        requiredAuthorization: Bool = true
    ) async throws -> T {
        let session = self.session(requiredAuthorization: requiredAuthorization)
        let urlRequest = try router.asURLRequest()
        
        let response = await session.request(urlRequest)
            .serializingData()
            .response
        
        return try handleResponse(response)
    }
    
    
    func requestACK(
        router: AlamofireBaseRouterProtocol,
        requiredAuthorization: Bool = true
    ) async throws {
        let session = self.session(requiredAuthorization: requiredAuthorization)
        let urlRequest = try router.asURLRequest()
        
        let response = await session.request(urlRequest)
            .serializingData()
            .response
        
        try handleResponseACK(response)
    }
    
    func requestData(
        router: AlamofireBaseRouterProtocol,
        requiredAuthorization: Bool = true
    ) async throws -> Data? {
        let session = self.session(requiredAuthorization: requiredAuthorization)
        let urlRequest = try router.asURLRequest()
        
        let response = await session.request(urlRequest)
            .serializingData()
            .response
        
        return try handleResponseData(response)
    }
    
    func cancelAllRequests() {
        session.cancelAllRequests()
        authSession.cancelAllRequests()
    }
}

private extension APIManager {

    func fullPath(path: String) -> String {
        return "\(baseURL)\(path)"
    }
    
    func session(requiredAuthorization: Bool) -> Session {
        if requiredAuthorization {
            return authSession
        }
        return session
    }
    
    func handleResponse<T: Decodable>(_ response: AFDataResponse<Data>) throws -> T {
        // handel error
        if let error = response.error?.asAFError {
            switch error {
            case .requestAdaptationFailed(let err):
                print(err.localizedDescription)
                throw APIError.unauthorized(error: err)
                
            default:
                throw APIError.unexpectedError(error: error)
            }
        }
            
        if let error = response.error?.asAFError {
            print(error.localizedDescription)
            throw APIError.unexpectedError(error: error)
        }
        
        // case no response
        guard let serverResponse = response.response else {
            throw APIError.serverError(statusCode: 500)
        }
      
        // case no response value
        guard let value = response.value else {
            throw APIError.serverError(statusCode: serverResponse.statusCode)
        }
        
        // try to decode data to APIErrorResponse
        if let apiError: APIErrorResponse = try? JSONDecoder().decode(APIErrorResponse.self, from: value) {
            throw apiError
        }
        
        
        // try to decode to <T>
        if let decoded: T = try? JSONDecoder().decode(T.self, from: value) {
            return decoded
        }
        
        // try to decode data to String
        if let string: String = String(data: value, encoding: .utf8),
           string.count > 0 {
            throw APIError.unknownError(title: "Error",
                                        subtitle: string,
                                        underlying: nil)
        }
      
        
        print("error 500")
        throw APIError.serverError(statusCode: 500)
    }

    func handleResponseData(_ response: AFDataResponse<Data>) throws -> Data? {
        // case no response
        guard let serverResponse = response.response else {
            throw APIError.serverError(statusCode: 500)
        }
        
        // cast to Data
        guard let value = response.value else {
            throw APIError.serverError(statusCode: serverResponse.statusCode)
        }
        // try to decode data to APIErrorResponse
        if let apiError: APIErrorResponse = try? JSONDecoder().decode(APIErrorResponse.self, from: value) {
            throw apiError
        }
        
        if let error = response.error {
            print(error.localizedDescription)
            throw APIError.unexpectedError(error: error)
        }
                
        return value
    }

    func handleResponseACK(_ response: AFDataResponse<Data>) throws {
        // case no response
        guard let serverResponse = response.response else {
            throw APIError.serverError(statusCode: 500)
        }
        
        // Check if there's error data to decode
        if let value = response.value,
           let apiError: APIErrorResponse = try? JSONDecoder().decode(APIErrorResponse.self, from: value) {
            throw apiError
        }
        
        if let error = response.error {
            print(error.localizedDescription)
            throw APIError.unexpectedError(error: error)
        }
        
        // If status code is not in 200-299 range, throw server error
        if !(200...299).contains(serverResponse.statusCode) {
            throw APIError.serverError(statusCode: serverResponse.statusCode)
        }
    }

}
