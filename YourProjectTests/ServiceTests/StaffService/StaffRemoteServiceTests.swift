//
//  StaffRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest
import Mockable

final class StaffRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchStaffs_WillGetValidResponse() async throws {
        // Given
        let expectedStaffs = Staffs(array: [
            Staff(
                id: 1,
                status: .active,
                role: .frontDesk,
                userId: 101,
                username: "staff1@example.com",
                email: "staff1@example.com",
                firstName: "John",
                lastName: "Doe",
                phoneNumber: "123-456-7890",
                idCard: "1234567890123",
                logoImage: nil,
                signSignatureImage: nil,
                hotelId: 105
            ),
            Staff(
                id: 2,
                status: .inactive,
                role: .manager,
                userId: 102,
                username: "staff2@example.com",
                email: "staff2@example.com",
                firstName: "Jane",
                lastName: "Smith",
                phoneNumber: "098-765-4321",
                idCard: "9876543210987",
                logoImage: nil,
                signSignatureImage: nil,
                hotelId: 105
            )
        ])
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedStaffs)
        
        let service = StaffRemoteService(localStorage: localStorage,
                                         apiManager: apiManager)
        let request = StaffServiceRequest.FetchStaffs(hotelId: 105)
        
        // When
        let result = try await service.fetchStaffs(request: request)
        
        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.lists.first?.id, 1)
        XCTAssertEqual(result.lists.first?.email, "staff1@example.com")
        XCTAssertEqual(result.lists.first?.role, .frontDesk)
        XCTAssertEqual(result.lists.first?.status, .active)
        XCTAssertEqual(result.lists.last?.id, 2)
        XCTAssertEqual(result.lists.last?.role, .manager)
        XCTAssertEqual(result.lists.last?.status, .inactive)
    }
    
    func testFetchStaffs_WithEmptyResult_WillGetValidResponse() async throws {
        // Given
        let expectedStaffs = Staffs(array: [])
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedStaffs)
        
        let service = StaffRemoteService(localStorage: localStorage,
                                         apiManager: apiManager)
        let request = StaffServiceRequest.FetchStaffs(hotelId: 105)
        
        // When
        let result = try await service.fetchStaffs(request: request)
        
        // Then
        XCTAssertEqual(result.count, 0)
        XCTAssertTrue(result.lists.isEmpty)
    }

    func testFetchStaff_WillGetValidResponse() async throws {
        // Given
        let expectedStaff = Staff(
            id: 1,
            status: .active,
            role: .frontDesk,
            userId: 101,
            username: "staff1@example.com",
            email: "staff1@example.com",
            firstName: "John",
            lastName: "Doe",
            phoneNumber: "123-456-7890",
            idCard: "1234567890123",
            logoImage: nil,
            signSignatureImage: nil,
            hotelId: 105
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedStaff)

        let service = StaffRemoteService(localStorage: localStorage, 
                                        apiManager: apiManager)
        let request = StaffServiceRequest.FetchStaff(id: 1)

        // When
        let result = try await service.fetchStaff(request: request)

        // Then
        XCTAssertEqual(result.id, expectedStaff.id)
        XCTAssertEqual(result.email, expectedStaff.email)
        XCTAssertEqual(result.firstName, expectedStaff.firstName)
        XCTAssertEqual(result.lastName, expectedStaff.lastName)
        XCTAssertEqual(result.role, expectedStaff.role)
        XCTAssertEqual(result.status, expectedStaff.status)
        XCTAssertEqual(result.hotelId, expectedStaff.hotelId)
    }

    func testCreateStaff_WillGetValidResponse() async throws {
        // Given
        let expectedStaff = Staff(
            id: 3,
            status: .active,
            role: .frontDesk,
            userId: 103,
            username: "newstaff@example.com",
            email: "newstaff@example.com",
            firstName: "New",
            lastName: "Staff",
            phoneNumber: "111-222-3333",
            idCard: "1112223334445",
            logoImage: nil,
            signSignatureImage: nil,
            hotelId: 105
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedStaff)

        let service = StaffRemoteService(localStorage: localStorage, 
                                        apiManager: apiManager)
        let request = StaffServiceRequest.CreateStaff(
            hotelId: 105,
            username: "newstaff@example.com",
            password: "password123",
            role: .frontDesk,
            email: "abc@email.com"
        )

        // When
        let result = try await service.createStaff(request: request)

        // Then
        XCTAssertEqual(result.id, expectedStaff.id)
        //XCTAssertEqual(result.email, expectedStaff.email)
        XCTAssertEqual(result.role, expectedStaff.role)
        XCTAssertEqual(result.status, expectedStaff.status)
        XCTAssertEqual(result.hotelId, expectedStaff.hotelId)
    }

    func testUpdateStaff_WillGetValidResponse() async throws {
        // Given
        let expectedStaff = Staff(
            id: 1,
            status: .active,
            role: .frontDesk,
            userId: 101,
            username: "staff1@example.com",
            email: "staff1@example.com",
            firstName: "Updated John",
            lastName: "Updated Doe",
            phoneNumber: "999-888-7777",
            idCard: "1234567890123",
            logoImage: nil,
            signSignatureImage: nil,
            hotelId: 105
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedStaff)

        let service = StaffRemoteService(localStorage: localStorage, 
                                        apiManager: apiManager)
        let request = StaffServiceRequest.UpdateStaff(
            id: 1,
            firstName: "Updated John",
            lastName: "Updated Doe",
            phoneNumber: "999-888-7777",
            pinCode: "1234",
            idCard: "1234567890123",
            email: "abc@email.com"
        )

        // When
        let result = try await service.updateStaff(request: request)

        // Then
        XCTAssertEqual(result.id, expectedStaff.id)
        XCTAssertEqual(result.firstName, expectedStaff.firstName)
        XCTAssertEqual(result.lastName, expectedStaff.lastName)
        XCTAssertEqual(result.phoneNumber, expectedStaff.phoneNumber)        
        XCTAssertEqual(result.idCard, expectedStaff.idCard)
        XCTAssertEqual(result.email, expectedStaff.email)
    }

    func testChangeStaffUsername_WillGetValidResponse() async throws {
        // Given
        let expectedStaff = Staff(
            id: 1,
            status: .active,
            role: .frontDesk,
            userId: 101,
            username: "newusername@example.com",
            email: "staff1@example.com",
            firstName: "John",
            lastName: "Doe",
            phoneNumber: "123-456-7890",
            idCard: "1234567890123",
            logoImage: nil,
            signSignatureImage: nil,
            hotelId: 105
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedStaff)

        let service = StaffRemoteService(localStorage: localStorage, 
                                        apiManager: apiManager)
        let request = StaffServiceRequest.ChangeStaffUsername(
            id: 1,
            username: "newusername@example.com"
        )

        // When
        let result = try await service.changeStaffUsername(request: request)

        // Then
        XCTAssertEqual(result.id, expectedStaff.id)
        XCTAssertEqual(result.username, expectedStaff.username)
        XCTAssertEqual(result.email, expectedStaff.email)
        XCTAssertEqual(result.firstName, expectedStaff.firstName)
        XCTAssertEqual(result.lastName, expectedStaff.lastName)
    }

    func testDeleteStaff_WillSucceed() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = StaffRemoteService(localStorage: localStorage, 
                                        apiManager: apiManager)
        let request = StaffServiceRequest.DeleteStaff(id: 3)

        // When/Then
        do {
            try await service.deleteStaff(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("Delete should not throw error")
        }
    }

    func testChangeHotel_WillGetValidResponse() async throws {
        // Given
        let expectedStaff = Staff(
            id: 1,
            status: .active,
            role: .frontDesk,
            userId: 101,
            username: "staff1@example.com",
            email: "staff1@example.com",
            firstName: "John",
            lastName: "Doe",
            phoneNumber: "123-456-7890",
            idCard: "1234567890123",
            logoImage: nil,
            signSignatureImage: nil,
            hotelId: 201
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedStaff)

        let service = StaffRemoteService(localStorage: localStorage, 
                                        apiManager: apiManager)
        let request = StaffServiceRequest.ChangeHotel(
            id: 1,
            hotelId: 201
        )

        // When
        let result = try await service.changeHotel(request: request)

        // Then
        XCTAssertEqual(result.id, expectedStaff.id)
        XCTAssertEqual(result.hotelId, expectedStaff.hotelId)
    }

    func testChangePassword_WillGetValidResponse() async throws {
        // Given
        let expectedStaff = Staff(
            id: 1,
            status: .active,
            role: .frontDesk,
            userId: 101,
            username: "staff1@example.com",
            email: "staff1@example.com",
            firstName: "John",
            lastName: "Doe",
            phoneNumber: "123-456-7890",
            idCard: "1234567890123",
            logoImage: nil,
            signSignatureImage: nil,
            hotelId: 105
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedStaff)

        let service = StaffRemoteService(localStorage: localStorage, 
                                        apiManager: apiManager)
        let request = StaffServiceRequest.ChangePassword(
            id: 1,
            password: "newpassword123"
        )

        // When
        let result = try await service.changePassword(request: request)

        // Then
        XCTAssertEqual(result.id, expectedStaff.id)
        XCTAssertEqual(result.email, expectedStaff.email)
    }

    func testUpdateStatus_WillGetValidResponse() async throws {
        // Given
        let expectedStaff = Staff(
            id: 1,
            status: .inactive,
            role: .frontDesk,
            userId: 101,
            username: "staff1@example.com",
            email: "staff1@example.com",
            firstName: "John",
            lastName: "Doe",
            phoneNumber: "123-456-7890",
            idCard: "1234567890123",
            logoImage: nil,
            signSignatureImage: nil,
            hotelId: 105
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedStaff)

        let service = StaffRemoteService(localStorage: localStorage, 
                                        apiManager: apiManager)
        let request = StaffServiceRequest.UpdateStatus(
            id: 1,
            status: .inactive
        )

        // When
        let result = try await service.updateStatus(request: request)

        // Then
        XCTAssertEqual(result.id, expectedStaff.id)
        XCTAssertEqual(result.status, expectedStaff.status)
    }

    func testVerifyPin_WillGetValidResponse() async throws {
        // Given      
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn()

        let service = StaffRemoteService(localStorage: localStorage, 
                                        apiManager: apiManager)
        let request = StaffServiceRequest.VerifyPin(
            id: 1,
            pinCode: "1234"
        )

        // When
        do {
            try await service.verifyPin(request: request)
        }
        catch {
            XCTFail()
        }
                
        // Then
        
    }
} 
