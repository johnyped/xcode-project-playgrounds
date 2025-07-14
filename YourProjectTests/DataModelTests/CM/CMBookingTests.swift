//
//  CMBookingTests.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import XCTest

final class CMBookingTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let booking = createSampleCMBooking()
        
        // Assert
        XCTAssertEqual(booking.id, 2)
        XCTAssertEqual(booking.hotelId, 105)
        XCTAssertEqual(booking.hmsUnitType, .roomType)
        XCTAssertEqual(booking.hmsUnitId, 179)
        
        XCTAssertEqual(booking.firstNight, "2020-01-15".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(booking.lastNight, "2020-01-15".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(booking.cmBookID, "16500820")
        XCTAssertEqual(booking.cmRoomId, "232711")
        XCTAssertEqual(booking.cmStatus, .confirmed)
    }
    
    func test_initWithOptionalProperties() throws {
        // Arrange & Act
        let booking = createSampleCMBooking()
        
        // Assert
        XCTAssertEqual(booking.hmsReservationID, 512)
    }
    
    func test_initWithDates() throws {
        // Arrange & Act
        let booking = createSampleCMBooking()
        
        // Assert
        XCTAssertNotNil(booking.createdAt)
        XCTAssertNotNil(booking.updatedAt)
    }
    
    func test_computedProperties() throws {
        // Arrange & Act
        let booking = createSampleCMBooking()
        
        // Assert
        XCTAssertEqual(booking.period.numberOfNight, 1)
        XCTAssertEqual(booking.unitCount, 1)
    }
    
    // MARK: - Kind Tests
    
    func test_kindRawValues() throws {
        XCTAssertEqual(CMBooking.ReservableType.roomType.rawValue, "ROOM_TYPE")
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 2,
            "book_id": "16500820",
            "room_id": "232711",
            "hms_unit_type": "ROOM_TYPE",
            "hms_unit_id": 116,            
            "hms_reservation_id": 512,
            "status": "1",
            "first_night": "2020-01-15",
            "last_night": "2020-01-15",
            "raw_response": {
                "bookId": "16500820",
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
                "guestArrivalTime": "",
                "guestVoucher": "",
                "guestComments": "Test comments",
                "notes": "Test notes",
                "message": "",
                "groupNote": "",
                "custom1": "",
                "custom2": "",
                "custom3": "",
                "custom4": "",
                "custom5": "",
                "custom6": "",
                "custom7": "",
                "custom8": "",
                "custom9": "",
                "custom10": "",
                "flagColor": "",
                "flagText": "",
                "statusCode": "0",
                "lang": "",
                "price": "200.00",
                "deposit": "0.00",
                "tax": "0.00",
                "commission": "0.00",
                "currency": "THB",
                "rateDescription": "2020-01-15 100 rate 2656105",
                "offerId": "0",
                "referer": "homemadestay",
                "reference": "",
                "apiSource": "0",
                "apiReference": "",
                "apiMessage": "",
                "allowChannelUpdate": "1",
                "allowAutoAction": "1",
                "allowReview": "1",
                "propId": "102230",
                "ownerId": "56401",
                "bookingTime": "2020-01-13 01:53:03",
                "modified": "2020-01-13 14:16:01",
                "masterId": "",
                "invoiceNumber": "",
                "invoiceDate": "",
                "invoice": [],
                "infoItems": []
            },
            "created_at": "2020-01-13T09:18:24.071+07:00",
            "updated_at": "2022-05-04T21:48:43.353+07:00",
            "hotel_id": 105
        }
        """.data(using: .utf8)!
        
        // Act
        let booking = try JSONDecoder().decode(CMBooking.self, from: json)
        
        // Assert
        XCTAssertEqual(booking.id, 2)
        XCTAssertEqual(booking.cmBookID, "16500820")
        XCTAssertEqual(booking.cmRoomId, "232711")
        XCTAssertEqual(booking.hmsUnitType, .roomType)
        XCTAssertEqual(booking.hmsUnitId, 116)
        XCTAssertEqual(booking.cmStatus, .confirmed)
        XCTAssertEqual(booking.hmsReservationID, 512)
        XCTAssertEqual(booking.hotelId, 105)
        XCTAssertNotNil(booking.createdAt)
        XCTAssertNotNil(booking.updatedAt)
        XCTAssertEqual(booking.period.numberOfNight, 1)
        XCTAssertEqual(booking.unitCount, 1)
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let booking = createSampleCMBooking()
        
        // Act
        let encodedData = try JSONEncoder().encode(booking)
        let decodedBooking = try JSONDecoder().decode(CMBooking.self, from: encodedData)
        
        // Assert
        XCTAssertEqual(decodedBooking.id, booking.id)
        XCTAssertEqual(decodedBooking.cmBookID, booking.cmBookID)
        XCTAssertEqual(decodedBooking.cmRoomId, booking.cmRoomId)
        XCTAssertEqual(decodedBooking.hmsUnitType, booking.hmsUnitType)
        XCTAssertEqual(decodedBooking.hmsUnitId, booking.hmsUnitId)
        
        
        let dateFormat = FormConfig.DateFormat.yyyyMMdd
        XCTAssertEqual(decodedBooking.firstNight.toDateString(dateFormat), booking.firstNight.toDateString(dateFormat))
        XCTAssertEqual(decodedBooking.lastNight.toDateString(dateFormat), booking.lastNight.toDateString(dateFormat))
        
        XCTAssertEqual(decodedBooking.cmStatus, booking.cmStatus)
        XCTAssertEqual(decodedBooking.hmsReservationID, booking.hmsReservationID)
        XCTAssertEqual(decodedBooking.hotelId, booking.hotelId)
        XCTAssertEqual(decodedBooking.createdAt, booking.createdAt)
        XCTAssertEqual(decodedBooking.updatedAt, booking.updatedAt)
        XCTAssertEqual(decodedBooking.period.numberOfNight, booking.period.numberOfNight)
        XCTAssertEqual(decodedBooking.unitCount, booking.unitCount)
    }
    
    // MARK: - Helper Methods
    
    private func createSampleCMBooking() -> CMBooking {

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
            bookingID: "16500820",
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
        
        return CMBooking(
            id: 2,
            hotelId: 105,
            hmsUnitType: .roomType,
            hmsUnitId: 179,
            firstNight: "2020-01-15".toDate(FormConfig.DateFormat.yyyyMMdd) ?? .now,
            lastNight: "2020-01-15".toDate(FormConfig.DateFormat.yyyyMMdd) ?? .now,
            cmBookID: "16500820",
            cmRoomId: "232711",
            cmStatus: .confirmed,
            raw: rawBooking,
            hmsReservationID: 512,
            createdAt: Date(timeIntervalSince1970: 1578880704.071),
            updatedAt: Date(timeIntervalSince1970: 1651673323.353)
        )
    }
} 
