//
//  ReservationServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//
import Foundation

struct ReservationServiceRequest {
    // MARK: - Type Aliases for simple requests
    typealias FetchById = ByID
    typealias CheckIn = ByID
    typealias CheckOut = ByID
    typealias Cancel = ByID
    typealias NoShow = ByID
    typealias FetchConfirmation = ByID
    typealias SetFirstGuest = ByID
    
    struct ByID { let id: Int }
    
    // MARK: - Sorting Enums
    enum SortedBy: String {
        case id = "ID"
        case checkInDate = "CHECK_IN_DATE"
        case checkOutDate = "CHECK_OUT_DATE"
        case createdAt = "CREATED_AT"
        case updatedAt = "UPDATED_AT"
    }
    
    // MARK: - Basic Fetch Requests
    struct FetchReservations: Encodable {
        let hotelId: Int
        let status: Reservation.Status?
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case status
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            if let status {
                try container.encode(status.rawValue, forKey: .status)
            }
            if let page, page >= 1 {
                try container.encode(page, forKey: .page)
            }
            if let perPage {
                try container.encode(perPage.rawValue, forKey: .perPage)
            }
            if let sortedBy {
                try container.encode(sortedBy.rawValue, forKey: .sortedBy)
            }
            if let sortedOrder {
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
    
    struct FetchReservationsByFlags: Encodable {
        let hotelId: Int
        let flags: [Reservation.Flag]
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case flags
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            
            let flagsText: String = flags.map { $0.rawValue }.joined(separator: ",")
            try container.encode(flagsText, forKey: .flags)
            
            if let page, page >= 1 {
                try container.encode(page, forKey: .page)
            }
            if let perPage {
                try container.encode(perPage.rawValue, forKey: .perPage)
            }
            if let sortedBy {
                try container.encode(sortedBy.rawValue, forKey: .sortedBy)
            }
            if let sortedOrder {
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
    
    struct FetchReservationsByGuest: Encodable {
        let hotelId: Int
        let guestId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case guestId = "guest_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(guestId, forKey: .guestId)
            if let page, page >= 1 {
                try container.encode(page, forKey: .page)
            }
            if let perPage {
                try container.encode(perPage.rawValue, forKey: .perPage)
            }
            if let sortedBy {
                try container.encode(sortedBy.rawValue, forKey: .sortedBy)
            }
            if let sortedOrder {
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
    
    struct FetchReservationsByCompany: Encodable {
        let hotelId: Int
        let companyId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case companyId = "company_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(companyId, forKey: .companyId)
            if let page , page >= 1 {
                try container.encode(page, forKey: .page)
            }
            if let perPage {
                try container.encode(perPage.rawValue, forKey: .perPage)
            }
            if let sortedBy {
                try container.encode(sortedBy.rawValue, forKey: .sortedBy)
            }
            if let sortedOrder {
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
    
    struct FetchReservationsByPeriod: Encodable {
        let hotelId: Int
        let period: PeriodDate
        let status: Reservation.Status?
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case startAt = "start_at"
            case endAt = "end_at"
            case status
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let dateFormat = FormConfig.DateFormat.yyyyMMdd
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(period.start.toDateString(dateFormat), forKey: .startAt)
            try container.encode(period.end.toDateString(dateFormat), forKey: .endAt)
            if let status = status {
                try container.encode(status, forKey: .status)
            }
            if let page, page >= 1 {
                try container.encode(page, forKey: .page)
            }
            if let perPage {
                try container.encode(perPage.rawValue, forKey: .perPage)
            }
            if let sortedBy {
                try container.encode(sortedBy.rawValue, forKey: .sortedBy)
            }
            if let sortedOrder {
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
    
    struct FetchReservationsByCreatedAt: Encodable {
        let hotelId: Int
        let period: PeriodDate
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case startAt = "start_at"
            case endAt = "end_at"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let dateFormat = FormConfig.DateFormat.datetimeISO
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(period.start.toDateString(dateFormat), forKey: .startAt)
            try container.encode(period.end.toDateString(dateFormat), forKey: .endAt)
            if let page, page >= 1 {
                try container.encode(page, forKey: .page)
            }
            if let perPage {
                try container.encode(perPage.rawValue, forKey: .perPage)
            }
            if let sortedBy {
                try container.encode(sortedBy.rawValue, forKey: .sortedBy)
            }
            if let sortedOrder {
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
    
    struct FetchReservationsByTags: Encodable {
        let hotelId: Int
        let tags: [String]
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case tags
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            
            let tagsText = tags.joined(separator: ",")
            try container.encode(tagsText, forKey: .tags)
            
            if let page, page >= 1 {
                try container.encode(page, forKey: .page)
            }
            if let perPage {
                try container.encode(perPage.rawValue, forKey: .perPage)
            }
            if let sortedBy = sortedBy {
                try container.encode(sortedBy.rawValue, forKey: .sortedBy)
            }
            if let sortedOrder {
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
    
    struct FetchReservationsByKeyword: Encodable {
        let hotelId: Int
        let keyword: String
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case keyword
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(keyword, forKey: .keyword)
            if let page, page >= 1 {
                try container.encode(page, forKey: .page)
            }
            if let perPage {
                try container.encode(perPage.rawValue, forKey: .perPage)
            }
            if let sortedBy {
                try container.encode(sortedBy.rawValue, forKey: .sortedBy)
            }
            if let sortedOrder {
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
    
    struct FetchReservationsByBatchIds: Encodable {
        let hotelId: Int
        let ids: [Int]
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case ids
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            let idsText: String = ids.map { String($0) }.joined(separator: ",")
            try container.encode(idsText, forKey: .ids)
        }
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
    }
    
    struct FetchReservationByUid: Encodable {
        let hotelId: Int
        let uid: String
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case uid
        }
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
    }
    
    // MARK: - CM Booking Requests
    struct FetchReservationByCMBooking: Encodable {
        let cmBookingId: Int
        
        enum CodingKeys: String, CodingKey {
            case cmBookingId = "cm_booking_id"
        }
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
    }
    
    struct CreateReservationByCMBooking: Encodable {
        let hotelId: Int
        let cmBookingId: Int
        let period: PeriodDate
        let adultNumber: Int
        let extraAdultNumber: Int        

        let contactName: String
        let contactEmail: String?
        let contactTel: String?

        let items: [CreateReservationItem]
        
        let note: String?
        let guestComment: String?

        let channelId: Int
        let subChannelId: Int?
        let otaBookingId: String?
        let relatedReservationId: Int?
        let guestIds: [Int]?

        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case cmBookingId = "cm_booking_id"
            case checkInDate = "check_in_date"
            case checkOutDate = "check_out_date"
            case adultNumber = "adult_number"
            case extraAdultNumber = "extra_adult_number"            
            case contactName = "contact_fullname"
            case contactEmail = "contact_email"
            case contactTel = "contact_tel"
            case items
            case note
            case guestComment = "guest_comment"
            case channelId = "channel_id"
            case subChannelId = "sub_channel_id"            
            case otaBookingId = "ota_booking_id"
            case relatedReservationId = "related_reservation_id"
            case guestIds = "guest_ids"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let dateFormat = FormConfig.DateFormat.yyyyMMdd
            try container.encode(hotelId, forKey: .hotelId)  
            try container.encode(cmBookingId, forKey: .cmBookingId)
            try container.encode(period.start.toDateString(dateFormat), forKey: .checkInDate)
            try container.encode(period.end.toDateString(dateFormat), forKey: .checkOutDate)
            try container.encode(adultNumber, forKey: .adultNumber)
            try container.encode(extraAdultNumber, forKey: .extraAdultNumber)
            try container.encode(contactName, forKey: .contactName)
            try container.encodeIfPresent(contactEmail, forKey: .contactEmail)
            try container.encodeIfPresent(contactTel, forKey: .contactTel)
            try container.encode(items, forKey: .items)
            try container.encodeIfPresent(note, forKey: .note)
            try container.encodeIfPresent(guestComment, forKey: .guestComment)            
            try container.encode(channelId, forKey: .channelId)
            try container.encodeIfPresent(subChannelId, forKey: .subChannelId)
            try container.encodeIfPresent(otaBookingId, forKey: .otaBookingId)
            try container.encodeIfPresent(relatedReservationId, forKey: .relatedReservationId)
            try container.encodeIfPresent(guestIds, forKey: .guestIds)            
        }
    }
    
    // MARK: - CRUD Operations
    
    struct CreateReservation: Encodable {
        let hotelId: Int        
        let period: PeriodDate
        let adultNumber: Int
        let extraAdultNumber: Int        

        let contactName: String
        let contactEmail: String?
        let contactTel: String?

        let items: [CreateReservationItem]
        
        let note: String?
        let guestComment: String?

        let channelId: Int
        let subChannelId: Int?
        let otaBookingId: String?
        let relatedReservationId: Int?
        let guestIds: [Int]?

        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"            
            case checkInDate = "check_in_date"
            case checkOutDate = "check_out_date"
            case adultNumber = "adult_number"
            case extraAdultNumber = "extra_adult_number"            
            case contactName = "contact_fullname"
            case contactEmail = "contact_email"
            case contactTel = "contact_tel"
            case items
            case note
            case guestComment = "guest_comment"
            case channelId = "channel_id"
            case subChannelId = "sub_channel_id"            
            case otaBookingId = "ota_booking_id"
            case relatedReservationId = "related_reservation_id"
            case guestIds = "guest_ids"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let dateFormat = FormConfig.DateFormat.yyyyMMdd
            try container.encode(hotelId, forKey: .hotelId)            
            try container.encode(period.start.toDateString(dateFormat), forKey: .checkInDate)
            try container.encode(period.end.toDateString(dateFormat), forKey: .checkOutDate)
            try container.encode(adultNumber, forKey: .adultNumber)
            try container.encode(extraAdultNumber, forKey: .extraAdultNumber)
            try container.encode(contactName, forKey: .contactName)
            try container.encodeIfPresent(contactEmail, forKey: .contactEmail)
            try container.encodeIfPresent(contactTel, forKey: .contactTel)
            try container.encode(items, forKey: .items)
            try container.encodeIfPresent(note, forKey: .note)
            try container.encodeIfPresent(guestComment, forKey: .guestComment)            
            try container.encode(channelId, forKey: .channelId)
            try container.encodeIfPresent(subChannelId, forKey: .subChannelId)
            try container.encodeIfPresent(otaBookingId, forKey: .otaBookingId)
            try container.encodeIfPresent(relatedReservationId, forKey: .relatedReservationId)
            try container.encodeIfPresent(guestIds, forKey: .guestIds)            
        }        
    }
    
    struct UpdateReservation: Encodable {
        let id: Int
        let adultNumber: Int?
        let extraAdultNumber: Int?        

        let contactName: String?
        let contactEmail: String?
        let contactTel: String?

        let note: String?
        let guestComment: String?

        let flags: [Reservation.Flag]?
        let emoji: String?
        let channelId: Int
        let subChannelId: Int?
        let otaBookingId: String?
        let relatedReservationId: Int?
        let guestIds: [Int]?

        var body: Data? {
            return try? JSONEncoder().encode(self)
        }

        init(id: Int,
             adultNumber: Int?,
             extraAdultNumber: Int?,
             contactName: String?,
             contactEmail: String?,
             contactTel: String?,
             note: String?,
             guestComment: String?,
             flags: [Reservation.Flag]?,
             emoji: String?,
             channelId: Int,
             subChannelId: Int?,
             otaBookingId: String?,
             relatedReservationId: Int?,
             guestIds: [Int]?) {
            self.id = id
            self.adultNumber = adultNumber
            self.extraAdultNumber = extraAdultNumber
            self.contactName = contactName
            self.contactEmail = contactEmail
            self.contactTel = contactTel
            self.note = note
            self.guestComment = guestComment
            self.flags = flags
            self.emoji = emoji
            self.channelId = channelId
            self.subChannelId = subChannelId
            self.otaBookingId = otaBookingId
            self.relatedReservationId = relatedReservationId
            self.guestIds = guestIds
        }

        //encode
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)            
            try container.encodeIfPresent(adultNumber, forKey: .adultNumber)
            try container.encodeIfPresent(extraAdultNumber, forKey: .extraAdultNumber)
            try container.encodeIfPresent(contactName, forKey: .contactName)
            try container.encodeIfPresent(contactEmail, forKey: .contactEmail)
            try container.encodeIfPresent(contactTel, forKey: .contactTel)
            try container.encodeIfPresent(note, forKey: .note)
            try container.encodeIfPresent(guestComment, forKey: .guestComment)
            if let flags {
                let flagsRaw: [String] = flags.map { $0.rawValue }
                try container.encode(flagsRaw, forKey: .flags)
            }
            try container.encodeIfPresent(emoji, forKey: .emoji)
            try container.encodeIfPresent(channelId, forKey: .channelId)
            try container.encodeIfPresent(subChannelId, forKey: .subChannelId)
            try container.encodeIfPresent(otaBookingId, forKey: .otaBookingId)
            try container.encodeIfPresent(relatedReservationId, forKey: .relatedReservationId)
            try container.encodeIfPresent(guestIds, forKey: .guestIds)
        }
                

        enum CodingKeys: String, CodingKey {            
            case adultNumber = "adult_number"
            case extraAdultNumber = "extra_adult_number"            
            case contactName = "contact_fullname"
            case contactEmail = "contact_email"
            case contactTel = "contact_tel"
            case note
            case guestComment = "guest_comment"
            case flags
            case emoji
            case channelId = "channel_id"
            case subChannelId = "sub_channel_id"            
            case otaBookingId = "ota_booking_id"            
            case relatedReservationId = "related_reservation_id"
            case guestIds = "guest_ids"            
        }
        
    }
    
    // MARK: - Guest Management
    struct DropGuest: Encodable {
        let id: Int
        let guestId: Int
        
        enum CodingKeys: String, CodingKey {
            case guestId = "guest_id"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(guestId, forKey: .guestId)
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
    }
    
    struct AppendGuest: Encodable {
        let id: Int
        let guestId: Int
        
        enum CodingKeys: String, CodingKey {
            case guestId = "guest_id"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(guestId, forKey: .guestId)
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
    }
    
    struct ReplaceGuests: Encodable {
        let id: Int
        let guestIds: [Int]
        
        enum CodingKeys: String, CodingKey {
            case guestIds = "guest_ids"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(guestIds, forKey: .guestIds)
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
    }
    
    // MARK: - Additional Actions
    struct CreateConfirmation: Encodable {
        let id: Int
        let remark: String?
        
        enum CodingKeys: String, CodingKey {
            case remark
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(remark, forKey: .remark)
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
    }
    
    struct SplitReservation: Encodable {
        let id: Int
        let firstCheckOutDate: Date
        
        //encode
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(firstCheckOutDate.toDateString(FormConfig.DateFormat.yyyyMMdd), forKey: .splitDate)
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
        
        enum CodingKeys: String, CodingKey {
            case splitDate = "split_date"
        }
    }
    
    struct CreateReservationItem: Encodable {
        let reservableId: Int
        let reservableType: UnitReservableType
        let reservedDate: Date
        let totalPrice: Double
        let priceCardId: Int?
        let data: ItemData

        init(reservableId: Int,
            reservableType: UnitReservableType,
            reservedDate: Date,
            totalPrice: Double,
            priceCardId: Int?,            
            data: ItemData) {
            self.reservableId = reservableId
            self.reservableType = reservableType
            self.reservedDate = reservedDate
            self.totalPrice = totalPrice
            self.priceCardId = priceCardId
            self.data = data
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(reservableId, forKey: .reservableId)
            try container.encode(reservableType.rawValue, forKey: .reservableType)
            try container.encode(reservedDate.toDateString(FormConfig.DateFormat.yyyyMMdd), forKey: .reservedDate)
            try container.encode(totalPrice.toString(), forKey: .totalPrice)
            try container.encode(priceCardId, forKey: .priceCardId)
            try container.encode(data, forKey: .data)
        }
        
        enum CodingKeys: String, CodingKey {
            case reservableId = "reservable_id"
            case reservableType = "reservable_type"
            case reservedDate = "reserved_date"
            case totalPrice = "total_price"
            case priceCardId = "price_card_id"
            case data
        }
    }
    
    struct ItemData: Encodable {
        let isCustomRate: Bool
        let selectedRate: Double
        let extraAdultRate: Double
        let extraAdultQty: Int
        let extraChildRate: Double
        let extraChildQty: Int
        
        let mealIncluded: Bool
        let adultMealLimit: Int?
        let adultMealRate: Double?
        let childMealLimit: Int?
        let childMealRate: Double?
        
        let extraAdultMealRate: Double?
        let extraAdultMealQty: Int?
        let extraChildMealRate: Double?
        let extraChildMealQty: Int?
        
        init(isCustomRate: Bool,
             selectedRate: Double,
             extraAdultRate: Double,
             extraAdultQty: Int,
             extraChildRate: Double,
             extraChildQty: Int,
             mealIncluded: Bool,
             adultMealLimit: Int? = nil,
             adultMealRate: Double? = nil,
             childMealLimit: Int? = nil,
             childMealRate: Double? = nil,
             extraAdultMealRate: Double? = nil,
             extraAdultMealQty: Int? = nil,
             extraChildMealRate: Double? = nil,
             extraChildMealQty: Int? = nil) {
            self.isCustomRate = isCustomRate
            self.selectedRate = selectedRate
            self.extraAdultRate = extraAdultRate
            self.extraAdultQty = extraAdultQty
            self.extraChildRate = extraChildRate
            self.extraChildQty = extraChildQty
            self.mealIncluded = mealIncluded
            self.adultMealLimit = adultMealLimit
            self.adultMealRate = adultMealRate
            self.childMealLimit = childMealLimit
            self.childMealRate = childMealRate
            self.extraAdultMealRate = extraAdultMealRate
            self.extraAdultMealQty = extraAdultMealQty
            self.extraChildMealRate = extraChildMealRate
            self.extraChildMealQty = extraChildMealQty
        }
        
        // encode
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(isCustomRate, forKey: .isCustomRate)
            try container.encode(selectedRate.toString(), forKey: .selectedRate)
            try container.encode(extraAdultRate.toString(), forKey: .extraAdultRate)
            try container.encode(extraAdultQty, forKey: .extraAdultQty)
            try container.encode(extraChildRate.toString(), forKey: .extraChildRate)
            try container.encode(extraChildQty, forKey: .extraChildQty)
            try container.encode(mealIncluded, forKey: .mealIncluded)
            try container.encodeIfPresent(adultMealLimit, forKey: .adultMealLimit)
            try container.encodeIfPresent(adultMealRate?.toString(), forKey: .adultMealRate)
            try container.encodeIfPresent(childMealLimit, forKey: .childMealLimit)
            try container.encodeIfPresent(childMealRate?.toString(), forKey: .childMealRate)
            try container.encodeIfPresent(extraAdultMealRate?.toString(), forKey: .extraAdultMealRate)
            try container.encodeIfPresent(extraAdultMealQty, forKey: .extraAdultMealQty)
            try container.encodeIfPresent(extraChildMealRate?.toString(), forKey: .extraChildMealRate)
            try container.encodeIfPresent(extraChildMealQty, forKey: .extraChildMealQty)
        }
        
        enum CodingKeys: String, CodingKey {
            case date
            case isCustomRate = "is_custom_rate"
            case selectedRate = "price_card_rate"
            case extraAdultRate = "extra_person_rate"
            case extraAdultQty = "extra_person_number"
            case extraChildRate = "extra_bed_rate"
            case extraChildQty = "extra_bed_number"
            case mealIncluded = "meal_included"
            case adultMealLimit = "adult_meal_limit"
            case adultMealRate = "adult_meal_rate"
            case childMealLimit = "child_meal_limit"
            case childMealRate = "child_meal_rate"
            case extraAdultMealRate = "extra_adult_meal_rate"
            case extraAdultMealQty = "extra_adult_meal_number"
            case extraChildMealRate = "extra_child_meal_rate"
            case extraChildMealQty = "extra_child_meal_number"
        }
        
    }    
    
}
