//  ReservationLogServiceRequestTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 23/5/2568 BE.
//
import XCTest

final class ReservationLogServiceRequestTests: XCTestCase {
    
    // MARK: - FetchByReservation Tests
    
    func test_fetchByReservation_initWithRequiredProperties() throws {
        // Arrange & Act
        let request = ReservationLogServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 1092            
        )
        
        // Assert
        XCTAssertEqual(request.hotelId, 105)
        XCTAssertEqual(request.reservationId, 1092)
    }       
    
    func test_fetchByReservation_parameters() throws {
        // Arrange
        let request = ReservationLogServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 1092            
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["reservation_id"] as? Int, 1092)
    }
        
    // MARK: - Helper Methods
    
    private func createDate(year: Int, month: Int, day: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.timeZone = TimeZone(secondsFromGMT: 0)
        return Calendar.current.date(from: components) ?? Date()
    }
    
    private func createDateTime(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.timeZone = TimeZone(secondsFromGMT: 0)
        return Calendar.current.date(from: components) ?? Date()
    }
} 