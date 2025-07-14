//
//  HotelShort.swift
//  YourProject
//
//  Created by IntrodexMini on 26/2/2568 BE.
//

import Foundation

struct HotelShort: Codable {
    let id: Int
    let status: Status
    let name: String
    let quote: String?
    let hotelLogo300: String?
    let headerLogoPhotos: [String]
    let bannerImage: String?
    let logoImage: String?
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case status
        case name
        case quote
        case hotelLogo300 = "hotel_logo_300"
        case headerLogoPhotos = "header_logo_photos"
        case bannerImage = "banner_image"
        case logoImage = "logo_image"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self,
                                  forKey: .id)
        status = try container.decode(Status.self,
                                      forKey: .status)
        name = try container.decode(String.self,
                                    forKey: .name)
        quote = try container.decodeIfPresent(String.self,
                                              forKey: .quote)
        hotelLogo300 = try container.decodeIfPresent(String.self,
                                                     forKey: .hotelLogo300)
        headerLogoPhotos = try container.decode([String].self,
                                                forKey: .headerLogoPhotos)
        bannerImage = try container.decodeIfPresent(String.self,
                                                    forKey: .bannerImage)
        logoImage = try container.decodeIfPresent(String.self,
                                                  forKey: .logoImage)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        createdAt = try container.decode(String.self,
                                         forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        updatedAt = try container.decode(String.self,
                                         forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
    }
    
    init(id: Int,
         status: Status,
         name: String,
         quote: String?,
         hotelLogo300: String?,
         headerLogoPhotos: [String],
         bannerImage: String?,
         logoImage: String?,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.status = status
        self.name = name
        self.quote = quote
        self.hotelLogo300 = hotelLogo300
        self.headerLogoPhotos = headerLogoPhotos
        self.bannerImage = bannerImage
        self.logoImage = logoImage
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id,
                             forKey: .id)
        try container.encode(status,
                             forKey: .status)
        try container.encode(name,
                             forKey: .name)
        try container.encodeIfPresent(quote,
                                      forKey: .quote)
        try container.encodeIfPresent(hotelLogo300,
                                      forKey: .hotelLogo300)
        try container.encode(headerLogoPhotos,
                             forKey: .headerLogoPhotos)
        try container.encodeIfPresent(bannerImage,
                                      forKey: .bannerImage)
        try container.encodeIfPresent(logoImage,
                                      forKey: .logoImage)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        try container.encode(createdAt.toDateString(dateFormat),
                             forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat),
                             forKey: .updatedAt)
    }
} 

extension HotelShort {
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
        "id": 107,
        "status": "CREATED",
        "name": "HMS2",
        "hotel_logo_300": null,
        "photos": [],
        "header_logo_photos": [],
        "quote": null,
        "logo_image": null,
        "banner_image": null,
        "created_at": "2021-11-13T16:23:50.637+07:00",
        "updated_at": "2021-11-13T16:23:50.637+07:00"
    }
    */
