//
//  APIErrorResponse.swift
//  YourProject
//
//  Created by IntrodexMini on 31/1/2568 BE.
//
import Foundation

struct APIErrorResponse: Decodable, Error {

    let errorCode: Int
    let errorKey: String?
    let errorMessage: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.errorCode = try container.decode(Int.self, forKey: .errorCode)
        self.errorKey = try container.decodeIfPresent(String.self, forKey: .errorKey)
        self.errorMessage = try container.decodeIfPresent(String.self, forKey: .errorMessage)
    }
    
    init (errorCode: Int,
          errorKey: String? = nil,
          errorMessage: String? = nil) {
        self.errorCode = errorCode
        self.errorKey = errorKey
        self.errorMessage = errorMessage
    }
    
    var authErorKey: AuthErrorKey? {
        guard let errorKey else { return nil }
        return AuthErrorKey(rawValue: errorKey)
    }
    
    var isAccessTokenExpired: Bool {
        (authErorKey == .accessTokenExpired) && (errorCode == 401)
    }

     private enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorKey = "error_key"
        case errorMessage = "error_message"
    }
}

extension APIErrorResponse {
    enum AuthErrorKey: String {
        case accessTokenExpired = "access_token_expired"
        case invalidAccessToken = "invalid_access_token"
        case invalidRefreshToken = "invalid_refresh_token"
        case missingAccessToken = "missing_access_token"
        case missingRefreshToken = "missing_refresh_token"

        var errorMessage: String {
            switch self {
            case .accessTokenExpired:
                return "Access token expired."
            case .invalidAccessToken:
                return "Invalid access token."
            case .invalidRefreshToken:
                return "Invalid refresh token."
            case .missingAccessToken:
                return "Missing access token."
            case .missingRefreshToken:
                return "Missing refresh token."
            }
        }

        var apiErrorResponse: APIErrorResponse {
            return .init(errorCode: 401,
                         errorKey: rawValue,
                         errorMessage: errorMessage)
        }
    }
}

/*
 json response
 {
     "error_code": 401,
     "error_key": "unauthorized",
     "error_message": "Unauthorized."
 }
 */
