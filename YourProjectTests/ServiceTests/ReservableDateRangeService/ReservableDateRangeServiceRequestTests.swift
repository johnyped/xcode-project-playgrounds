//
//  ReservableDateRangeServiceRequestTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 5/7/2568 BE.
//

import XCTest


final class ReservableDateRangeServiceRequestTests: XCTestCase {
    
    func test_fetchReservableDateRanges_WithBasicParameters_WillGenerateCorrectParameters() throws {
        // Arrange
        let hotelId = 123
        let checkInDate = Date(timeIntervalSince1970: 1719446400) // 2024-06-27
        let checkOutDate = Date(timeIntervalSince1970: 1719705600) // 2024-06-30
        let roomIds = [642, 643]
        
        let request = ReservableDateRangeServiceRequest.FetchReservableDateRanges(
            hotelId: hotelId,
            period: .init(start: checkInDate,
                          end: checkOutDate),            
            roomIds: roomIds
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, hotelId)
        XCTAssertEqual(parameters?["check_in_date"] as? String, "2024-06-27")
        XCTAssertEqual(parameters?["check_out_date"] as? String, "2024-06-30")
        XCTAssertEqual(parameters?["room_ids"] as? String, "642,643")
    }
    
    func test_fetchReservableDateRanges_WithPeriodDate_WillGenerateCorrectParameters() throws {
        // Arrange
        let hotelId = 456
        let startDate = Date(timeIntervalSince1970: 1719446400) // 2024-06-27
        let endDate = Date(timeIntervalSince1970: 1719705600) // 2024-06-30
        let period = PeriodDate(start: startDate, end: endDate)
        let roomIds = [101, 102, 103]
        
        let request = ReservableDateRangeServiceRequest.FetchReservableDateRanges(
            hotelId: hotelId,
            period: period,
            roomIds: roomIds
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, hotelId)
        XCTAssertEqual(parameters?["check_in_date"] as? String, "2024-06-27")
        XCTAssertEqual(parameters?["check_out_date"] as? String, "2024-06-30")
        XCTAssertEqual(parameters?["room_ids"] as? String, "101,102,103")
    }
    
    func test_fetchReservableDateRanges_WithoutRoomIds_WillGenerateCorrectParameters() throws {
        // Arrange
        let hotelId = 789
        let checkInDate = Date(timeIntervalSince1970: 1719446400) // 2024-06-27
        let checkOutDate = Date(timeIntervalSince1970: 1719705600) // 2024-06-30
        
        let request = ReservableDateRangeServiceRequest.FetchReservableDateRanges(
            hotelId: hotelId,
            period: .init(start: checkInDate,
                          end: checkOutDate),            
            roomIds: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, hotelId)
        XCTAssertEqual(parameters?["check_in_date"] as? String, "2024-06-27")
        XCTAssertEqual(parameters?["check_out_date"] as? String, "2024-06-30")
        XCTAssertNil(parameters?["room_ids"])
    }
    
    func test_fetchReservableDateRanges_WithEmptyRoomIds_WillGenerateCorrectParameters() throws {
        // Arrange
        let hotelId = 321
        let checkInDate = Date(timeIntervalSince1970: 1719446400) // 2024-06-27
        let checkOutDate = Date(timeIntervalSince1970: 1719705600) // 2024-06-30
        
        let request = ReservableDateRangeServiceRequest.FetchReservableDateRanges(
            hotelId: hotelId,
            period: .init(start: checkInDate,
                          end: checkOutDate),            
            roomIds: []
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, hotelId)
        XCTAssertEqual(parameters?["check_in_date"] as? String, "2024-06-27")
        XCTAssertEqual(parameters?["check_out_date"] as? String, "2024-06-30")
        XCTAssertNil(parameters?["room_ids"])
    }
    
    func test_fetchReservableDateRanges_WithSingleRoomId_WillGenerateCorrectParameters() throws {
        // Arrange
        let hotelId = 999
        let checkInDate = Date(timeIntervalSince1970: 1719446400) // 2024-06-27
        let checkOutDate = Date(timeIntervalSince1970: 1719705600) // 2024-06-30
        let roomIds = [555]
        
        let request = ReservableDateRangeServiceRequest.FetchReservableDateRanges(
            hotelId: hotelId,
            period: .init(start: checkInDate,
                          end: checkOutDate),            
            roomIds: roomIds
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, hotelId)
        XCTAssertEqual(parameters?["check_in_date"] as? String, "2024-06-27")
        XCTAssertEqual(parameters?["check_out_date"] as? String, "2024-06-30")
        XCTAssertEqual(parameters?["room_ids"] as? String, "555")
    }
    
    func test_fetchReservableDateRanges_DateFormatting_WillUseCorrectFormat() throws {
        // Arrange
        let hotelId = 100
        let checkInDate = Date(timeIntervalSince1970: 1609459200) // 2021-01-01
        let checkOutDate = Date(timeIntervalSince1970: 1609545600) // 2021-01-02
        
        let request = ReservableDateRangeServiceRequest.FetchReservableDateRanges(
            hotelId: hotelId,
            period: .init(start: checkInDate,
                          end: checkOutDate),            
            roomIds: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["check_in_date"] as? String, "2021-01-01")
        XCTAssertEqual(parameters?["check_out_date"] as? String, "2021-01-02")
    }
    
    func test_fetchReservableDateRanges_Encoding_WillEncodeCorrectly() throws {
        // Arrange
        let hotelId = 200
        let checkInDate = Date(timeIntervalSince1970: 1719446400) // 2024-06-27
        let checkOutDate = Date(timeIntervalSince1970: 1719705600) // 2024-06-30
        let roomIds = [1, 2, 3]
        
        let request = ReservableDateRangeServiceRequest.FetchReservableDateRanges(
            hotelId: hotelId,
            period: .init(start: checkInDate,
                          end: checkOutDate),            
            roomIds: roomIds
        )
        
        // Act
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, hotelId)
        XCTAssertEqual(json?["check_in_date"] as? String, "2024-06-27")
        XCTAssertEqual(json?["check_out_date"] as? String, "2024-06-30")
        XCTAssertEqual(json?["room_ids"] as? String, "1,2,3")
    }
} 
