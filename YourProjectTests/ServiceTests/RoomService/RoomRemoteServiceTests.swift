//
//  RoomRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest
import Mockable

final class RoomRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchRooms_WillGetValidResponse() async throws {
        // Given
        let expectedRooms = Rooms(array: [
            Room(
                id: 1,
                roomTypeId: 201,
                code: "101",
                order: 1,
                status: .available,
                needCleaning: false,
                createdAt: Date(),
                updatedAt: Date()
            ),
            Room(
                id: 2,
                roomTypeId: 201,
                code: "102",
                order: 2,
                status: .available,
                needCleaning: true,
                createdAt: Date(),
                updatedAt: Date()
            )
        ])
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedRooms)
        
        let service = RoomRemoteService(localStorage: localStorage,
                                        apiManager: apiManager)
        let request = RoomServiceRequest.FetchRooms(
            hotelId: 105,
            roomTypeId: 201
        )
        
        // When
        let result = try await service.fetchRooms(request: request)
        
        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.lists.first?.id, 1)
        XCTAssertEqual(result.lists.first?.code, "101")
        XCTAssertEqual(result.lists.first?.roomTypeId, 201)
        XCTAssertEqual(result.lists.last?.id, 2)
        XCTAssertEqual(result.lists.last?.code, "102")
        XCTAssertEqual(result.lists.last?.needCleaning, true)
    }
    
    func testFetchRooms_WithEmptyResult_WillGetValidResponse() async throws {
        // Given
        let expectedRooms = Rooms(array: [])
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedRooms)
        
        let service = RoomRemoteService(localStorage: localStorage,
                                        apiManager: apiManager)
        let request = RoomServiceRequest.FetchRooms(
            hotelId: 105,
            roomTypeId: 201
        )
        
        // When
        let result = try await service.fetchRooms(request: request)
        
        // Then
        XCTAssertEqual(result.count, 0)
        XCTAssertTrue(result.lists.isEmpty)
    }

    func testFetchRoom_WillGetValidResponse() async throws {
        // Given
        let expectedRoom = Room(
            id: 1,
            roomTypeId: 201,
            code: "101",
            order: 1,
            status: .available,
            needCleaning: false,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedRoom)

        let service = RoomRemoteService(localStorage: localStorage, 
                                       apiManager: apiManager)
        let request = RoomServiceRequest.FetchRoom(id: 1)

        // When
        let result = try await service.fetchRoom(request: request)

        // Then
        XCTAssertEqual(result.id, expectedRoom.id)
        XCTAssertEqual(result.roomTypeId, expectedRoom.roomTypeId)
        XCTAssertEqual(result.code, expectedRoom.code)
        XCTAssertEqual(result.order, expectedRoom.order)
        XCTAssertEqual(result.status, expectedRoom.status)
        XCTAssertEqual(result.needCleaning, expectedRoom.needCleaning)
    }

    func testCreateRoom_WillGetValidResponse() async throws {
        // Given
        let expectedRoom = Room(
            id: 2,
            roomTypeId: 201,
            code: "102",
            order: 2,
            status: .available,
            needCleaning: false,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedRoom)

        let service = RoomRemoteService(localStorage: localStorage, 
                                       apiManager: apiManager)
        let request = RoomServiceRequest.CreateRoom(
            code: "102",
            roomTypeId: 201,
            hotelId: 105
        )

        // When
        let result = try await service.createRoom(request: request)

        // Then
        XCTAssertEqual(result.id, expectedRoom.id)
        XCTAssertEqual(result.roomTypeId, expectedRoom.roomTypeId)
        XCTAssertEqual(result.code, expectedRoom.code)
        XCTAssertEqual(result.order, expectedRoom.order)
        XCTAssertEqual(result.status, expectedRoom.status)
        XCTAssertEqual(result.needCleaning, expectedRoom.needCleaning)
    }

    func testUpdateRoom_WillGetValidResponse() async throws {
        // Given
        let expectedRoom = Room(
            id: 1,
            roomTypeId: 301,
            code: "101A",
            order: 5,
            status: .unavailable,
            needCleaning: true,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedRoom)

        let service = RoomRemoteService(localStorage: localStorage, 
                                       apiManager: apiManager)
        let request = RoomServiceRequest.UpdateRoom(
            id: 1,
            code: "101A",
            status: "unavailable",
            needCleaning: true
        )

        // When
        let result = try await service.updateRoom(request: request)

        // Then
        XCTAssertEqual(result.id, expectedRoom.id)
        XCTAssertEqual(result.roomTypeId, expectedRoom.roomTypeId)
        XCTAssertEqual(result.code, expectedRoom.code)
        XCTAssertEqual(result.order, expectedRoom.order)
        XCTAssertEqual(result.status, expectedRoom.status)
        XCTAssertEqual(result.needCleaning, expectedRoom.needCleaning)
    }

    func testDeleteRoom_WillSucceed() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = RoomRemoteService(localStorage: localStorage, 
                                       apiManager: apiManager)
        let request = RoomServiceRequest.DeleteRoom(id: 3)

        // When/Then
        do {
            try await service.deleteRoom(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("Delete should not throw error")
        }
    }

    func testChangeRoomType_WillGetValidResponse() async throws {
        // Given
        let expectedRoom = Room(
            id: 1,
            roomTypeId: 501,
            code: "101",
            order: 1,
            status: .available,
            needCleaning: false,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedRoom)

        let service = RoomRemoteService(localStorage: localStorage, 
                                       apiManager: apiManager)
        let request = RoomServiceRequest.ChangeRoomType(
            id: 1,
            roomTypeId: 501
        )

        // When
        let result = try await service.changeRoomType(request: request)

        // Then
        XCTAssertEqual(result.id, expectedRoom.id)
        XCTAssertEqual(result.roomTypeId, expectedRoom.roomTypeId)
        XCTAssertEqual(result.code, expectedRoom.code)
    }

    func testUpdateRoomsOrder_WillSucceed() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = RoomRemoteService(localStorage: localStorage, 
                                       apiManager: apiManager)
        let request = RoomServiceRequest.UpdateRoomsOrder(
            hotelId: 105,
            roomOrders: [
                RoomServiceRequest.UpdateRoomsOrder.RoomOrder(roomId: 1, order: 1),
                RoomServiceRequest.UpdateRoomsOrder.RoomOrder(roomId: 2, order: 2),
                RoomServiceRequest.UpdateRoomsOrder.RoomOrder(roomId: 3, order: 3)
            ]
        )

        // When/Then
        do {
            try await service.updateRoomsOrder(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("Update rooms order should not throw error")
        }
    }

    func testBatchCreateRooms_WillGetValidResponse() async throws {
        // Given
        let expectedRooms = Rooms(array: [
            Room(
                id: 10,
                roomTypeId: 201,
                code: "201",
                order: 10,
                status: .available,
                needCleaning: false,
                createdAt: Date(),
                updatedAt: Date()
            ),
            Room(
                id: 11,
                roomTypeId: 301,
                code: "301",
                order: 11,
                status: .available,
                needCleaning: false,
                createdAt: Date(),
                updatedAt: Date()
            )
        ])
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedRooms)

        let service = RoomRemoteService(localStorage: localStorage, 
                                       apiManager: apiManager)
        let request = RoomServiceRequest.BatchCreateRooms(
            hotelId: 105,
            rooms: [
                RoomServiceRequest.BatchCreateRooms.BatchRoom(code: "201", roomTypeId: 201),
                RoomServiceRequest.BatchCreateRooms.BatchRoom(code: "301", roomTypeId: 301)
            ]
        )

        // When
        let result = try await service.batchCreateRooms(request: request)

        // Then
        XCTAssertEqual(result.lists.count, expectedRooms.lists.count)
        XCTAssertEqual(result.lists.first?.id, expectedRooms.lists.first?.id)
        XCTAssertEqual(result.lists.first?.code, expectedRooms.lists.first?.code)
        XCTAssertEqual(result.lists.last?.code, expectedRooms.lists.last?.code)
        XCTAssertEqual(result.lists.last?.roomTypeId, 301)
    }

    func testBatchDeleteRooms_WillSucceed() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = RoomRemoteService(localStorage: localStorage, 
                                       apiManager: apiManager)
        let request = RoomServiceRequest.BatchDeleteRooms(
            hotelId: 105,
            roomIds: [10, 11, 12]
        )

        // When/Then
        do {
            try await service.batchDeleteRooms(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("Batch delete should not throw error")
        }
    }
} 
