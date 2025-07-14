//
//  RoomServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//
import Foundation

struct RoomServiceRequest {
    
    typealias FetchRoom = ById
    typealias DeleteRoom = ById
        
    struct ById {
        let id: Int
    }
    
    // MARK: - Fetch Rooms with optional parameters and pagination
    struct FetchRooms: Encodable {
        let hotelId: Int
        let roomTypeId: Int
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case roomTypeId = "room_type_id"
        }
        
        var parameters: [String: Any]? {
            var params: [String: Any] = [:]            
            params["hotel_id"] = hotelId
            params["room_type_id"] = roomTypeId
            
            return params
        }
    }
    
    // MARK: - Create Room
    struct CreateRoom: Encodable {
        let code: String
        let roomTypeId: Int
        let hotelId: Int        
        
        enum CodingKeys: String, CodingKey {
            case code
            case roomTypeId = "room_type_id"
            case hotelId = "hotel_id"
        }
    }
    
    // MARK: - Update Room
    struct UpdateRoom: Encodable {
        let id: Int
        let code: String?
        let status: String?
        let needCleaning: Bool?
        
        enum CodingKeys: String, CodingKey {
            case code
            case status
            case needCleaning = "need_cleaning"                      
            // id is not encoded as it's used in the URL path
        }
    }
    
    // MARK: - Change Room Type
    struct ChangeRoomType: Encodable {
        let id: Int
        let roomTypeId: Int
        
        enum CodingKeys: String, CodingKey {
            case roomTypeId = "room_type_id"
            // id is not encoded as it's used in the URL path
        }
    }
    
    // MARK: - Update Rooms Order
    struct UpdateRoomsOrder: Encodable {
        let hotelId: Int
        let roomOrders: [RoomOrder]
        
        struct RoomOrder: Encodable {
            let roomId: Int
            let order: Int
            
            enum CodingKeys: String, CodingKey {
                case roomId = "room_id"
                case order
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case roomOrders = "room_orders"
        }
    }
    
    // MARK: - Batch Create Rooms
    struct BatchCreateRooms: Encodable {
        let hotelId: Int
        let rooms: [BatchRoom]
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case rooms
        }
       
        struct BatchRoom: Encodable {
            let code: String
            let roomTypeId: Int
            
            enum CodingKeys: String, CodingKey {
                case code
                case roomTypeId = "room_type_id"
            }
        }
    }
    
    // MARK: - Batch Delete Rooms
    struct BatchDeleteRooms: Encodable {
        let hotelId: Int
        let roomIds: [Int]
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id" 
            case roomIds = "room_ids"
        }
        
    }
    
} 
