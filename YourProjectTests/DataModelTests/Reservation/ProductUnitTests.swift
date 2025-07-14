//
//  ProductUnitTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 18/6/2568 BE.
//

import XCTest

final class ProductUnitTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let productUnit = createSampleProductUnit()
        
        // Assert
        XCTAssertEqual(productUnit.id, 1)
        XCTAssertEqual(productUnit.hotelId, 105)
        XCTAssertEqual(productUnit.unit, "pc")
        XCTAssertEqual(productUnit.kind, .product)
        XCTAssertNotNil(productUnit.createdAt)
        XCTAssertNotNil(productUnit.updatedAt)
    }
    
    func test_initWithServiceKind() throws {
        // Arrange
        let id = 2
        let hotelId = 105
        let unit = "hour"
        let kind = ProductUnit.Kind.service
        let createdAt = Date()
        let updatedAt = Date()
        
        // Act
        let productUnit = ProductUnit(
            id: id,
            unit: unit,
            kind: kind,
            hotelId: hotelId,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
        
        // Assert
        XCTAssertEqual(productUnit.id, id)
        XCTAssertEqual(productUnit.hotelId, hotelId)
        XCTAssertEqual(productUnit.unit, unit)
        XCTAssertEqual(productUnit.kind, kind)
        XCTAssertEqual(productUnit.createdAt, createdAt)
        XCTAssertEqual(productUnit.updatedAt, updatedAt)
    }
    
    func test_initWithProductKind() throws {
        // Arrange
        let id = 3
        let hotelId = 105
        let unit = "kg"
        let kind = ProductUnit.Kind.product
        let createdAt = Date()
        let updatedAt = Date()
        
        // Act
        let productUnit = ProductUnit(
            id: id,
            unit: unit,
            kind: kind,
            hotelId: hotelId,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
        
        // Assert
        XCTAssertEqual(productUnit.id, id)
        XCTAssertEqual(productUnit.hotelId, hotelId)
        XCTAssertEqual(productUnit.unit, unit)
        XCTAssertEqual(productUnit.kind, kind)
        XCTAssertEqual(productUnit.createdAt, createdAt)
        XCTAssertEqual(productUnit.updatedAt, updatedAt)
    }
    
    // MARK: - Kind Tests
    
    func test_kindRawValues() throws {
        XCTAssertEqual(ProductUnit.Kind.product.rawValue, "PRODUCT")
        XCTAssertEqual(ProductUnit.Kind.service.rawValue, "SERVICE")
    }
    
    func test_kindCodable() throws {
        // Test encoding
        let productKind = ProductUnit.Kind.product
        let serviceKind = ProductUnit.Kind.service
        
        let productData = try JSONEncoder().encode(productKind)
        let serviceData = try JSONEncoder().encode(serviceKind)
        
        let productString = String(data: productData, encoding: .utf8)
        let serviceString = String(data: serviceData, encoding: .utf8)
        
        XCTAssertEqual(productString, "\"PRODUCT\"")
        XCTAssertEqual(serviceString, "\"SERVICE\"")
        
        // Test decoding
        let decodedProduct = try JSONDecoder().decode(ProductUnit.Kind.self, from: productData)
        let decodedService = try JSONDecoder().decode(ProductUnit.Kind.self, from: serviceData)
        
        XCTAssertEqual(decodedProduct, .product)
        XCTAssertEqual(decodedService, .service)
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 1,
            "unit": "pc",
            "kind": "PRODUCT",
            "created_at": "2025-06-18T13:36:40.901+07:00",
            "updated_at": "2025-06-18T13:36:40.901+07:00",
            "hotel_id": 105
        }
        """.data(using: .utf8)!
        
        // Act
        let productUnit = try JSONDecoder().decode(ProductUnit.self, from: json)
        
        // Assert
        XCTAssertEqual(productUnit.id, 1)
        XCTAssertEqual(productUnit.unit, "pc")
        XCTAssertEqual(productUnit.kind, .product)
        XCTAssertEqual(productUnit.hotelId, 105)
        XCTAssertNotNil(productUnit.createdAt)
        XCTAssertNotNil(productUnit.updatedAt)
    }
    
    func test_decodingFromJSONWithServiceKind() throws {
        // Arrange
        let json = """
        {
            "id": 2,
            "unit": "hour",
            "kind": "SERVICE",
            "created_at": "2025-06-18T14:30:15.123+07:00",
            "updated_at": "2025-06-18T14:30:15.123+07:00",
            "hotel_id": 106
        }
        """.data(using: .utf8)!
        
        // Act
        let productUnit = try JSONDecoder().decode(ProductUnit.self, from: json)
        
        // Assert
        XCTAssertEqual(productUnit.id, 2)
        XCTAssertEqual(productUnit.unit, "hour")
        XCTAssertEqual(productUnit.kind, .service)
        XCTAssertEqual(productUnit.hotelId, 106)
        XCTAssertNotNil(productUnit.createdAt)
        XCTAssertNotNil(productUnit.updatedAt)
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let sampleDate = dateFormatter.date(from: "2025-06-18T13:36:40.901+07:00")!
        
        let productUnit = ProductUnit(
            id: 1,
            unit: "pc",
            kind: .product,
            hotelId: 105,
            createdAt: sampleDate,
            updatedAt: sampleDate
        )
        
        // Act
        let jsonData = try JSONEncoder().encode(productUnit)
        let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["id"] as? Int, 1)
        XCTAssertEqual(json?["unit"] as? String, "pc")
        XCTAssertEqual(json?["kind"] as? String, "PRODUCT")
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertNotNil(json?["created_at"])
        XCTAssertNotNil(json?["updated_at"])
    }
    
    func test_encodingToJSONWithServiceKind() throws {
        // Arrange
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let sampleDate = dateFormatter.date(from: "2025-06-18T14:30:15.123+07:00")!
        
        let productUnit = ProductUnit(
            id: 2,
            unit: "hour",
            kind: .service,
            hotelId: 106,
            createdAt: sampleDate,
            updatedAt: sampleDate
        )
        
        // Act
        let jsonData = try JSONEncoder().encode(productUnit)
        let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["id"] as? Int, 2)
        XCTAssertEqual(json?["unit"] as? String, "hour")
        XCTAssertEqual(json?["kind"] as? String, "SERVICE")
        XCTAssertEqual(json?["hotel_id"] as? Int, 106)
        XCTAssertNotNil(json?["created_at"])
        XCTAssertNotNil(json?["updated_at"])
    }
    
    // MARK: - Edge Cases Tests
    
    func test_decodingWithDifferentUnits() throws {
        let units = ["pc", "kg", "liter", "hour", "day", "meter"]
        
        for unit in units {
            let json = """
            {
                "id": 1,
                "unit": "\(unit)",
                "kind": "PRODUCT",
                "created_at": "2025-06-18T13:36:40.901+07:00",
                "updated_at": "2025-06-18T13:36:40.901+07:00",
                "hotel_id": 105
            }
            """.data(using: .utf8)!
            
            let productUnit = try JSONDecoder().decode(ProductUnit.self, from: json)
            XCTAssertEqual(productUnit.unit, unit)
        }
    }
    
    func test_decodingWithDifferentHotelIds() throws {
        let hotelIds = [105, 106, 107, 999]
        
        for hotelId in hotelIds {
            let json = """
            {
                "id": 1,
                "unit": "pc",
                "kind": "PRODUCT",
                "created_at": "2025-06-18T13:36:40.901+07:00",
                "updated_at": "2025-06-18T13:36:40.901+07:00",
                "hotel_id": \(hotelId)
            }
            """.data(using: .utf8)!
            
            let productUnit = try JSONDecoder().decode(ProductUnit.self, from: json)
            XCTAssertEqual(productUnit.hotelId, hotelId)
        }
    }
    
    // MARK: - Helper Methods
    
    private func createSampleProductUnit() -> ProductUnit {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        return ProductUnit(
            id: 1,
            unit: "pc",
            kind: .product,
            hotelId: 105,
            createdAt: dateFormatter.date(from: "2025-06-18T13:36:40.901+07:00")!,
            updatedAt: dateFormatter.date(from: "2025-06-18T13:36:40.901+07:00")!
        )
    }
    
    private func createSampleServiceProductUnit() -> ProductUnit {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        return ProductUnit(
            id: 2,
            unit: "hour",
            kind: .service,
            hotelId: 105,
            createdAt: dateFormatter.date(from: "2025-06-18T14:30:15.123+07:00")!,
            updatedAt: dateFormatter.date(from: "2025-06-18T14:30:15.123+07:00")!
        )
    }
} 
