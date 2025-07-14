//
//  ReceiptServiceRequest.swift
//  YourProject
//
//  Created by AI Assistant
//

import Foundation

struct ReceiptServiceRequest {
    typealias FetchById = ByID
    typealias CancelReceipt = ByID
    typealias VoidReceipt = ByID
    typealias PreviewEmail = ByID
    typealias PreviewPDF = ByID
    typealias ExportPDF = ByID
    typealias ExportImage = ByID

    struct ByID { let id: Int }

    enum SortedBy: String {
        case id = "ID"
        case number = "NUMBER"
        case createdAt = "CREATED_AT"
        case updatedAt = "UPDATED_AT"
        case paidDate = "PAID_DATE"
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
    
    struct FetchByFolioForm: Encodable {
        let hotelId: Int
        let folioFormId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?

        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case folioFormId = "folio_form_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(folioFormId, forKey: .folioFormId)
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
    
    struct FetchByFinancialRecord: Encodable {
        let hotelId: Int
        let financialRecordId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?

        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case financialRecordId = "financial_record_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(financialRecordId, forKey: .financialRecordId)
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
    
    struct CreateFromFinancialRecord: Encodable {
        let hotelId: Int
        let financialRecordId: Int
        let payerContactId: Int
        let receiverContactId: Int
        let remark: String?
        let internalNote: String?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case financialRecordId = "financial_record_id"
            case payerContactId = "payer_id"
            case receiverContactId = "receiver_id"
            case remark
            case internalNote = "internal_note"
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(financialRecordId, forKey: .financialRecordId)
            try container.encode(payerContactId, forKey: .payerContactId)
            try container.encode(receiverContactId, forKey: .receiverContactId)
            try container.encode(remark, forKey: .remark)
            try container.encode(internalNote, forKey: .internalNote)
        }
        
        /*
{
  "hotel_id": "1",
  "financial_record_id": "<integer>",
  "receiver_id": "<integer>",
  "payer_id": "<integer>",
  "remark": "<string>",
  "internal_note": "<string>"
}
        */
    }

    struct CreateFromReservation: Encodable {
        let hotelId: Int
        let reservationId: Int
        let paidDate: Date
        let payerContactId: Int
        let receiverContactId: Int
        let remark: String?
        let internalNote: String?
        let roomItemGrouped: Bool?
        let additionalItemGrouped: Bool?
        let otherItemGrouped: Bool?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case reservationId = "reservation_id"
            case paidDate = "paid_date"
            case payerContactId = "payer_id"
            case receiverContactId = "receiver_id"
            case remark
            case internalNote = "internal_note"
            case roomItemGrouped = "room_item_grouped"
            case additionalItemGrouped = "additional_item_grouped"
            case otherItemGrouped = "other_item_grouped"
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
                try container.encode(reservationId, forKey: .reservationId)
            try container.encode(paidDate.toDateString(FormConfig.DateFormat.yyyyMMdd), forKey: .paidDate)
            try container.encode(payerContactId, forKey: .payerContactId)
            try container.encode(receiverContactId, forKey: .receiverContactId)
            try container.encodeIfPresent(remark, forKey: .remark)
            try container.encodeIfPresent(internalNote, forKey: .internalNote)
            try container.encodeIfPresent(roomItemGrouped, forKey: .roomItemGrouped)
            try container.encodeIfPresent(additionalItemGrouped, forKey: .additionalItemGrouped)
            try container.encodeIfPresent(otherItemGrouped, forKey: .otherItemGrouped)
        }
        
    }
    
    struct CreateFromFolioForm: Encodable {
        let hotelId: Int
        let folioFormId: Int
        let paidDate: Date
        let payerContactId: Int
        let receiverContactId: Int
        let remark: String?
        let internalNote: String?
        let roomItemGrouped: Bool?
        let additionalItemGrouped: Bool?
        let otherItemGrouped: Bool?

        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case folioFormId = "folio_form_id"
            case paidDate = "paid_date"
            case payerContactId = "payer_id"
            case receiverContactId = "receiver_id"
            case remark
            case internalNote = "internal_note"
            case roomItemGrouped = "room_item_grouped"
            case additionalItemGrouped = "additional_item_grouped"
            case otherItemGrouped = "other_item_grouped"
        }

        var body: Data? {
            return try? JSONEncoder().encode(self)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(folioFormId, forKey: .folioFormId)
            try container.encode(paidDate.toDateString(FormConfig.DateFormat.yyyyMMdd), forKey: .paidDate)
            try container.encode(payerContactId, forKey: .payerContactId)
            try container.encode(receiverContactId, forKey: .receiverContactId)
            try container.encodeIfPresent(remark, forKey: .remark)
            try container.encodeIfPresent(internalNote, forKey: .internalNote)
            try container.encodeIfPresent(roomItemGrouped, forKey: .roomItemGrouped)
            try container.encodeIfPresent(additionalItemGrouped, forKey: .additionalItemGrouped)
            try container.encodeIfPresent(otherItemGrouped, forKey: .otherItemGrouped)
        }
        
        /*
         {
           "hotel_id": "1",
           "folio_form_id": "<integer>",
           "paid_date": "2025-04-26",
           "payer_id": "<integer>",
           "receiver_id": "<integer>",
           "remark": "<string>",
           "internal_note": "<string>",
           "room_item_grouped": "<boolean>",
           "additional_item_grouped": "<boolean>",
           "other_item_grouped": "<boolean>"
         }
         */
    }
    
    typealias CreateFromFolioFormVat = CreateFromFolioForm
    
    struct VoidReceiptRequest: Encodable {
        let id: Int
        let voidReason: String
        
        enum CodingKeys: String, CodingKey {
            case voidReason = "void_reason"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(voidReason, forKey: .voidReason)
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
    }
    
    struct CancelReceiptRequest: Encodable {
        let id: Int
        let cancelReason: String
        
        enum CodingKeys: String, CodingKey {
            case cancelReason = "cancel_reason"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(cancelReason, forKey: .cancelReason)
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
    }
} 
