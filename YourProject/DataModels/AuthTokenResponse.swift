//
//  AuthTokenResponse.swift
//  YourProject
//
//  Created by IntrodexMini on 30/1/2568 BE.
//

struct AuthTokenResponse: Decodable {
    let accessToken: String
    let refreshToken: String

    init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.accessToken = try container.decode(String.self, forKey: .accessToken)
        self.refreshToken = try container.decode(String.self, forKey: .refreshToken)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(accessToken, forKey: .accessToken)
        try container.encode(refreshToken, forKey: .refreshToken)
    }

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}

/*
json response
 {
     "access_token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiI2NTEzMWM2ZjFmMzViOWRiM2FhZWI1MzJjOGE2MGE2OCIsImlhdCI6MTczODI0ODQ2NSwiZXhwIjoxNzM4MjQ5MzY1LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.K357A1tEmowJHbHqMzJCIdis1279LvReJnXz0MGyiCA",
     "refresh_token": "aedf263d19f4cabee7c5090f95567e83"
 }
 */
