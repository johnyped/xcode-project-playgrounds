//
//  ReservationTests.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import XCTest

final class ReservationTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let reservation = createSampleReservation()
        
        // Assert
        XCTAssertEqual(reservation.id, 512)
        XCTAssertEqual(reservation.uid, "rsvt_5la15znqpb30lz5rmqj")
        XCTAssertEqual(reservation.status, .checkedOut)
        XCTAssertEqual(reservation.checkInDate, "2019-11-28".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(reservation.checkOutDate, "2019-12-01".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(reservation.adultNumber, 1)
        XCTAssertEqual(reservation.extraAdultNumber, 0)
        XCTAssertEqual(reservation.childNumber, 0)
        XCTAssertEqual(reservation.note, "test")
        XCTAssertEqual(reservation.otaBookingId, "")
        XCTAssertEqual(reservation.hotelId, 105)
        XCTAssertEqual(reservation.creatorId, 38)
        XCTAssertEqual(reservation.channelId, 9)
    }
    
    func test_initWithOptionalProperties() throws {
        // Arrange & Act
        let reservation = createSampleReservation()
        
        // Assert
        XCTAssertNil(reservation.canceledReason)
        XCTAssertNil(reservation.documentPhotos)
        XCTAssertNil(reservation.relatedReservationId)
        XCTAssertNil(reservation.guestComment)
        XCTAssertNil(reservation.emoji)
        XCTAssertNil(reservation.hotelChannelReservationId)
        XCTAssertNil(reservation.subChannelId)
    }
    
    func test_initWithDates() throws {
        // Arrange & Act
        let reservation = createSampleReservation()
        
        // Assert
        XCTAssertNotNil(reservation.checkedInAt)
        XCTAssertNotNil(reservation.checkedOutAt)
        XCTAssertNotNil(reservation.createdAt)
        XCTAssertNotNil(reservation.updatedAt)
        XCTAssertNil(reservation.canceledAt)
        XCTAssertNil(reservation.noShowAt)
    }
    
    func test_initWithContacts() throws {
        // Arrange & Act
        let reservation = createSampleReservation()
        
        // Assert
        XCTAssertEqual(reservation.contacts.title, "")
        XCTAssertEqual(reservation.contacts.fullname, "abc")
        XCTAssertEqual(reservation.contacts.email, "avc@email.com")
        XCTAssertEqual(reservation.contacts.tel, "1234567890")
    }
    
//    func test_initWithConfirmationInfo() throws {
//        // Arrange & Act
//        let reservation = createSampleReservation()
//        
//        // Assert
//        XCTAssertNil(reservation.confirmationInfo.createdAt)
//        XCTAssertNil(reservation.confirmationInfo.remark)
//        XCTAssertNil(reservation.confirmationInfo.url)
//    }
    
    // MARK: - Status Tests
    
    func test_statusDescription() throws {
        XCTAssertEqual(Reservation.Status.created.description, "Created")
        XCTAssertEqual(Reservation.Status.checkedIn.description, "Checked-in")
        XCTAssertEqual(Reservation.Status.checkedOut.description, "Checked-out")
        XCTAssertEqual(Reservation.Status.confirmed.description, "Confirmed")
        XCTAssertEqual(Reservation.Status.canceled.description, "Canceled")
        XCTAssertEqual(Reservation.Status.noShown.description, "No shown")
    }
    
    func test_statusRawValues() throws {
        XCTAssertEqual(Reservation.Status.created.rawValue, "CREATED")
        XCTAssertEqual(Reservation.Status.checkedIn.rawValue, "CHECKED_IN")
        XCTAssertEqual(Reservation.Status.checkedOut.rawValue, "CHECKED_OUT")
        XCTAssertEqual(Reservation.Status.confirmed.rawValue, "CONFIRMED")
        XCTAssertEqual(Reservation.Status.canceled.rawValue, "CANCELED")
        XCTAssertEqual(Reservation.Status.noShown.rawValue, "NO_SHOWED")
    }
    
    // MARK: - Flag Tests
    
    func test_flagRawValues() throws {
        XCTAssertEqual(Reservation.Flag.red.rawValue, "FLAG_RED")
        XCTAssertEqual(Reservation.Flag.blue.rawValue, "FLAG_BLUE")
        XCTAssertEqual(Reservation.Flag.orange.rawValue, "FLAG_ORANGE")
        XCTAssertEqual(Reservation.Flag.yellow.rawValue, "FLAG_YELLOW")
        XCTAssertEqual(Reservation.Flag.purple.rawValue, "FLAG_PURPLE")
        XCTAssertEqual(Reservation.Flag.green.rawValue, "FLAG_GREEN")
        XCTAssertEqual(Reservation.Flag.gray.rawValue, "FLAG_GRAY")
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 512,
            "uid": "rsvt_5la15znqpb30lz5rmqj",
            "status": "CHECKED_OUT",
            "check_in_date": "2019-11-28",
            "check_out_date": "2019-12-01",
            "adult_number": 1,
            "extra_adult_number": 0,
            "child_number": 0,
            "contacts": {
                "title": null,
                "fullname": "abc",
                "email": "avc@email.com",
                "tel": "1234567890"
            },
            "note": "test",
            "canceled_reason": null,
            "document_photos": null,
            "ota_booking_id": "",
            "related_reservation_id": null,
            "guest_comment": null,
            "markers": [],
            "flags": [],
            "tags": [],
            "emoji": null,
            "checked_in_at": "2019-11-28T13:51:22.214+07:00",
            "checked_out_at": "2020-08-27T21:58:06.587+07:00",
            "canceled_at": null,
            "no_showed_at": null,
            "created_at": "2019-11-28T13:43:02.888+07:00",
            "updated_at": "2020-08-27T21:58:06.595+07:00",
            "hotel_channel_reservation_id": null,
            "hotel_id": 105,
            "creator_id": 38,
            "channel_id": 9,
            "sub_channel_id": null
        }
        """.data(using: .utf8)!
        
        // Act
        let reservation = try JSONDecoder().decode(Reservation.self, from: json)
        
        // Assert
        XCTAssertEqual(reservation.id, 512)
        XCTAssertEqual(reservation.uid, "rsvt_5la15znqpb30lz5rmqj")
        XCTAssertEqual(reservation.status, .checkedOut)
        XCTAssertEqual(reservation.contacts.fullname, "abc")
        XCTAssertTrue(reservation.markers.isEmpty)
        XCTAssertTrue(reservation.flags.isEmpty)
        XCTAssertTrue(reservation.tags.isEmpty)
        XCTAssertNotNil(reservation.checkedInAt)
        XCTAssertNotNil(reservation.checkedOutAt)
        XCTAssertNotNil(reservation.createdAt)
        XCTAssertNotNil(reservation.updatedAt)
        XCTAssertEqual(reservation.contacts.title, "")
        XCTAssertEqual(reservation.contacts.fullname, "abc")
        XCTAssertEqual(reservation.contacts.email, "avc@email.com")
        XCTAssertEqual(reservation.contacts.tel, "1234567890")
        XCTAssertNil(reservation.canceledReason)
        XCTAssertNil(reservation.documentPhotos)
        XCTAssertEqual(reservation.otaBookingId, "")
        XCTAssertNil(reservation.relatedReservationId)
        XCTAssertNil(reservation.guestComment)
        XCTAssertNil(reservation.emoji)
        XCTAssertNil(reservation.hotelChannelReservationId)
        XCTAssertNil(reservation.subChannelId)
        XCTAssertEqual(reservation.hotelId, 105)
        XCTAssertEqual(reservation.creatorId, 38)
        XCTAssertEqual(reservation.channelId, 9)
        XCTAssertNil(reservation.subChannelId)        
        XCTAssertEqual(reservation.checkedOutAt?.toDateString(FormConfig.DateFormat.yyyyMMdd), "2020-08-27")
        XCTAssertNil(reservation.canceledAt)
        XCTAssertNil(reservation.noShowAt)        
        
    }
    
    func test_encodingToJSON() throws {

        
    }
    
    // MARK: - Helper Methods
    
    private func createSampleReservation() -> Reservation {
        let contacts = Reservation.Contacts(
            title: "",
            fullname: "abc",
            email: "avc@email.com",
            tel: "1234567890"
        )
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        return Reservation(
            id: 512,
            uid: "rsvt_5la15znqpb30lz5rmqj",
            status: .checkedOut,
            checkInDate: "2019-11-28".toDate(FormConfig.DateFormat.yyyyMMdd) ?? .now,
            checkOutDate: "2019-12-01".toDate(FormConfig.DateFormat.yyyyMMdd) ?? .now,
            adultNumber: 1,
            extraAdultNumber: 0,
            childNumber: 0,
            contacts: contacts,
            note: "test",
            canceledReason: nil,
            documentPhotos: nil,
            otaBookingId: "",
            relatedReservationId: nil,
            guestComment: nil,
            markers: [],
            flags: [],
            tags: [],
            emoji: nil,
            hotelChannelReservationId: nil,
            hotelId: 105,
            creatorId: 38,
            channelId: 9,
            subChannelId: nil,
            checkedInAt: dateFormatter.date(from: "2019-11-28T13:51:22.214+07:00"),
            checkedOutAt: dateFormatter.date(from: "2020-08-27T21:58:06.587+07:00"),
            canceledAt: nil,
            noShowAt: nil,
            createdAt: dateFormatter.date(from: "2019-11-28T13:43:02.888+07:00")!,
            updatedAt: dateFormatter.date(from: "2020-08-27T21:58:06.595+07:00")!
        )
    }
}

