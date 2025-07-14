//
//  Hotel.swift
//  YourProject
//
//  Created by IntrodexMini on 26/2/2568 BE.
//
import Foundation

struct Hotel: Codable {
    let id: Int
    let name: String
    let status: Status
    let information: String
    let address: String
    let geolocation: String?
    let phone: String?
    let policies: String?
    let email: String?
    let website: String?
    let workingTime: String?
    let checkInTime: String?
    let checkOutTime: String?
    let note: String?
    let hotelLogo300: String?
    let taxNumber: String?
    let photos: [String]
    let headerLogoPhotos: [String]
    let tags: [String]
    let quote: String?
    let termAndCondition: String?
    let latitude: String?
    let longitude: String?
    let logoImage: String?
    let bannerImage: String?
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id, name, status, information, address, geolocation, phone, policies, email, website
        case workingTime = "working_time"
        case checkInTime = "check_in_time"
        case checkOutTime = "check_out_time"
        case note
        case hotelLogo300 = "hotel_logo_300"
        case taxNumber = "tax_number"
        case photos, headerLogoPhotos = "header_logo_photos", tags, quote
        case termAndCondition = "term_and_condition"
        case latitude, longitude
        case logoImage = "logo_image"
        case bannerImage = "banner_image"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        status = try container.decode(Status.self, forKey: .status)
        information = try container.decode(String.self, forKey: .information)
        address = try container.decode(String.self, forKey: .address)
        geolocation = try container.decodeIfPresent(String.self, forKey: .geolocation)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        policies = try container.decodeIfPresent(String.self, forKey: .policies)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        website = try container.decodeIfPresent(String.self, forKey: .website)
        workingTime = try container.decodeIfPresent(String.self, forKey: .workingTime)
        checkInTime = try container.decodeIfPresent(String.self, forKey: .checkInTime)
        checkOutTime = try container.decodeIfPresent(String.self, forKey: .checkOutTime)
        note = try container.decodeIfPresent(String.self, forKey: .note)
        hotelLogo300 = try container.decodeIfPresent(String.self, forKey: .hotelLogo300)
        taxNumber = try container.decodeIfPresent(String.self, forKey: .taxNumber)
        photos = try container.decode([String].self, forKey: .photos)
        headerLogoPhotos = try container.decode([String].self, forKey: .headerLogoPhotos)
        tags = try container.decode([String].self, forKey: .tags)
        quote = try container.decodeIfPresent(String.self, forKey: .quote)
        termAndCondition = try container.decodeIfPresent(String.self, forKey: .termAndCondition)
        latitude = try container.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try container.decodeIfPresent(String.self, forKey: .longitude)
        logoImage = try container.decodeIfPresent(String.self, forKey: .logoImage)
        bannerImage = try container.decodeIfPresent(String.self, forKey: .bannerImage)
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
    }
    
    init(id: Int,
         name: String,
         status: Status,
         information: String,
         address: String,
         geolocation: String?,
         phone: String?,
         policies: String?,
         email: String?,
         website: String?,
         workingTime: String?,
         checkInTime: String?,
         checkOutTime: String?,
         note: String?,
         hotelLogo300: String?,
         taxNumber: String?,
         photos: [String],
         headerLogoPhotos: [String],
         tags: [String],
         quote: String?,
         termAndCondition: String?,
         latitude: String?,
         longitude: String?,
         logoImage: String?,
         bannerImage: String?,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.name = name
        self.status = status
        self.information = information
        self.address = address
        self.geolocation = geolocation
        self.phone = phone
        self.policies = policies
        self.email = email
        self.website = website
        self.workingTime = workingTime
        self.checkInTime = checkInTime
        self.checkOutTime = checkOutTime
        self.note = note
        self.hotelLogo300 = hotelLogo300
        self.taxNumber = taxNumber
        self.photos = photos
        self.headerLogoPhotos = headerLogoPhotos
        self.tags = tags
        self.quote = quote
        self.termAndCondition = termAndCondition
        self.latitude = latitude
        self.longitude = longitude
        self.logoImage = logoImage
        self.bannerImage = bannerImage
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(status, forKey: .status)
        try container.encode(information, forKey: .information)
        try container.encode(address, forKey: .address)
        try container.encodeIfPresent(geolocation, forKey: .geolocation)
        try container.encodeIfPresent(phone, forKey: .phone)
        try container.encodeIfPresent(policies, forKey: .policies)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(website, forKey: .website)
        try container.encodeIfPresent(workingTime, forKey: .workingTime)
        try container.encodeIfPresent(checkInTime, forKey: .checkInTime)
        try container.encodeIfPresent(checkOutTime, forKey: .checkOutTime)
        try container.encodeIfPresent(note, forKey: .note)
        try container.encodeIfPresent(hotelLogo300, forKey: .hotelLogo300)
        try container.encodeIfPresent(taxNumber, forKey: .taxNumber)
        try container.encode(photos, forKey: .photos)
        try container.encode(headerLogoPhotos, forKey: .headerLogoPhotos)
        try container.encode(tags, forKey: .tags)
        try container.encodeIfPresent(quote, forKey: .quote)
        try container.encodeIfPresent(termAndCondition, forKey: .termAndCondition)
        try container.encodeIfPresent(latitude, forKey: .latitude)
        try container.encodeIfPresent(longitude, forKey: .longitude)
        try container.encodeIfPresent(logoImage, forKey: .logoImage)
        try container.encodeIfPresent(bannerImage, forKey: .bannerImage)
        try container.encode(createdAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .updatedAt)
    }
}

extension Hotel {
    
    enum FilterBy {
        case id(id: Int)
        case name(name: String)
        case status(status: Status)
    }
    
    enum SortBy {
        case id
        case name
        case createdAt
        case updatedAt
    }
    
    enum Status: String, Codable {
        case created = "CREATED"
        case banned = "BANNED"        
        case blocked = "BLOCKED"
    }
}

/*
 {
 "id": 105,
 "name": "โอมเมดเสตย์",
 "status": "CREATED",
 "information": "dddddddd",
 "address": "127/4 ถ. สุขุมวิท แขวง พระโขนงเหนือ เขตวัฒนา กรุงเทพมหานคร 10110 ประเทศไทย",
 "geolocation": null,
 "phone": "0223232655",
 "policies": null,
 "email": "asdd@asd.com",
 "website": null,
 "working_time": "",
 "check_in_time": "1",
 "check_out_time": "2",
 "note": null,
 "hotel_logo_300": null,
 "tax_number": null,
 "photos": [],
 "header_logo_photos": [],
 "tags": [],
 "quote": "ฟกฟกไฟหกฟกหก",
 "term_and_condition": "344r///ำ  sdfdsf  ",
 "latitude": "13.706704797987564",
 "longitude": "100.60173992067575",
 "logo_image": "https://hms-heroku.s3.ap-southeast-1.amazonaws.com/documents/c3b43969-ac5b-4099-9351-6607cd778475/BFD53D03-8E67-491B-BCF7-45C3D0B8451C.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2I7XJ7WJNRHU7NRV%2F20250509%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250509T010227Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=aad33c5b285172985dd43619af1af64ad821a4f98a3206b12ed864b00b20b8c0",
 "banner_image": null,
 "created_at": "2019-11-19T17:08:46.877+07:00",
 "updated_at": "2024-05-11T06:13:49.864+07:00"
 }
 */
