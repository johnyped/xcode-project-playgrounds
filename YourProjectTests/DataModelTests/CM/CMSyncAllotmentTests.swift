//
//  CMSyncAllotmentTests.swift
//  YourProject
//
//  Created by IntrodexMini on 9/7/2568 BE.
//

import XCTest

final class CMSyncAllotmentTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let cmSyncAllotment = createSampleCMSyncAllotment()
        
        // Assert
        XCTAssertEqual(cmSyncAllotment.id, 13)
        XCTAssertEqual(cmSyncAllotment.status, .pending)
        XCTAssertEqual(cmSyncAllotment.startDate, "2025-07-09".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(cmSyncAllotment.endDate, "2026-07-09".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(cmSyncAllotment.hotelId, 105)
    }
    
    func test_initWithOptionalProperties() throws {
        // Arrange & Act
        let cmSyncAllotment = createSampleCMSyncAllotment()
        
        // Assert
        XCTAssertNil(cmSyncAllotment.result)
    }
    
    func test_initWithDates() throws {
        // Arrange & Act
        let cmSyncAllotment = createSampleCMSyncAllotment()
        
        // Assert
        XCTAssertNotNil(cmSyncAllotment.createdAt)
        XCTAssertNotNil(cmSyncAllotment.updatedAt)
    }
    
    // MARK: - Status Tests

    func test_statusRawValues() throws {
        XCTAssertEqual(CMSyncAllotment.Status.pending.rawValue, "PENDING")
        XCTAssertEqual(CMSyncAllotment.Status.done.rawValue, "DONE")
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 13,
            "status": "PENDING",
            "start_date": "2025-07-09",
            "end_date": "2026-07-09",
            "result": {},
            "created_at": "2025-07-09T16:22:03.296+07:00",
            "updated_at": "2025-07-09T16:22:03.296+07:00",
            "hotel_id": 105
        }
        """.data(using: .utf8)!
        
        // Act
        let cmSyncAllotment = try JSONDecoder().decode(CMSyncAllotment.self, from: json)
        
        // Assert
        XCTAssertEqual(cmSyncAllotment.id, 13)
        XCTAssertEqual(cmSyncAllotment.status, .pending)
        XCTAssertEqual(cmSyncAllotment.startDate.timeIntervalSince1970, "2025-07-09".toDate(FormConfig.DateFormat.yyyyMMdd)?.timeIntervalSince1970)
        XCTAssertEqual(cmSyncAllotment.endDate.timeIntervalSince1970, "2026-07-09".toDate(FormConfig.DateFormat.yyyyMMdd)?.timeIntervalSince1970)
        XCTAssertEqual(cmSyncAllotment.hotelId, 105)
        XCTAssertNil(cmSyncAllotment.result)
        XCTAssertNotNil(cmSyncAllotment.createdAt)
        XCTAssertNotNil(cmSyncAllotment.updatedAt)
        
        // Test date parsing
        let expectedCreatedAt = "2025-07-09T16:22:03.296+07:00".toDate(FormConfig.DateFormat.datetimeISO)
        let expectedUpdatedAt = "2025-07-09T16:22:03.296+07:00".toDate(FormConfig.DateFormat.datetimeISO)
        XCTAssertEqual(cmSyncAllotment.createdAt.timeIntervalSince1970, expectedCreatedAt!.timeIntervalSince1970, accuracy: 1.0)
        XCTAssertEqual(cmSyncAllotment.updatedAt.timeIntervalSince1970, expectedUpdatedAt!.timeIntervalSince1970, accuracy: 1.0)
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let cmSyncAllotment = createSampleCMSyncAllotment()
        
        // Act
        let data = try JSONEncoder().encode(cmSyncAllotment)
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
        let json = jsonObject as? [String: Any]
        
        // Assert
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["id"] as? Int, 13)
        XCTAssertEqual(json?["status"] as? String, "PENDING")
        XCTAssertEqual(json?["start_date"] as? String, "2025-07-09")
        XCTAssertEqual(json?["end_date"] as? String, "2026-07-09")
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertNotNil(json?["created_at"])
        XCTAssertNotNil(json?["updated_at"])
    }
    
    // MARK: - Helper Methods
    
    private func createSampleCMSyncAllotment() -> CMSyncAllotment {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = FormConfig.DateFormat.datetimeISO
        
        return CMSyncAllotment(
            id: 13,
            status: .pending,
            startDate: "2025-07-09".toDate(FormConfig.DateFormat.yyyyMMdd) ?? Date(),
            endDate: "2026-07-09".toDate(FormConfig.DateFormat.yyyyMMdd) ?? Date(),
            result: nil,
            hotelId: 105,
            createdAt: dateFormatter.date(from: "2025-07-09T16:22:03.296+07:00") ?? Date(),
            updatedAt: dateFormatter.date(from: "2025-07-09T16:22:03.296+07:00") ?? Date()
        )
    }
} 
