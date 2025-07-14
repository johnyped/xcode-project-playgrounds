//
//  CMRateServiceRouterTests.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//

import XCTest
import Alamofire
import Mockable

final class CMRateServiceRouterTests: XCTestCase {
    
    func testFetchByPeriodRouter_WillHaveCorrectParameters() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1714129200) // 2024-04-26
        let endDate = Date(timeIntervalSince1970: 1714215600) // 2025-04-27
        let request = CMRateServiceRequest.FetchByPeriod(
            hotelId: 105,
            startDate: startDate,
            endDate: endDate,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // When
        let router = CMRateServiceRouter.fetchByPeriod(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/cm-rates/period")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["start_date"] as? String, "2024-04-26")
        XCTAssertEqual(parameters?["end_date"] as? String, "2024-04-27")
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func testFetchByHotelRouter_WillHaveCorrectParameters() throws {
        // Given
        let request = CMRateServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // When
        let router = CMRateServiceRouter.fetchByHotel(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/cm-rates")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
    }
    
    func testFetchByRoomTypeRouter_WillHaveCorrectParameters() throws {
        // Given
        let request = CMRateServiceRequest.FetchByRoomType(
            hotelId: 105,
            roomTypeId: 179,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // When
        let router = CMRateServiceRouter.fetchByRoomType(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/cm-rates/room-type")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["room_type_id"] as? Int, 179)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func testFetchByIdRouter_WillHaveCorrectPath() throws {
        // Given
        let request = CMRateServiceRequest.FetchById(id: 40)
        
        // When
        let router = CMRateServiceRouter.fetchById(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/cm-rates/40")
        XCTAssertEqual(router.method.rawValue, "GET")
        XCTAssertNil(router.parameters)
    }
    
    func testCreateCMRateRouter_WillHaveCorrectMethodAndPath() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1714129200)
        let endDate = Date(timeIntervalSince1970: 1714215600)
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
            let availableDay = CMRate.DayOption(mon: true, tue: true, wed: true, thu: true, fri: true, sat: true, sun: true)
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
            availableDay: availableDay,
            channels: channels,
            rateCode: CMRate.RateCodes(),
            hmsUnitType: .roomType,
            hmsUnitId: 179,
            hotelId: 105,
            isDefault: false,
            code: nil,
            color: nil
        )
        
        // When
        let router = CMRateServiceRouter.createCMRate(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/cm-rates")
        XCTAssertEqual(router.method.rawValue, "POST")
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
    func testUpdateCMRateRouter_WillHaveCorrectMethodAndPath() throws {
        // Given
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
        
        // When
        let router = CMRateServiceRouter.updateCMRate(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/cm-rates/40")
        XCTAssertEqual(router.method.rawValue, "PUT")
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
    func testDeleteCMRateRouter_WillHaveCorrectMethodAndPath() throws {
        // Given
        let request = CMRateServiceRequest.DeleteCMRate(id: 40)
        
        // When
        let router = CMRateServiceRouter.deleteCMRate(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/cm-rates/40")
        XCTAssertEqual(router.method.rawValue, "DELETE")
        XCTAssertNil(router.parameters)
        XCTAssertNil(router.body)
    }
    
    func testChangeUnitableRouter_WillHaveCorrectMethodAndPath() throws {
        // Given
        let request = CMRateServiceRequest.ChangeUnitableRequest(
            id: 40,
            hmsUnitType: .roomType,
            hmsUnitId: 180
        )
        
        // When
        let router = CMRateServiceRouter.changeUnitable(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/cm-rates/40/change-unitable")
        XCTAssertEqual(router.method.rawValue, "PUT")
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
} 
