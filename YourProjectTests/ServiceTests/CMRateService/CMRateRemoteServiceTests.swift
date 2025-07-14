//
//  CMRateRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//

import XCTest
import Mockable

final class CMRateRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchByPeriod_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<CMRate>(
            items: Collection(array: []),
            totalItems: 0,
            totalPages: 0,
            perPage: 20,
            page: 1
        )
        // Stub the API manager to return the expected paginator
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)

        let service = CMRateRemoteService(localStorage: localStorage,
                                         apiManager: apiManager)
        let startDate = Date(timeIntervalSince1970: 1714129200) // 2025-04-26
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
        let result = try await service.fetchByPeriod(request: request)

        // Then
        XCTAssertEqual(result.totalItems, expectedPaginator.totalItems)
    }

    func testFetchByHotel_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<CMRate>(
            items: Collection(array: []),
            totalItems: 0,
            totalPages: 0,
            perPage: 20,
            page: 1
        )
        // Stub the API manager to return the expected paginator
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)

        let service = CMRateRemoteService(localStorage: localStorage,
                                         apiManager: apiManager)
        let request = CMRateServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )

        // When
        let result = try await service.fetchByHotel(request: request)

        // Then
        XCTAssertEqual(result.totalItems, expectedPaginator.totalItems)
    }

    func testFetchByRoomType_WillGetValidResponse() async throws {
        // Given
        let expectedCMRates = CMRates(array: [])
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCMRates)

        let service = CMRateRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = CMRateServiceRequest.FetchByRoomType(
            hotelId: 105,
            roomTypeId: 179,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )

        // When
        let result = try await service.fetchByRoomType(request: request)

        // Then
        XCTAssertEqual(result.count, expectedCMRates.count)
    }

    func testFetchById_WillGetValidResponse() async throws {
        // Given
        let expectedCMRate = CMRate(
            id: 40,
            cmRoomId: 1,
            cmRateId: "4486488",
            offerId: "1",
            name: "Agoda Rate",
            description: "",
            minNight: 0,
            maxNight: 365,
            minAdvance: 0,
            maxAdvance: 999,
            strategy: ._default,
            firstNight: Date(timeIntervalSince1970: 1714129200),
            lastNight: Date(timeIntervalSince1970: 1714215600),
            roomPrice: CMRate.RateOption(enable: true, rate: 620.0),
            roomPriceGuest: 0.0,
            onePersonPrice: CMRate.RateOption(enable: false, rate: 0.0),
            twoPersonPrice: CMRate.RateOption(enable: false, rate: 0.0),
            extraPersonPrice: CMRate.RateOption(enable: false, rate: 0.0),
            extraChildPrice: CMRate.RateOption(enable: false, rate: 0.0),
            availableDay: CMRate.DayOption(mon: true, tue: true, wed: true, thu: true, fri: true, sat: true, sun: true),
            channels: CMRate.Channels(
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
            ),
            rateCode: CMRate.RateCodes(),
            hmsUnitType: .roomType,
            hmsUnitId: 179,
            hotelId: 105,
            isDefault: false,
            code: nil,
            color: nil,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCMRate)

        let service = CMRateRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = CMRateServiceRequest.FetchById(id: 40)

        // When
        let result = try await service.fetchById(request: request)

        // Then
        XCTAssertEqual(result.id, expectedCMRate.id)
        XCTAssertEqual(result.name, expectedCMRate.name)
        XCTAssertEqual(result.cmRateId, expectedCMRate.cmRateId)
        XCTAssertEqual(result.hotelId, expectedCMRate.hotelId)
    }

    func testCreateCMRate_WillGetValidResponse() async throws {
        // Given
        let expectedCMRate = CMRate(
            id: 41,
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
            firstNight: Date(timeIntervalSince1970: 1714129200),
            lastNight: Date(timeIntervalSince1970: 1714215600),
            roomPrice: CMRate.RateOption(enable: true, rate: 500.0),
            roomPriceGuest: 0.0,
            onePersonPrice: CMRate.RateOption(enable: false, rate: 0.0),
            twoPersonPrice: CMRate.RateOption(enable: false, rate: 0.0),
            extraPersonPrice: CMRate.RateOption(enable: false, rate: 0.0),
            extraChildPrice: CMRate.RateOption(enable: false, rate: 0.0),
            availableDay: CMRate.DayOption(mon: true, tue: true, wed: true, thu: true, fri: true, sat: true, sun: true),
            channels: CMRate.Channels(
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
            ),
            rateCode: CMRate.RateCodes(),
            hmsUnitType: .roomType,
            hmsUnitId: 179,
            hotelId: 105,
            isDefault: false,
            code: nil,
            color: nil,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCMRate)

        let service = CMRateRemoteService(localStorage: localStorage, apiManager: apiManager)
        let startDate = Date(timeIntervalSince1970: 1714129200)
        let endDate = Date(timeIntervalSince1970: 1714215600)
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
            channels: CMRate.Channels(
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
            ),
            rateCode: CMRate.RateCodes(),
            hmsUnitType: .roomType,
            hmsUnitId: 179,
            hotelId: 105,
            isDefault: false,
            code: nil,
            color: nil
        )

        // When
        let result = try await service.createCMRate(request: request)

        // Then
        XCTAssertEqual(result.id, expectedCMRate.id)
        XCTAssertEqual(result.name, expectedCMRate.name)
        XCTAssertEqual(result.cmRateId, expectedCMRate.cmRateId)
    }

    func testUpdateCMRate_WillGetValidResponse() async throws {
        // Given
        let expectedCMRate = CMRate(
            id: 40,
            cmRoomId: 1,
            cmRateId: "4486488",
            offerId: "1",
            name: "Updated Agoda Rate",
            description: "Updated description",
            minNight: 2,
            maxNight: 365,
            minAdvance: 0,
            maxAdvance: 999,
            strategy: ._default,
            firstNight: Date(timeIntervalSince1970: 1714129200),
            lastNight: Date(timeIntervalSince1970: 1714215600),
            roomPrice: CMRate.RateOption(enable: true, rate: 700.0),
            roomPriceGuest: 0.0,
            onePersonPrice: CMRate.RateOption(enable: false, rate: 0.0),
            twoPersonPrice: CMRate.RateOption(enable: false, rate: 0.0),
            extraPersonPrice: CMRate.RateOption(enable: false, rate: 0.0),
            extraChildPrice: CMRate.RateOption(enable: false, rate: 0.0),
            availableDay: CMRate.DayOption(mon: true, tue: true, wed: true, thu: true, fri: true, sat: true, sun: true),
            channels:  CMRate.Channels(
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
            ),
            rateCode: CMRate.RateCodes(),
            hmsUnitType: .roomType,
            hmsUnitId: 179,
            hotelId: 105,
            isDefault: false,
            code: nil,
            color: nil,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCMRate)

        let service = CMRateRemoteService(localStorage: localStorage, apiManager: apiManager)
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
        let result = try await service.updateCMRate(request: request)

        // Then
        XCTAssertEqual(result.id, expectedCMRate.id)
        XCTAssertEqual(result.name, expectedCMRate.name)
        XCTAssertEqual(result.description, expectedCMRate.description)
        XCTAssertEqual(result.roomPrice.rate, expectedCMRate.roomPrice.rate)
    }

    func testDeleteCMRate_WillSucceed() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = CMRateRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = CMRateServiceRequest.DeleteCMRate(id: 40)

        // When/Then
        do {
            try await service.deleteCMRate(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("Delete should not throw error")
        }
    }

    func testChangeUnitable_WillGetValidResponse() async throws {
        // Given
        let expectedCMRate = CMRate(
            id: 40,
            cmRoomId: 1,
            cmRateId: "4486488",
            offerId: "1",
            name: "Agoda Rate",
            description: "",
            minNight: 0,
            maxNight: 365,
            minAdvance: 0,
            maxAdvance: 999,
            strategy: ._default,
            firstNight: Date(timeIntervalSince1970: 1714129200),
            lastNight: Date(timeIntervalSince1970: 1714215600),
            roomPrice: CMRate.RateOption(enable: true, rate: 620.0),
            roomPriceGuest: 0.0,
            onePersonPrice: CMRate.RateOption(enable: false, rate: 0.0),
            twoPersonPrice: CMRate.RateOption(enable: false, rate: 0.0),
            extraPersonPrice: CMRate.RateOption(enable: false, rate: 0.0),
            extraChildPrice: CMRate.RateOption(enable: false, rate: 0.0),
            availableDay: CMRate.DayOption(mon: true, tue: true, wed: true, thu: true, fri: true, sat: true, sun: true),
            channels:  CMRate.Channels(
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
            ),
            rateCode: CMRate.RateCodes(),
            hmsUnitType: .roomType,
            hmsUnitId: 180, // Changed unit ID
            hotelId: 105,
            isDefault: false,
            code: nil,
            color: nil,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCMRate)

        let service = CMRateRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = CMRateServiceRequest.ChangeUnitableRequest(
            id: 40,
            hmsUnitType: .roomType,
            hmsUnitId: 180
        )

        // When
        let result = try await service.changeUnitable(request: request)

        // Then
        XCTAssertEqual(result.id, expectedCMRate.id)
        XCTAssertEqual(result.hmsUnitId, expectedCMRate.hmsUnitId)
        XCTAssertEqual(result.hmsUnitType, expectedCMRate.hmsUnitType)
    }
} 
