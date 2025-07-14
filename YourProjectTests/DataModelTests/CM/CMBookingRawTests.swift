//
//  CMBookingRawTests.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import XCTest

final class CMBookingRawTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let booking = createSampleCMBookingRaw()
        
        // Assert
        XCTAssertEqual(booking.bookingID, "16500820")
        XCTAssertEqual(booking.status, .confirmed)
        XCTAssertEqual(booking.propId, "102230")
        XCTAssertEqual(booking.roomID, "232711")
        XCTAssertEqual(booking.unitID, "2")
        XCTAssertEqual(booking.roomCount, 1)
        XCTAssertEqual(booking.adultCount, 2)
        XCTAssertEqual(booking.childCount, 0)
        XCTAssertEqual(booking.price, 200.00)
        XCTAssertEqual(booking.deposit, 0.00)
        XCTAssertEqual(booking.tax, 0.00)
        XCTAssertEqual(booking.commission, 0.00)
        XCTAssertEqual(booking.currencyUnit, "THB")
        XCTAssertEqual(booking.referer, "homemadestay")
        XCTAssertEqual(booking.apiSource, 0)
        XCTAssertEqual(booking.referenceBookingID, "")
    }
    
    func test_initWithDates() throws {
        // Arrange & Act
        let booking = createSampleCMBookingRaw()
        
        // Assert
        XCTAssertNotNil(booking.firstNightDate)
        XCTAssertNotNil(booking.lastNightDate)
        XCTAssertNotNil(booking.bookingTime)
        XCTAssertNotNil(booking.modified)
    }
    
    func test_initWithGuestInfo() throws {
        // Arrange & Act
        let booking = createSampleCMBookingRaw()
        
        // Assert
        XCTAssertEqual(booking.guestInfo.title, "Mr")
        XCTAssertEqual(booking.guestInfo.firstname, "John")
        XCTAssertEqual(booking.guestInfo.lastname, "Doe")
        XCTAssertEqual(booking.guestInfo.email, "john.doe@example.com")
        XCTAssertEqual(booking.guestInfo.phone, "1234567890")
        XCTAssertEqual(booking.guestInfo.mobile, "0987654321")
        XCTAssertEqual(booking.guestInfo.fax, "")
        XCTAssertEqual(booking.guestInfo.company, "Test Company")
    }
    
    func test_initWithGuestAddress() throws {
        // Arrange & Act
        let booking = createSampleCMBookingRaw()
        
        // Assert
        XCTAssertEqual(booking.guestAddress.address, "123 Test St")
        XCTAssertEqual(booking.guestAddress.city, "Test City")
        XCTAssertEqual(booking.guestAddress.state, "Test State")
        XCTAssertEqual(booking.guestAddress.postCode, "12345")
        XCTAssertEqual(booking.guestAddress.country, "Thailand")
        XCTAssertEqual(booking.guestAddress.countryCode, "TH")
    }
    
    func test_computedProperties() throws {
        // Arrange & Act
        let booking = createSampleCMBookingRaw()
        
        // Assert
        XCTAssertEqual(booking.nightCount, 2)
        XCTAssertEqual(booking.totalInvoiceAmount, 0.0) // Empty invoices
        XCTAssertEqual(booking.totalCost, 200.00)
        XCTAssertEqual(booking.dailyRatePerUnit, 100.0)
        XCTAssertEqual(booking.totalRatePerUnit, 200.0)
    }
    
    func test_computedPropertiesWithInvoices() throws {
        // Arrange
        let invoice = CMInvoice(
            id: "24373826",
            description: "Test room",
            status: "",
            qty: 1,
            price: 250.00,
            tax: 0.00,
            invoiceeID: "",
            type: "1",
            type2: "2"
        )
        
        var booking = createSampleCMBookingRaw()
        booking = CMBookingRaw(
            propId: booking.propId,
            status: booking.status,
            bookingID: booking.bookingID,
            roomID: booking.roomID,
            unitID: booking.unitID,
            roomCount: booking.roomCount,
            firstNightDate: booking.firstNightDate,
            lastNightDate: booking.lastNightDate,
            adultCount: booking.adultCount,
            childCount: booking.childCount,
            guestInfo: booking.guestInfo,
            guestAddress: booking.guestAddress,
            guestComments: booking.guestComments,
            notes: booking.notes,
            price: booking.price,
            deposit: booking.deposit,
            tax: booking.tax,
            commission: booking.commission,
            currencyUnit: booking.currencyUnit,
            rateDescription: booking.rateDescription,
            invoices: [invoice],
            referer: booking.referer,
            apiSource: booking.apiSource,
            referenceBookingID: booking.referenceBookingID,
            bookingTime: booking.bookingTime,
            modified: booking.modified
        )
        
        // Assert
        XCTAssertEqual(booking.totalInvoiceAmount, 250.00)
        XCTAssertEqual(booking.totalCost, 250.00)
        XCTAssertEqual(booking.dailyRatePerUnit, 125.0)
        XCTAssertEqual(booking.totalRatePerUnit, 250.0)
    }
    
    // MARK: - Status Tests
    
    func test_statusRawValues() throws {
        XCTAssertEqual(CMBookingRaw.Status.cancelled.rawValue, "0")
        XCTAssertEqual(CMBookingRaw.Status.confirmed.rawValue, "1")
        XCTAssertEqual(CMBookingRaw.Status.new.rawValue, "2")
        XCTAssertEqual(CMBookingRaw.Status.request.rawValue, "3")
        XCTAssertEqual(CMBookingRaw.Status.black.rawValue, "4")
        XCTAssertEqual(CMBookingRaw.Status.unknow.rawValue, "-1")
    }
    
    // MARK: - GuestInfo Tests
    
    func test_guestInfoInitialization() throws {
        // Arrange & Act
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
        
        // Assert
        XCTAssertEqual(guestInfo.title, "Mr")
        XCTAssertEqual(guestInfo.firstname, "John")
        XCTAssertEqual(guestInfo.lastname, "Doe")
        XCTAssertEqual(guestInfo.email, "john.doe@example.com")
        XCTAssertEqual(guestInfo.phone, "1234567890")
        XCTAssertEqual(guestInfo.mobile, "0987654321")
        XCTAssertEqual(guestInfo.fax, "")
        XCTAssertEqual(guestInfo.company, "Test Company")
    }
    
    func test_guestInfoComputedProperties() throws {
        // Arrange & Act
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
        
        // Assert
        XCTAssertEqual(guestInfo.fullName, "John Doe")
        XCTAssertEqual(guestInfo.allPhoneNumber, "1234567890, 0987654321")
    }
    
    func test_guestInfoComputedPropertiesWithEmptyPhone() throws {
        // Arrange & Act
        let guestInfo = CMBookingRaw.GuestInfo(
            title: "Mr",
            firstname: "John",
            lastname: "Doe",
            email: "john.doe@example.com",
            phone: "",
            mobile: "0987654321",
            fax: "",
            company: "Test Company"
        )
        
        // Assert
        XCTAssertEqual(guestInfo.allPhoneNumber, "0987654321")
    }
    
    // MARK: - GuestAddress Tests
    
    func test_guestAddressInitialization() throws {
        // Arrange & Act
        let guestAddress = CMBookingRaw.GuestAddress(
            address: "123 Test St",
            city: "Test City",
            state: "Test State",
            postCode: "12345",
            country: "Thailand",
            countryCode: "TH"
        )
        
        // Assert
        XCTAssertEqual(guestAddress.address, "123 Test St")
        XCTAssertEqual(guestAddress.city, "Test City")
        XCTAssertEqual(guestAddress.state, "Test State")
        XCTAssertEqual(guestAddress.postCode, "12345")
        XCTAssertEqual(guestAddress.country, "Thailand")
        XCTAssertEqual(guestAddress.countryCode, "TH")
    }
    
    // MARK: - Codable Tests
    
    func test_statusDecodingFromJSON() throws {
        // Arrange
        let json = """
        "1"
        """.data(using: .utf8)!
        
        // Act
        let status = try JSONDecoder().decode(CMBookingRaw.Status.self, from: json)
        
        // Assert
        XCTAssertEqual(status, .confirmed)
    }
    
    func test_statusEncodingToJSON() throws {
        // Arrange
        let status = CMBookingRaw.Status.confirmed
        
        // Act
        let encodedData = try JSONEncoder().encode(status)
        let decodedStatus = try JSONDecoder().decode(CMBookingRaw.Status.self, from: encodedData)
        
        // Assert
        XCTAssertEqual(decodedStatus, status)
    }
    
    func test_decodingFromCompleteJSON() throws {
        // Arrange
        let json = """
        {
            "bookId": "16500820",
            "roomId": "232711",
            "unitId": "2",
            "roomQty": "1",
            "status": "1",
            "firstNight": "2020-01-15",
            "lastNight": "2020-01-15",
            "numAdult": "2",
            "numChild": "0",
            "guestTitle": "yyyyyy",
            "guestFirstName": "sasdasasda",
            "guestName": "dwqeqwewqfdfdsfsdf",
            "guestEmail": "s",
            "guestPhone": "444040",
            "guestMobile": "4540404",
            "guestFax": "",
            "guestCompany": "",
            "guestAddress": "s",
            "guestCity": "s",
            "guestState": "",
            "guestPostcode": "w",
            "guestCountry": "d",
            "guestCountry2": "",
            "guestArrivalTime": "",
            "guestVoucher": "",
            "guestComments": "",
            "notes": "update",
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
            "rateDescription": "2020-01-13 100 rate 2656105, \\r\\n2020-01-14 100 rate 2656105,",
            "offerId": "0",
            "referer": "homemadestay",
            "refererEditable": "homemadestay",
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
            "invoice": [
                {
                    "invoiceId": "24373826",
                    "description": "6 bed Wednesday, 15 January, 2020 - Thursday, 16 January, 2020",
                    "status": "",
                    "qty": "1",
                    "price": "200.00",
                    "vatRate": "0.00",
                    "type": "1",
                    "type2": "0",
                    "invoiceeId": ""
                }
            ],
            "infoItems": []
        }
        """.data(using: .utf8)!
        
        // Act
        let booking = try JSONDecoder().decode(CMBookingRaw.self, from: json)
        
        // Assert - Basic booking info
        XCTAssertEqual(booking.bookingID, "16500820")
        XCTAssertEqual(booking.roomID, "232711")
        XCTAssertEqual(booking.unitID, "2")
        XCTAssertEqual(booking.roomCount, 1)
        XCTAssertEqual(booking.status, .confirmed)
        XCTAssertEqual(booking.adultCount, 2)
        XCTAssertEqual(booking.childCount, 0)
        XCTAssertEqual(booking.propId, "102230")
        
        // Assert - Dates
        XCTAssertEqual(booking.firstNightDate, "2020-01-15".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(booking.lastNightDate, "2020-01-15".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(booking.bookingTime, "2020-01-13 01:53:03".toDate("yyyy-MM-dd HH:mm:ss"))
        XCTAssertEqual(booking.modified, "2020-01-13 14:16:01".toDate("yyyy-MM-dd HH:mm:ss"))
        
        // Assert - Guest info
        XCTAssertEqual(booking.guestInfo.title, "yyyyyy")
        XCTAssertEqual(booking.guestInfo.firstname, "sasdasasda")
        XCTAssertEqual(booking.guestInfo.lastname, "dwqeqwewqfdfdsfsdf")
        XCTAssertEqual(booking.guestInfo.email, "s")
        XCTAssertEqual(booking.guestInfo.phone, "444040")
        XCTAssertEqual(booking.guestInfo.mobile, "4540404")
        XCTAssertEqual(booking.guestInfo.fax, "")
        XCTAssertEqual(booking.guestInfo.company, "")
        
        // Assert - Guest address
        XCTAssertEqual(booking.guestAddress.address, "s")
        XCTAssertEqual(booking.guestAddress.city, "s")
        XCTAssertEqual(booking.guestAddress.state, "")
        XCTAssertEqual(booking.guestAddress.postCode, "w")
        XCTAssertEqual(booking.guestAddress.country, "d")
        XCTAssertEqual(booking.guestAddress.countryCode, "")
        
        // Assert - Financial info
        XCTAssertEqual(booking.price, 200.00)
        XCTAssertEqual(booking.deposit, 0.00)
        XCTAssertEqual(booking.tax, 0.00)
        XCTAssertEqual(booking.commission, 0.00)
        XCTAssertEqual(booking.currencyUnit, "THB")
        XCTAssertTrue(booking.rateDescription.isEmpty == false)
        
        // Assert - Channel info
        XCTAssertEqual(booking.referer, "homemadestay")
        XCTAssertEqual(booking.apiSource, 0)
        XCTAssertEqual(booking.referenceBookingID, "")
        
        // Assert - Other fields
        XCTAssertEqual(booking.notes, "update")
        XCTAssertEqual(booking.guestComments, "")
        
        // Assert - Invoices
        XCTAssertEqual(booking.invoices.count, 1)
        let invoice = booking.invoices[0]
        XCTAssertEqual(invoice.id, "24373826")
        XCTAssertEqual(invoice.description, "6 bed Wednesday, 15 January, 2020 - Thursday, 16 January, 2020")
        XCTAssertEqual(invoice.status, "")
        XCTAssertEqual(invoice.qty, 1)
        XCTAssertEqual(invoice.price, 200.00)
        XCTAssertEqual(invoice.tax, 0.00)
        XCTAssertEqual(invoice.invoiceeID, "")
        
        // Assert - Computed properties
        XCTAssertEqual(booking.nightCount, 1)
        XCTAssertEqual(booking.totalInvoiceAmount, 200.00)
        XCTAssertEqual(booking.totalCost, 200.00)
        XCTAssertEqual(booking.dailyRatePerUnit, 200.0) // 200 / 1 nights / 1 room
        XCTAssertEqual(booking.totalRatePerUnit, 200.0) // 200 / 1 room
        
        // Assert - Guest computed properties
        XCTAssertEqual(booking.guestInfo.fullName, "sasdasasda dwqeqwewqfdfdsfsdf")
        XCTAssertEqual(booking.guestInfo.allPhoneNumber, "444040, 4540404")
    }
    
    func test_encodingToCompleteJSON() throws {
        // Arrange
        let booking = createSampleCMBookingRaw()
        
        // Act
        let encoder = JSONEncoder()
        let encodedData = try encoder.encode(booking)
        let decodedBooking = try JSONDecoder().decode(CMBookingRaw.self, from: encodedData)
        
        // Assert - Basic booking info
        XCTAssertEqual(decodedBooking.bookingID, booking.bookingID)
        XCTAssertEqual(decodedBooking.roomID, booking.roomID)
        XCTAssertEqual(decodedBooking.unitID, booking.unitID)
        XCTAssertEqual(decodedBooking.roomCount, booking.roomCount)
        XCTAssertEqual(decodedBooking.status, booking.status)
        XCTAssertEqual(decodedBooking.adultCount, booking.adultCount)
        XCTAssertEqual(decodedBooking.childCount, booking.childCount)
        XCTAssertEqual(decodedBooking.propId, booking.propId)
        
        // Assert - Guest info
        XCTAssertEqual(decodedBooking.guestInfo.title, booking.guestInfo.title)
        XCTAssertEqual(decodedBooking.guestInfo.firstname, booking.guestInfo.firstname)
        XCTAssertEqual(decodedBooking.guestInfo.lastname, booking.guestInfo.lastname)
        XCTAssertEqual(decodedBooking.guestInfo.email, booking.guestInfo.email)
        XCTAssertEqual(decodedBooking.guestInfo.phone, booking.guestInfo.phone)
        XCTAssertEqual(decodedBooking.guestInfo.mobile, booking.guestInfo.mobile)
        XCTAssertEqual(decodedBooking.guestInfo.fax, booking.guestInfo.fax)
        XCTAssertEqual(decodedBooking.guestInfo.company, booking.guestInfo.company)
        
        // Assert - Guest address
        XCTAssertEqual(decodedBooking.guestAddress.address, booking.guestAddress.address)
        XCTAssertEqual(decodedBooking.guestAddress.city, booking.guestAddress.city)
        XCTAssertEqual(decodedBooking.guestAddress.state, booking.guestAddress.state)
        XCTAssertEqual(decodedBooking.guestAddress.postCode, booking.guestAddress.postCode)
        XCTAssertEqual(decodedBooking.guestAddress.country, booking.guestAddress.country)
        XCTAssertEqual(decodedBooking.guestAddress.countryCode, booking.guestAddress.countryCode)
        
        // Assert - Financial info
        XCTAssertEqual(decodedBooking.price, booking.price)
        XCTAssertEqual(decodedBooking.deposit, booking.deposit)
        XCTAssertEqual(decodedBooking.tax, booking.tax)
        XCTAssertEqual(decodedBooking.commission, booking.commission)
        XCTAssertEqual(decodedBooking.currencyUnit, booking.currencyUnit)
        XCTAssertEqual(decodedBooking.rateDescription, booking.rateDescription)
        
        // Assert - Channel info
        XCTAssertEqual(decodedBooking.referer, booking.referer)
        XCTAssertEqual(decodedBooking.apiSource, booking.apiSource)
        XCTAssertEqual(decodedBooking.referenceBookingID, booking.referenceBookingID)
        
        // Assert - Other fields
        XCTAssertEqual(decodedBooking.notes, booking.notes)
        XCTAssertEqual(decodedBooking.guestComments, booking.guestComments)
        
        // Assert - Computed properties
        XCTAssertEqual(decodedBooking.nightCount, booking.nightCount)
        XCTAssertEqual(decodedBooking.totalInvoiceAmount, booking.totalInvoiceAmount)
        XCTAssertEqual(decodedBooking.totalCost, booking.totalCost)
        XCTAssertEqual(decodedBooking.dailyRatePerUnit, booking.dailyRatePerUnit)
        XCTAssertEqual(decodedBooking.totalRatePerUnit, booking.totalRatePerUnit)
    }
    
    // MARK: - Helper Methods
    
    private func createSampleCMBookingRaw() -> CMBookingRaw {
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
        
        return CMBookingRaw(
            propId: "102230",
            status: .confirmed,
            bookingID: "16500820",
            roomID: "232711",
            unitID: "2",
            roomCount: 1,
            firstNightDate: "2020-01-15".toDate(FormConfig.DateFormat.yyyyMMdd) ?? .now,
            lastNightDate: "2020-01-16".toDate(FormConfig.DateFormat.yyyyMMdd) ?? .now,
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
    }
} 
