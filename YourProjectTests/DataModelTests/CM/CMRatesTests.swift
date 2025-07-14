//
//  CMRatesTests.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import XCTest
@testable import YourProject

final class CMRatesTests: XCTestCase {
    
    // MARK: - Collection Tests
    
    func test_emptyCollection() throws {
        // Arrange & Act
        let rates = CMRates()
        
        // Assert
        XCTAssertTrue(rates.lists.isEmpty)
        XCTAssertEqual(rates.count, 0)
    }
    
    func test_collectionWithItems() throws {
        // Arrange
        let rate1 = createSampleCMRate(id: 1, name: "Standard Rate")
        let rate2 = createSampleCMRate(id: 2, name: "Premium Rate")
        
        // Act
        let rates = CMRates(array: [rate1, rate2])
        
        // Assert
        XCTAssertFalse(rates.lists.isEmpty)
        XCTAssertEqual(rates.count, 2)
        XCTAssertEqual(rates.lists[0].id, 1)
        XCTAssertEqual(rates.lists[1].id, 2)
        XCTAssertEqual(rates.lists[0].name, "Standard Rate")
        XCTAssertEqual(rates.lists[1].name, "Premium Rate")
    }
    
    func test_collectionIteration() throws {
        // Arrange
        let rate1 = createSampleCMRate(id: 1, name: "Rate 1")
        let rate2 = createSampleCMRate(id: 2, name: "Rate 2")
        let rates = CMRates(array: [rate1, rate2])
        
        // Act
        var iteratedRates: [CMRate] = []
        for rate in rates.lists {
            iteratedRates.append(rate)
        }
        
        // Assert
        XCTAssertEqual(iteratedRates.count, 2)
        XCTAssertEqual(iteratedRates[0].id, 1)
        XCTAssertEqual(iteratedRates[1].id, 2)
    }
    
    func test_collectionWithDifferentRateTypes() throws {
        // Arrange
        let defaultRate = createSampleCMRate(id: 1, name: "Default", isDefault: true)
        let specialRate = createSampleCMRate(id: 2, name: "Special", isDefault: false)
        
        // Act
        let rates = CMRates(array: [defaultRate, specialRate])
        
        // Assert
        XCTAssertEqual(rates.count, 2)
        XCTAssertTrue(rates.lists[0].isDefault)
        XCTAssertFalse(rates.lists[1].isDefault)
        XCTAssertEqual(rates.lists[0].name, "Default")
        XCTAssertEqual(rates.lists[1].name, "Special")
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        [
                {
                    "id": 1,
                    "cm_room_id": 232711,
                    "rate_id": "rate123",
                    "offer_id": "offer456",
                    "name": "Standard Rate",
                    "description": "Standard room rate",
                    "min_nights": 1,
                    "max_nights": 30,
                    "min_advance": 0,
                    "max_advance": 365,
                    "strategy": 0,
                    "first_night": "2020-01-01",
                    "last_night": "2020-12-31",
                    "room_price": "100.0",
                    "room_price_enable": true,
                    "room_price_guests": "2.0",
                    "one_person_price": "80.0",
                    "one_person_price_enable": true,
                    "two_people_price": "100.0",
                    "two_people_price_enable": true,
                    "extra_person_price": "20.0",
                    "extra_person_price_enable": true,
                    "extra_child_price": "0.0",
                    "extra_child_price_enable": false,
                    "can_in_mon": true,
                    "can_in_tue": true,
                    "can_in_wed": true,
                    "can_in_thu": true,
                    "can_in_fri": true,
                    "can_in_sat": true,
                    "can_in_sun": true,
                    "channel": {
                        "channel000": 0,
                        "channel002": 0,
                        "channel012": 0,
                        "channel014": 0,
                        "channel017": 1,
                        "channel019": 0,
                        "channel023": 0,
                        "channel024": 0,
                        "channel027": 0,
                        "channel030": 0,
                        "channel031": 0,
                        "channel032": 0,
                        "channel033": 0,
                        "channel034": 0,
                        "channel035": 0,
                        "channel036": 0,
                        "channel042": 0,
                        "channel044": 0,
                        "channel046": 0,
                        "channel050": 0,
                        "channel051": 0,
                        "channel052": 0,
                        "channel053": 0,
                        "channel055": 0,
                        "channel056": 0,
                        "channel057": 0,
                        "channel059": 0,
                        "channel063": 0,
                        "channel064": 0,
                        "channel066": 0,
                        "channel072": 0,
                        "channel073": 0,
                        "channel076": 0,
                        "channel078": 0,
                        "channel083": 0,
                        "channel086": 0,
                        "channel087": 0,
                        "channel999": 0
                    },
                    "rate_code": {
                        "otaRateCode": "",
                        "ctripRateCode": "",
                        "hrsdeRateCode": "",
                        "odigeoRateCode": "",
                        "traviaRateCode": "",
                        "feratelRateCode": "",
                        "agodacomRateCode": "",
                        "bookingcomRateCode": "",
                        "expediacomRateCode": "",
                        "ostrovokruRateCode": "",
                        "tomastravelRateCode": "",
                        "hotelbedscomRateCode": "",
                        "lateroomscomRateCode": "",
                        "travelokacomRateCode": "",
                        "lastminutecomRateCode": "",
                        "hostelworldcomRateCode": "",
                        "travelocitycomRateCode": "",
                        "budgetplacescomRateCode": "",
                        "tablethotelscomRateCode": ""
                    },
                    "hms_unit_type": "ROOM_TYPE",
                    "hms_unit_id": 116,
                    "hotel_id": 105,
                    "is_default": true,
                    "code": null,
                    "color": null,
                    "created_at": "2020-01-01T00:00:00.000+07:00",
                    "updated_at": "2020-01-01T00:00:00.000+07:00"
                }
            ]
        """.data(using: .utf8)!
        
        // Act
        let rates = try JSONDecoder().decode(CMRates.self, from: json)
        
        // Assert
        XCTAssertEqual(rates.count, 1)
        XCTAssertEqual(rates.lists[0].id, 1)
        XCTAssertEqual(rates.lists[0].name, "Standard Rate")
        XCTAssertEqual(rates.lists[0].cmRoomId, 232711)
        XCTAssertEqual(rates.lists[0].cmRateId, "rate123")
        XCTAssertTrue(rates.lists[0].isDefault)
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let rate = createSampleCMRate(id: 1, name: "Test Rate")
        let rates = CMRates(array: [rate])
        
        // Act
        let encodedData = try JSONEncoder().encode(rates)
        let decodedRates = try JSONDecoder().decode(CMRates.self, from: encodedData)
        
        // Assert
        XCTAssertEqual(decodedRates.count, rates.count)
        XCTAssertEqual(decodedRates.lists[0].id, rates.lists[0].id)
        XCTAssertEqual(decodedRates.lists[0].name, rates.lists[0].name)
    }
    
    func test_emptyCollectionSerialization() throws {
        // Arrange
        let emptyRates = CMRates()
        
        // Act
        let encodedData = try JSONEncoder().encode(emptyRates)
        let decodedRates = try JSONDecoder().decode(CMRates.self, from: encodedData)
        
        // Assert
        XCTAssertTrue(decodedRates.lists.isEmpty)
        XCTAssertEqual(decodedRates.count, 0)
    }
    
    // MARK: - Helper Methods
    
    private func createSampleCMRate(id: Int, name: String, isDefault: Bool = true) -> CMRate {
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
            cmRateId: "rate\(id)",
            offerId: "offer\(id)",
            name: name,
            description: "\(name) description",
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
            isDefault: isDefault,
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
