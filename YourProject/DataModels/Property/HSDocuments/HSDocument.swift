//
//  HSDocument.swift
//  YourProject
//
//  Created by IntrodexMini on 5/7/2568 BE.
//

import Foundation

struct HSDocument: Codable {
    let id: Int
    let hotelId: Int
    let filename: String
    let kind: Kind
    let documentableId: Int
    let documentableType: DocumentableType
    let downloadUrl: String
    let mimeType: String?
    let fileExtention: String?
    let tags: [Tag]
    let expiresAt: Date?
    let createdAt: Date
    let updatedAt: Date
    
    var downloadURL: URL? {
        URL(string: downloadUrl)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case hotelId = "hotel_id"
        case filename
        case kind
        case documentableId = "documentable_id"
        case documentableType = "documentable_type"
        case downloadUrl = "download_url"
        case mimeType = "mime_type"
        case extention
        case tags
        case expiresAt = "expires_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        filename = try container.decode(String.self, forKey: .filename)
        kind = try container.decode(Kind.self, forKey: .kind)
        documentableId = try container.decode(Int.self, forKey: .documentableId)
        documentableType = try container.decode(DocumentableType.self, forKey: .documentableType)
        downloadUrl = try container.decode(String.self, forKey: .downloadUrl)
        mimeType = try container.decodeIfPresent(String.self, forKey: .mimeType)
        fileExtention = try container.decodeIfPresent(String.self, forKey: .extention)
        tags = (try? container.decode([Tag].self, forKey: .tags)) ?? []
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        expiresAt = try container.decodeIfPresent(String.self, forKey: .expiresAt)?.tryToDate(dateFormat: dateFormat)
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
    }
    
    init(id: Int,
         hotelId: Int,
         filename: String,
         kind: Kind,
         documentableId: Int,
         documentableType: DocumentableType,
         downloadUrl: String,
         mimeType: String? = nil,
         extention: String? = nil,
         tags: [Tag] = [],
         expiresAt: Date? = nil,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.hotelId = hotelId
        self.filename = filename
        self.kind = kind
        self.documentableId = documentableId
        self.documentableType = documentableType
        self.downloadUrl = downloadUrl
        self.mimeType = mimeType
        self.fileExtention = extention
        self.tags = tags
        self.expiresAt = expiresAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(hotelId, forKey: .hotelId)
        try container.encode(filename, forKey: .filename)
        try container.encode(kind, forKey: .kind)
        try container.encode(documentableId, forKey: .documentableId)
        try container.encode(documentableType, forKey: .documentableType)
        try container.encode(downloadUrl, forKey: .downloadUrl)
        try container.encodeIfPresent(mimeType, forKey: .mimeType)
        try container.encodeIfPresent(fileExtention, forKey: .extention)
        try container.encode(tags, forKey: .tags)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        try container.encodeIfPresent(expiresAt?.toDateString(dateFormat), forKey: .expiresAt)
        try container.encode(createdAt.toDateString(dateFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat), forKey: .updatedAt)
    }
}

extension HSDocument {
    enum Kind: String, Codable {
        case receiptPdf = "RECEIPT_PDF"
        case tm30 = "TM_30_FORM"
        case revenueReport = "REVENUE_REPORT"
        case occupancyReport = "OCCUPANCY_REPORT"
        case logoImage = "LOGO_IMAGE"
        case coverImage = "COVER_IMAGE"
        case reservationImage = "RESERVATION_IMAGE"
        case customerImage = "CUSTOMER_IMAGE"
        case guestRegisterCardSignature = "GUEST_REGISTER_CARD_SIGNATURE"

        // decode from string
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self)
            guard let kind = Kind(rawValue: rawValue.uppercased()) else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid kind value: \(rawValue)")
            }
            self = kind
        }           
    }
    
    enum DocumentableType: String, Codable {
        case accountItem = "ACCOUNT_ITEM"
        case hotel = "HOTEL"
        case reservation = "RESERVATION"
        case guest = "GUEST"
        case financialRecord = "FINANCIAL_RECORD"
        case user = "USER"
        case company = "COMPANY"
        case guestRegisterCard = "GUEST_REGISTER_CARD"
    }
    
    enum Tag: String, Codable {
        case video = "VIDEO"
        case photo = "PHOTO"
        case file = "FILE"

        // decode from string
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self)
            guard let tag = Tag(rawValue: rawValue.uppercased()) else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid tag value: \(rawValue)")
            }
            self = tag
        }
    }
}
/*
 {
     "id": 3,
     "hotel_id": 55,
     "filename": "inv2019112200001.pdf",
     "kind": "RECEIPT_PDF",
     "documentable_id": 1,
     "documentable_type": "RECEIPT",
     "download_url": "https://hms-heroku.s3.ap-southeast-1.amazonaws.com/documents/43839dfe-5a55-43c1-a9b3-b650c0616987/inv2019112200001.pdf?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2I7XJ7WJNRHU7NRV%2F20250705%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250705T030311Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=c9eb4025904308b6bbee8ee7b4a271b9d2b8ce16ab8e6f572ae077dafc1c96de",
     "mime_type": null,
     "extention": null,
     "tags": [],
     "expires_at": null,
     "created_at": "2019-11-22T12:16:28.601+07:00",
     "updated_at": "2021-01-22T23:38:24.928+07:00"
 }
 */
