//  FolioFormServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 13/6/2568 BE.
//
import Foundation

struct FolioFormServiceRequest {
    typealias FetchById = ByID    
    typealias CancelFolioForm = ByID
    typealias PreviewEmail = ByID
    typealias PreviewPDF = ByID
    typealias ExportPDF = ByID
    typealias ExportImage = ByID

    struct ByID { let id: Int }

    enum SortedBy: String {
        case id = "ID"
        case createdAt = "CREATED_AT"
        case updatedAt = "UPDATED_AT"
    }

    struct FetchByHotel: Encodable {
        let hotelId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
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
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
    }
    
    struct FetchByQuery: Encodable {
        let hotelId: Int
        let query: String
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?

        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case query
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(query, forKey: .query)
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

        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
    }
    
    struct FetchByPeriod: Encodable {
        let hotelId: Int
        let period: PeriodDate
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?

        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case startDate = "start_date"
            case endDate = "end_date"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let dateFormat = FormConfig.DateFormat.yyyyMMdd
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(period.start.toDateString(dateFormat), forKey: .startDate)
            try container.encode(period.end.toDateString(dateFormat), forKey: .endDate)
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

        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
    }
    
    struct FetchByReservation: Encodable {
        let hotelId: Int
        let reservationId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?

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

        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
    }    
    
    struct CreateFolioFormReservation: Encodable {
       /*
        {
          "hotel_id": 1,
          "reservation_id" : {{reservation_id}},
          "hotel_contact_id": "<integer>",
          "customer_contact_id": "<integer>",
          "vat_included": "<boolean>",
          "remark": "<string>",
          "internal_note": "<string>",
          "payment_info": "<string>",
          "group_room_charge": "<boolean>",
          "group_additional_item": "<boolean>"
        }
        */

        let hotelId: Int
        let reservationId: Int
        let hotelContactId: Int
        let customerContactId: Int
        let vatIncluded: Bool
        let remark: String?
        let internalNote: String?
        let paymentInfo: String?
        let groupRoomCharge: Bool?
        let groupAdditionalItem: Bool?
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        init(hotelId: Int,
             reservationId: Int,
             hotelContactId: Int,
             customerContactId: Int,
             vatIncluded: Bool,
             remark: String?,
             internalNote: String?,
             paymentInfo: String?,
             groupRoomCharge: Bool?,
             groupAdditionalItem: Bool?) {
            self.hotelId = hotelId
            self.reservationId = reservationId
            self.hotelContactId = hotelContactId
            self.customerContactId = customerContactId
            self.vatIncluded = vatIncluded
            self.remark = remark
            self.internalNote = internalNote
            self.paymentInfo = paymentInfo
            self.groupRoomCharge = groupRoomCharge
            self.groupAdditionalItem = groupAdditionalItem
        }

        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case reservationId = "reservation_id"
            case hotelContactId = "hotel_contact_id"
            case customerContactId = "customer_contact_id"
            case vatIncluded = "vat_included"
            case remark = "remark"
            case internalNote = "internal_note"
            case paymentInfo = "payment_info"
            case groupRoomCharge = "group_room_charge"
            case groupAdditionalItem = "group_additional_item"
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(reservationId, forKey: .reservationId)
            try container.encode(hotelContactId, forKey: .hotelContactId)
            try container.encode(customerContactId, forKey: .customerContactId)
            try container.encode(vatIncluded, forKey: .vatIncluded)
            try container.encodeIfPresent(remark, forKey: .remark)
            try container.encodeIfPresent(internalNote, forKey: .internalNote)
            try container.encodeIfPresent(paymentInfo, forKey: .paymentInfo)
            try container.encodeIfPresent(groupRoomCharge, forKey: .groupRoomCharge)
            try container.encodeIfPresent(groupAdditionalItem, forKey: .groupAdditionalItem)
        }
       
    }
    
    struct UpdateFolioForm: Encodable {
       /*
       {
  "hotel_contact_id": "<integer>",
  "customer_contact_id": "<integer>",
  "remark": "<string>",
  "internal_note": "<string>",
  "payment_info": "<string>",
  "group_room_charge": "<boolean>",
  "group_additional_item": "<boolean>"
}
*/
        let id: Int
        let hotelContactId: Int?
        let customerContactId: Int?
        let remark: String?
        let internalNote: String?
        let paymentInfo: String?
        let groupRoomCharge: Bool?
        let groupAdditionalItem: Bool?
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }

        init(id: Int, 
        hotelContactId: Int?, 
        customerContactId: Int?, 
        remark: String?, 
        internalNote: String?, 
        paymentInfo: String?, 
        groupRoomCharge: Bool?, 
        groupAdditionalItem: Bool?) {
            self.id = id
            self.hotelContactId = hotelContactId
            self.customerContactId = customerContactId
            self.remark = remark
            self.internalNote = internalNote
            self.paymentInfo = paymentInfo
            self.groupRoomCharge = groupRoomCharge
            self.groupAdditionalItem = groupAdditionalItem
            }

        enum CodingKeys: String, CodingKey {
            case hotelContactId = "hotel_contact_id"
            case customerContactId = "customer_contact_id"
            case remark = "remark"
            case internalNote = "internal_note"
            case paymentInfo = "payment_info"
            case groupRoomCharge = "group_room_charge"
            case groupAdditionalItem = "group_additional_item"
            // id is not encoded as it's used in the URL path
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)            
            try container.encodeIfPresent(hotelContactId, forKey: .hotelContactId)
            try container.encodeIfPresent(customerContactId, forKey: .customerContactId)
            try container.encodeIfPresent(remark, forKey: .remark)
            try container.encodeIfPresent(internalNote, forKey: .internalNote)
            try container.encodeIfPresent(paymentInfo, forKey: .paymentInfo)
            try container.encodeIfPresent(groupRoomCharge, forKey: .groupRoomCharge)
            try container.encodeIfPresent(groupAdditionalItem, forKey: .groupAdditionalItem)
        }
    }
    
} 
