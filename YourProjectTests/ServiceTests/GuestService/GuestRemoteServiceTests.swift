//
//  GuestRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 7/6/2568 BE.
//

import XCTest
import Mockable

final class GuestRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchGuestsByHotel_WillGetValidResponse() async throws {
        let expectedPaginator = Paginator<Guest>(
            items: Collection(array: []),
            totalItems: 0,
            totalPages: 0,
            perPage: 20,
            page: 1
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)
        let service = GuestRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = GuestServiceRequest.FetchGuests(
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            hotelId: 105,
            includeHidden: true
        )
        let result = try await service.fetchGuestsByHotel(request: request)
        XCTAssertEqual(result.totalItems, expectedPaginator.totalItems)
        XCTAssertEqual(result.page, expectedPaginator.page)
        XCTAssertEqual(result.perPage, expectedPaginator.perPage)
    }

    func testFetchGuest_WillGetValidResponse() async throws {
        let expectedGuest = Guest(id: 2,
                                  titleCode: "Mr",
                                  firstName: "John",
                                  midName: "Middle",
                                  lastName: "Doe",
                                  nickName: "JD",
                                  nationalityCode: "THA",
                                  countryCode: "THA",
                                  birthdate: Date(),
                                  citizenCardID: "1234567890123",
                                  passportNo: "A1234567",
                                  gender: .male,
                                  email: "john.doe@example.com",
                                  phone: "0812345678",
                                  note: "Test note",
                                  hotelId: 789,
                                  companyId: 456,
                                  isFirst: false,
                                  isHidden: false,
                                  address: Address(houseNumber: "123 Main St",
                                                   district: "District",
                                                   province: "Province",
                                                   zipCode: "10100",
                                                   countryCode: "THA"),
                                  occupation: "Engineer",
                                  createdAt: Date(),
                                  updatedAt: Date())

        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedGuest)
        let service = GuestRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = GuestServiceRequest.FetchGuest(id: 2)
        let result = try await service.fetchGuest(request: request)
        XCTAssertEqual(result.id, expectedGuest.id)
        XCTAssertEqual(result.firstName, expectedGuest.firstName)
        XCTAssertEqual(result.lastName, expectedGuest.lastName)
        XCTAssertEqual(result.nationalityCode, expectedGuest.nationalityCode)
        XCTAssertEqual(result.countryCode, expectedGuest.countryCode)
        XCTAssertEqual(result.hotelId, expectedGuest.hotelId)
    }

    func testCreateGuest_WillGetValidResponse() async throws {
        let expectedGuest = Guest(id: 3,
                                  titleCode: "Mr",
                                  firstName: "John",
                                  midName: "Middle",
                                  lastName: "Doe",
                                  nickName: "JD",
                                  nationalityCode: "THA",
                                  countryCode: "THA",
                                  birthdate: Date(),
                                  citizenCardID: "1234567890123",
                                  passportNo: "A1234567",
                                  gender: .male,
                                  email: "john.doe@example.com",
                                  phone: "0812345678",
                                  note: "Test note",
                                  hotelId: 789,
                                  companyId: 456,
                                  isFirst: false,
                                  isHidden: false,
                                  address: Address(houseNumber: "123 Main St",
                                                   district: "District",
                                                   province: "Province",
                                                   zipCode: "10100",
                                                   countryCode: "THA"),
                                  occupation: "Engineer",
                                  createdAt: Date(),
                                  updatedAt: Date())
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedGuest)
        let service = GuestRemoteService(localStorage: localStorage, apiManager: apiManager)
        let dateOfBirth = Date(timeIntervalSince1970: 631152000) // 1990-01-01
        let request = GuestServiceRequest.CreateGuest(
            firstName: "John",
            lastName: "Doe",
            nationality: "THA",
            country: "THA",
            reservationId: 123,
            companyId: 456,
            hotelId: 789,
            title: "Mr.",
            middleName: "Middle",
            dateOfBirth: dateOfBirth,
            idCardNo: "1234567890123",
            passportNo: "A1234567",
            gender: .male,
            email: "john.doe@example.com",
            occupation: "Engineer",
            phone: "0812345678",
            address: "123 Main St",
            district: "District",
            province: "Province",
            zipCode: "10100",
            note: "Test note",
            nickname: "JD",
            photos: ["photo1.jpg", "photo2.jpg"],
            documentPhotos: ["doc1.jpg", "doc2.jpg"]
        )
        let result = try await service.createGuest(request: request)
        XCTAssertEqual(result.id, expectedGuest.id)
        XCTAssertEqual(result.firstName, expectedGuest.firstName)
        XCTAssertEqual(result.lastName, expectedGuest.lastName)
        XCTAssertEqual(result.nationalityCode, expectedGuest.nationalityCode)
        XCTAssertEqual(result.countryCode, expectedGuest.countryCode)
        XCTAssertEqual(result.hotelId, expectedGuest.hotelId)
        XCTAssertEqual(result.companyId, expectedGuest.companyId)
        XCTAssertEqual(result.isFirst, expectedGuest.isFirst)
        XCTAssertEqual(result.isHidden, expectedGuest.isHidden)
        XCTAssertEqual(result.address.houseNumber, expectedGuest.address.houseNumber)
        XCTAssertEqual(result.address.district, expectedGuest.address.district)
        XCTAssertEqual(result.address.province, expectedGuest.address.province)
        XCTAssertEqual(result.address.zipCode, expectedGuest.address.zipCode)
        XCTAssertEqual(result.address.countryCode, expectedGuest.address.countryCode)
        XCTAssertEqual(result.address.countryNameWithFlag, expectedGuest.address.countryNameWithFlag)
        XCTAssertEqual(result.createdAt, expectedGuest.createdAt)
        XCTAssertEqual(result.updatedAt, expectedGuest.updatedAt)
    }

    func testUpdateGuest_WillGetValidResponse() async throws {
        let expectedGuest = Guest(id: 1,
                                  titleCode: "Mr",
                                  firstName: "John",
                                  midName: "Middle",
                                  lastName: "Doe",
                                  nickName: "JD",
                                  nationalityCode: "THA",
                                  countryCode: "THA",
                                  birthdate: Date(),
                                  citizenCardID: "1234567890123",
                                  passportNo: "A1234567",
                                  gender: .male,
                                  email: "john.doe@example.com",
                                  phone: "0812345678",
                                  note: "Test note",
                                  hotelId: 789,
                                  companyId: 456,
                                  isFirst: false,
                                  isHidden: false,
                                  address: Address(houseNumber: "123 Main St",
                                                   district: "District",
                                                   province: "Province",
                                                   zipCode: "10100",
                                                   countryCode: "THA"),
                                  occupation: "Engineer",
                                  createdAt: Date(),
                                  updatedAt: Date())
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedGuest)
        let service = GuestRemoteService(localStorage: localStorage, apiManager: apiManager)
        let dateOfBirth = Date(timeIntervalSince1970: 631152000) // 1990-01-01
        let request = GuestServiceRequest.UpdateGuest(
            id: 1,
            companyId: 456,
            title: "Mr.",
            firstName: "John",
            middleName: "Middle",
            lastName: "Doe",
            nationality: "THA",
            country: "THA",
            dateOfBirth: dateOfBirth,
            idCardNo: "1234567890123",
            passportNo: "A1234567",
            gender: .male,
            email: "john.doe@example.com",
            occupation: "Engineer",
            phone: "0812345678",
            address: "123 Main St",
            district: "District",
            province: "Province",
            zipCode: "10100",
            note: "Test note",
            nickname: "JD",
            photos: ["photo1.jpg", "photo2.jpg"],
            documentPhotos: ["doc1.jpg", "doc2.jpg"]
        )
        let result = try await service.updateGuest(request: request)
        XCTAssertEqual(result.id, expectedGuest.id)
        XCTAssertEqual(result.firstName, expectedGuest.firstName)
        XCTAssertEqual(result.lastName, expectedGuest.lastName)
        XCTAssertEqual(result.nationalityCode, expectedGuest.nationalityCode)
        XCTAssertEqual(result.countryCode, expectedGuest.countryCode)
        XCTAssertEqual(result.hotelId, expectedGuest.hotelId)
        XCTAssertEqual(result.companyId, expectedGuest.companyId)
        XCTAssertEqual(result.isFirst, expectedGuest.isFirst)
        XCTAssertEqual(result.isHidden, expectedGuest.isHidden)
        XCTAssertEqual(result.address.houseNumber, expectedGuest.address.houseNumber)
        XCTAssertEqual(result.address.district, expectedGuest.address.district)
        XCTAssertEqual(result.address.province, expectedGuest.address.province)
        XCTAssertEqual(result.address.zipCode, expectedGuest.address.zipCode)
        XCTAssertEqual(result.createdAt, expectedGuest.createdAt)
        XCTAssertEqual(result.updatedAt, expectedGuest.updatedAt)
        
    }

    func testDeleteGuest_WillSucceed() async throws {
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())
        let service = GuestRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = GuestServiceRequest.DeleteGuest(id: 4)
        do {
            try await service.deleteGuest(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("Delete should not throw error")
        }
    }
} 
