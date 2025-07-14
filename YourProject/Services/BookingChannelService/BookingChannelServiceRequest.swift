//
//  BookingChannelServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//
import Foundation

struct BookingChannelServiceRequest {
    
    typealias FetchChannel = ById
    typealias DeleteChannel = ById
    typealias FetchSubChannels = ById
    
    struct ById {
        let id: Int
    }
    
    // MARK: - Create Channel
    struct CreateChannel: Encodable {
        let name: String
        let feeRate: Double
        
        enum CodingKeys: String, CodingKey {
            case name
            case feeRate = "fee_rate"
        }
    }
    
    // MARK: - Update Channel
    struct UpdateChannel: Encodable {
        let id: Int
        let name: String?
        let feeRate: Double?
        
        enum CodingKeys: String, CodingKey {
            case name
            case feeRate = "fee_rate"
            // id is not encoded as it's used in the URL path
        }
    }
    
    // MARK: - Create Sub Channel
    struct CreateSubChannel: Encodable {
        let channelId: Int
        let name: String
        let feeRate: Double
        
        enum CodingKeys: String, CodingKey {
            case name
            case feeRate = "fee_rate"
            // channelId is not encoded as it's used in the URL path
        }
    }
    
    // MARK: - Update Sub Channel
    struct UpdateSubChannel: Encodable {
        let channelId: Int
        let subChannelId: Int
        let name: String?
        let feeRate: Double?
        
        enum CodingKeys: String, CodingKey {
            case name
            case feeRate = "fee_rate"
            // channelId and subChannelId are not encoded as they're used in the URL path
        }
    }
    
    // MARK: - Delete Sub Channel
    struct DeleteSubChannel {
        let channelId: Int
        let subChannelId: Int
    }
} 
