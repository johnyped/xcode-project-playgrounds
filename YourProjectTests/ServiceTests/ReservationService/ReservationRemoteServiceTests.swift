//
//  ReservationRemoteServiceTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest
import Mockable

class ReservationRemoteServiceTests: XCTestCase {
    
    var sut: ReservationRemoteService!
    var mockAPIManager: MockAPIManagerProtocal!
    var mockLocalStorage: MockLocalStorageManagerProtocal!
    
    override func setUp() {
        super.setUp()
        mockAPIManager = MockAPIManagerProtocal()
        mockLocalStorage = MockLocalStorageManagerProtocal()
        sut = ReservationRemoteService(localStorage: mockLocalStorage, apiManager: mockAPIManager)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIManager = nil
        mockLocalStorage = nil
        super.tearDown()
    }
    
    // MARK: - Test fetchReservations
    
    func test_fetchReservations_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservations(
            hotelId: 105,
            status: .confirmed,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        let expectedReservations = createMockReservationsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservations)
        
        // Act
        let result = try await sut.fetchReservations(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedReservations.totalItems)
        XCTAssertEqual(result.items.first?.id, expectedReservations.items.first?.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_fetchReservations_failure() async throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservations(
            hotelId: 105,
            status: .confirmed,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        let error = APIError.unknownError(title: "Stub Error",
                                          subtitle: nil,
                                          underlying: nil)
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce { (a, b) -> Paginator<Reservation> in
                throw error
            }
        
        // Act & Assert
        do {
            _ = try await sut.fetchReservations(request: request)
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
    
    // MARK: - Test fetchReservationsByFlags
    
    func test_fetchReservationsByFlags_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservationsByFlags(
            hotelId: 105,
            flags: [.red, .blue],
            page: 1,
            perPage: .fifty,
            sortedBy: .checkInDate,
            sortedOrder: .descending
        )
        
        let expectedReservations = createMockReservationsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservations)
        
        // Act
        let result = try await sut.fetchReservationsByFlags(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedReservations.totalItems)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchReservationsByGuest
    
    func test_fetchReservationsByGuest_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservationsByGuest(
            hotelId: 105,
            guestId: 123,
            page: 1,
            perPage: .ten,
            sortedBy: .createdAt,
            sortedOrder: .ascending
        )
        
        let expectedReservations = createMockReservationsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservations)
        
        // Act
        let result = try await sut.fetchReservationsByGuest(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedReservations.totalItems)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchReservationsByCompany
    
    func test_fetchReservationsByCompany_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservationsByCompany(
            hotelId: 105,
            companyId: 456,
            page: 1,
            perPage: .twenty,
            sortedBy: .checkInDate,
            sortedOrder: .descending
        )
        
        let expectedReservations = createMockReservationsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservations)
        
        // Act
        let result = try await sut.fetchReservationsByCompany(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedReservations.totalItems)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchReservationsByPeriod
    
    func test_fetchReservationsByPeriod_success() async throws {
        // Arrange
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate)!
        let period = PeriodDate(start: startDate, end: endDate)
        
        let request = ReservationServiceRequest.FetchReservationsByPeriod(
            hotelId: 105,
            period: period,
            status: .checkedIn,
            page: 1,
            perPage: .hundred,
            sortedBy: .checkOutDate,
            sortedOrder: .ascending
        )
        
        let expectedReservations = createMockReservationsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservations)
        
        // Act
        let result = try await sut.fetchReservationsByPeriod(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedReservations.totalItems)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchReservationsByCreatedAt
    
    func test_fetchReservationsByCreatedAt_success() async throws {
        // Arrange
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate)!
        let period = PeriodDate(start: startDate, end: endDate)
        
        let request = ReservationServiceRequest.FetchReservationsByCreatedAt(
            hotelId: 105,
            period: period,
            page: 1,
            perPage: .twenty,
            sortedBy: .createdAt,
            sortedOrder: .descending
        )
        
        let expectedReservations = createMockReservationsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservations)
        
        // Act
        let result = try await sut.fetchReservationsByCreatedAt(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedReservations.totalItems)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchReservationsByTags
    
    func test_fetchReservationsByTags_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservationsByTags(
            hotelId: 105,
            tags: ["VIP", "Corporate"],
            page: 1,
            perPage: .fifty,
            sortedBy: .checkInDate,
            sortedOrder: .ascending
        )
        
        let expectedReservations = createMockReservationsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservations)
        
        // Act
        let result = try await sut.fetchReservationsByTags(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedReservations.totalItems)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchReservationsByKeyword
    
    func test_fetchReservationsByKeyword_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservationsByKeyword(
            hotelId: 105,
            keyword: "John Smith",
            page: 1,
            perPage: .twenty,
            sortedBy: .checkInDate,
            sortedOrder: .ascending
        )
        
        let expectedReservations = createMockReservationsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservations)
        
        // Act
        let result = try await sut.fetchReservationsByKeyword(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedReservations.totalItems)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchReservationByUid
    
    func test_fetchReservationByUid_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservationByUid(
            hotelId: 105,
            uid: "rsvt_thai_booking_001"
        )
        
        let expectedReservation = createMockReservation()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservation)
        
        // Act
        let result = try await sut.fetchReservationByUid(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedReservation.id)
        XCTAssertEqual(result.uid, expectedReservation.uid)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchReservation
    
    func test_fetchReservation_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.FetchById(id: 512)
        
        let expectedReservation = createMockReservation()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservation)
        
        // Act
        let result = try await sut.fetchReservation(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedReservation.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test checkIn
    
    func test_checkIn_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.CheckIn(id: 512)
        let expectedReservation = createMockReservation()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservation)
        
        // Act
        let result = try await sut.checkIn(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedReservation.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test checkOut
    
    func test_checkOut_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.CheckOut(id: 512)
        let expectedReservation = createMockReservation()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservation)
        
        // Act
        let result = try await sut.checkOut(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedReservation.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test cancel
    
    func test_cancel_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.Cancel(id: 512)
        let expectedReservation = createMockReservation()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservation)
        
        // Act
        let result = try await sut.cancel(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedReservation.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test Guest Management
    
    func test_appendGuest_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.AppendGuest(
            id: 512,
            guestId: 789
        )
        let expectedReservation = createMockReservation()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservation)
        
        // Act
        let result = try await sut.appendGuest(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedReservation.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test noShow
    
    func test_noShow_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.NoShow(id: 512)
        let expectedReservation = createMockReservation()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservation)
        
        // Act
        let result = try await sut.noShow(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedReservation.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchConfirmation
    
    func test_fetchConfirmation_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.FetchConfirmation(id: 512)
        
        let expectedConfirmation = ReservationServiceResponse.ConfirmationInfo(
            createdAt: "2023-11-15T10:30:00Z",
            remark: "Confirmation for reservation #512",
            url: "https://example.com/confirmation/512"
        )
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedConfirmation)
        
        // Act
        let result = try await sut.fetchConfirmation(request: request)
        
        // Assert
        XCTAssertEqual(result.createdAt, expectedConfirmation.createdAt)
        XCTAssertEqual(result.remark, expectedConfirmation.remark)
        XCTAssertEqual(result.url, expectedConfirmation.url)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Helper Methods
    
    private func createMockReservationsPaginator() -> Paginator<Reservation> {
        let reservation = createMockReservation()
        let collection = Reservations(array: [reservation])
        
        return Paginator<Reservation>(
            items: collection,
            totalItems: 1,
            totalPages: 1,
            perPage: 20,
            page: 1
        )
    }
    
    private func createMockReservation() -> Reservation {
        let checkInDate = Date()
        let checkOutDate = Calendar.current.date(byAdding: .day, value: 3, to: checkInDate) ?? Date()
        let createdAt = Date()
        let updatedAt = Date()
        
        let contacts = Reservation.Contacts(
            title: "Mr.",
            fullname: "John Smith",
            email: "john.smith@example.com",
            tel: "+66123456789"
        )
        
        return Reservation(
            id: 512,
            uid: "rsvt_5la15znqpb30lz5rmqj",
            status: .confirmed,
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            adultNumber: 2,
            extraAdultNumber: 0,
            childNumber: 1,
            contacts: contacts,
            note: "Adjacent rooms requested",
            canceledReason: nil,
            documentPhotos: nil,
            otaBookingId: "",
            relatedReservationId: nil,
            guestComment: "High floor room preferred",
            markers: [],
            flags: [.red],
            tags: ["VIP"],
            emoji: nil,
            hotelChannelReservationId: nil,
            hotelId: 105,
            creatorId: 38,
            channelId: 1,
            subChannelId: nil,
            checkedInAt: nil,
            checkedOutAt: nil,
            canceledAt: nil,
            noShowAt: nil,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
} 
