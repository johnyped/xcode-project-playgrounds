//
//  CMBookingRaw.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//

import Foundation

struct CMBookingRaw: Codable {
        
    let bookingID: String
    let status: Status
    let propId: String
    let roomID: String
    let unitID: String
    let roomCount: Int
    let firstNightDate: Date
    let lastNightDate: Date
    let adultCount: Int
    let childCount: Int
    
    // guest info
    let guestInfo: GuestInfo
    let guestAddress: GuestAddress
    let guestComments: String
    
    var notes: String
    
    // finance
    let price: Double
    let deposit: Double
    let tax: Double
    let commission: Double
    let currencyUnit: String
    let rateDescription: String // "2020-01-06 1000 rate 2597321, \r\n2020-01-07 1000 rate 2597321,",
    
    // invoice
    let invoices: [CMInvoice]
    
    // creater
    let referer: String // ota name
    let apiSource: Int // ota channel id
    let referenceBookingID: String // ota booking id
    
    let bookingTime: Date
    let modified: Date
    
    var nightCount: Int {
        firstNightDate.numberOfDaysUntilDateTime(lastNightDate) + 1
    }
    
    var totalInvoiceAmount: Double {
        invoices.reduce(0) { (result, invoice) -> Double in
            result + (Double(invoice.qty) * invoice.price)
        }
    }
    
    var totalCost: Double {
        if invoices.count > 0 {
            return totalInvoiceAmount
        }
        
        return price
    }
    
    // dailyRatePerUnit = (price / number of night) / number of unit
    var dailyRatePerUnit: Double {
        if invoices.count > 0 {
            return (totalInvoiceAmount / Double(nightCount)) / Double(roomCount)
        }
        
        return (price / Double(nightCount)) / Double(roomCount)
    }
    
    // totalRatePerUnit = price / number of unit
    var totalRatePerUnit: Double {
        if invoices.count > 0 {
            return totalInvoiceAmount / Double(roomCount)
        }
        
        return price / Double(roomCount)
    }
    
    init(propId: String,
         status: Status,
         bookingID: String,
         roomID: String,
         unitID: String,
         roomCount: Int,
         firstNightDate: Date,
         lastNightDate: Date,
         adultCount: Int,
         childCount: Int,
         guestInfo: GuestInfo,
         guestAddress: GuestAddress,
         guestComments: String,
         notes: String,
         price: Double,
         deposit: Double,
         tax: Double,
         commission: Double,
         currencyUnit: String,
         rateDescription: String,
         invoices: [CMInvoice],
         referer: String,
         apiSource: Int,
         referenceBookingID: String,
         bookingTime: Date,
         modified: Date) {
        self.propId = propId
        self.status = status
        self.bookingID = bookingID
        self.roomID = roomID
        self.unitID = unitID
        self.roomCount = roomCount
        self.firstNightDate = firstNightDate
        self.lastNightDate = lastNightDate
        self.adultCount = adultCount
        self.childCount = childCount
        self.guestInfo = guestInfo
        self.guestAddress = guestAddress
        self.guestComments = guestComments
        self.notes = notes
        self.price = price
        self.deposit = deposit
        self.tax = tax
        self.commission = commission
        self.currencyUnit = currencyUnit
        self.rateDescription = rateDescription
        self.invoices = invoices
        self.referer = referer
        self.apiSource = apiSource
        self.referenceBookingID = referenceBookingID
        self.bookingTime = bookingTime
        self.modified = modified
    }
    
    //decode
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        propId = try container.decode(String.self, forKey: .propID)
        status = try container.decode(Status.self, forKey: .status)
        bookingID = try container.decode(String.self, forKey: .bookingID)
        roomID = try container.decode(String.self, forKey: .roomID)
        unitID = try container.decode(String.self, forKey: .unitID)
        roomCount = try container.decode(String.self, forKey: .roomCount).trytoInt()
        
        firstNightDate = try container.decode(String.self, forKey: .firstNightDate).tryToDate(FormConfig.DateFormat.yyyyMMdd)
        
        lastNightDate = try container.decode(String.self, forKey: .lastNightDate).tryToDate(FormConfig.DateFormat.yyyyMMdd)
        
        adultCount = try container.decode(String.self, forKey: .adultCount).trytoInt()
        childCount = try container.decode(String.self, forKey: .childCount).trytoInt()
        
        notes = (try? container.decode(String.self, forKey: .notes)) ?? ""
        price = try container.decode(String.self, forKey: .price).tryToDouble()
        deposit = try container.decode(String.self, forKey: .deposit).tryToDouble()
        tax = try container.decode(String.self, forKey: .tax).tryToDouble()
        commission = try container.decode(String.self, forKey: .commission).tryToDouble()
        
        currencyUnit = try container.decode(String.self, forKey: .currencyUnit)
        rateDescription = try container.decode(String.self, forKey: .rateDescription)
        
        let _invoices: [CMInvoice?] = (try? container.decode([CMInvoice?].self, forKey: .invoices)) ?? []
        invoices = _invoices.compactMap({ $0 })
        
        referer = try container.decode(String.self, forKey: .referer)
        apiSource = try container.decode(String.self, forKey: .apiSource).trytoInt()
        referenceBookingID = try container.decode(String.self, forKey: .referenceBookingID)
        
        // bookingTime
        let datetimeFormat = "yyyy-MM-dd HH:mm:ss" // 2020-01-06
        bookingTime = try container.decode(String.self, forKey: .bookingTime).tryToDate(datetimeFormat)
        modified = try container.decode(String.self, forKey: .modified).tryToDate(datetimeFormat)
        
        guestInfo = try GuestInfo(from: decoder)
        guestAddress = try GuestAddress(from: decoder)
        guestComments = try container.decode(String.self, forKey: .guestComments)
    }
    
    //encode
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(propId, forKey: .propID)
        try container.encode(status, forKey: .status)
        try container.encode(bookingID, forKey: .bookingID)
        try container.encode(roomID, forKey: .roomID)
        try container.encode(unitID, forKey: .unitID)
        try container.encode(roomCount.toString(), forKey: .roomCount)
        try container.encode(firstNightDate.toDateString(FormConfig.DateFormat.yyyyMMdd), forKey: .firstNightDate)
        try container.encode(lastNightDate.toDateString(FormConfig.DateFormat.yyyyMMdd), forKey: .lastNightDate)
        try container.encode(adultCount.toString(), forKey: .adultCount)
        try container.encode(childCount.toString(), forKey: .childCount)
        try container.encode(notes, forKey: .notes)
        try container.encode(price.toString(), forKey: .price)
        try container.encode(deposit.toString(), forKey: .deposit)
        try container.encode(tax.toString(), forKey: .tax)
        try container.encode(commission.toString(), forKey: .commission)
        try container.encode(currencyUnit, forKey: .currencyUnit)
        try container.encode(rateDescription, forKey: .rateDescription)
        try container.encode(invoices, forKey: .invoices)
        
        try container.encode(referer, forKey: .referer)
        try container.encode(apiSource.toString(), forKey: .apiSource)
        try container.encode(referenceBookingID, forKey: .referenceBookingID)
        
        let datetimeFormat = "yyyy-MM-dd HH:mm:ss" // 2020-01-06
        try container.encode(bookingTime.toDateString(datetimeFormat), forKey: .bookingTime)
        try container.encode(modified.toDateString(datetimeFormat), forKey: .modified)
        
        try guestInfo.encode(to: encoder)
        try guestAddress.encode(to: encoder)
        try container.encode(guestComments, forKey: .guestComments)
    }
    
    enum CodingKeys: String, CodingKey {
        case propID = "propId"
        case status
        case bookingID = "bookId"
        case roomID = "roomId"
        case unitID = "unitId"
        case roomCount = "roomQty"
        case firstNightDate = "firstNight"
        case lastNightDate = "lastNight"
        case adultCount = "numAdult"
        case childCount = "numChild"
        case guestComments
        case notes
        case price
        case deposit
        case tax
        case commission
        case currencyUnit = "currency"
        case rateDescription = "rateDescription"
        case invoices = "invoice"
        case referer
        case referenceBookingID = "apiReference"
        case apiSource = "apiSource"
        case bookingTime
        case modified
    }
}

extension CMBookingRaw {
    
    enum Status: String, Codable {
        case cancelled = "0"
        case confirmed = "1"
        case new = "2" //(same as confirmed but unread)
        case request = "3"
        case black = "4"
        case unknow = "-1"
        
        //decode
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let value = try container.decode(String.self)
            self = Status(rawValue: value) ?? .unknow
        }
        
        //encode
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(rawValue)
        }
    }
    
    struct GuestInfo: Codable {
        let title: String
        let firstname: String
        let lastname: String
        let email: String
        let phone: String
        let mobile: String
        let fax: String
        let company: String
        
        var fullName: String {
            firstname + " " + lastname
        }
        
        var allPhoneNumber: String {
            var buffer = ""
            if phone.count > 0 {
                buffer += phone
            }
            
            if buffer.count > 0 {
                buffer += ", "
            }
            
            if mobile.count > 0 {
                buffer += mobile
            }
           
            return buffer
        }
        
        init(title: String = "",
             firstname: String = "",
             lastname: String = "",
             email: String = "",
             phone: String = "",
             mobile: String = "",
             fax: String = "",
             company: String = "") {
            self.title = title
            self.firstname = firstname
            self.lastname = lastname
            self.email = email
            self.phone = phone
            self.mobile = mobile
            self.fax = fax
            self.company = company
        }
        
        //decode
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            title = (try? container.decode(String.self, forKey: .title)) ?? ""
            firstname = (try? container.decode(String.self, forKey: .firstname)) ?? ""
            lastname = (try? container.decode(String.self, forKey: .lastname)) ?? ""
            email = (try? container.decode(String.self, forKey: .email)) ?? ""
            phone = (try? container.decode(String.self, forKey: .phone)) ?? ""
            mobile = (try? container.decode(String.self, forKey: .mobile)) ?? ""
            fax = (try? container.decode(String.self, forKey: .fax)) ?? ""
            company = (try? container.decode(String.self, forKey: .company)) ?? ""
        }
        
        //encode
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(title, forKey: .title)
            try container.encode(firstname, forKey: .firstname)
            try container.encode(lastname, forKey: .lastname)
            try container.encode(email, forKey: .email)
            try container.encode(phone, forKey: .phone)
            try container.encode(mobile, forKey: .mobile)
            try container.encode(fax, forKey: .fax)
            try container.encode(company, forKey: .company)
        }
        
        
        // enum
        enum CodingKeys: String, CodingKey {
            case title = "guestTitle"
            case firstname = "guestFirstName"
            case lastname = "guestName"
            case email = "guestEmail"
            case phone = "guestPhone"
            case mobile = "guestMobile"
            case fax = "guestFax"
            case company = "guestCompany"
        }
        
    }
    
    struct GuestAddress: Codable {
        let address: String
        let city: String
        let state: String
        let postCode: String
        let country: String // ex. "Thailand"
        let countryCode: String //ex. "TH"
        
        init(address: String,
             city: String,
             state: String,
             postCode: String,
             country: String,
             countryCode: String) {
            self.address = address
            self.city = city
            self.state = state
            self.postCode = postCode
            self.country = country
            self.countryCode = countryCode
        }

        //decode
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            address = (try? container.decode(String.self, forKey: .address)) ?? ""
            city = (try? container.decode(String.self, forKey: .city)) ?? ""
            state = (try? container.decode(String.self, forKey: .state)) ?? ""
            postCode = (try? container.decode(String.self, forKey: .postCode)) ?? ""
            country = (try? container.decode(String.self, forKey: .country)) ?? ""
            countryCode = (try? container.decode(String.self, forKey: .countryCode)) ?? ""
        }
        
        //encode
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(address, forKey: .address)
            try container.encode(city, forKey: .city)
            try container.encode(state, forKey: .state)
            try container.encode(postCode, forKey: .postCode)
            try container.encode(country, forKey: .country)
            try container.encode(countryCode, forKey: .countryCode)
        }
        
        //enum
        enum CodingKeys: String, CodingKey {
            case address = "guestAddress"
            case city = "guestCity"
            case state = "guestState"
            case postCode = "guestPostcode"
            case country = "guestCountry"
            case countryCode = "guestCountry2"
        }
    }
}

/*
 JSON reaponse
 {
       "bookId": "46892344",
       "roomId": "232710",
       "unitId": "1",
       "roomQty": "1",
       "status": "1",
       "substatus": "0",
       "firstNight": "2023-10-06",
       "lastNight": "2023-10-06",
       "numAdult": "2",
       "numChild": "0",
       "guestTitle": "",
       "guestFirstName": "Ja",
       "guestName": "Aey Wallapa",
       "guestEmail": "0f10hd9bnqvjgcbxv6vgjhkqa28g@agoda-messaging.com",
       "guestPhone": "+66 949022909",
       "guestMobile": "",
       "guestFax": "",
       "guestCompany": "",
       "guestAddress": "",
       "guestCity": "",
       "guestState": "",
       "guestPostcode": "",
       "guestCountry": "",
       "guestCountry2": "TH",
       "guestArrivalTime": "",
       "guestVoucher": "",
       "guestComments": "NonSmoke\r\nTwinBeds\r\nAdditionalNotes:มีผู้สูงอายุพัก รบกวนขอห้องชั้น 1 นะคะ ขอบคุณค่ะ\r\n",
       "notes": "Note: price less than room min price 2400.00\r\nCoffee & tea\r\nFree WiFi\r\nDrinking water\r\nParking\r\nBreakfast\r\nBike rental\r\nWelcome drink\r\n",
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
       "price": "2400.00",
       "deposit": "0.00",
       "tax": "0.00",
       "commission": "0.00",
       "currency": "THB",
       "rateDescription": "Agoda Collect\r\nStandard Twin\r\n44944 Breakfast\r\nCxl code = 14D1N_7D100P_100P",
       "offerId": "0",
       "referer": "homemadestay",
       "refererEditable": "Agoda.com",
       "reference": "",
       "apiSource": "0",
       "apiReference": "",
       "apiMessage": "<prices currency=\"THB\" net_inclusive_amt=\"1322.19\" refsell_amt=\"1593.0\"><price date=\"2023-10-06\" net_inclusive_amt=\"1322.19\" refsell_amt=\"1593.0\" type=\"Room\"/></prices>",
       "allowChannelUpdate": "1",
       "allowAutoAction": "1",
       "allowReview": "1",
       "cancelUntil": "-1",
       "stripeToken": "",
       "propId": "102230",
       "ownerId": "56401",
       "invoiceeId": "",
       "bookingTime": "2023-09-28 09:30:17",
       "modified": "2023-09-28 09:30:17",
       "cancelTime": "",
       "masterId": "",
       "invoiceNumber": "",
       "invoiceDate": "",
       "invoice": [
         {
           "invoiceId": "77333327",
           "description": "Duluxe Room Friday,  6 October, 2023 - Saturday,  7 October, 2023",
           "status": "",
           "qty": "1",
           "price": "1322.19",
           "vatRate": "0.00",
           "type": "8",
           "type2": "0",
           "invoiceeId": "",
           "createBy": "56401",
           "createTime": "2023-09-28 09:30:17"
         }
       ],
       "infoItems": []
     }
 */

