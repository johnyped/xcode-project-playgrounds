//
//  FolioFormServiceResponseTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest

class FolioFormServiceResponseTests: XCTestCase {
    
    // MARK: - PreviewEmail Tests
    
    func test_previewEmail_withValidJSON_correctDeserialization() throws {
        // Arrange
        let json = """
        {
            "preview_email_info": {
                "created_at": "2023-06-10T15:16:06.902+07:00",
                "url": "/folio_forms/preview-email?token=2q9JfKU09_RrDuK-Qx42jQ"
            }
        }
        """.data(using: .utf8)!
        
        // Act
        let previewEmail = try JSONDecoder().decode(FolioFormServiceResponse.PreviewEmail.self, from: json)
        
        // Assert
        XCTAssertNotNil(previewEmail.info)
        XCTAssertEqual(previewEmail.info.urlPath, "/folio_forms/preview-email?token=2q9JfKU09_RrDuK-Qx42jQ")
        XCTAssertNotNil(previewEmail.info.URL)
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
        let previewEmail = try JSONDecoder().decode(FolioFormServiceResponse.PreviewEmail.self, from: json)
        
        // Assert
        XCTAssertNotNil(previewEmail.info)
        XCTAssertNil(previewEmail.info.urlPath)
        XCTAssertNil(previewEmail.info.URL)
    }
    
    func test_previewEmail_withInitializer_correctInitialization() throws {
        // Arrange
        let mockDate = Date()
        let mockPreviewUrl = PreviewUrl(
            hostUrl: "https://test.com",
            createdAt: mockDate,
            urlPath: "/test/path"
        )
        
        // Act
        let previewEmail = FolioFormServiceResponse.PreviewEmail(info: mockPreviewUrl)
        
        // Assert
        XCTAssertEqual(previewEmail.info.hostUrl, "https://test.com")
        XCTAssertEqual(previewEmail.info.createdAt, mockDate)
        XCTAssertEqual(previewEmail.info.urlPath, "/test/path")
    }
    
    func test_previewEmail_withInvalidJSON_throwsError() throws {
        // Arrange
        let json = """
        {
            "preview_email_info": {
                "invalid_field": "invalid_value"
            }
        }
        """.data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(FolioFormServiceResponse.PreviewEmail.self, from: json))
    }
    
    // MARK: - PreviewPDF Tests
    
    func test_previewPDF_withValidJSON_correctDeserialization() throws {
        // Arrange
        let json = """
        {
            "preview_pdf_info": {
                "created_at": "2023-06-10T15:16:06.902+07:00",
                "url": "/folio_forms/preview-pdf?token=3r8KgLV10_SsDvL-Ry53kR"
            }
        }
        """.data(using: .utf8)!
        
        // Act
        let previewPDF = try JSONDecoder().decode(FolioFormServiceResponse.PreviewPDF.self, from: json)
        
        // Assert
        XCTAssertNotNil(previewPDF.info)
        XCTAssertEqual(previewPDF.info.urlPath, "/folio_forms/preview-pdf?token=3r8KgLV10_SsDvL-Ry53kR")
        XCTAssertNotNil(previewPDF.info.URL)
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
        let previewPDF = try JSONDecoder().decode(FolioFormServiceResponse.PreviewPDF.self, from: json)
        
        // Assert
        XCTAssertNotNil(previewPDF.info)
        XCTAssertNil(previewPDF.info.urlPath)
        XCTAssertNil(previewPDF.info.URL)
    }
    
    func test_previewPDF_withInitializer_correctInitialization() throws {
        // Arrange
        let mockDate = Date()
        let mockPreviewUrl = PreviewUrl(
            hostUrl: "https://test.com",
            createdAt: mockDate,
            urlPath: "/test/pdf/path"
        )
        
        // Act
        let previewPDF = FolioFormServiceResponse.PreviewPDF(info: mockPreviewUrl)
        
        // Assert
        XCTAssertEqual(previewPDF.info.hostUrl, "https://test.com")
        XCTAssertEqual(previewPDF.info.createdAt, mockDate)
        XCTAssertEqual(previewPDF.info.urlPath, "/test/pdf/path")
    }
    
    func test_previewPDF_withInvalidJSON_throwsError() throws {
        // Arrange
        let json = """
        {
            "preview_pdf_info": {
                "invalid_field": "invalid_value"
            }
        }
        """.data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(FolioFormServiceResponse.PreviewPDF.self, from: json))
    }
    
    // MARK: - Edge Cases Tests
    
    func test_previewEmail_withEmptyJSON_throwsError() throws {
        // Arrange
        let json = "{}".data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(FolioFormServiceResponse.PreviewEmail.self, from: json))
    }
    
    func test_previewPDF_withEmptyJSON_throwsError() throws {
        // Arrange
        let json = "{}".data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(FolioFormServiceResponse.PreviewPDF.self, from: json))
    }
    
    func test_previewEmail_withMalformedJSON_throwsError() throws {
        // Arrange
        let json = "{ invalid json }".data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(FolioFormServiceResponse.PreviewEmail.self, from: json))
    }
    
    func test_previewPDF_withMalformedJSON_throwsError() throws {
        // Arrange
        let json = "{ invalid json }".data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(FolioFormServiceResponse.PreviewPDF.self, from: json))
    }
} 