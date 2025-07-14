//
//  CMBookingsTests.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import XCTest

final class CMBookingsTests: XCTestCase {
    
    // MARK: - Collection Tests
    
    func test_emptyCollection() throws {
        // Arrange & Act
        let bookings = CMBookings()
        
        // Assert
        XCTAssertTrue(bookings.lists.isEmpty)
        XCTAssertEqual(bookings.count, 0)
    }
    
    func test_collectionWithItems() throws {
        // Arrange
        let booking1 = createSampleCMBooking(id: 1, bookID: "123")
        let booking2 = createSampleCMBooking(id: 2, bookID: "456")
        
        // Act
        let bookings = CMBookings(array: [booking1, booking2])
        
        // Assert
        XCTAssertFalse(bookings.lists.isEmpty)
        XCTAssertEqual(bookings.count, 2)
        XCTAssertEqual(bookings.lists[0].id, 1)
        XCTAssertEqual(bookings.lists[1].id, 2)
        XCTAssertEqual(bookings.lists[0].cmBookID, "123")
        XCTAssertEqual(bookings.lists[1].cmBookID, "456")
    }
    
    func test_collectionIteration() throws {
        // Arrange
        let booking1 = createSampleCMBooking(id: 1, bookID: "123")
        let booking2 = createSampleCMBooking(id: 2, bookID: "456")
        let bookings = CMBookings(array: [booking1, booking2])
        
        // Act
        var iteratedBookings: [CMBooking] = []
        for booking in bookings.lists {
            iteratedBookings.append(booking)
        }
        
        // Assert
        XCTAssertEqual(iteratedBookings.count, 2)
        XCTAssertEqual(iteratedBookings[0].id, 1)
        XCTAssertEqual(iteratedBookings[1].id, 2)
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
         [
                {
                    "id": 1,
                    "book_id": "123",
                    "room_id": "232711",
                    "hms_unit_type": "ROOM_TYPE",
                    "hms_unit_id": 116,
                    "hms_unit_detail": {
                        "id": 116,
                        "name": "6 bed",
                        "base_rate": 100.0,
                        "data": null
                    },
                    "hms_reservation_id": 512,
                    "status": "1",
                    "first_night": "2020-01-15",
                    "last_night": "2020-01-15",
                    "raw_response": {
                        "bookId": "123",
                        "roomId": "232711",
                        "unitId": "2",
                        "roomQty": "1",
                        "status": "1",
                        "firstNight": "2020-01-15",
                        "lastNight": "2020-01-15",
                        "numAdult": "2",
                        "numChild": "0",
                        "guestTitle": "Mr",
                        "guestFirstName": "John",
                        "guestName": "Doe",
                        "guestEmail": "john.doe@example.com",
                        "guestPhone": "1234567890",
                        "guestMobile": "0987654321",
                        "guestFax": "",
                        "guestCompany": "Test Company",
                        "guestAddress": "123 Test St",
                        "guestCity": "Test City",
                        "guestState": "Test State",
                        "guestPostcode": "12345",
                        "guestCountry": "Thailand",
                        "guestCountry2": "TH",
                        "guestComments": "Test comments",
                        "notes": "Test notes",
                        "price": "200.00",
                        "deposit": "0.00",
                        "tax": "0.00",
                        "commission": "0.00",
                        "currency": "THB",
                        "rateDescription": "2020-01-15 100 rate 2656105",
                        "referer": "homemadestay",
                        "apiSource": "0",
                        "apiReference": "",
                        "propId": "102230",
                        "bookingTime": "2020-01-13 01:53:03",
                        "modified": "2020-01-13 14:16:01",
                        "invoice": []
                    },
                    "created_at": "2020-01-13T09:18:24.071+07:00",
                    "updated_at": "2022-05-04T21:48:43.353+07:00",
                    "hotel_id": 105
                }
        ]
        """.data(using: .utf8)!
        
        // Act
        let bookings = try JSONDecoder().decode(CMBookings.self, from: json)
        
        // Assert
        XCTAssertEqual(bookings.count, 1)
        XCTAssertEqual(bookings.lists[0].id, 1)
        XCTAssertEqual(bookings.lists[0].cmBookID, "123")
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let booking = createSampleCMBooking(id: 1, bookID: "123")
        let bookings = CMBookings(array: [booking])
        
        // Act
        let encodedData = try JSONEncoder().encode(bookings)
        let decodedBookings = try JSONDecoder().decode(CMBookings.self, from: encodedData)
        
        // Assert
        XCTAssertEqual(decodedBookings.count, bookings.count)
        XCTAssertEqual(decodedBookings.lists[0].id, bookings.lists[0].id)
        XCTAssertEqual(decodedBookings.lists[0].cmBookID, bookings.lists[0].cmBookID)
    }
    
    // MARK: - Helper Methods
    
    private func createSampleCMBooking(id: Int, bookID: String) -> CMBooking {
      
        let guestInfo = CMBookingRaw.GuestInfo(
            title: "Mr",
            firstname: "John",
            lastname: "Doe",
            email: "john.doe@example.com",
            phone: "1234567890",
            mobile: "0987654321",
            fax: "",
            company: "Test Company"
        )
        
        let guestAddress = CMBookingRaw.GuestAddress(
            address: "123 Test St",
            city: "Test City",
            state: "Test State",
            postCode: "12345",
            country: "Thailand",
            countryCode: "TH"
        )
        
        let rawBooking = CMBookingRaw(
            propId: "102230",
            status: .confirmed,
            bookingID: bookID,
            roomID: "232711",
            unitID: "2",
            roomCount: 1,
            firstNightDate: "2020-01-15".toDate(FormConfig.DateFormat.yyyyMMdd) ?? .now,
            lastNightDate: "2020-01-15".toDate(FormConfig.DateFormat.yyyyMMdd) ?? .now,
            adultCount: 2,
            childCount: 0,
            guestInfo: guestInfo,
            guestAddress: guestAddress,
            guestComments: "Test comments",
            notes: "Test notes",
            price: 200.00,
            deposit: 0.00,
            tax: 0.00,
            commission: 0.00,
            currencyUnit: "THB",
            rateDescription: "2020-01-15 100 rate 2656105",
            invoices: [],
            referer: "homemadestay",
            apiSource: 0,
            referenceBookingID: "",
            bookingTime: "2020-01-13 01:53:03".toDate("yyyy-MM-dd HH:mm:ss") ?? .now,
            modified: "2020-01-13 14:16:01".toDate("yyyy-MM-dd HH:mm:ss") ?? .now
        )
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        return CMBooking(
            id: id,
            hotelId: 105,
            hmsUnitType: .roomType,
            hmsUnitId: 179,
            firstNight: "2020-01-15".toDate(FormConfig.DateFormat.yyyyMMdd) ?? .now,
            lastNight: "2020-01-15".toDate(FormConfig.DateFormat.yyyyMMdd) ?? .now,
            cmBookID: bookID,
            cmRoomId: "232711",
            cmStatus: .confirmed,
            raw: rawBooking,
            hmsReservationID: 512,
            createdAt: dateFormatter.date(from: "2020-01-13T09:18:24.071+07:00") ?? .now,
            updatedAt: dateFormatter.date(from: "2022-05-04T21:48:43.353+07:00") ?? .now
        )
    }
} 
