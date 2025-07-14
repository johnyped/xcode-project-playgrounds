//
//  StaffServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//
import Foundation


struct GuestServiceRequest {

    typealias HideGuest = ById
    typealias UnhideGuest = ById
    typealias RemoveGuestCompany = ById
    typealias FetchGuest = ById
    typealias DeleteGuest = ById
    
    struct ById {
        let id: Int
    }

    enum SortedBy: String {
        case id = "ID"
        case firstName = "FIRST_NAME"
        case lastName = "LAST_NAME"
        case createdAt = "CREATED_AT"
        case updatedAt = "UPDATED_AT"
    }

    struct FetchGuests: Encodable {
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        let hotelId: Int?
        let includeHidden: Bool?
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
        
        enum CodingKeys: String, CodingKey {
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
            case hotelId = "hotel_id"
            case includeHidden = "include_hidden"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
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
            try container.encodeIfPresent(hotelId, forKey: .hotelId)
            
            if let includeHidden {
                try container.encode(includeHidden, forKey: .includeHidden)
            }
        }
    }
    
    struct FetchGuestsQuery: Encodable {
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        let hotelId: Int?
        let q: String?
        let includeHidden: Bool?
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
        
        enum CodingKeys: String, CodingKey {
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
            case hotelId = "hotel_id"
            case q
            case includeHidden = "include_hidden"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
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
            try container.encodeIfPresent(hotelId, forKey: .hotelId)
            try container.encodeIfPresent(q, forKey: .q)
            
            if let includeHidden {
                try container.encode(includeHidden, forKey: .includeHidden)
            }
        }
    }
    
    struct FetchGuestsCompany: Encodable {
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        let hotelId: Int?
        let companyId: Int?
        let includeHidden: Bool?
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
        
        enum CodingKeys: String, CodingKey {
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
            case hotelId = "hotel_id"
            case companyId = "company_id"
            case includeHidden = "include_hidden"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
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
            try container.encodeIfPresent(hotelId, forKey: .hotelId)
            try container.encodeIfPresent(companyId, forKey: .companyId)
            
            if let includeHidden {
                try container.encode(includeHidden, forKey: .includeHidden)
            }
            
        }
    }
    
    struct FetchGuestsReservation: Encodable {
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        let hotelId: Int?
        let reservationId: Int?
        let includeHidden: Bool?
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
        
        enum CodingKeys: String, CodingKey {
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
            case hotelId = "hotel_id"
            case reservationId = "reservation_id"
            case includeHidden = "include_hidden"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
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
            try container.encodeIfPresent(hotelId, forKey: .hotelId)
            try container.encodeIfPresent(reservationId, forKey: .reservationId)
            
            if let includeHidden {
                try container.encode(includeHidden, forKey: .includeHidden)
            }
        }
    }
    
    struct FetchGuestsDatetimeOffset: Encodable {
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        let hotelId: Int?
        let datetimeOffset: String?
        let includeHidden: Bool?
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
        
        enum CodingKeys: String, CodingKey {
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
            case hotelId = "hotel_id"
            case datetimeOffset = "datetime_offset"
            case includeHidden = "include_hidden"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            if let page = page, page >= 1 {
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
            try container.encodeIfPresent(hotelId, forKey: .hotelId)
            try container.encodeIfPresent(datetimeOffset, forKey: .datetimeOffset)
            
            if let includeHidden {
                try container.encode(includeHidden, forKey: .includeHidden)
            }
        }
    }
    
    struct CreateGuest: Encodable {
        let firstName: String
        let lastName: String
        let nationality: String
        let country: String
        let reservationId: Int?
        let companyId: Int?
        let hotelId: Int
        let title: String?
        let middleName: String?
        let dateOfBirth: Date?
        let idCardNo: String?
        let passportNo: String?
        let gender: Guest.Gender?
        let email: String?
        let occupation: String?
        let phone: String?
        let address: String?
        let district: String?
        let province: String?
        let zipCode: String?
        let note: String?
        let nickname: String?
        let photos: [String]?
        let documentPhotos: [String]?

        var body: Data? {
            try? JSONEncoder().encode(self)
        }

        enum CodingKeys: String, CodingKey {
            case firstName = "first_name"
            case lastName = "last_name"
            case nationality
            case country
            case reservationId = "reservation_id"
            case companyId = "company_id"
            case hotelId = "hotel_id"
            case title
            case middleName = "middle_name"
            case dateOfBirth = "date_of_birth"
            case idCardNo = "id_card_no"
            case passportNo = "passport_no"
            case gender
            case email
            case occupation
            case phone
            case address
            case district
            case province
            case zipCode = "zip_code"
            case note
            case nickname
            case photos
            case documentPhotos = "document_photos"
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(firstName, forKey: .firstName)
            try container.encode(lastName, forKey: .lastName)
            try container.encode(nationality, forKey: .nationality)
            try container.encode(country, forKey: .country)
            try container.encodeIfPresent(reservationId, forKey: .reservationId)
            try container.encodeIfPresent(companyId, forKey: .companyId)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encodeIfPresent(title, forKey: .title)
            try container.encodeIfPresent(middleName, forKey: .middleName)
            try container.encodeIfPresent(dateOfBirth?.toDateString(FormConfig.DateFormat.yyyyMMdd), forKey: .dateOfBirth)
            try container.encodeIfPresent(idCardNo, forKey: .idCardNo)
            try container.encodeIfPresent(passportNo, forKey: .passportNo)
            try container.encodeIfPresent(gender?.rawValue, forKey: .gender)
            try container.encodeIfPresent(email, forKey: .email)
            try container.encodeIfPresent(occupation, forKey: .occupation)
            try container.encodeIfPresent(phone, forKey: .phone)
            try container.encodeIfPresent(address, forKey: .address)
            try container.encodeIfPresent(district, forKey: .district)
            try container.encodeIfPresent(province, forKey: .province)
            try container.encodeIfPresent(zipCode, forKey: .zipCode)
            try container.encodeIfPresent(note, forKey: .note)
            try container.encodeIfPresent(nickname, forKey: .nickname)
            try container.encodeIfPresent(photos, forKey: .photos)
            try container.encodeIfPresent(documentPhotos, forKey: .documentPhotos)
        }
    }
    
    struct UpdateGuest: Encodable {
        let id: Int
        let companyId: Int?
        let title: String?
        let firstName: String?
        let middleName: String?
        let lastName: String?
        let nationality: String?
        let country: String?
        let dateOfBirth: Date?
        let idCardNo: String?
        let passportNo: String?
        let gender: Guest.Gender?
        let email: String?
        let occupation: String?
        let phone: String?
        let address: String?
        let district: String?
        let province: String?
        let zipCode: String?
        let note: String?
        let nickname: String?
        let photos: [String]?
        let documentPhotos: [String]?
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        enum CodingKeys: String, CodingKey {
            case companyId = "company_id"
            case title
            case firstName = "first_name"
            case middleName = "middle_name"
            case lastName = "last_name"
            case nationality
            case country
            case dateOfBirth = "date_of_birth"
            case idCardNo = "id_card_no"
            case passportNo = "passport_no"
            case gender
            case email
            case occupation
            case phone
            case address
            case district
            case province
            case zipCode = "zip_code"
            case note
            case nickname
            case photos
            case documentPhotos = "document_photos"
            // id is not encoded as it's used in the URL path
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(companyId, forKey: .companyId)
            try container.encodeIfPresent(title, forKey: .title)
            try container.encodeIfPresent(firstName, forKey: .firstName)
            try container.encodeIfPresent(middleName, forKey: .middleName)
            try container.encodeIfPresent(lastName, forKey: .lastName)
            try container.encodeIfPresent(nationality, forKey: .nationality)
            try container.encodeIfPresent(country, forKey: .country)
            try container.encodeIfPresent(dateOfBirth?.toDateString(FormConfig.DateFormat.yyyyMMdd), forKey: .dateOfBirth)
            try container.encodeIfPresent(idCardNo, forKey: .idCardNo)
            try container.encodeIfPresent(passportNo, forKey: .passportNo)
            try container.encodeIfPresent(gender?.rawValue, forKey: .gender)
            try container.encodeIfPresent(email, forKey: .email)
            try container.encodeIfPresent(occupation, forKey: .occupation)
            try container.encodeIfPresent(phone, forKey: .phone)
            try container.encodeIfPresent(address, forKey: .address)
            try container.encodeIfPresent(district, forKey: .district)
            try container.encodeIfPresent(province, forKey: .province)
            try container.encodeIfPresent(zipCode, forKey: .zipCode)
            try container.encodeIfPresent(note, forKey: .note)
            try container.encodeIfPresent(nickname, forKey: .nickname)
            try container.encodeIfPresent(photos, forKey: .photos)
            try container.encodeIfPresent(documentPhotos, forKey: .documentPhotos)
        }
    }

} 
