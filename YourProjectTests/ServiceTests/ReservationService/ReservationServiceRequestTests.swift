//
//  ReservationServiceRequestTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest

class ReservationServiceRequestTests: XCTestCase {
    
    // MARK: - Test FetchReservations
    
    func test_fetchReservations_encodesCorrectly() throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservations(
            hotelId: 105,
            status: .confirmed,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["status"] as? String, "CONFIRMED")
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func test_fetchReservations_optionalFields_nil() throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservations(
            hotelId: 105,
            status: nil,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNil(parameters?["status"])
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
    }
    
    // MARK: - Test FetchReservationsByFlags
    
    func test_fetchReservationsByFlags_encodesCorrectly() throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservationsByFlags(
            hotelId: 105,
            flags: [.red, .blue],
            page: 2,
            perPage: .fifty,
            sortedBy: .checkInDate,
            sortedOrder: .descending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["flags"] as? String, "FLAG_RED,FLAG_BLUE")
        XCTAssertEqual(parameters?["page"] as? Int, 2)
        XCTAssertEqual(parameters?["per_page"] as? String, "50")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "CHECK_IN_DATE")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    // MARK: - Test FetchReservationsByGuest
    
    func test_fetchReservationsByGuest_encodesCorrectly() throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservationsByGuest(
            hotelId: 105,
            guestId: 123,
            page: 1,
            perPage: .ten,
            sortedBy: .createdAt,
            sortedOrder: .ascending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["guest_id"] as? Int, 123)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "10")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "CREATED_AT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    // MARK: - Test FetchReservationsByCompany
    
    func test_fetchReservationsByCompany_encodesCorrectly() throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservationsByCompany(
            hotelId: 105,
            companyId: 456,
            page: 1,
            perPage: .twenty,
            sortedBy: .checkInDate,
            sortedOrder: .descending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["company_id"] as? Int, 456)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "CHECK_IN_DATE")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    // MARK: - Test FetchReservationsByPeriod
    
    func test_fetchReservationsByPeriod_encodesCorrectly() throws {
        // Arrange
        let startDate = Date(timeIntervalSince1970: 1700000000) // 2023-11-15
        let endDate = Date(timeIntervalSince1970: 1700086400)   // 2023-11-16
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
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["start_at"] as? String, "2023-11-15")
        XCTAssertEqual(parameters?["end_at"] as? String, "2023-11-16")
        XCTAssertEqual(parameters?["status"] as? String, "CHECKED_IN")
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "100")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "CHECK_OUT_DATE")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    // MARK: - Test FetchReservationsByCreatedAt
    
    func test_fetchReservationsByCreatedAt_encodesCorrectly() throws {
        // Arrange
        let startDate = Date(timeIntervalSince1970: 1700000000)
        let endDate = Date(timeIntervalSince1970: 1700086400)
        let period = PeriodDate(start: startDate, end: endDate)
        
        let request = ReservationServiceRequest.FetchReservationsByCreatedAt(
            hotelId: 105,
            period: period,
            page: 1,
            perPage: .ten,
            sortedBy: .createdAt,
            sortedOrder: .descending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNotNil(parameters?["start_at"] as? String)
        XCTAssertNotNil(parameters?["end_at"] as? String)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "10")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "CREATED_AT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    // MARK: - Test FetchReservationsByTags
    
    func test_fetchReservationsByTags_encodesCorrectly() throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservationsByTags(
            hotelId: 105,
            tags: ["VIP", "Corporate"],
            page: 1,
            perPage: .twenty,
            sortedBy: .checkInDate,
            sortedOrder: .ascending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["tags"] as? String, "VIP,Corporate")
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "CHECK_IN_DATE")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    // MARK: - Test FetchReservationsByBatchIds
    
    func test_fetchReservationsByBatchIds_encodesCorrectly() throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservationsByBatchIds(
            hotelId: 105,
            ids: [512, 513, 514]
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["ids"] as? String, "512,513,514")
    }
    
    // MARK: - Test FetchReservationsByKeyword
    
    func test_fetchReservationsByKeyword_encodesCorrectly() throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservationsByKeyword(
            hotelId: 105,
            keyword: "John Smith",
            page: 1,
            perPage: .twenty,
            sortedBy: .checkInDate,
            sortedOrder: .ascending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["keyword"] as? String, "John Smith")
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "CHECK_IN_DATE")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    // MARK: - Test FetchReservationByUid
    
    func test_fetchReservationByUid_encodesCorrectly() throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservationByUid(
            hotelId: 105,
            uid: "rsvt_thai_booking_001"
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["uid"] as? String, "rsvt_thai_booking_001")
    }
    
    // MARK: - Test CreateReservation
    
    func test_createReservation_encodesCorrectly() throws {
        // Arrange
        let checkInDate = Date(timeIntervalSince1970: 1700000000)
        let checkOutDate = checkInDate.addingTimeInterval(24 * 60 * 60) // Add 1 day
      
        let items = [
            ReservationServiceRequest.CreateReservationItem(reservableId: 5,
                                                            reservableType: .room,
                                                            reservedDate: checkInDate,
                                                            totalPrice: 111.11,
                                                            priceCardId: nil,
                                                            data: .init(isCustomRate: false,
                                                                        selectedRate: 111.11,
                                                                        extraAdultRate: 0,
                                                                        extraAdultQty: 0,
                                                                        extraChildRate: 0,
                                                                        extraChildQty: 0,
                                                                        mealIncluded: false))
        ]
        let request = ReservationServiceRequest.CreateReservation(hotelId: 105,
                                                                  period: .init(start: checkInDate,
                                                                                end: checkOutDate),
                                                                  adultNumber: 2,
                                                                  extraAdultNumber: 1,
                                                                  contactName: "สมชาย ใจดี",
                                                                  contactEmail: "somchai@example.com",
                                                                  contactTel: "0812345678",
                                                                  items: items,
                                                                  note: "ห้องติดกัน",
                                                                  guestComment: "ต้องการห้องชั้นสูง",
                                                                  channelId: 1,
                                                                  subChannelId: 2,
                                                                  otaBookingId: "BOOKING_12345",
                                                                  relatedReservationId: 123,
                                                                  guestIds: [123, 456])
        
        // Act
        let bodyData = request.body
        
        // Assert
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["check_in_date"] as? String, "2023-11-15")
        XCTAssertEqual(json?["check_out_date"] as? String, "2023-11-16")
        XCTAssertEqual(json?["adult_number"] as? Int, 2)
        XCTAssertEqual(json?["extra_adult_number"] as? Int, 1)
        XCTAssertEqual(json?["contact_fullname"] as? String, "สมชาย ใจดี")
        XCTAssertEqual(json?["contact_email"] as? String, "somchai@example.com")
        XCTAssertEqual(json?["contact_tel"] as? String, "0812345678")
        XCTAssertEqual(json?["note"] as? String, "ห้องติดกัน")
        XCTAssertEqual(json?["guest_comment"] as? String, "ต้องการห้องชั้นสูง")
        XCTAssertEqual(json?["channel_id"] as? Int, 1)
        XCTAssertEqual(json?["sub_channel_id"] as? Int, 2)
        XCTAssertEqual(json?["ota_booking_id"] as? String, "BOOKING_12345")
        XCTAssertEqual(json?["related_reservation_id"] as? Int, 123)
        XCTAssertEqual(json?["guest_ids"] as? [Int], [123, 456])
    }
    
    // MARK: - Test UpdateReservation
    
    func test_updateReservation_encodesCorrectly() throws {
        // Arrange
        let request = ReservationServiceRequest.UpdateReservation(id: 105,
                                                                  adultNumber: 3,
                                                                  extraAdultNumber: nil,
                                                                  contactName: "สมใส ใจดี",
                                                                  contactEmail: "somsai@example.com",
                                                                  contactTel: "0887654321",
                                                                  note: "เปลี่ยนเป็นห้องใหญ่",
                                                                  guestComment: "ต้องการเตียงเสริม",
                                                                  flags: [.red],
                                                                  emoji: "👍",
                                                                  channelId: 1,
                                                                  subChannelId: 2,
                                                                  otaBookingId: nil,
                                                                  relatedReservationId: nil,
                                                                  guestIds: [123, 456])
        
        // Act
        let bodyData = request.body
        
        // Assert
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["adult_number"] as? Int, 3)
        XCTAssertEqual(json?["note"] as? String, "เปลี่ยนเป็นห้องใหญ่")
        XCTAssertEqual(json?["guest_comment"] as? String, "ต้องการเตียงเสริม")
        XCTAssertEqual(json?["flags"] as? [String], ["FLAG_RED"])
        XCTAssertEqual(json?["emoji"] as? String, "👍")
        XCTAssertEqual(json?["channel_id"] as? Int, 1)
        XCTAssertEqual(json?["sub_channel_id"] as? Int, 2)
        XCTAssertEqual(json?["ota_booking_id"] as? String, nil)
        XCTAssertEqual(json?["related_reservation_id"] as? Int, nil)
        XCTAssertEqual(json?["guest_ids"] as? [Int], [123, 456])
        
        // Verify nil fields are not encoded
        XCTAssertNil(json?["check_out_date"])        
        XCTAssertNil(json?["extra_adult_number"])  

        XCTAssertEqual(json?["contact_fullname"] as? String, "สมใส ใจดี")
        XCTAssertEqual(json?["contact_email"] as? String, "somsai@example.com")
        XCTAssertEqual(json?["contact_tel"] as? String, "0887654321")                       
    }
    
    // MARK: - Test Guest Management
    
    func test_dropGuest_encodesCorrectly() throws {
        // Arrange
        let request = ReservationServiceRequest.DropGuest(
            id: 512,
            guestId: 789
        )
        
        // Act
        let bodyData = request.body
        
        // Assert
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["guest_id"] as? Int, 789)
    }
    
    func test_appendGuest_encodesCorrectly() throws {
        // Arrange
        let request = ReservationServiceRequest.AppendGuest(
            id: 512,
            guestId: 890
        )
        
        // Act
        let bodyData = request.body
        
        // Assert
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["guest_id"] as? Int, 890)
    }
    
    func test_replaceGuests_encodesCorrectly() throws {
        // Arrange
        let request = ReservationServiceRequest.ReplaceGuests(
            id: 512,
            guestIds: [789, 890, 901]
        )
        
        // Act
        let bodyData = request.body
        
        // Assert
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        
        let guestIds = json?["guest_ids"] as? [Int]
        XCTAssertNotNil(guestIds)
        XCTAssertEqual(guestIds?.count, 3)
        XCTAssertTrue(guestIds?.contains(789) == true)
        XCTAssertTrue(guestIds?.contains(890) == true)
        XCTAssertTrue(guestIds?.contains(901) == true)
    }
    
    // MARK: - Test PostConfirmation
    
    func test_postConfirmation_encodesCorrectly() throws {
        // Arrange
        let request = ReservationServiceRequest.CreateConfirmation(
            id: 512,
            remark: "การจองได้รับการยืนยันแล้ว"
        )
        
        // Act
        let bodyData = request.body
        
        // Assert
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["remark"] as? String, "การจองได้รับการยืนยันแล้ว")
    }
    
    // MARK: - Test Reservation.Contacts
    
    func test_reservationContacts_init() {
        // Test with all fields
        let contacts = Reservation.Contacts(
            title: "นาย",
            fullname: "วิชาญ เก่งดี",
            email: "wichan@example.com",
            tel: "0898765432"
        )
        
        XCTAssertEqual(contacts.title, "นาย")
        XCTAssertEqual(contacts.fullname, "วิชาญ เก่งดี")
        XCTAssertEqual(contacts.email, "wichan@example.com")
        XCTAssertEqual(contacts.tel, "0898765432")
        
        // Test with minimal fields
        let minimalContacts = Reservation.Contacts(fullname: "สมชาย")
        XCTAssertEqual(minimalContacts.title, "")
        XCTAssertEqual(minimalContacts.fullname, "สมชาย")
        XCTAssertEqual(minimalContacts.email, "")
        XCTAssertEqual(minimalContacts.tel, "")
    }
    
    // MARK: - Test Edge Cases
    
    func test_fetchReservations_pageZero_notEncoded() throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservations(
            hotelId: 105,
            status: .confirmed,
            page: 0, // Should not be encoded as it's < 1
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertNil(parameters?["page"]) // Should be nil since page < 1
    }
    
    func test_sortedBy_allCases() {
        // Test all SortedBy enum cases
        XCTAssertEqual(ReservationServiceRequest.SortedBy.id.rawValue, "ID")
        XCTAssertEqual(ReservationServiceRequest.SortedBy.checkInDate.rawValue, "CHECK_IN_DATE")
        XCTAssertEqual(ReservationServiceRequest.SortedBy.checkOutDate.rawValue, "CHECK_OUT_DATE")
        XCTAssertEqual(ReservationServiceRequest.SortedBy.createdAt.rawValue, "CREATED_AT")
        XCTAssertEqual(ReservationServiceRequest.SortedBy.updatedAt.rawValue, "UPDATED_AT")
    }
} 
