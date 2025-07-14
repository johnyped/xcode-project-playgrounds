//
//  ReservationLogTests.swift
//  YourProject
//
//  Created by IntrodexMini on 23/5/2568 BE.
//

import XCTest

final class ReservationLogTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let reservationLog = createSampleReservationLog()
        
        // Assert
        XCTAssertEqual(reservationLog.id, 2451)
        XCTAssertEqual(reservationLog.description, "Add a new reservation from channel manager booking")
        XCTAssertEqual(reservationLog.verb, "POST")
        XCTAssertEqual(reservationLog.path, "/api/v3/reservations/cm-reservations")
        XCTAssertNotNil(reservationLog.user)
        XCTAssertNotNil(reservationLog.parameters)
        XCTAssertNotNil(reservationLog.createdAt)
        XCTAssertNotNil(reservationLog.updatedAt)
    }
    
    func test_initWithUserProperties() throws {
        // Arrange & Act
        let reservationLog = createSampleReservationLog()
        let user = reservationLog.user
        
        // Assert
        XCTAssertEqual(user.id, 38)
        XCTAssertEqual(user.firstName, "John2")
        XCTAssertEqual(user.lastName, "Doe2")
        XCTAssertEqual(user.email, "test1@email.com")
        XCTAssertEqual(user.role, "ROLE_SUPPORT_SUPER_ADMIN")
        XCTAssertNil(user.staffRole)
    }
    
    func test_initWithParametersProperties() throws {
        // Arrange & Act
        let reservationLog = createSampleReservationLog()
        let parameters = reservationLog.parameters
        
        // Assert
        XCTAssertEqual(parameters.contactEmail, "stongp.580776@guest.booking.com")
        XCTAssertEqual(parameters.channelId, 7)
        XCTAssertEqual(parameters.extraAdultNumber, 0)
        XCTAssertEqual(parameters.hotelId, "105")
        XCTAssertEqual(parameters.otaBookingId, "")
        XCTAssertEqual(parameters.contactTel, "+66 89 170 3704, ")
        XCTAssertEqual(parameters.subChannelId, 35)
        XCTAssertNotNil(parameters.checkOutDate)
        XCTAssertFalse(parameters.items.isEmpty)
    }
    
    func test_initWithItemProperties() throws {
        // Arrange & Act
        let reservationLog = createSampleReservationLog()
        let item = reservationLog.parameters.items.first!
        
        // Assert
        XCTAssertEqual(item.reservableId, 625)
        XCTAssertEqual(item.totalPrice, 2160)
        XCTAssertEqual(item.reservableType, "Room")
        XCTAssertEqual(item.reservedDate, "2024-06-06")
        XCTAssertNotNil(item.data)
    }
    
    func test_initWithItemDataProperties() throws {
        // Arrange & Act
        let reservationLog = createSampleReservationLog()
        let itemData = reservationLog.parameters.items.first!.data
        
        // Assert
        XCTAssertEqual(itemData.extraBedRate, 0)
        XCTAssertEqual(itemData.extraPersonRate, 500)
        XCTAssertEqual(itemData.childMealRate, 0)
        XCTAssertEqual(itemData.adultMealLimit, 0)
        XCTAssertEqual(itemData.extraAdultMealNumber, 0)
        XCTAssertEqual(itemData.extraChildMealRate, 0)
        XCTAssertEqual(itemData.adultMealRate, 0)
        XCTAssertEqual(itemData.extraPersonNumber, 0)
        XCTAssertEqual(itemData.priceCardRate, 2160)
        XCTAssertEqual(itemData.extraChildMealNumber, 0)
        XCTAssertEqual(itemData.extraBedNumber, 0)
        XCTAssertFalse(itemData.mealIncluded)
        XCTAssertEqual(itemData.childMealLimit, 0)
        XCTAssertEqual(itemData.extraAdultMealRate, 0)
        XCTAssertTrue(itemData.isCustomRate)
    }
    
    func test_initWithDates() throws {
        // Arrange & Act
        let reservationLog = createSampleReservationLog()
        
        // Assert
        XCTAssertNotNil(reservationLog.createdAt)
        XCTAssertNotNil(reservationLog.updatedAt)
        XCTAssertNotNil(reservationLog.parameters.checkOutDate)
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 2451,
            "user": {
                "id": 38,
                "first_name": "John2",
                "last_name": "Doe2",
                "email": "test1@email.com",
                "role": "ROLE_SUPPORT_SUPER_ADMIN",
                "staff_role": null
            },
            "description": "Add a new reservation from channel manager booking",
            "verb": "POST",
            "path": "/api/v3/reservations/cm-reservations",
            "parameters": {
                "contact_email": "stongp.580776@guest.booking.com",
                "channel_id": 7,
                "check_out_date": "2024-06-07T00:00:00.000+00:00",
                "extra_adult_number": 0,
                "hotel_id": "105",
                "ota_booking_id": "",
                "items": [
                    {
                        "reservable_id": 625,
                        "total_price": 2160,
                        "reservable_type": "Room",
                        "reserved_date": "2024-06-06",
                        "data": {
                            "extra_bed_rate": 0,
                            "extra_person_rate": 500,
                            "child_meal_rate": 0,
                            "adult_meal_limit": 0,
                            "extra_adult_meal_number": 0,
                            "extra_child_meal_rate": 0,
                            "adult_meal_rate": 0,
                            "extra_person_number": 0,
                            "price_card_rate": 2160,
                            "extra_child_meal_number": 0,
                            "extra_bed_number": 0,
                            "meal_included": false,
                            "child_meal_limit": 0,
                            "extra_adult_meal_rate": 0,
                            "is_custom_rate": true
                        }
                    }
                ],
                "contact_tel": "+66 89 170 3704, ",
                "sub_channel_id": 35
            },
            "created_at": "2024-04-13T17:09:11.862+07:00",
            "updated_at": "2024-04-13T17:09:11.862+07:00"
        }
        """.data(using: .utf8)!
        
        // Set up date formatter for decoding
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        // Act
        let reservationLog = try decoder.decode(ReservationLog.self, from: json)
        
        // Assert
        XCTAssertEqual(reservationLog.id, 2451)
        XCTAssertEqual(reservationLog.description, "Add a new reservation from channel manager booking")
        XCTAssertEqual(reservationLog.verb, "POST")
        XCTAssertEqual(reservationLog.path, "/api/v3/reservations/cm-reservations")
        
        // User assertions
        XCTAssertEqual(reservationLog.user.id, 38)
        XCTAssertEqual(reservationLog.user.firstName, "John2")
        XCTAssertEqual(reservationLog.user.lastName, "Doe2")
        XCTAssertEqual(reservationLog.user.email, "test1@email.com")
        XCTAssertEqual(reservationLog.user.role, "ROLE_SUPPORT_SUPER_ADMIN")
        XCTAssertNil(reservationLog.user.staffRole)
        
        // Parameters assertions
        XCTAssertEqual(reservationLog.parameters.contactEmail, "stongp.580776@guest.booking.com")
        XCTAssertEqual(reservationLog.parameters.channelId, 7)
        XCTAssertEqual(reservationLog.parameters.extraAdultNumber, 0)
        XCTAssertEqual(reservationLog.parameters.hotelId, "105")
        XCTAssertEqual(reservationLog.parameters.otaBookingId, "")
        XCTAssertEqual(reservationLog.parameters.contactTel, "+66 89 170 3704, ")
        XCTAssertEqual(reservationLog.parameters.subChannelId, 35)
        
        // Items assertions
        XCTAssertEqual(reservationLog.parameters.items.count, 1)
        let item = reservationLog.parameters.items.first!
        XCTAssertEqual(item.reservableId, 625)
        XCTAssertEqual(item.totalPrice, 2160)
        XCTAssertEqual(item.reservableType, "Room")
        XCTAssertEqual(item.reservedDate, "2024-06-06")
        
        // Item data assertions
        let itemData = item.data
        XCTAssertEqual(itemData.extraBedRate, 0)
        XCTAssertEqual(itemData.extraPersonRate, 500)
        XCTAssertEqual(itemData.priceCardRate, 2160)
        XCTAssertFalse(itemData.mealIncluded)
        XCTAssertTrue(itemData.isCustomRate)
        
        // Date assertions
        XCTAssertNotNil(reservationLog.createdAt)
        XCTAssertNotNil(reservationLog.updatedAt)
        XCTAssertNotNil(reservationLog.parameters.checkOutDate)
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let reservationLog = createSampleReservationLog()
        
        // Set up date formatter for encoding
        let encoder = JSONEncoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        encoder.dateEncodingStrategy = .formatted(formatter)
        encoder.outputFormatting = .prettyPrinted
        
        // Act
        let jsonData = try encoder.encode(reservationLog)
        let jsonString = String(data: jsonData, encoding: .utf8)
        
        // Assert
        XCTAssertNotNil(jsonString)
        XCTAssertTrue(jsonString!.contains("\"id\" : 2451"))
        XCTAssertTrue(jsonString!.contains("\"description\" : \"Add a new reservation from channel manager booking\""))
        XCTAssertTrue(jsonString!.contains("\"verb\" : \"POST\""))
        XCTAssertTrue(jsonString!.contains("\"first_name\" : \"John2\""))
        XCTAssertTrue(jsonString!.contains("\"contact_email\" : \"stongp.580776@guest.booking.com\""))
    }
    
    // MARK: - Helper Methods
    
    private func createSampleReservationLog() -> ReservationLog {
        let user = ReservationLog.User(
            id: 38,
            firstName: "John2",
            lastName: "Doe2",
            email: "test1@email.com",
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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        let parameters = ReservationLog.Parameters(
            contactEmail: "stongp.580776@guest.booking.com",
            channelId: 7,
            checkOutDate: dateFormatter.date(from: "2024-06-07T00:00:00.000+00:00") ?? .now,
            extraAdultNumber: 0,
            hotelId: "105",
            otaBookingId: "",
            items: [item],
            contactTel: "+66 89 170 3704, ",
            subChannelId: 35
        )
        
        return ReservationLog(
            id: 2451,
            user: user,
            description: "Add a new reservation from channel manager booking",
            verb: "POST",
            path: "/api/v3/reservations/cm-reservations",
            parameters: parameters,
            createdAt: dateFormatter.date(from: "2024-04-13T17:09:11.862+07:00") ?? .now,
            updatedAt: dateFormatter.date(from: "2024-04-13T17:09:11.862+07:00") ?? .now
        )
    }
} 
