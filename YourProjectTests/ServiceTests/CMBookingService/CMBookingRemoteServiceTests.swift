//
//  CMBookingRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//

import XCTest
import Mockable

final class CMBookingRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchByHotel_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<CMBooking>(
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

        let service = CMBookingRemoteService(localStorage: localStorage,
                                            apiManager: apiManager)
        let request = CMBookingServiceRequest.FetchByHotel(
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
        XCTAssertEqual(result.page, expectedPaginator.page)
        XCTAssertEqual(result.perPage, expectedPaginator.perPage)
    }

    func testFetchByPeriod_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<CMBooking>(
            items: Collection(array: []),
            totalItems: 0,
            totalPages: 0,
            perPage: 20,
            page: 1
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)

        let startDate = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let endDate = Date(timeIntervalSince1970: 1609459200) // 2021-01-01
        let service = CMBookingRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = CMBookingServiceRequest.FetchByPeriod(
            hotelId: 105,
            period: .init(start: startDate,
                          end: endDate),
            includedAcknowledged: false,
            page: 1,
            perPage: .twenty,
            sortedBy: .createdAt,
            sortedOrder: .descending
        )

        // When
        let result = try await service.fetchByPeriod(request: request)

        // Then
        XCTAssertEqual(result.totalItems, expectedPaginator.totalItems)
        XCTAssertEqual(result.page, expectedPaginator.page)
        XCTAssertEqual(result.perPage, expectedPaginator.perPage)
    }

    func testFetchByStatus_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<CMBooking>(
            items: Collection(array: []),
            totalItems: 0,
            totalPages: 0,
            perPage: 20,
            page: 1
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)

        let service = CMBookingRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = CMBookingServiceRequest.FetchByStatus(
            hotelId: 105,
            status: .confirmed,
            includedAcknowledged: true,
            page: 1,
            perPage: .twenty,
            sortedBy: .updatedAt,
            sortedOrder: .ascending
        )

        // When
        let result = try await service.fetchByStatus(request: request)

        // Then
        XCTAssertEqual(result.totalItems, expectedPaginator.totalItems)
        XCTAssertEqual(result.page, expectedPaginator.page)
        XCTAssertEqual(result.perPage, expectedPaginator.perPage)
    }

    func testFetchByKeyword_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<CMBooking>(
            items: Collection(array: []),
            totalItems: 0,
            totalPages: 0,
            perPage: 20,
            page: 1
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)

        let service = CMBookingRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = CMBookingServiceRequest.FetchByKeyword(
            hotelId: 105,
            keyword: "THA",
            includedAcknowledged: false,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )

        // When
        let result = try await service.fetchByKeyword(request: request)

        // Then
        XCTAssertEqual(result.totalItems, expectedPaginator.totalItems)
        XCTAssertEqual(result.page, expectedPaginator.page)
        XCTAssertEqual(result.perPage, expectedPaginator.perPage)
    }

    func testFetchBatch_WillGetValidResponse() async throws {
        // Given
        let expected = CMBookings()
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expected)

        let service = CMBookingRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = CMBookingServiceRequest.FetchByBatchIds(
            hotelId: 105,
            ids: [1, 2, 3]
        )

        // When
        let result = try await service.fetchByBatchIds(request: request)

        // Then
        XCTAssertEqual(result.count, expected.count)
    }

    func testFetchById_WillGetValidResponse() async throws {
        // Given
        let guestInfo = CMBookingRaw.GuestInfo(title: "Mr.",
                                               firstname: "John",
                                               lastname: "Doe",
                                               email: "john.doe@example.com", 
                                               phone: "+66123456789",
                                               mobile: "+66987654321",
                                               fax: "+6611112222",
                                               company: "Test Company Ltd.")
        let addr = CMBookingRaw.GuestAddress(address: "123 Test Street",
                                             city: "Bangkok",
                                             state: "Bangkok",
                                             postCode: "10110",
                                             country: "Thailand",
                                             countryCode: "THA")
        let rawCMBooking = CMBookingRaw(propId: "prop123",
                                        status: .confirmed,
                                        bookingID: "book123",
                                        roomID: "room456",
                                        unitID: "unit789",
                                        roomCount: 1,
                                        firstNightDate: Date(timeIntervalSince1970: 1577836800),
                                        lastNightDate: Date(timeIntervalSince1970: 1577923200),
                                        adultCount: 2,
                                        childCount: 0,
                                        guestInfo: guestInfo,
                                        guestAddress: addr,
                                        guestComments: "",
                                        notes: "",
                                        price: 1500.0,
                                        deposit: 0.0,
                                        tax: 0.0,
                                        commission: 0.0,
                                        currencyUnit: "THB",
                                        rateDescription: "Standard Rate",
                                        invoices: [],
                                        referer: "Manual",
                                        apiSource: 1,
                                        referenceBookingID: "",
                                        bookingTime: Date(),
                                        modified: Date())               
        
        let expectedCMBooking = CMBooking(
            id: 123,
            hotelId: 105,
            hmsUnitType: .roomType,
            hmsUnitId: 179,
            firstNight: Date(timeIntervalSince1970: 1577836800),
            lastNight: Date(timeIntervalSince1970: 1577923200),
            cmBookID: "book123",
            cmRoomId: "room456",
            cmStatus: .confirmed,
            raw: rawCMBooking,
            hmsReservationID: 789,
            createdAt: Date(),
            updatedAt: Date())
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCMBooking)

        let service = CMBookingRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = CMBookingServiceRequest.FetchById(id: 123)

        // When
        let result = try await service.fetchById(request: request)

        // Then
        XCTAssertEqual(result.id, expectedCMBooking.id)
        XCTAssertEqual(result.hotelId, expectedCMBooking.hotelId)
        XCTAssertEqual(result.hmsUnitType, expectedCMBooking.hmsUnitType)
        XCTAssertEqual(result.hmsUnitId, expectedCMBooking.hmsUnitId)
        XCTAssertEqual(result.cmBookID, expectedCMBooking.cmBookID)
        XCTAssertEqual(result.cmRoomId, expectedCMBooking.cmRoomId)
        XCTAssertEqual(result.cmStatus, expectedCMBooking.cmStatus)
        XCTAssertEqual(result.hmsReservationID, expectedCMBooking.hmsReservationID)
    }

    func testAcknowledge_WillSucceed() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = CMBookingRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = CMBookingServiceRequest.Acknowledge(id: 456)

        // When/Then
        do {
            try await service.acknowledge(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("Acknowledge should not throw error")
        }
    }

    func testBatchAcknowledge_WillSucceed() async throws {
        // Given
        let cmBookings = CMBookings()
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(cmBookings)

        let service = CMBookingRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = CMBookingServiceRequest.BatchAcknowledge(hotelId: 105,
                                                               ids: [789, 101112])

        // When/Then
        let response = try await service.batchAcknowledge(request: request)
        XCTAssertEqual(cmBookings.count, response.count)
    }

    func testSync_WillSucceed() async throws {
        // Given
        let cmBookings = CMBookings()
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(cmBookings)

        let service = CMBookingRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = CMBookingServiceRequest.Sync(
            hotelId: 105
        )

        // When/Then
        let response = try await service.sync(request: request)
        XCTAssertEqual(cmBookings.count, response.count)
    }

    func testFetchByHotelWithMinimalParameters_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<CMBooking>(
            items: Collection(array: []),
            totalItems: 0,
            totalPages: 0,
            perPage: 20,
            page: 1
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)

        let service = CMBookingRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = CMBookingServiceRequest.FetchByHotel(
            hotelId: 105,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )

        // When
        let result = try await service.fetchByHotel(request: request)

        // Then
        XCTAssertEqual(result.totalItems, expectedPaginator.totalItems)
        XCTAssertEqual(result.page, expectedPaginator.page)
        XCTAssertEqual(result.perPage, expectedPaginator.perPage)
    }

    func testFetchByPeriodWithMinimalParameters_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<CMBooking>(
            items: Collection(array: []),
            totalItems: 0,
            totalPages: 0,
            perPage: 20,
            page: 1
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)

        let startDate = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let endDate = Date(timeIntervalSince1970: 1609459200) // 2021-01-01
        let service = CMBookingRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = CMBookingServiceRequest.FetchByPeriod(
            hotelId: 105,
            period: .init(start: startDate,
                          end: endDate),
            includedAcknowledged: nil,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )

        // When
        let result = try await service.fetchByPeriod(request: request)

        // Then
        XCTAssertEqual(result.totalItems, expectedPaginator.totalItems)
        XCTAssertEqual(result.page, expectedPaginator.page)
        XCTAssertEqual(result.perPage, expectedPaginator.perPage)
    }

    func testFetchByStatusWithDifferentStatus_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<CMBooking>(
            items: Collection(array: []),
            totalItems: 0,
            totalPages: 0,
            perPage: 20,
            page: 1
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)

        let service = CMBookingRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = CMBookingServiceRequest.FetchByStatus(
            hotelId: 105,
            status: .cancelled,
            includedAcknowledged: false,
            page: 1,
            perPage: .fifty,
            sortedBy: .createdAt,
            sortedOrder: .descending
        )

        // When
        let result = try await service.fetchByStatus(request: request)

        // Then
        XCTAssertEqual(result.totalItems, expectedPaginator.totalItems)
        XCTAssertEqual(result.page, expectedPaginator.page)
        XCTAssertEqual(result.perPage, expectedPaginator.perPage)
    }

    func testFetchByKeywordWithDifferentKeyword_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<CMBooking>(
            items: Collection(array: []),
            totalItems: 0,
            totalPages: 0,
            perPage: 20,
            page: 1
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)

        let service = CMBookingRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = CMBookingServiceRequest.FetchByKeyword(
            hotelId: 105,
            keyword: "John Doe",
            includedAcknowledged: true,
            page: 2,
            perPage: .ten,
            sortedBy: .updatedAt,
            sortedOrder: .descending
        )

        // When
        let result = try await service.fetchByKeyword(request: request)

        // Then
        XCTAssertEqual(result.totalItems, expectedPaginator.totalItems)
        XCTAssertEqual(result.page, expectedPaginator.page)
        XCTAssertEqual(result.perPage, expectedPaginator.perPage)
    }

    func testFetchBatchWithSingleId_WillGetValidResponse() async throws {
        // Given
        let expected = CMBookings()
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expected)

        let service = CMBookingRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = CMBookingServiceRequest.FetchByBatchIds(
            hotelId: 105,
            ids: [999]
        )

        // When
        let result = try await service.fetchByBatchIds(request: request)

        // Then
        XCTAssertEqual(result.count, expected.count)
    }

    func testBatchAcknowledgeWithSingleId_WillSucceed() async throws {
        // Given
        let expected = CMBookings()
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expected)

        let service = CMBookingRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = CMBookingServiceRequest.BatchAcknowledge(hotelId: 105,
                                                               ids: [555])

        // When/Then
        let result = try await service.batchAcknowledge(request: request)

        XCTAssertEqual(result.count, expected.count)
    }

    func testSyncWithDifferentCountry_WillSucceed() async throws {
        // Given
        let expected = CMBookings()
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expected)

        let service = CMBookingRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = CMBookingServiceRequest.Sync(
            hotelId: 105
        )

        // When/Then
        let result = try await service.sync(request: request)

        XCTAssertEqual(result.count, expected.count)      
    }
} 
