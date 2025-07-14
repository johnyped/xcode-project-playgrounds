//
//  ReservationsTests.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import XCTest

final class ReservationsTests: XCTestCase {
    
    // MARK: - Filter Tests
    
//    func test_filterByID_whenIDExists_returnsReservation() throws {
//        // Arrange
//        let reservations = createSampleReservations()
//        
//        // Act
//        let result = reservations.filter(byID: 512)
//        
//        // Assert
//        XCTAssertNotNil(result)
//        XCTAssertEqual(result?.id, 512)
//        XCTAssertEqual(result?.uid, "rsvt_5la15znqpb30lz5rmqj")
//        XCTAssertEqual(result?.status, .checkedOut)
//    }
//    
//    func test_filterByID_whenIDDoesNotExist_returnsNil() throws {
//        // Arrange
//        let reservations = createSampleReservations()
//        
//        // Act
//        let result = reservations.filter(byID: 999)
//        
//        // Assert
//        XCTAssertNil(result)
//    }
//    
//    // MARK: - Helper Methods
//    
//    private func createSampleReservations() -> Reservations {
//        let reservation1 = createSampleReservation(
//            id: 512,
//            uid: "rsvt_5la15znqpb30lz5rmqj",
//            status: .checkedOut
//        )
//        
//        let reservation2 = createSampleReservation(
//            id: 528,
//            uid: "rsvt_5la15zp03yyhsxbvsl5",
//            status: .checkedOut
//        )
//        
//        return Reservations(array: [reservation1, reservation2])
//    }
//    
//    private func createSampleReservation(
//        id: Int,
//        uid: String,
//        status: Reservation.Status
//    ) -> Reservation {
//        let contacts = Reservation.Contacts(
//            title: nil,
//            fullname: "abc",
//            email: "avc@email.com",
//            tel: "1234567890"
//        )
//        
//        let confirmationInfo = Reservation.ConfirmationInfo(
//            createdAt: nil,
//            remark: nil,
//            url: nil
//        )
//        
//        return Reservation(
//            id: id,
//            uid: uid,
//            status: status,
//            checkInDate: "2019-11-28",
//            checkOutDate: "2019-12-01",
//            adultNumber: 1,
//            extraAdultNumber: 0,
//            childNumber: 0,
//            contacts: contacts,
//            note: "test",
//            canceledReason: nil,
//            documentPhotos: nil,
//            otaBookingId: "",
//            relatedReservationId: nil,
//            guestComment: nil,
//            markers: [],
//            flags: [],
//            tags: [],
//            emoji: nil,
//            checkedInAt: "2019-11-28T13:51:22.214+07:00",
//            checkedOutAt: "2020-08-27T21:58:06.587+07:00",
//            canceledAt: nil,
//            noShowAt: nil,
//            createdAt: "2019-11-28T13:43:02.888+07:00",
//            updatedAt: "2020-08-27T21:58:06.595+07:00",
//            hotelChannelReservationId: nil,
//            confirmationInfo: confirmationInfo,
//            hotelId: 105,
//            creatorId: 38,
//            channelId: 9,
//            subChannelId: nil
//        )
//    }
}

