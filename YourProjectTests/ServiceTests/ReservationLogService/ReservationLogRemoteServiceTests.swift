//  ReservationLogRemoteServiceTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 23/5/2568 BE.
//
import XCTest
import Mockable

final class ReservationLogRemoteServiceTests: XCTestCase {
    
    private var sut: ReservationLogRemoteService!

    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()
    
    override func setUp() {
        super.setUp()        
        sut = ReservationLogRemoteService(
            localStorage: localStorage,
            apiManager: apiManager
        )
    }
    
    override func tearDown() {
        sut = nil        
        super.tearDown()
    }
    
    // MARK: - Initialization Tests    
    
    func test_init_withProvidedDependencies() throws {
        // Arrange & Act
        let service = ReservationLogRemoteService(
            localStorage: localStorage,
            apiManager: apiManager
        )
        
        // Assert
        XCTAssertNotNil(service)
    }
    
    // MARK: - FetchByReservation Tests
    
    func test_fetchByReservation_success() async throws {
        // Arrange
        let expectedResponse = ReservationLogs(array: [createSampleReservationLog()])
        let request = ReservationLogServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 1092
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)
        
        // Act
        let result = try await sut.fetchByReservation(request: request)
        
        // Assert
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, expectedResponse.count)
        
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_fetchByReservation_failure() async throws {
        // Arrange
        let error = APIError.unknownError(title: "Stub Error",
                                          subtitle: nil,
                                          underlying: nil)
        let request = ReservationLogServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 1092
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce({ (a,b) -> ReservationLogs in
                throw error
            })
        
        // Act & Assert
        do {
            _ = try await sut.fetchByReservation(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error as? APIError {
            case .unknownError(let title, _ , _):
                XCTAssertEqual(title, "Stub Error")
            default:
                XCTFail("Unexpected error type")
            }
        }
                
        verify(apiManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Helper Methods
    
    private func createSampleReservationLog() -> ReservationLog {
        let user = ReservationLog.User(
            id: 38,
            firstName: "John",
            lastName: "Doe",
            email: "john.doe@test.com",
            role: "ROLE_SUPPORT_SUPER_ADMIN",
            staffRole: nil
        )
        
        let itemData = ReservationLog.ItemData(
            extraBedRate: 0,
            extraPersonRate: 500,
            childMealRate: 0,
            adultMealLimit: 0,
            extraAdultMealNumber: 0,
            extraChildMealRate: 0,
            adultMealRate: 0,
            extraPersonNumber: 0,
            priceCardRate: 2160,
            extraChildMealNumber: 0,
            extraBedNumber: 0,
            mealIncluded: false,
            childMealLimit: 0,
            extraAdultMealRate: 0,
            isCustomRate: true
        )
        
        let item = ReservationLog.Item(
            reservableId: 625,
            totalPrice: 2160,
            reservableType: "Room",
            reservedDate: "2024-06-06",
            data: itemData
        )
        
        let parameters = ReservationLog.Parameters(
            contactEmail: "test@guest.booking.com",
            channelId: 7,
            checkOutDate: Date(),
            extraAdultNumber: 0,
            hotelId: "105",
            otaBookingId: "",
            items: [item],
            contactTel: "+66 12 345 6789",
            subChannelId: 35
        )
        
        return ReservationLog(
            id: 2451,
            user: user,
            description: "Add a new reservation from channel manager booking",
            verb: "POST",
            path: "/api/v3/reservations/cm-reservations",
            parameters: parameters,
            createdAt: Date(),
            updatedAt: Date()
        )
    }
    
    private func createPeriodDate() -> PeriodDate {
        let startDate = createDate(year: 2024, month: 6, day: 1)
        let endDate = createDate(year: 2024, month: 6, day: 30)
        return PeriodDate(start: startDate, end: endDate)
    }
    
    private func createDate(year: Int, month: Int, day: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.timeZone = TimeZone(secondsFromGMT: 0)
        return Calendar.current.date(from: components) ?? Date()
    }
} 
