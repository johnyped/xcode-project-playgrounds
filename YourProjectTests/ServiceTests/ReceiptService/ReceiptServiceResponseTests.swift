//
//  ReceiptServiceResponseTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest

class ReceiptServiceResponseTests: XCTestCase {
    
    // MARK: - PreviewEmail Tests
    
    func test_previewEmail_withValidJSON_correctDeserialization() throws {
        // Arrange
        let json = """
        {
            "preview_email_info": {
                "created_at": "2023-06-10T15:16:06.902+07:00",
                "url": "/receipts/preview-email?token=2q9JfKU09_RrDuK-Qx42jQ"
            }
        }
        """.data(using: .utf8)!
        
        // Act
        let previewEmail = try JSONDecoder().decode(ReceiptServiceResponse.PreviewEmail.self, from: json)
        
        // Assert
        XCTAssertNotNil(previewEmail.info)
        XCTAssertNotNil(previewEmail.info.createdAt)
        XCTAssertEqual(previewEmail.info.urlPath, "/receipts/preview-email?token=2q9JfKU09_RrDuK-Qx42jQ")
        XCTAssertNotNil(previewEmail.info.hostUrl)
    }
    
    func test_previewEmail_withMinimalJSON_correctDeserialization() throws {
        // Arrange
        let json = """
        {
            "preview_email_info": {
                "created_at": "2023-06-10T15:16:06.902+07:00"
            }
        }
        """.data(using: .utf8)!
        
        // Act
        let previewEmail = try JSONDecoder().decode(ReceiptServiceResponse.PreviewEmail.self, from: json)
        
        // Assert
        XCTAssertNotNil(previewEmail.info)
        XCTAssertNotNil(previewEmail.info.createdAt)
        XCTAssertNil(previewEmail.info.urlPath)
        XCTAssertNotNil(previewEmail.info.hostUrl)
    }
    
    func test_previewEmail_withInitializer_correctInitialization() {
        // Arrange
        let mockDate = Date()
        let previewUrl = PreviewUrl(hostUrl: "https://api.test.com", 
                                   createdAt: mockDate, 
                                   urlPath: "/test/path")
        
        // Act
        let previewEmail = ReceiptServiceResponse.PreviewEmail(info: previewUrl)
        
        // Assert
        XCTAssertEqual(previewEmail.info.hostUrl, "https://api.test.com")
        XCTAssertEqual(previewEmail.info.createdAt, mockDate)
        XCTAssertEqual(previewEmail.info.urlPath, "/test/path")
    }
    
    func test_previewEmail_withInvalidJSON_throwsError() {
        // Arrange
        let json = """
        {
            "preview_email_info": {
                "created_at": "invalid-date-format"
            }
        }
        """.data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(ReceiptServiceResponse.PreviewEmail.self, from: json))
    }
    
    func test_previewEmail_withMalformedJSON_throwsError() {
        // Arrange
        let json = """
        {
            "preview_email_info": {
                "created_at": "2023-06-10T15:16:06.902+07:00",
                "url": "/receipts/preview-email?token=2q9JfKU09_RrDuK-Qx42jQ"
            }
        """.data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(ReceiptServiceResponse.PreviewEmail.self, from: json))
    }
    
    func test_previewEmail_withEmptyJSON_throwsError() {
        // Arrange
        let json = "{}".data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(ReceiptServiceResponse.PreviewEmail.self, from: json))
    }
    
    // MARK: - PreviewPDF Tests
    
    func test_previewPDF_withValidJSON_correctDeserialization() throws {
        // Arrange
        let json = """
        {
            "preview_pdf_info": {
                "created_at": "2023-06-10T15:16:06.902+07:00",
                "url": "/receipts/preview-pdf?token=3r8KgLV10_SsDvL-Ry53kR"
            }
        }
        """.data(using: .utf8)!
        
        // Act
        let previewPDF = try JSONDecoder().decode(ReceiptServiceResponse.PreviewPDF.self, from: json)
        
        // Assert
        XCTAssertNotNil(previewPDF.info)
        XCTAssertNotNil(previewPDF.info.createdAt)
        XCTAssertEqual(previewPDF.info.urlPath, "/receipts/preview-pdf?token=3r8KgLV10_SsDvL-Ry53kR")
        XCTAssertNotNil(previewPDF.info.hostUrl)
    }
    
    func test_previewPDF_withMinimalJSON_correctDeserialization() throws {
        // Arrange
        let json = """
        {
            "preview_pdf_info": {
                "created_at": "2023-06-10T15:16:06.902+07:00"
            }
        }
        """.data(using: .utf8)!
        
        // Act
        let previewPDF = try JSONDecoder().decode(ReceiptServiceResponse.PreviewPDF.self, from: json)
        
        // Assert
        XCTAssertNotNil(previewPDF.info)
        XCTAssertNotNil(previewPDF.info.createdAt)
        XCTAssertNil(previewPDF.info.urlPath)
        XCTAssertNotNil(previewPDF.info.hostUrl)
    }
    
    func test_previewPDF_withInitializer_correctInitialization() {
        // Arrange
        let mockDate = Date()
        let previewUrl = PreviewUrl(hostUrl: "https://api.test.com", 
                                   createdAt: mockDate, 
                                   urlPath: "/test/pdf/path")
        
        // Act
        let previewPDF = ReceiptServiceResponse.PreviewPDF(info: previewUrl)
        
        // Assert
        XCTAssertEqual(previewPDF.info.hostUrl, "https://api.test.com")
        XCTAssertEqual(previewPDF.info.createdAt, mockDate)
        XCTAssertEqual(previewPDF.info.urlPath, "/test/pdf/path")
    }
    
    func test_previewPDF_withInvalidJSON_throwsError() {
        // Arrange
        let json = """
        {
            "preview_pdf_info": {
                "created_at": "invalid-date-format"
            }
        }
        """.data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(ReceiptServiceResponse.PreviewPDF.self, from: json))
    }
    
    func test_previewPDF_withMalformedJSON_throwsError() {
        // Arrange
        let json = """
        {
            "preview_pdf_info": {
                "created_at": "2023-06-10T15:16:06.902+07:00",
                "url": "/receipts/preview-pdf?token=3r8KgLV10_SsDvL-Ry53kR"
            }
        """.data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(ReceiptServiceResponse.PreviewPDF.self, from: json))
    }
    
    func test_previewPDF_withEmptyJSON_throwsError() {
        // Arrange
        let json = "{}".data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(ReceiptServiceResponse.PreviewPDF.self, from: json))
    }
    
    // MARK: - Edge Cases
    
    func test_previewEmail_withNullValues_handlesGracefully() throws {
        // Arrange
        let json = """
        {
            "preview_email_info": {
                "created_at": "2023-06-10T15:16:06.902+07:00",
                "url": null
            }
        }
        """.data(using: .utf8)!
        
        // Act
        let previewEmail = try JSONDecoder().decode(ReceiptServiceResponse.PreviewEmail.self, from: json)
        
        // Assert
        XCTAssertNotNil(previewEmail.info)
        XCTAssertNotNil(previewEmail.info.createdAt)
        XCTAssertNil(previewEmail.info.urlPath)
    }
    
    func test_previewPDF_withNullValues_handlesGracefully() throws {
        // Arrange
        let json = """
        {
            "preview_pdf_info": {
                "created_at": "2023-06-10T15:16:06.902+07:00",
                "url": null
            }
        }
        """.data(using: .utf8)!
        
        // Act
        let previewPDF = try JSONDecoder().decode(ReceiptServiceResponse.PreviewPDF.self, from: json)
        
        // Assert
        XCTAssertNotNil(previewPDF.info)
        XCTAssertNotNil(previewPDF.info.createdAt)
        XCTAssertNil(previewPDF.info.urlPath)
    }
    
    func test_previewEmail_withDifferentDateFormats_correctDeserialization() throws {
        // Arrange
        let json = """
        {
            "preview_email_info": {
                "created_at": "2023-12-25T10:30:45.123Z"
            }
        }
        """.data(using: .utf8)!
        
        // Act
        let previewEmail = try JSONDecoder().decode(ReceiptServiceResponse.PreviewEmail.self, from: json)
        
        // Assert
        XCTAssertNotNil(previewEmail.info)
        XCTAssertNotNil(previewEmail.info.createdAt)
    }
    
    func test_previewPDF_withDifferentDateFormats_correctDeserialization() throws {
        // Arrange
        let json = """
        {
            "preview_pdf_info": {
                "created_at": "2023-12-25T10:30:45.123Z"
            }
        }
        """.data(using: .utf8)!
        
        // Act
        let previewPDF = try JSONDecoder().decode(ReceiptServiceResponse.PreviewPDF.self, from: json)
        
        // Assert
        XCTAssertNotNil(previewPDF.info)
        XCTAssertNotNil(previewPDF.info.createdAt)
    }
} 