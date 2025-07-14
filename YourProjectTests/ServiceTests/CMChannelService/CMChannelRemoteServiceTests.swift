//  CMChannelRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 14/1/2568 BE.
//

import XCTest
import Mockable

final class CMChannelRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchByHotel_WillGetValidResponse() async throws {
        // Given
        let expectedChannels = CMChannels(array:[
            CMChannel(
                id: 1,
                name: "Booking.com",
                channelId: 1,
                subChannelId: nil
            ),
            CMChannel(
                id: 2,
                name: "Agoda",
                channelId: 2,
                subChannelId: nil
            )
        ])
        
        // Stub the API manager to return the expected channels
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedChannels)

        let service = CMChannelRemoteService(localStorage: localStorage,
                                           apiManager: apiManager)
        let request = CMChannelServiceRequest.FetchByHotel(hotelId: 105)

        // When
        let result = try await service.fetchByHotel(request: request)

        // Then
        XCTAssertEqual(result.count, expectedChannels.count)
        XCTAssertEqual(result.first?.name, "Booking.com")
        XCTAssertEqual(result.lists.last?.name, "Agoda")
    }
} 
