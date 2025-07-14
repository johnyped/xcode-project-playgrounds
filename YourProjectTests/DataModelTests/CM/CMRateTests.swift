//
//  CMRateTests.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import XCTest

final class CMRateTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let rate = createSampleCMRate()
        
        // Assert
        XCTAssertEqual(rate.id, 1)
        XCTAssertEqual(rate.cmRoomId, 232711)
        XCTAssertEqual(rate.cmRateId, "rate123")
        XCTAssertEqual(rate.offerId, "offer456")
        XCTAssertEqual(rate.name, "Standard Rate")
        XCTAssertEqual(rate.description, "Standard room rate")
        XCTAssertEqual(rate.minNight, 1)
        XCTAssertEqual(rate.maxNight, 30)
        XCTAssertEqual(rate.minAdvance, 0)
        XCTAssertEqual(rate.maxAdvance, 365)
        XCTAssertEqual(rate.strategy, ._default)
        XCTAssertEqual(rate.roomPriceGuest, 2.0)
        XCTAssertEqual(rate.hmsUnitType, .roomType)
        XCTAssertEqual(rate.hmsUnitId, 116)
        XCTAssertEqual(rate.isDefault, true)
        XCTAssertEqual(rate.hotelId, 105)
    }
    
    func test_initWithDates() throws {
        // Arrange & Act
        let rate = createSampleCMRate()
        
        // Assert
        XCTAssertNotNil(rate.firstNight)
        XCTAssertNotNil(rate.lastNight)
        XCTAssertNotNil(rate.createdAt)
        XCTAssertNotNil(rate.updatedAt)
    }
    
    func test_initWithNestedStructs() throws {
        // Arrange & Act
        let rate = createSampleCMRate()
        
        // Assert
        XCTAssertEqual(rate.roomPrice.enable, true)
        XCTAssertEqual(rate.roomPrice.rate, 100.0)
        XCTAssertEqual(rate.onePersonPrice.enable, true)
        XCTAssertEqual(rate.onePersonPrice.rate, 80.0)
        XCTAssertEqual(rate.twoPersonPrice.enable, true)
        XCTAssertEqual(rate.twoPersonPrice.rate, 100.0)
        XCTAssertEqual(rate.extraPersonPrice.enable, true)
        XCTAssertEqual(rate.extraPersonPrice.rate, 20.0)
        XCTAssertEqual(rate.extraChildPrice.enable, false)
        XCTAssertEqual(rate.extraChildPrice.rate, 0.0)
    }
    
    func test_initWithDayOptions() throws {
        // Arrange & Act
        let rate = createSampleCMRate()
        
        // Assert
        XCTAssertEqual(rate.availableDay.mon, true)
        XCTAssertEqual(rate.availableDay.tue, true)
        XCTAssertEqual(rate.availableDay.wed, true)
        XCTAssertEqual(rate.availableDay.thu, true)
        XCTAssertEqual(rate.availableDay.fri, true)
        XCTAssertEqual(rate.availableDay.sat, true)
        XCTAssertEqual(rate.availableDay.sun, true)
    }
    
    func test_initWithChannels() throws {
        // Arrange & Act
        let rate = createSampleCMRate()
        
        // Assert
        XCTAssertNotNil(rate.channels)
        XCTAssertEqual(rate.channels.channel017, true) // Agoda
        XCTAssertEqual(rate.channels.channel019, false) // Booking.com
    }
    
    func test_initWithRateCodes() throws {
        // Arrange & Act
        let rate = createSampleCMRate()
        
        // Assert
        XCTAssertNotNil(rate.rateCode)
        XCTAssertEqual(rate.rateCode.agodaRateCode, "")
        XCTAssertEqual(rate.rateCode.bookingcomRateCode, "")
    }
    
    // MARK: - Strategy Tests
    
    func test_strategyRawValues() throws {
        XCTAssertEqual(CMRate.Strategy._default.rawValue, 0)
        XCTAssertEqual(CMRate.Strategy.doNotAllowLowerPricesOrShorterStays.rawValue, 1)
        XCTAssertEqual(CMRate.Strategy.doNotAllowAnyOtherRate.rawValue, 2)
    }
    
    func test_strategyValue() throws {
        XCTAssertEqual(CMRate.Strategy._default.value, 0)
        XCTAssertEqual(CMRate.Strategy.doNotAllowLowerPricesOrShorterStays.value, 1)
        XCTAssertEqual(CMRate.Strategy.doNotAllowAnyOtherRate.value, 2)
    }
    
    // MARK: - UnitType Tests
    
    func test_unitTypeRawValues() throws {
        XCTAssertEqual(CMRate.UnitType.roomType.rawValue, "ROOM_TYPE")
    }
    
    // MARK: - Property Tests
    
    func test_optionalPropertiesInitialization() throws {
        // Arrange & Act
        let rate = createSampleCMRate()
        
        // Assert
        XCTAssertNotNil(rate.id)
        XCTAssertNil(rate.code)
        XCTAssertNil(rate.color)
    }
    
    // MARK: - DayOption Tests
    
    func test_dayOptionInitialization() throws {
        // Arrange & Act
        let dayOption = CMRate.DayOption(
            mon: true,
            tue: true,
            wed: false,
            thu: true,
            fri: false,
            sat: true,
            sun: false
        )
        
        // Assert
        XCTAssertEqual(dayOption.mon, true)
        XCTAssertEqual(dayOption.tue, true)
        XCTAssertEqual(dayOption.wed, false)
        XCTAssertEqual(dayOption.thu, true)
        XCTAssertEqual(dayOption.fri, false)
        XCTAssertEqual(dayOption.sat, true)
        XCTAssertEqual(dayOption.sun, false)
    }
    
    func test_dayOptionAllTrue() throws {
        // Arrange & Act
        let dayOption = CMRate.DayOption(
            mon: true,
            tue: true,
            wed: true,
            thu: true,
            fri: true,
            sat: true,
            sun: true
        )
        
        // Assert
        XCTAssertTrue(dayOption.mon)
        XCTAssertTrue(dayOption.tue)
        XCTAssertTrue(dayOption.wed)
        XCTAssertTrue(dayOption.thu)
        XCTAssertTrue(dayOption.fri)
        XCTAssertTrue(dayOption.sat)
        XCTAssertTrue(dayOption.sun)
    }
    
    // MARK: - RateOption Tests
    
    func test_rateOptionInitialization() throws {
        // Arrange & Act
        let rateOption = CMRate.RateOption(enable: true, rate: 150.0)
        
        // Assert
        XCTAssertEqual(rateOption.enable, true)
        XCTAssertEqual(rateOption.rate, 150.0)
    }
    
    func test_rateOptionDisabled() throws {
        // Arrange & Act
        let rateOption = CMRate.RateOption(enable: false, rate: 0.0)
        
        // Assert
        XCTAssertEqual(rateOption.enable, false)
        XCTAssertEqual(rateOption.rate, 0.0)
    }
    
    // MARK: - Codable Tests
    
    func test_strategyDecodingFromJSON() throws {
        // Arrange
        let json = """
        0
        """.data(using: .utf8)!
        
        // Act
        let strategy = try JSONDecoder().decode(CMRate.Strategy.self, from: json)
        
        // Assert
        XCTAssertEqual(strategy, ._default)
    }
    
    func test_strategyEncodingToJSON() throws {
        // Arrange
        let strategy = CMRate.Strategy.doNotAllowLowerPricesOrShorterStays
        
        // Act
        let encodedData = try JSONEncoder().encode(strategy)
        let decodedStrategy = try JSONDecoder().decode(CMRate.Strategy.self, from: encodedData)
        
        // Assert
        XCTAssertEqual(decodedStrategy, strategy)
    }
    
    func test_unitTypeDecodingFromJSON() throws {
        // Arrange
        let json = """
        "ROOM_TYPE"
        """.data(using: .utf8)!
        
        // Act
        let unitType = try JSONDecoder().decode(CMRate.UnitType.self, from: json)
        
        // Assert
        XCTAssertEqual(unitType, .roomType)
    }
    
    
    // MARK: - Helper Methods
    
    private func createSampleCMRate(id: Int = 1, name: String = "Standard Rate") -> CMRate {
        let roomPrice = CMRate.RateOption(enable: true, rate: 100.0)
        let onePersonPrice = CMRate.RateOption(enable: true, rate: 80.0)
        let twoPersonPrice = CMRate.RateOption(enable: true, rate: 100.0)
        let extraPersonPrice = CMRate.RateOption(enable: true, rate: 20.0)
        let extraChildPrice = CMRate.RateOption(enable: false, rate: 0.0)
        
        let availableDay = CMRate.DayOption(
            mon: true,
            tue: true,
            wed: true,
            thu: true,
            fri: true,
            sat: true,
            sun: true
        )
        
        let channels = createSampleChannels()
        let rateCodes = createSampleRateCodes()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return CMRate(
            id: id,
            cmRoomId: 232711,
            cmRateId: "rate123",
            offerId: "offer456",
            name: name,
            description: "Standard room rate",
            minNight: 1,
            maxNight: 30,
            minAdvance: 0,
            maxAdvance: 365,
            strategy: ._default,
            firstNight: dateFormatter.date(from: "2020-01-01") ?? .now,
            lastNight: dateFormatter.date(from: "2020-12-31") ?? .now,
            roomPrice: roomPrice,
            roomPriceGuest: 2.0,
            onePersonPrice: onePersonPrice,
            twoPersonPrice: twoPersonPrice,
            extraPersonPrice: extraPersonPrice,
            extraChildPrice: extraChildPrice,
            availableDay: availableDay,
            channels: channels,
            rateCode: rateCodes,
            hmsUnitType: .roomType,
            hmsUnitId: 116,
            hotelId: 105,
            isDefault: true,
            code: nil,
            color: nil,
            createdAt: .now,
            updatedAt: .now
        )
    }
    
    private func createSampleChannels() -> CMRate.Channels {
        return CMRate.Channels(
            beds24: false,
            bookit: false,
            flipkey: false,
            expedia: false,
            agoda: true,
            booking: false,
            tablet: false,
            hostelworld: false,
            bedandbreakfastEU: false,
            vrbo: false,
            bedandbreakfastNL: false,
            atraveo: false,
            feratel: false,
            webRooms: false,
            lastminute: false,
            hotelbeds: false,
            ota: false,
            hostelInternational: false,
            airbnb: false,
            tomasTravel: false,
            ostrovok: false,
            bookeasy: false,
            trip: false,
            tripadvisorRentals: false,
            traveloka: false,
            hrs: false,
            despegar: false,
            vacationStay: false,
            hostelsclub: false,
            eDreams: false,
            jomres: false,
            goibibo: false,
            travia: false,
            homeToGo: false,
            traumFerienwohnungen: false,
            tiket: false,
            marriott: false,
            beds24Agents: false
        )
    }
    
    private func createSampleRateCodes() -> CMRate.RateCodes {
        return CMRate.RateCodes()
    }
} 
