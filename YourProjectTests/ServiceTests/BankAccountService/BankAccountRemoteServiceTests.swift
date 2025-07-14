//
//  BankAccountRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest
import Mockable

final class BankAccountRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchBankAccounts_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<BankAccounts>(
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

        let service = BankAccountRemoteService(localStorage: localStorage,
                                              apiManager: apiManager)
        let request = BankAccountServiceRequest.FetchBankAccounts(
            page: 1,
            perPage: 20,
            sortedBy: "ID",
            sortedOrder: "ASC",
            hotelId: 105
        )

        // When
        let result = try await service.fetchBankAccounts(request: request)

        // Then
        XCTAssertEqual(result.totalItems,
                       expectedPaginator.totalItems)
        XCTAssertEqual(result.page,
                       expectedPaginator.page)
        XCTAssertEqual(result.perPage,
                       expectedPaginator.perPage)
    }

    func testFetchBankAccount_WillGetValidResponse() async throws {
        // Given
        let expectedBankAccount = BankAccount(
            id: 2,
            bankNumber: "3202999102",
            bankName: "กสิกรไทย",
            bankBranch: "สยามพารากอน",
            accountName: "นายสมชาย ชาติทหาร",
            isDefault: false,
            hotelId: 105,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedBankAccount)

        let service = BankAccountRemoteService(localStorage: localStorage, 
                                              apiManager: apiManager)
        let request = BankAccountServiceRequest.FetchBankAccount(id: 2)

        // When
        let result = try await service.fetchBankAccount(request: request)

        // Then
        XCTAssertEqual(result.id, expectedBankAccount.id)
        XCTAssertEqual(result.bankNumber, expectedBankAccount.bankNumber)
        XCTAssertEqual(result.bankName, expectedBankAccount.bankName)
        XCTAssertEqual(result.bankBranch, expectedBankAccount.bankBranch)
        XCTAssertEqual(result.accountName, expectedBankAccount.accountName)
        XCTAssertEqual(result.isDefault, expectedBankAccount.isDefault)
        XCTAssertEqual(result.hotelId, expectedBankAccount.hotelId)
    }

    func testCreateBankAccount_WillGetValidResponse() async throws {
        // Given
        let expectedBankAccount = BankAccount(
            id: 3,
            bankNumber: "1234567890",
            bankName: "ธนาคารกรุงเทพ",
            bankBranch: "สาขาใหญ่",
            accountName: "นายทดสอบ ระบบ",
            isDefault: true,
            hotelId: 105,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedBankAccount)

        let service = BankAccountRemoteService(localStorage: localStorage, 
                                              apiManager: apiManager)
        let request = BankAccountServiceRequest.CreateBankAccount(
            bankNumber: "1234567890",
            bankName: "ธนาคารกรุงเทพ",
            bankBranch: "สาขาใหญ่",
            accountName: "นายทดสอบ ระบบ",
            isDefault: true,
            hotelId: 105
        )

        // When
        let result = try await service.createBankAccount(request: request)

        // Then
        XCTAssertEqual(result.id, expectedBankAccount.id)
        XCTAssertEqual(result.bankNumber, expectedBankAccount.bankNumber)
        XCTAssertEqual(result.bankName, expectedBankAccount.bankName)
        XCTAssertEqual(result.bankBranch, expectedBankAccount.bankBranch)
        XCTAssertEqual(result.accountName, expectedBankAccount.accountName)
        XCTAssertEqual(result.isDefault, expectedBankAccount.isDefault)
        XCTAssertEqual(result.hotelId, expectedBankAccount.hotelId)
    }

    func testUpdateBankAccount_WillGetValidResponse() async throws {
        // Given
        let expectedBankAccount = BankAccount(
            id: 2,
            bankNumber: "9876543210",
            bankName: "ธนาคารกสิกรไทย",
            bankBranch: "สาขาอัพเดท",
            accountName: "นายอัพเดท ทดสอบ",
            isDefault: true,
            hotelId: 105,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedBankAccount)

        let service = BankAccountRemoteService(localStorage: localStorage, 
                                              apiManager: apiManager)
        let request = BankAccountServiceRequest.UpdateBankAccount(
            id: 2,
            bankNumber: "9876543210",
            bankName: "ธนาคารกสิกรไทย",
            bankBranch: "สาขาอัพเดท",
            accountName: "นายอัพเดท ทดสอบ",
            isDefault: true
        )

        // When
        let result = try await service.updateBankAccount(request: request)

        // Then
        XCTAssertEqual(result.id, expectedBankAccount.id)
        XCTAssertEqual(result.bankNumber, expectedBankAccount.bankNumber)
        XCTAssertEqual(result.bankName, expectedBankAccount.bankName)
        XCTAssertEqual(result.bankBranch, expectedBankAccount.bankBranch)
        XCTAssertEqual(result.accountName, expectedBankAccount.accountName)
        XCTAssertEqual(result.isDefault, expectedBankAccount.isDefault)
    }

    func testDeleteBankAccount_WillSucceed() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = BankAccountRemoteService(localStorage: localStorage, 
                                              apiManager: apiManager)
        let request = BankAccountServiceRequest.DeleteBankAccount(id: 4)

        // When/Then
        do {
            try await service.deleteBankAccount(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("Delete should not throw error")
        }
    }

    func testSetDefaultBankAccount_WillGetValidResponse() async throws {
        // Given
        let expectedBankAccount = BankAccount(
            id: 5,
            bankNumber: "5555555555",
            bankName: "ธนาคารไทยพาณิชย์",
            bankBranch: "สาขาเซ็นทรัล",
            accountName: "นายค่าเริ่มต้น ทดสอบ",
            isDefault: true,
            hotelId: 105,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedBankAccount)

        let service = BankAccountRemoteService(localStorage: localStorage, 
                                              apiManager: apiManager)
        let request = BankAccountServiceRequest.SetDefaultBankAccount(id: 5)

        // When
        let result = try await service.setDefaultBankAccount(request: request)

        // Then
        XCTAssertEqual(result.id, expectedBankAccount.id)
        XCTAssertEqual(result.isDefault, true)
        XCTAssertEqual(result.bankName, expectedBankAccount.bankName)
    }
} 