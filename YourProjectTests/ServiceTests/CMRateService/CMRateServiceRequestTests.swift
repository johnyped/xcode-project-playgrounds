//
//  CMRateServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//

import XCTest

final class CMRateServiceRequestTests: XCTestCase {
    
    func testFetchByPeriodRequest() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1714129200) // 2025-04-26
        let endDate = Date(timeIntervalSince1970: 1714215600) // 2025-04-27
        
        // When
        let request = CMRateServiceRequest.FetchByPeriod(
            hotelId: 105,
            startDate: startDate,
            endDate: endDate,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // Then
        XCTAssertEqual(request.hotelId, 105)
        XCTAssertEqual(request.startDate, startDate)
        XCTAssertEqual(request.endDate, endDate)
        XCTAssertEqual(request.page, 1)
        XCTAssertEqual(request.perPage, .twenty)
        XCTAssertEqual(request.sortedBy, .id)
        XCTAssertEqual(request.sortedOrder, .ascending)
    }
    
    func testFetchByHotelRequest() throws {
        // Given/When
        let request = CMRateServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // Then
        XCTAssertEqual(request.hotelId, 105)
        XCTAssertEqual(request.page, 1)
        XCTAssertEqual(request.perPage, .twenty)
        XCTAssertEqual(request.sortedBy, .id)
        XCTAssertEqual(request.sortedOrder, .ascending)
    }
    
    func testFetchByRoomTypeRequest() throws {
        // Given/When
        let request = CMRateServiceRequest.FetchByRoomType(
            hotelId: 105,
            roomTypeId: 179,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // Then
        XCTAssertEqual(request.hotelId, 105)
        XCTAssertEqual(request.roomTypeId, 179)
        XCTAssertEqual(request.page, 1)
        XCTAssertEqual(request.perPage, .twenty)
        XCTAssertEqual(request.sortedBy, .id)
        XCTAssertEqual(request.sortedOrder, .ascending)
    }
    
    func testFetchByIdRequest() throws {
        // Given/When
        let request = CMRateServiceRequest.FetchById(id: 40)
        
        // Then
        XCTAssertEqual(request.id, 40)
    }
    
    func testCreateCMRateRequest() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1714129200)
        let endDate = Date(timeIntervalSince1970: 1714215600)
        
        // When
        let channels = CMRate.Channels(
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
        let request = CMRateServiceRequest.CreateCMRate(
            cmRoomId: 1,
            cmRateId: "NEW_RATE_001",
            offerId: "1",
            name: "New Test Rate",
            description: "Test rate description",
            minNight: 1,
            maxNight: 30,
            minAdvance: 0,
            maxAdvance: 365,
            strategy: ._default,
            firstNight: startDate,
            lastNight: endDate,
            roomPrice: CMRate.RateOption(enable: true, rate: 500.0),
            roomPriceGuest: 0.0,
            onePersonPrice: CMRate.RateOption(enable: false, rate: 0.0),
            twoPersonPrice: CMRate.RateOption(enable: false, rate: 0.0),
            extraPersonPrice: CMRate.RateOption(enable: false, rate: 0.0),
            extraChildPrice: CMRate.RateOption(enable: false, rate: 0.0),
            availableDay: CMRate.DayOption(mon: true, tue: true, wed: true, thu: true, fri: true, sat: true, sun: true),
            channels: channels,
            rateCode: CMRate.RateCodes(),
            hmsUnitType: .roomType,
            hmsUnitId: 179,
            hotelId: 105,
            isDefault: false,
            code: nil,
            color: nil
        )
        
        // Then
        XCTAssertEqual(request.cmRoomId, 1)
        XCTAssertEqual(request.cmRateId, "NEW_RATE_001")
        XCTAssertEqual(request.offerId, "1")
        XCTAssertEqual(request.name, "New Test Rate")
        XCTAssertEqual(request.description, "Test rate description")
        XCTAssertEqual(request.minNight, 1)
        XCTAssertEqual(request.maxNight, 30)
        XCTAssertEqual(request.minAdvance, 0)
        XCTAssertEqual(request.maxAdvance, 365)
        XCTAssertEqual(request.strategy, ._default)
        XCTAssertEqual(request.firstNight, startDate)
        XCTAssertEqual(request.lastNight, endDate)
        XCTAssertEqual(request.roomPrice.enable, true)
        XCTAssertEqual(request.roomPrice.rate, 500.0)
        XCTAssertEqual(request.roomPriceGuest, 0.0)
        XCTAssertEqual(request.onePersonPrice.enable, false)
        XCTAssertEqual(request.onePersonPrice.rate, 0.0)
        XCTAssertEqual(request.twoPersonPrice.enable, false)
        XCTAssertEqual(request.twoPersonPrice.rate, 0.0)
        XCTAssertEqual(request.extraPersonPrice.enable, false)
        XCTAssertEqual(request.extraPersonPrice.rate, 0.0)
        XCTAssertEqual(request.extraChildPrice.enable, false)
        XCTAssertEqual(request.extraChildPrice.rate, 0.0)
        XCTAssertEqual(request.availableDay.mon, true)
        XCTAssertEqual(request.availableDay.tue, true)
        XCTAssertEqual(request.availableDay.wed, true)
        XCTAssertEqual(request.availableDay.thu, true)
        XCTAssertEqual(request.availableDay.fri, true)
        XCTAssertEqual(request.availableDay.sat, true)
        XCTAssertEqual(request.availableDay.sun, true)
        XCTAssertEqual(request.channels.channel017, true)
        XCTAssertEqual(request.channels.channel019, false)
        XCTAssertEqual(request.hmsUnitType, .roomType)
        XCTAssertEqual(request.hmsUnitId, 179)
        XCTAssertEqual(request.hotelId, 105)
        XCTAssertEqual(request.isDefault, false)
        XCTAssertNil(request.code)
        XCTAssertNil(request.color)
    }
    
    func testUpdateCMRateRequest() throws {
        // Given/When
        let request = CMRateServiceRequest.UpdateCMRate(
            id: 40,
            cmRoomId: nil,
            cmRateId: nil,
            offerId: nil,
            name: "Updated Agoda Rate",
            description: "Updated description",
            minNight: 2,
            maxNight: nil,
            minAdvance: nil,
            maxAdvance: nil,
            strategy: nil,
            firstNight: nil,
            lastNight: nil,
            roomPrice: CMRate.RateOption(enable: true, rate: 700.0),
            roomPriceGuest: nil,
            onePersonPrice: nil,
            twoPersonPrice: nil,
            extraPersonPrice: nil,
            extraChildPrice: nil,
            availableDay: nil,
            channels: nil,
            rateCode: nil,
            hmsUnitType: nil,
            hmsUnitId: nil,
            hotelId: nil,
            isDefault: nil,
            code: nil,
            color: nil
        )
        
        // Then
        XCTAssertEqual(request.id, 40)
        XCTAssertNil(request.cmRoomId)
        XCTAssertNil(request.cmRateId)
        XCTAssertNil(request.offerId)
        XCTAssertEqual(request.name, "Updated Agoda Rate")
        XCTAssertEqual(request.description, "Updated description")
        XCTAssertEqual(request.minNight, 2)
        XCTAssertNil(request.maxNight)
        XCTAssertNil(request.minAdvance)
        XCTAssertNil(request.maxAdvance)
        XCTAssertNil(request.strategy)
        XCTAssertNil(request.firstNight)
        XCTAssertNil(request.lastNight)
        XCTAssertEqual(request.roomPrice?.enable, true)
        XCTAssertEqual(request.roomPrice?.rate, 700.0)
        XCTAssertNil(request.roomPriceGuest)
        XCTAssertNil(request.onePersonPrice)
        XCTAssertNil(request.twoPersonPrice)
        XCTAssertNil(request.extraPersonPrice)
        XCTAssertNil(request.extraChildPrice)
        XCTAssertNil(request.availableDay)
        XCTAssertNil(request.channels)
        XCTAssertNil(request.rateCode)
        XCTAssertNil(request.hmsUnitType)
        XCTAssertNil(request.hmsUnitId)
        XCTAssertNil(request.hotelId)
        XCTAssertNil(request.isDefault)
        XCTAssertNil(request.code)
        XCTAssertNil(request.color)
    }
    
    func testDeleteCMRateRequest() throws {
        // Given/When
        let request = CMRateServiceRequest.DeleteCMRate(id: 40)
        
        // Then
        XCTAssertEqual(request.id, 40)
    }
    
    func testChangeUnitableRequest() throws {
        // Given/When
        let request = CMRateServiceRequest.ChangeUnitableRequest(
            id: 40,
            hmsUnitType: .roomType,
            hmsUnitId: 180
        )
        
        // Then
        XCTAssertEqual(request.id, 40)
        XCTAssertEqual(request.hmsUnitType, .roomType)
        XCTAssertEqual(request.hmsUnitId, 180)
    }
    
    // MARK: - CMRate RateOption Tests
    
    func testRateOption() throws {
        // Given/When
        let enabledOption = CMRate.RateOption(enable: true, rate: 500.0)
        let disabledOption = CMRate.RateOption(enable: false, rate: 0.0)
        
        // Then
        XCTAssertEqual(enabledOption.enable, true)
        XCTAssertEqual(enabledOption.rate, 500.0)
        XCTAssertEqual(disabledOption.enable, false)
        XCTAssertEqual(disabledOption.rate, 0.0)
    }
    
    // MARK: - CMRate DayOption Tests
    
    func testDayOption() throws {
        // Given/When
        let allDaysAvailable = CMRate.DayOption(
            mon: true,
            tue: true,
            wed: true,
            thu: true,
            fri: true,
            sat: true,
            sun: true
        )
        let weekdaysOnly = CMRate.DayOption(
            mon: true,
            tue: true,
            wed: true,
            thu: true,
            fri: true,
            sat: false,
            sun: false
        )
        
        // Then
        XCTAssertEqual(allDaysAvailable.mon, true)
        XCTAssertEqual(allDaysAvailable.tue, true)
        XCTAssertEqual(allDaysAvailable.wed, true)
        XCTAssertEqual(allDaysAvailable.thu, true)
        XCTAssertEqual(allDaysAvailable.fri, true)
        XCTAssertEqual(allDaysAvailable.sat, true)
        XCTAssertEqual(allDaysAvailable.sun, true)
        
        XCTAssertEqual(weekdaysOnly.mon, true)
        XCTAssertEqual(weekdaysOnly.tue, true)
        XCTAssertEqual(weekdaysOnly.wed, true)
        XCTAssertEqual(weekdaysOnly.thu, true)
        XCTAssertEqual(weekdaysOnly.fri, true)
        XCTAssertEqual(weekdaysOnly.sat, false)
        XCTAssertEqual(weekdaysOnly.sun, false)
    }
    
    // MARK: - CMRate Channels Tests
    
    func testChannels() throws {
        // Given/When
        let agodaOnlyChannels = CMRate.Channels(
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
        
        // Then
        XCTAssertEqual(agodaOnlyChannels.channel017, true) // Agoda
        XCTAssertEqual(agodaOnlyChannels.channel019, false) // Booking.com
        XCTAssertEqual(agodaOnlyChannels.channel014, false) // Expedia.com
        XCTAssertEqual(agodaOnlyChannels.channel046, false) // Airbnb
        XCTAssertEqual(agodaOnlyChannels.selectedKeys.count, 1)
        XCTAssertTrue(agodaOnlyChannels.selectedKeys.contains(.agoda))
    }
    
    // MARK: - CMRate RateCodes Tests
    
    func testRateCodes() throws {
        // Given/When
        let emptyCodes = CMRate.RateCodes()
        let customCodes = CMRate.RateCodes(
            otaRateCode: "OTA001",
            ctripRateCode: "CTRIP001",
            hrsdeRateCode: "HRS001",
            odigeoRateCode: "ODI001",
            traviaRateCode: "TRA001",
            feratelRateCode: "FER001",
            agodaRateCode: "AGO001",
            bookingcomRateCode: "BKG001",
            expediaRateCode: "EXP001",
            ostrovokruRateCode: "OST001",
            tomastravelRateCode: "TOM001",
            hotelbedsRateCode: "HTB001",
            lateroomsRateCode: "LAT001",
            travelokaRateCode: "TVK001",
            lastminuteRateCode: "LST001",
            hostelworldRateCode: "HST001",
            travelocityRateCode: "TVC001",
            budgetplacesRateCode: "BDG001",
            tablethotelsRateCode: "TAB001"
        )
        
        // Then
        XCTAssertEqual(emptyCodes.otaRateCode, "")
        XCTAssertEqual(emptyCodes.agodaRateCode, "")
        XCTAssertEqual(emptyCodes.bookingcomRateCode, "")
        
        XCTAssertEqual(customCodes.otaRateCode, "OTA001")
        XCTAssertEqual(customCodes.agodaRateCode, "AGO001")
        XCTAssertEqual(customCodes.bookingcomRateCode, "BKG001")
        XCTAssertEqual(customCodes.expediaRateCode, "EXP001")
    }
    
} 
