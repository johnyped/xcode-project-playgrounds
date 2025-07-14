//  ReservationItemServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 13/6/2568 BE.
//
import Foundation

struct ReservationItemServiceRequest {
    typealias FetchById = ByID
    typealias DeleteReservationItem = ByID
    
    struct ByID { let id: Int }
    
    enum SortedBy: String {
        case id = "ID"
        case reservedDate = "RESERVED_DATE"
        case createdAt = "CREATED_AT"
        case updatedAt = "UPDATED_AT"
    }

    struct FetchByReservation: Encodable {
        let hotelId: Int
        let reservationId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case reservationId = "reservation_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(reservationId, forKey: .reservationId)
            if let page = page, page >= 1 {
                try container.encode(page, forKey: .page)
            }
            if let perPage = perPage {
                try container.encode(perPage.rawValue, forKey: .perPage)
            }
            if let sortedBy = sortedBy {
                try container.encode(sortedBy.rawValue, forKey: .sortedBy)
            }
            if let sortedOrder = sortedOrder {
                try container.encode(sortedOrder.rawValue, forKey: .sortedOrder)
            }
        }
    }
    
    struct UpdateReservationItem: Encodable {
        let id: Int
        let reservationId: Int?
        let reservationType: ReservationItem.ReservableType?
        let totalPrice: Double?
        let priceCardId: Int?
        let data: ReservationItem.Data?
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        init(id: Int,
             reservationId: Int?,
             reservationType: ReservationItem.ReservableType?,
             totalPrice: Double?,
             priceCardId: Int?,
             data: ReservationItem.Data?) {
            self.id = id
            self.reservationId = reservationId
            self.reservationType = reservationType
            self.totalPrice = totalPrice
            self.priceCardId = priceCardId
            self.data = data
        }
        
        /*
         {
           "reservable_id": "<integer>",
           "reservable_type": "RoomType",
           "total_price": "<float>",
           "price_card_id": "<integer>",
           "data": "<json>"
         }
         */
        
        enum CodingKeys: String, CodingKey {
            case reservationId = "reservation_id"
            case reservationType = "reservation_type"
            case totalPrice = "total_price"
            case data
            case priceCardId = "price_card_id"
            // id is not encoded as it's used in the URL path
        }
        
        func encode(to encoder: Encoder) throws {
            var container: KeyedEncodingContainer<ReservationItemServiceRequest.UpdateReservationItem.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(reservationId, forKey: .reservationId)
            try container.encodeIfPresent(reservationType?.rawValue, forKey: .reservationType)
            try container.encodeIfPresent(totalPrice?.toString(), forKey: .totalPrice)
            try container.encodeIfPresent(priceCardId, forKey: .priceCardId)
            try container.encodeIfPresent(data, forKey: .data)
        }
    }
    
    struct ReplaceReservationItems: Encodable {
        let reservationId: Int 
        let period: PeriodDate               
        let items: [ReservationItemData]
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }               
        
        enum CodingKeys: String, CodingKey {
            case reservationId = "reservation_id"
            case checkInDate = "check_in_date"
            case checkOutDate = "check_out_date"
            case items
        }
        
        func encode(to encoder: Encoder) throws {
            let yyyyMMdd = FormConfig.DateFormat.yyyyMMdd
            
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(reservationId, forKey: .reservationId)
            try container.encode(period.start.toDateString(yyyyMMdd), forKey: .checkInDate)
            try container.encode(period.end.toDateString(yyyyMMdd), forKey: .checkOutDate)
            try container.encode(items, forKey: .items)
        }

        /*
             {
               "hotel_id": "<integer>",
               "reservation_id": "<integer>",
               "items": "<string>",
               "check_in_date": "<dateTime>",
               "check_out_date": "<dateTime>"
             }
             */
    }

     struct ReservationItemData: Encodable {
            let reservedDate: Date
            let reservableType: ReservationItem.ReservableType
            let reservableId: Int
            let totalPrice: Double
            let priceCardId: Int?
            let data: ReservationItem.Data
            
            
            enum CodingKeys: String, CodingKey {
                case reservedDate = "reserved_date"
                case reservableType = "reservable_type"
                case reservableId = "reservable_id"
                case totalPrice = "total_price"
                case priceCardId = "price_card_id"
                case data
            }
            
            func encode(to encoder: Encoder) throws {
                var container: KeyedEncodingContainer<ReservationItemData.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(reservedDate.toDateString(FormConfig.DateFormat.yyyyMMdd), forKey: .reservedDate)
                try container.encode(reservableType.rawValue, forKey: .reservableType)
                try container.encode(reservableId, forKey: .reservableId)
                try container.encode(totalPrice.toString(), forKey: .totalPrice)
                try container.encodeIfPresent(priceCardId, forKey: .priceCardId)
                try container.encode(data, forKey: .data)
            }
        }
} 
