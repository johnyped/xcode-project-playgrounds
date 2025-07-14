//
//  BookingChannelRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest
import Mockable

final class BookingChannelRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchChannels_WillGetValidResponse() async throws {
        // Given
        let expectedChannels = BookingChannels(array: [
            BookingChannel(
                id: 1,
                name: "Online Travel Agent (OTA)",
                feeRate: 10.5,
                subChannels: [],
                createdAt: Date(),
                updatedAt: Date()
            ),
            BookingChannel(
                id: 2,
                name: "Direct Booking",
                feeRate: 5.0,
                subChannels: [],
                createdAt: Date(),
                updatedAt: Date()
            )
        ])
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedChannels)
        
        let service = BookingChannelRemoteService(localStorage: localStorage,
                                                  apiManager: apiManager)
        
        // When
        let result = try await service.fetchChannels()
        
        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.lists.first?.id, 1)
        XCTAssertEqual(result.lists.first?.name, "Online Travel Agent (OTA)")
        XCTAssertEqual(result.lists.first?.feeRate, 10.5)
        XCTAssertEqual(result.lists.last?.id, 2)
        XCTAssertEqual(result.lists.last?.name, "Direct Booking")
        XCTAssertEqual(result.lists.last?.feeRate, 5.0)
    }
    
    func testFetchChannels_WithEmptyResult_WillGetValidResponse() async throws {
        // Given
        let expectedChannels = BookingChannels(array: [])
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedChannels)
        
        let service = BookingChannelRemoteService(localStorage: localStorage,
                                                  apiManager: apiManager)
        // When
        let result = try await service.fetchChannels()
        
        // Then
        XCTAssertEqual(result.count, 0)
        XCTAssertTrue(result.lists.isEmpty)
    }

    func testFetchChannel_WillGetValidResponse() async throws {
        // Given
        let expectedChannel = BookingChannel(
            id: 1,
            name: "Online Travel Agent (OTA)",
            feeRate: 10.5,
            subChannels: [
                BookingChannel.SubChannel(
                    id: 101,
                    name: "Booking.com",
                    feeRate: 15.0,
                    createdAt: Date(),
                    updatedAt: Date()
                )
            ],
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedChannel)

        let service = BookingChannelRemoteService(localStorage: localStorage, 
                                                 apiManager: apiManager)
        let request = BookingChannelServiceRequest.FetchChannel(id: 1)

        // When
        let result = try await service.fetchChannel(request: request)

        // Then
        XCTAssertEqual(result.id, expectedChannel.id)
        XCTAssertEqual(result.name, expectedChannel.name)
        XCTAssertEqual(result.feeRate, expectedChannel.feeRate)
        XCTAssertEqual(result.subChannels.count, 1)
        XCTAssertEqual(result.subChannels.first?.name, "Booking.com")
    }

    func testCreateChannel_WillGetValidResponse() async throws {
        // Given
        let expectedChannel = BookingChannel(
            id: 3,
            name: "Phone Booking",
            feeRate: 0.0,
            subChannels: [],
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedChannel)

        let service = BookingChannelRemoteService(localStorage: localStorage, 
                                                 apiManager: apiManager)
        let request = BookingChannelServiceRequest.CreateChannel(
            name: "Phone Booking",
            feeRate: 0.0
        )

        // When
        let result = try await service.createChannel(request: request)

        // Then
        XCTAssertEqual(result.id, expectedChannel.id)
        XCTAssertEqual(result.name, expectedChannel.name)
        XCTAssertEqual(result.feeRate, expectedChannel.feeRate)
    }

    func testUpdateChannel_WillGetValidResponse() async throws {
        // Given
        let expectedChannel = BookingChannel(
            id: 1,
            name: "Updated OTA",
            feeRate: 12.0,
            subChannels: [],
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedChannel)

        let service = BookingChannelRemoteService(localStorage: localStorage, 
                                                 apiManager: apiManager)
        let request = BookingChannelServiceRequest.UpdateChannel(
            id: 1,
            name: "Updated OTA",
            feeRate: 12.0
        )

        // When
        let result = try await service.updateChannel(request: request)

        // Then
        XCTAssertEqual(result.id, expectedChannel.id)
        XCTAssertEqual(result.name, expectedChannel.name)
        XCTAssertEqual(result.feeRate, expectedChannel.feeRate)
    }

    func testDeleteChannel_WillSucceed() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = BookingChannelRemoteService(localStorage: localStorage, 
                                                 apiManager: apiManager)
        let request = BookingChannelServiceRequest.DeleteChannel(id: 3)

        // When/Then
        do {
            try await service.deleteChannel(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("Delete should not throw error")
        }
    }

    func testFetchSubChannels_WillGetValidResponse() async throws {
        // Given
        let expectedSubChannels = [
            BookingChannel.SubChannel(
                id: 101,
                name: "Booking.com",
                feeRate: 15.0,
                createdAt: Date(),
                updatedAt: Date()
            ),
            BookingChannel.SubChannel(
                id: 102,
                name: "Agoda.com",
                feeRate: 12.0,
                createdAt: Date(),
                updatedAt: Date()
            )
        ]
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedSubChannels)

        let service = BookingChannelRemoteService(localStorage: localStorage, 
                                                 apiManager: apiManager)
        let request = BookingChannelServiceRequest.FetchSubChannels(id: 1)

        // When
        let result = try await service.fetchSubChannels(request: request)

        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.name, "Booking.com")
        XCTAssertEqual(result.first?.feeRate, 15.0)
        XCTAssertEqual(result.last?.name, "Agoda.com")
        XCTAssertEqual(result.last?.feeRate, 12.0)
    }

    func testCreateSubChannel_WillGetValidResponse() async throws {
        // Given
        let expectedSubChannel = BookingChannel.SubChannel(
            id: 103,
            name: "Expedia",
            feeRate: 10.0,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedSubChannel)

        let service = BookingChannelRemoteService(localStorage: localStorage, 
                                                 apiManager: apiManager)
        let request = BookingChannelServiceRequest.CreateSubChannel(
            channelId: 1,
            name: "Expedia",
            feeRate: 10.0
        )

        // When
        let result = try await service.createSubChannel(request: request)

        // Then
        XCTAssertEqual(result.id, expectedSubChannel.id)
        XCTAssertEqual(result.name, expectedSubChannel.name)
        XCTAssertEqual(result.feeRate, expectedSubChannel.feeRate)
    }

    func testUpdateSubChannel_WillGetValidResponse() async throws {
        // Given
        let expectedSubChannel = BookingChannel.SubChannel(
            id: 101,
            name: "Updated Booking.com",
            feeRate: 18.0,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedSubChannel)

        let service = BookingChannelRemoteService(localStorage: localStorage, 
                                                 apiManager: apiManager)
        let request = BookingChannelServiceRequest.UpdateSubChannel(
            channelId: 1,
            subChannelId: 101,
            name: "Updated Booking.com",
            feeRate: 18.0
        )

        // When
        let result = try await service.updateSubChannel(request: request)

        // Then
        XCTAssertEqual(result.id, expectedSubChannel.id)
        XCTAssertEqual(result.name, expectedSubChannel.name)
        XCTAssertEqual(result.feeRate, expectedSubChannel.feeRate)
    }

    func testDeleteSubChannel_WillSucceed() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = BookingChannelRemoteService(localStorage: localStorage, 
                                                 apiManager: apiManager)
        let request = BookingChannelServiceRequest.DeleteSubChannel(
            channelId: 1,
            subChannelId: 101
        )

        // When/Then
        do {
            try await service.deleteSubChannel(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("Delete should not throw error")
        }
    }
} 
