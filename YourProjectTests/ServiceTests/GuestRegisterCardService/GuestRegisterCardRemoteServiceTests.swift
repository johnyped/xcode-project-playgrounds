 //
//  GuestRegisterCardRemoteServiceTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest
import Mockable

class GuestRegisterCardRemoteServiceTests: XCTestCase {
    
    var sut: GuestRegisterCardRemoteService!
    var mockAPIManager: MockAPIManagerProtocal!
    var mockLocalStorage: MockLocalStorageManagerProtocal!
    
    override func setUp() {
        super.setUp()
        mockAPIManager = MockAPIManagerProtocal()
        mockLocalStorage = MockLocalStorageManagerProtocal()
        sut = GuestRegisterCardRemoteService(localStorage: mockLocalStorage, apiManager: mockAPIManager)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIManager = nil
        mockLocalStorage = nil
        super.tearDown()
    }
    
    // MARK: - Test fetchGuestRegisterCards
    
    func test_fetchGuestRegisterCards_success() async throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.FetchGuestRegisterCards(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        let expectedGuestRegisterCards = createMockGuestRegisterCardsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedGuestRegisterCards)
        
        // Act
        let result = try await sut.fetchGuestRegisterCards(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedGuestRegisterCards.totalItems)
        XCTAssertEqual(result.items.first?.id, expectedGuestRegisterCards.items.first?.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_fetchGuestRegisterCards_failure() async throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.FetchGuestRegisterCards(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        let error = APIError.unknownError(title: "Stub Error", subtitle: nil, underlying: nil)
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce { (a,b) -> Paginator<GuestRegisterCard> in
                throw error
            }
        
        // Act & Assert
        do {
            _ = try await sut.fetchGuestRegisterCards(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error as? APIError {
            case .unknownError(let title, _, _):
                XCTAssertEqual(title, "Stub Error")
            default:
                XCTFail("Unexpected error type")
            }
        }
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchByGuest
    
    func test_fetchByGuest_success() async throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.FetchByGuest(
            hotelId: 105,
            customerId: 267,
            page: 1,
            perPage: .twenty,
            sortedBy: .createdAt,
            sortedOrder: .descending
        )
        
        let expectedGuestRegisterCards = createMockGuestRegisterCardsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedGuestRegisterCards)
        
        // Act
        let result = try await sut.fetchByGuest(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedGuestRegisterCards.totalItems)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchByReservation
    
    func test_fetchByReservation_success() async throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 987,
            page: 1,
            perPage: .fifty,
            sortedBy: .updatedAt,
            sortedOrder: .ascending
        )
        
        let expectedGuestRegisterCards = createMockGuestRegisterCardsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedGuestRegisterCards)
        
        // Act
        let result = try await sut.fetchByReservation(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedGuestRegisterCards.totalItems)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchByPeriod
    
    func test_fetchByPeriod_success() async throws {
        // Arrange
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate)!
        let period = PeriodDate(start: startDate, end: endDate)
        
        let request = GuestRegisterCardServiceRequest.FetchByPeriod(
            hotelId: 105,
            period: period,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        let expectedGuestRegisterCards = createMockGuestRegisterCardsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedGuestRegisterCards)
        
        // Act
        let result = try await sut.fetchByPeriod(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedGuestRegisterCards.totalItems)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchGuestRegisterCardById
    
    func test_fetchGuestRegisterCardById_success() async throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.FetchById(id: 17)
        let expectedGuestRegisterCard = createMockGuestRegisterCard()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedGuestRegisterCard)
        
        // Act
        let result = try await sut.fetchGuestRegisterCardById(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedGuestRegisterCard.id)
        XCTAssertEqual(result.guestId, expectedGuestRegisterCard.guestId)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test updateGuestRegisterCard
    
    func test_updateGuestRegisterCard_success() async throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.UpdateRequest(
            id: 17,
            purposeOfVisit: .business,
            fromAddress: "Updated address",
            fromCountry: "THA",
            nextAddress: "Next address",
            nextCountry: "THA",
            remark: "Updated remark"
        )
        
        let expectedGuestRegisterCard = createMockGuestRegisterCard()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedGuestRegisterCard)
        
        // Act
        let result = try await sut.updateGuestRegisterCard(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedGuestRegisterCard.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test deleteGuestRegisterCard
    
    func test_deleteGuestRegisterCard_success() async throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.DeleteGuestRegisterCard(id: 17)
        
        given(mockAPIManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())
        
        // Act
        try await sut.deleteGuestRegisterCard(request: request)
        
        // Assert
        verify(mockAPIManager)
            .requestACK(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test acceptPdpa
    
    func test_acceptPdpa_success() async throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.AcceptPdpa(id: 17)
        let expectedGuestRegisterCard = createMockGuestRegisterCard()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedGuestRegisterCard)
        
        // Act
        let result = try await sut.acceptPdpa(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedGuestRegisterCard.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test acceptRules
    
    func test_acceptRules_success() async throws {
        // Arrange
        let request = GuestRegisterCardServiceRequest.AcceptRules(id: 17)
        let expectedGuestRegisterCard = createMockGuestRegisterCard()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedGuestRegisterCard)
        
        // Act
        let result = try await sut.acceptRules(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedGuestRegisterCard.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Helper Methods
    
    private func createMockGuestRegisterCardsPaginator() -> Paginator<GuestRegisterCard> {
        let guestRegisterCards = [createMockGuestRegisterCard()]
        return Paginator(
            items: Collection(array: guestRegisterCards),
            totalItems: 1,
            totalPages: 1,
            perPage: 20,
            page: 1
        )
    }
    
    private func createMockGuestRegisterCard() -> GuestRegisterCard {
        return GuestRegisterCard(
            id: 17,
            hotelId: 105,
            guestId: 267,
            reservationId: 987,
            pdpaId: 1,
            purposeOfVisit: .leisure,
            fromAddress: nil,
            nextAddress: nil,
            remark: nil,
            fromCountry: "THA",
            nextCountry: "THA",
            acceptedRulesAt: Date(),
            acceptedPdpaAt: Date(),
            createdAt: Date(),
            updatedAt: Date()
        )
    }
}
