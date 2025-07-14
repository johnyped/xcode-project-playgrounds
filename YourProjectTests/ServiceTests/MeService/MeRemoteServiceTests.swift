//
//  MeRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//

import XCTest
import Mockable

final class MeRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchProfile_WillGetValidResponse() async throws {
        // Given
        let expectedMe = Me(
            id: 38,
            email: "test1@email.com",
            firstName: "John2",
            lastName: "Doe2",
            phoneNumber: "1234567890",
            role: .supportSuperAdmin,
            idCard: "1232323232333",
            logoImage: nil,
            signSignatureImage: nil,
            verifiedAt: nil,
            passwordChangedAt: "2023-11-28T06:11:43.011+07:00",
            authProviders: [],
            images: [],
            staffId: nil,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedMe)

        let service = MeRemoteService(localStorage: localStorage,
                                      apiManager: apiManager)

        // When
        let result = try await service.fetchProfile()

        // Then
        XCTAssertEqual(result.id, expectedMe.id)
        XCTAssertEqual(result.email, expectedMe.email)
        XCTAssertEqual(result.firstName, expectedMe.firstName)
        XCTAssertEqual(result.lastName, expectedMe.lastName)
        XCTAssertEqual(result.phoneNumber, expectedMe.phoneNumber)
        XCTAssertEqual(result.role, expectedMe.role)
        XCTAssertEqual(result.idCard, expectedMe.idCard)
    }

    func testUpdateProfile_WillGetValidResponse() async throws {
        // Given
        let expectedMe = Me(
            id: 38,
            email: "test1@email.com",
            firstName: "John",
            lastName: "Doe",
            phoneNumber: "1234567890",
            role: .user,
            idCard: "1234567890123",
            logoImage: nil,
            signSignatureImage: nil,
            verifiedAt: nil,
            passwordChangedAt: "2023-11-28T06:11:43.011+07:00",
            authProviders: [],
            images: [],
            staffId: nil,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedMe)

        let service = MeRemoteService(localStorage: localStorage,
                                      apiManager: apiManager)
        let request = MeServiceRequest.UpdateProfile(
            firstName: "John",
            lastName: "Doe",
            phoneNumber: "1234567890",
            pinCode: "12345",
            idCard: "1234567890123",
            lineAccessToken: "line_token_123",
            notificationLanguage: "th"
        )

        // When
        let result = try await service.updateProfile(request: request)

        // Then
        XCTAssertEqual(result.id, expectedMe.id)
        XCTAssertEqual(result.firstName, expectedMe.firstName)
        XCTAssertEqual(result.lastName, expectedMe.lastName)
        XCTAssertEqual(result.phoneNumber, expectedMe.phoneNumber)
        XCTAssertEqual(result.idCard, expectedMe.idCard)
    }

    func testChangeEmail_WillGetValidResponse() async throws {
        // Given
        let expectedMe = Me(
            id: 38,
            email: "new@email.com",
            firstName: "John2",
            lastName: "Doe2",
            phoneNumber: "1234567890",
            role: nil,
            idCard: "1232323232333",
            logoImage: nil,
            signSignatureImage: nil,
            verifiedAt: nil,
            passwordChangedAt: "2023-11-28T06:11:43.011+07:00",
            authProviders: [],
            images: [],
            staffId: nil,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedMe)

        let service = MeRemoteService(localStorage: localStorage,
                                      apiManager: apiManager)
        let request = MeServiceRequest.ChangeEmail(
            currentPassword: "current123",
            newEmail: "new@email.com",
            newEmailConfirmation: "new@email.com"
        )

        // When
        let result = try await service.changeEmail(request: request)

        // Then
        XCTAssertEqual(result.id, expectedMe.id)
        XCTAssertEqual(result.email, expectedMe.email)
    }

    func testChangePassword_WillGetValidResponse() async throws {
        // Given
        let expectedMe = Me(
            id: 38,
            email: "test1@email.com",
            firstName: "John2",
            lastName: "Doe2",
            phoneNumber: "1234567890",
            role: nil,
            idCard: "1232323232333",
            logoImage: nil,
            signSignatureImage: nil,
            verifiedAt: nil,
            passwordChangedAt: "2023-11-28T06:11:43.011+07:00",
            authProviders: [],
            images: [],
            staffId: nil,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedMe)

        let service = MeRemoteService(localStorage: localStorage,
                                      apiManager: apiManager)
        let request = MeServiceRequest.ChangePassword(
            currentPassword: "current123",
            newPassword: "new123",
            newPasswordConfirmation: "new123"
        )

        // When
        let result = try await service.changePassword(request: request)

        // Then
        XCTAssertEqual(result.id, expectedMe.id)
        XCTAssertEqual(result.passwordChangedAt, expectedMe.passwordChangedAt)
    }

    func testVerification_WillGetValidResponse() async throws {
        // Given
        let expectedMe = Me(
            id: 38,
            email: "test1@email.com",
            firstName: "John2",
            lastName: "Doe2",
            phoneNumber: "1234567890",
            role: nil,
            idCard: "1232323232333",
            logoImage: nil,
            signSignatureImage: nil,
            verifiedAt: "2025-01-01T00:00:00.000+07:00",
            passwordChangedAt: "2023-11-28T06:11:43.011+07:00",
            authProviders: [],
            images: [],
            staffId: nil,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedMe)

        let service = MeRemoteService(localStorage: localStorage,
                                      apiManager: apiManager)
        let request = MeServiceRequest.Verification(pinCode: "12345")

        // When
        let result = try await service.verification(userId: 38, request: request)

        // Then
        XCTAssertEqual(result.id, expectedMe.id)
        XCTAssertEqual(result.verifiedAt, expectedMe.verifiedAt)
    }

    func testGetNotificationSettings_WillGetValidResponse() async throws {
        // Given
        let expectedNotificationSettings = NotificationSettings(
            notificationLanguage: "th",
            registeredLineAccessToken: true,
            pushNotification: NotificationSettings.NotificationConfig(
                cmBooking: NotificationSettings.MessageConfig(
                    newMessage: true,
                    updatedMessage: true,
                    cancelledMessage: true
                ),
                hmsReservation: NotificationSettings.MessageConfig(
                    newMessage: true,
                    updatedMessage: true,
                    cancelledMessage: true
                ),
                broadcastMessage: NotificationSettings.BroadcastConfig(
                    adminMessage: true,
                    systemMessage: true,
                    operatorMessage: true
                )
            ),
            lineNotification: NotificationSettings.NotificationConfig(
                cmBooking: NotificationSettings.MessageConfig(
                    newMessage: true,
                    updatedMessage: true,
                    cancelledMessage: true
                ),
                hmsReservation: NotificationSettings.MessageConfig(
                    newMessage: true,
                    updatedMessage: true,
                    cancelledMessage: true
                ),
                broadcastMessage: NotificationSettings.BroadcastConfig(
                    adminMessage: true,
                    systemMessage: true,
                    operatorMessage: true
                )
            )
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedNotificationSettings)

        let service = MeRemoteService(localStorage: localStorage,
                                      apiManager: apiManager)

        // When
        let result = try await service.getNotificationSettings()

        // Then
        XCTAssertEqual(result.notificationLanguage, expectedNotificationSettings.notificationLanguage)
        XCTAssertEqual(result.registeredLineAccessToken, expectedNotificationSettings.registeredLineAccessToken)
        XCTAssertEqual(result.pushNotification.cmBooking.newMessage, 
                      expectedNotificationSettings.pushNotification.cmBooking.newMessage)
        XCTAssertEqual(result.lineNotification.cmBooking.newMessage,
                      expectedNotificationSettings.lineNotification.cmBooking.newMessage)
    }

    func testUpdateNotificationSettings_WillGetValidResponse() async throws {
        // Given
        let expectedMe = Me(
            id: 38,
            email: "test1@email.com",
            firstName: "John2",
            lastName: "Doe2",
            phoneNumber: "1234567890",
            role: nil,
            idCard: "1232323232333",
            logoImage: nil,
            signSignatureImage: nil,
            verifiedAt: nil,
            passwordChangedAt: "2023-11-28T06:11:43.011+07:00",
            authProviders: [],
            images: [],
            staffId: nil,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedMe)

        let service = MeRemoteService(localStorage: localStorage,
                                      apiManager: apiManager)
        let request = MeServiceRequest.NotificationSettings(
            newCmBooking: true,
            cmBookingWasUpdated: false,
            cmBookingWasCancelled: true,
            newHmsReservation: true,
            hmsReservationWasUpdated: false,
            hmsReservationWasCancelled: true,
            adminBroadcastMessage: true,
            systemBroadcastMessage: false,
            operatorBroadcastMessage: true,
            lineNewCmBooking: true,
            lineCmBookingWasUpdated: false,
            lineCmBookingWasCancelled: true,
            lineNewHmsReservation: true,
            lineHmsReservationWasUpdated: false,
            lineHmsReservationWasCancelled: true,
            lineAdminBroadcastMessage: true,
            lineSystemBroadcastMessage: false,
            lineOperatorBroadcastMessage: true
        )

        // When
        let result = try await service.updateNotificationSettings(request: request)

        // Then
        XCTAssertEqual(result.id, expectedMe.id)
    }

    func testFetchDevices_WillGetValidResponse() async throws {
        // Given
        let expectedDevices: Devices = Collection(array: [
            Device(
                id: 12,
                uuid: "BA56A5D2-8EC6-466A-8F95-BDD6148F5336",
                token: "4fdb1a52ff9718dee6236cd7fe54a1e9ac9b7a7198457dab7ee730571f99efac",
                userId: 38,
                createdAt: "2021-04-29T22:05:33.072+07:00",
                updatedAt: "2021-04-29T22:05:33.072+07:00"
            ),
            Device(
                id: 13,
                uuid: "CD67B6E3-9F07-577B-9F96-CEE7259F6447",
                token: "5gec2b63gf8829ef7347de8gf65b2f0bbd8c8b8309546ebc8ff841682g00fgbd",
                userId: 38,
                createdAt: "2021-05-15T14:22:15.123+07:00",
                updatedAt: "2021-05-15T14:22:15.123+07:00"
            )
        ])
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedDevices)

        let service = MeRemoteService(localStorage: localStorage,
                                      apiManager: apiManager)

        // When
        let result = try await service.fetchDevices()

        // Then
        XCTAssertEqual(result.count, expectedDevices.count)
        XCTAssertEqual(result.first?.id, expectedDevices.first?.id)
        XCTAssertEqual(result.first?.uuid, expectedDevices.first?.uuid)
        XCTAssertEqual(result.first?.token, expectedDevices.first?.token)
        XCTAssertEqual(result.first?.userId, expectedDevices.first?.userId)
    }

    func testEmailLoginResendCode_WillSucceed() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = MeRemoteService(localStorage: localStorage,
                                      apiManager: apiManager)
        let request = MeServiceRequest.EmailLoginResendCode(code: "ABC123")

        // When/Then
        do {
            try await service.emailLoginResendCode(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("EmailLoginResendCode should not throw error")
        }
    }

    func testEmailLoginLink_WillGetValidResponse() async throws {
        // Given
        let expectedMe = Me(
            id: 38,
            email: "test1@email.com",
            firstName: "John2",
            lastName: "Doe2",
            phoneNumber: "1234567890",
            role: nil,
            idCard: "1232323232333",
            logoImage: nil,
            signSignatureImage: nil,
            verifiedAt: nil,
            passwordChangedAt: "2023-11-28T06:11:43.011+07:00",
            authProviders: ["email"],
            images: [],
            staffId: nil,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedMe)

        let service = MeRemoteService(localStorage: localStorage,
                                      apiManager: apiManager)
        let request = MeServiceRequest.EmailLoginLink(
            code: "ABC123",
            password: "password123",
            confirmPassword: "password123"
        )

        // When
        let result = try await service.emailLoginLink(request: request)

        // Then
        XCTAssertEqual(result.id, expectedMe.id)
        XCTAssertEqual(result.authProviders, expectedMe.authProviders)
    }

    func testEmailLoginSendCode_WillSucceed() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = MeRemoteService(localStorage: localStorage,
                                      apiManager: apiManager)
        let request = MeServiceRequest.EmailLoginSendCode(email: "test@email.com")

        // When/Then
        do {
            try await service.emailLoginSendCode(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("EmailLoginSendCode should not throw error")
        }
    }

    func testAppleLoginLink_WillSucceed() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = MeRemoteService(localStorage: localStorage,
                                      apiManager: apiManager)
        let request = MeServiceRequest.AppleLoginLink(code: "APPLE123")

        // When/Then
        do {
            try await service.appleLoginLink(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("AppleLoginLink should not throw error")
        }
    }

    func testAppleLoginUnlink_WillSucceed() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = MeRemoteService(localStorage: localStorage,
                                      apiManager: apiManager)
        let request = MeServiceRequest.AppleLoginUnlink(
            password: "password123",
            confirmPassword: "password123"
        )

        // When/Then
        do {
            try await service.appleLoginUnlink(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("AppleLoginUnlink should not throw error")
        }
    }
} 
