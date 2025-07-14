//
//  HSDocumentTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 5/7/2568 BE.
//

import XCTest


final class HSDocumentTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let document = createSampleHSDocument()
        
        // Assert
        XCTAssertEqual(document.id, 3)
        XCTAssertEqual(document.hotelId, 55)
        XCTAssertEqual(document.filename, "inv2019112200001.pdf")
        XCTAssertEqual(document.kind, .receiptPdf)
        XCTAssertEqual(document.documentableId, 1)
        XCTAssertEqual(document.documentableType, .guest)
        XCTAssertEqual(document.downloadUrl, "https://hms-heroku.s3.ap-southeast-1.amazonaws.com/documents/43839dfe-5a55-43c1-a9b3-b650c0616987/inv2019112200001.pdf?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2I7XJ7WJNRHU7NRV%2F20250705%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250705T030311Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=c9eb4025904308b6bbee8ee7b4a271b9d2b8ce16ab8e6f572ae077dafc1c96de")
        XCTAssertNotNil(document.createdAt)
        XCTAssertNotNil(document.updatedAt)
        XCTAssertNotNil(document.downloadURL)
    }
    
    func test_initWithOptionalProperties() throws {
        // Arrange & Act
        let document = createSampleHSDocument()
        
        // Assert
        XCTAssertNil(document.mimeType)
        XCTAssertNil(document.fileExtention)
        XCTAssertNil(document.expiresAt)
        XCTAssertTrue(document.tags.isEmpty)
    }
    
    func test_initWithArrays() throws {
        // Arrange & Act
        let document = createSampleHSDocument()
        
        // Assert
        XCTAssertTrue(document.tags.isEmpty)
        XCTAssertEqual(document.tags.count, 0)
    }
    
    func test_initWithDates() throws {
        // Arrange & Act
        let document = createSampleHSDocument()
        
        // Assert
        XCTAssertNotNil(document.createdAt)
        XCTAssertNotNil(document.updatedAt)
        XCTAssertNil(document.expiresAt)
    }
    
    func test_initWithCustomValues() throws {
        // Arrange
        let customTags: [HSDocument.Tag] = [.video, .photo, .file]
        let customMimeType = "application/pdf"
        let customExtention = "pdf"
        let customExpiresAt = Date(timeIntervalSince1970: 1714857600)
        let customCreatedAt = Date(timeIntervalSince1970: 1714857600)
        let customUpdatedAt = Date(timeIntervalSince1970: 1714857600)
        
        // Act
        let document = HSDocument(
            id: 100,
            hotelId: 200,
            filename: "custom-document.pdf",
            kind: .receiptPdf,
            documentableId: 300,
            documentableType: .accountItem,
            downloadUrl: "https://example.com/document.pdf",
            mimeType: customMimeType,
            extention: customExtention,
            tags: customTags,
            expiresAt: customExpiresAt,
            createdAt: customCreatedAt,
            updatedAt: customUpdatedAt
        )
        
        // Assert
        XCTAssertEqual(document.id, 100)
        XCTAssertEqual(document.hotelId, 200)
        XCTAssertEqual(document.filename, "custom-document.pdf")
        XCTAssertEqual(document.kind, .receiptPdf)
        XCTAssertEqual(document.documentableId, 300)
        XCTAssertEqual(document.documentableType, .accountItem)
        XCTAssertEqual(document.downloadUrl, "https://example.com/document.pdf")
        XCTAssertEqual(document.mimeType, customMimeType)
        XCTAssertEqual(document.fileExtention, customExtention)
        XCTAssertEqual(document.tags, customTags)
        XCTAssertEqual(document.expiresAt, customExpiresAt)
        XCTAssertEqual(document.createdAt, customCreatedAt)
        XCTAssertEqual(document.updatedAt, customUpdatedAt)
        XCTAssertEqual(document.downloadURL, URL(string: "https://example.com/document.pdf"))
    }
    
    // MARK: - Computed Properties Tests
    
    func test_downloadURL() throws {
        // Arrange
        let document = HSDocument(
            id: 1,
            hotelId: 2,
            filename: "test.pdf",
            kind: .receiptPdf,
            documentableId: 3,
            documentableType: .hotel,
            downloadUrl: "https://example.com/test.pdf",
            createdAt: Date(),
            updatedAt: Date()
        )
        
        // Act & Assert
        XCTAssertEqual(document.downloadURL, URL(string: "https://example.com/test.pdf"))
    }
    
    func test_downloadURLWithInvalidURL() throws {
        // Arrange
        let document = HSDocument(
            id: 1,
            hotelId: 2,
            filename: "test.pdf",
            kind: .receiptPdf,
            documentableId: 3,
            documentableType: .hotel,
            downloadUrl: "invalid-url",
            createdAt: Date(),
            updatedAt: Date()
        )
        
        // Act & Assert
        XCTAssertNotNil(document.downloadURL)
    }
    
    // MARK: - Enum Tests
    
    func test_kindRawValues() throws {
        XCTAssertEqual(HSDocument.Kind.receiptPdf.rawValue, "RECEIPT_PDF")
        XCTAssertEqual(HSDocument.Kind.tm30.rawValue, "TM_30_FORM")
        XCTAssertEqual(HSDocument.Kind.revenueReport.rawValue, "REVENUE_REPORT")
        XCTAssertEqual(HSDocument.Kind.occupancyReport.rawValue, "OCCUPANCY_REPORT")
        XCTAssertEqual(HSDocument.Kind.logoImage.rawValue, "LOGO_IMAGE")
        XCTAssertEqual(HSDocument.Kind.coverImage.rawValue, "COVER_IMAGE")
        XCTAssertEqual(HSDocument.Kind.reservationImage.rawValue, "RESERVATION_IMAGE")
        XCTAssertEqual(HSDocument.Kind.customerImage.rawValue, "CUSTOMER_IMAGE")
        XCTAssertEqual(HSDocument.Kind.guestRegisterCardSignature.rawValue, "GUEST_REGISTER_CARD_SIGNATURE")
    }
    
    func test_documentableTypeRawValues() throws {
        XCTAssertEqual(HSDocument.DocumentableType.accountItem.rawValue, "ACCOUNT_ITEM")
        XCTAssertEqual(HSDocument.DocumentableType.hotel.rawValue, "HOTEL")
        XCTAssertEqual(HSDocument.DocumentableType.reservation.rawValue, "RESERVATION")
        XCTAssertEqual(HSDocument.DocumentableType.guest.rawValue, "GUEST")
        XCTAssertEqual(HSDocument.DocumentableType.financialRecord.rawValue, "FINANCIAL_RECORD")
        XCTAssertEqual(HSDocument.DocumentableType.user.rawValue, "USER")
        XCTAssertEqual(HSDocument.DocumentableType.company.rawValue, "COMPANY")
        XCTAssertEqual(HSDocument.DocumentableType.guestRegisterCard.rawValue, "GUEST_REGISTER_CARD")
    }
    
    func test_tagRawValues() throws {
        XCTAssertEqual(HSDocument.Tag.video.rawValue, "VIDEO")
        XCTAssertEqual(HSDocument.Tag.photo.rawValue, "PHOTO")
        XCTAssertEqual(HSDocument.Tag.file.rawValue, "FILE")
    }
    
    func test_kindEnumDecoding() throws {
        // Arrange
        let kindRawValue = "RECEIPT_PDF"
        let jsonData = """
        {
            "kind": "\(kindRawValue)"
        }
        """.data(using: .utf8)!
        
        // Act
        let decoded = try JSONDecoder().decode([String: HSDocument.Kind].self, from: jsonData)
        
        // Assert
        XCTAssertEqual(decoded["kind"], .receiptPdf)
    }
    
    func test_kindEnumDecodingCaseInsensitive() throws {
        // Arrange
        let kindRawValue = "receipt_pdf"
        let jsonData = """
        {
            "kind": "\(kindRawValue)"
        }
        """.data(using: .utf8)!
        
        // Act
        let decoded = try JSONDecoder().decode([String: HSDocument.Kind].self, from: jsonData)
        
        // Assert
        XCTAssertEqual(decoded["kind"], .receiptPdf)
    }
    
    func test_documentableTypeEnumDecoding() throws {
        // Arrange
        let documentableTypeRawValue = "ACCOUNT_ITEM"
        let jsonData = """
        {
            "documentable_type": "\(documentableTypeRawValue)"
        }
        """.data(using: .utf8)!
        
        // Act
        let decoded = try JSONDecoder().decode([String: HSDocument.DocumentableType].self, from: jsonData)
        
        // Assert
        XCTAssertEqual(decoded["documentable_type"], .accountItem)
    }
    
    func test_tagEnumDecoding() throws {
        // Arrange
        let tagRawValue = "VIDEO"
        let jsonData = """
        {
            "tag": "\(tagRawValue)"
        }
        """.data(using: .utf8)!
        
        // Act
        let decoded = try JSONDecoder().decode([String: HSDocument.Tag].self, from: jsonData)
        
        // Assert
        XCTAssertEqual(decoded["tag"], .video)
    }
    
    func test_tagEnumDecodingCaseInsensitive() throws {
        // Arrange
        let tagRawValue = "video"
        let jsonData = """
        {
            "tag": "\(tagRawValue)"
        }
        """.data(using: .utf8)!
        
        // Act
        let decoded = try JSONDecoder().decode([String: HSDocument.Tag].self, from: jsonData)
        
        // Assert
        XCTAssertEqual(decoded["tag"], .video)
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 3,
            "hotel_id": 55,
            "filename": "inv2019112200001.pdf",
            "kind": "RECEIPT_PDF",
            "documentable_id": 1,
            "documentable_type": "GUEST",
            "download_url": "https://hms-heroku.s3.ap-southeast-1.amazonaws.com/documents/43839dfe-5a55-43c1-a9b3-b650c0616987/inv2019112200001.pdf?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2I7XJ7WJNRHU7NRV%2F20250705%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250705T030311Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=c9eb4025904308b6bbee8ee7b4a271b9d2b8ce16ab8e6f572ae077dafc1c96de",
            "mime_type": null,
            "extention": null,
            "tags": [],
            "expires_at": null,
            "created_at": "2019-11-22T12:16:28.601+07:00",
            "updated_at": "2021-01-22T23:38:24.928+07:00"
        }
        """.data(using: .utf8)!
        
        // Act
        let document = try JSONDecoder().decode(HSDocument.self, from: json)
        
        // Assert
        XCTAssertEqual(document.id, 3)
        XCTAssertEqual(document.hotelId, 55)
        XCTAssertEqual(document.filename, "inv2019112200001.pdf")
        XCTAssertEqual(document.kind, .receiptPdf)
        XCTAssertEqual(document.documentableId, 1)
        XCTAssertEqual(document.documentableType, .guest)
        XCTAssertTrue(document.downloadUrl.contains("hms-heroku.s3.ap-southeast-1.amazonaws.com"))
        XCTAssertNil(document.mimeType)
        XCTAssertNil(document.fileExtention)
        XCTAssertTrue(document.tags.isEmpty)
        XCTAssertNil(document.expiresAt)
        XCTAssertNotNil(document.createdAt)
        XCTAssertNotNil(document.updatedAt)
        XCTAssertNotNil(document.downloadURL)
    }
    
    func test_decodingFromJSONWithOptionalValues() throws {
        // Arrange
        let json = """
        {
            "id": 4,
            "hotel_id": 56,
            "filename": "document.pdf",
            "kind": "RECEIPT_PDF",
            "documentable_id": 2,
            "documentable_type": "ACCOUNT_ITEM",
            "download_url": "https://example.com/document.pdf",
            "mime_type": "application/pdf",
            "extention": "pdf",
            "tags": ["VIDEO", "PHOTO"],
            "expires_at": "2025-12-31T23:59:59.999+07:00",
            "created_at": "2019-11-22T12:16:28.601+07:00",
            "updated_at": "2021-01-22T23:38:24.928+07:00"
        }
        """.data(using: .utf8)!
        
        // Act
        let document = try JSONDecoder().decode(HSDocument.self, from: json)
        
        // Assert
        XCTAssertEqual(document.id, 4)
        XCTAssertEqual(document.hotelId, 56)
        XCTAssertEqual(document.filename, "document.pdf")
        XCTAssertEqual(document.kind, .receiptPdf)
        XCTAssertEqual(document.documentableId, 2)
        XCTAssertEqual(document.documentableType, .accountItem)
        XCTAssertEqual(document.downloadUrl, "https://example.com/document.pdf")
        XCTAssertEqual(document.mimeType, "application/pdf")
        XCTAssertEqual(document.fileExtention, "pdf")
        XCTAssertEqual(document.tags, [.video, .photo])
        XCTAssertNotNil(document.expiresAt)
        XCTAssertNotNil(document.createdAt)
        XCTAssertNotNil(document.updatedAt)
    }
    
    func test_decodingWithMissingOptionalFields() throws {
        // Arrange
        let json = """
        {
            "id": 5,
            "hotel_id": 57,
            "filename": "minimal.pdf",
            "kind": "RECEIPT_PDF",
            "documentable_id": 3,
            "documentable_type": "HOTEL",
            "download_url": "https://example.com/minimal.pdf",
            "created_at": "2019-11-22T12:16:28.601+07:00",
            "updated_at": "2021-01-22T23:38:24.928+07:00"
        }
        """.data(using: .utf8)!
        
        // Act
        let document = try JSONDecoder().decode(HSDocument.self, from: json)
        
        // Assert
        XCTAssertEqual(document.id, 5)
        XCTAssertEqual(document.hotelId, 57)
        XCTAssertEqual(document.filename, "minimal.pdf")
        XCTAssertEqual(document.kind, .receiptPdf)
        XCTAssertEqual(document.documentableId, 3)
        XCTAssertEqual(document.documentableType, .hotel)
        XCTAssertEqual(document.downloadUrl, "https://example.com/minimal.pdf")
        XCTAssertNil(document.mimeType)
        XCTAssertNil(document.fileExtention)
        XCTAssertTrue(document.tags.isEmpty)
        XCTAssertNil(document.expiresAt)
        XCTAssertNotNil(document.createdAt)
        XCTAssertNotNil(document.updatedAt)
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let document = createSampleHSDocument()
        
        // Act
        let encoded = try JSONEncoder().encode(document)
        let decoded = try JSONDecoder().decode(HSDocument.self, from: encoded)
        
        // Assert
        XCTAssertEqual(decoded.id, document.id)
        XCTAssertEqual(decoded.hotelId, document.hotelId)
        XCTAssertEqual(decoded.filename, document.filename)
        XCTAssertEqual(decoded.kind, document.kind)
        XCTAssertEqual(decoded.documentableId, document.documentableId)
        XCTAssertEqual(decoded.documentableType, document.documentableType)
        XCTAssertEqual(decoded.downloadUrl, document.downloadUrl)
        XCTAssertEqual(decoded.mimeType, document.mimeType)
        XCTAssertEqual(decoded.fileExtention, document.fileExtention)
        XCTAssertEqual(decoded.tags, document.tags)
        XCTAssertEqual(decoded.expiresAt, document.expiresAt)
        XCTAssertEqual(decoded.createdAt.timeIntervalSince1970, document.createdAt.timeIntervalSince1970, accuracy: 1.0)
        XCTAssertEqual(decoded.updatedAt.timeIntervalSince1970, document.updatedAt.timeIntervalSince1970, accuracy: 1.0)
    }
    
    func test_encodingWithOptionalValues() throws {
        // Arrange
        let document = HSDocument(
            id: 10,
            hotelId: 20,
            filename: "test.pdf",
            kind: .receiptPdf,
            documentableId: 30,
            documentableType: .guest,
            downloadUrl: "https://example.com/test.pdf",
            mimeType: "application/pdf",
            extention: "pdf",
            tags: [.video, .photo],
            expiresAt: Date(timeIntervalSince1970: 1714857600),
            createdAt: Date(timeIntervalSince1970: 1714857600),
            updatedAt: Date(timeIntervalSince1970: 1714857600)
        )
        
        // Act
        let encoded = try JSONEncoder().encode(document)
        let decoded = try JSONDecoder().decode(HSDocument.self, from: encoded)
        
        // Assert
        XCTAssertEqual(decoded.id, document.id)
        XCTAssertEqual(decoded.hotelId, document.hotelId)
        XCTAssertEqual(decoded.filename, document.filename)
        XCTAssertEqual(decoded.kind, document.kind)
        XCTAssertEqual(decoded.documentableId, document.documentableId)
        XCTAssertEqual(decoded.documentableType, document.documentableType)
        XCTAssertEqual(decoded.downloadUrl, document.downloadUrl)
        XCTAssertEqual(decoded.mimeType, document.mimeType)
        XCTAssertEqual(decoded.fileExtention, document.fileExtention)
        XCTAssertEqual(decoded.tags, document.tags)
        XCTAssertNotNil(decoded.expiresAt)
        XCTAssertNotNil(decoded.createdAt)
        XCTAssertNotNil(decoded.updatedAt)
    }
    
    // MARK: - Edge Cases Tests
    
    func test_decodingWithEmptyTags() throws {
        // Arrange
        let json = """
        {
            "id": 6,
            "hotel_id": 58,
            "filename": "empty-tags.pdf",
            "kind": "RECEIPT_PDF",
            "documentable_id": 4,
            "documentable_type": "RESERVATION",
            "download_url": "https://example.com/empty-tags.pdf",
            "tags": [],
            "created_at": "2019-11-22T12:16:28.601+07:00",
            "updated_at": "2021-01-22T23:38:24.928+07:00"
        }
        """.data(using: .utf8)!
        
        // Act
        let document = try JSONDecoder().decode(HSDocument.self, from: json)
        
        // Assert
        XCTAssertTrue(document.tags.isEmpty)
        XCTAssertEqual(document.tags.count, 0)
    }
    
    func test_decodingWithNullValues() throws {
        // Arrange
        let json = """
        {
            "id": 7,
            "hotel_id": 59,
            "filename": "null-values.pdf",
            "kind": "RECEIPT_PDF",
            "documentable_id": 5,
            "documentable_type": "FINANCIAL_RECORD",
            "download_url": "https://example.com/null-values.pdf",
            "mime_type": null,
            "extention": null,
            "expires_at": null,
            "created_at": "2019-11-22T12:16:28.601+07:00",
            "updated_at": "2021-01-22T23:38:24.928+07:00"
        }
        """.data(using: .utf8)!
        
        // Act
        let document = try JSONDecoder().decode(HSDocument.self, from: json)
        
        // Assert
        XCTAssertNil(document.mimeType)
        XCTAssertNil(document.fileExtention)
        XCTAssertNil(document.expiresAt)
    }
    
    func test_decodingWithMixedCaseTags() throws {
        // Arrange
        let json = """
        {
            "id": 8,
            "hotel_id": 60,
            "filename": "mixed-case.pdf",
            "kind": "receipt_pdf",
            "documentable_id": 6,
            "documentable_type": "GUEST",
            "download_url": "https://example.com/mixed-case.pdf",
            "tags": ["video", "PHOTO", "File"],
            "created_at": "2019-11-22T12:16:28.601+07:00",
            "updated_at": "2021-01-22T23:38:24.928+07:00"
        }
        """.data(using: .utf8)!
        
        // Act
        let document = try JSONDecoder().decode(HSDocument.self, from: json)
        
        // Assert
        XCTAssertEqual(document.kind, .receiptPdf)
        XCTAssertEqual(document.documentableType, .guest)
        XCTAssertEqual(document.tags, [.video, .photo, .file])
    }
    
    // MARK: - Helper Methods
    
    private func createSampleHSDocument() -> HSDocument {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        return HSDocument(
            id: 3,
            hotelId: 55,
            filename: "inv2019112200001.pdf",
            kind: .receiptPdf,
            documentableId: 1,
            documentableType: .guest,
            downloadUrl: "https://hms-heroku.s3.ap-southeast-1.amazonaws.com/documents/43839dfe-5a55-43c1-a9b3-b650c0616987/inv2019112200001.pdf?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2I7XJ7WJNRHU7NRV%2F20250705%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250705T030311Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=c9eb4025904308b6bbee8ee7b4a271b9d2b8ce16ab8e6f572ae077dafc1c96de",
            mimeType: nil,
            extention: nil,
            tags: [],
            expiresAt: nil,
            createdAt: dateFormatter.date(from: "2019-11-22T12:16:28.601+07:00")!,
            updatedAt: dateFormatter.date(from: "2021-01-22T23:38:24.928+07:00")!
        )
    }
} 
