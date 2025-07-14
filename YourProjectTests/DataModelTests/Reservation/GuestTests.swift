import XCTest

final class GuestTests: XCTestCase {
    // MARK: - Helper Methods
    private func sampleAddress() -> Address {
        Address(houseNumber: "123", district: "Bangkok", province: "Bangkok", zipCode: "10110", countryCode: "THA")
    }

    private func sampleDate(_ string: String, format: String = "yyyy-MM-dd") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.date(from: string)
    }

    private func sampleGuest() -> Guest {
        Guest(
            id: 1,
            titleCode: "MR",
            firstName: "John",
            midName: "Mid",
            lastName: "Doe",
            nickName: "Johnny",
            nationalityCode: "THA",
            countryCode: "THA",
            birthdate: sampleDate("1990-01-01"),
            citizenCardID: "1234567890123",
            passportNo: "A12345678",
            gender: .male,
            email: "john@email.com",
            phone: "0812345678",
            note: "VIP guest",
            hotelId: 101,
            companyId: 202,
            isFirst: true,
            isHidden: false,
            address: sampleAddress(),
            occupation: "Engineer",
            createdAt: Date(),
            updatedAt: Date()
        )
    }

    private func sampleGuestWithNilGender() -> Guest {
        Guest(
            id: 2,
            titleCode: "MS",
            firstName: "Jane",
            midName: "",
            lastName: "Smith",
            nickName: "Janie",
            nationalityCode: "THA",
            countryCode: "THA",
            birthdate: sampleDate("1995-06-15"),
            citizenCardID: "9876543210987",
            passportNo: "",
            gender: nil,
            email: "jane@email.com",
            phone: "0887654321",
            note: "Regular guest",
            hotelId: 101,
            companyId: nil,
            isFirst: false,
            isHidden: false,
            address: sampleAddress(),
            occupation: "Teacher",
            createdAt: Date(),
            updatedAt: Date()
        )
    }

    private func sampleMinimalGuest() -> Guest {
        Guest(
            id: 3,
            titleCode: nil,
            firstName: "Min",
            midName: "",
            lastName: "User",
            nickName: "",
            nationalityCode: "THA",
            countryCode: "THA",
            birthdate: nil,
            citizenCardID: "",
            passportNo: "",
            gender: nil,
            email: "",
            phone: "",
            note: "",
            hotelId: 0,
            companyId: nil,
            isFirst: false,
            isHidden: false,
            address: sampleAddress(),
            occupation: "",
            createdAt: Date(),
            updatedAt: Date()
        )
    }

    // MARK: - Initialization Tests
    func test_initWithAllProperties() {
        let guest = sampleGuest()
        XCTAssertEqual(guest.id, 1)
        XCTAssertEqual(guest.titleCode, "MR")
        XCTAssertEqual(guest.firstName, "John")
        XCTAssertEqual(guest.midName, "Mid")
        XCTAssertEqual(guest.lastName, "Doe")
        XCTAssertEqual(guest.nickName, "Johnny")
        XCTAssertEqual(guest.nationalityCode, "THA")
        XCTAssertEqual(guest.countryCode, "THA")
        XCTAssertEqual(guest.citizenCardID, "1234567890123")
        XCTAssertEqual(guest.passportNo, "A12345678")
        XCTAssertEqual(guest.gender, .male)
        XCTAssertEqual(guest.email, "john@email.com")
        XCTAssertEqual(guest.phone, "0812345678")
        XCTAssertEqual(guest.address.houseNumber, "123")
        XCTAssertEqual(guest.occupation, "Engineer")
        XCTAssertEqual(guest.note, "VIP guest")
        XCTAssertEqual(guest.hotelId, 101)
        XCTAssertEqual(guest.companyId, 202)
        XCTAssertEqual(guest.isFirst, true)
        XCTAssertEqual(guest.isHidden, false)
    }

    // MARK: - Computed Properties Tests
    func test_fullName() {
        let guest = sampleGuest()
        XCTAssertEqual(guest.fullName, "John Mid Doe")
    }

    func test_titleFullName_fallback() {
        let guest = sampleGuest()
        // NameTitleList.shared.lists is empty by default, so fallback to code
        XCTAssertEqual(guest.titleFullName, "MR John Mid Doe")
    }

    func test_identityID_isThaiCitizen() {
        let guest = sampleGuest()
        XCTAssertEqual(guest.identityID, "1234567890123")
    }

    func test_identityID_isForeigner() {
        var guest = sampleGuest()
        guest = Guest(
            id: 2,
            titleCode: "MR",
            firstName: "Alex",
            midName: "",
            lastName: "Smith",
            nickName: "Al",
            nationalityCode: "USA",
            countryCode: "USA",
            birthdate: sampleDate("1985-05-05"),
            citizenCardID: "",
            passportNo: "B98765432",
            gender: .male,
            email: "alex@email.com",
            phone: "0898765432",
            note: "",
            hotelId: 102,
            companyId: nil,
            isFirst: false,
            isHidden: false,
            address: sampleAddress(),
            occupation: "Designer",
            createdAt: Date(),
            updatedAt: Date()
        )
        XCTAssertEqual(guest.identityID, "B98765432")
    }

    func test_isThaiCitizen_and_isForeigner() {
        let guest = sampleGuest()
        XCTAssertTrue(guest.isThaiCitizen)
        XCTAssertFalse(guest.isForeigner)
        var foreigner = sampleGuest()
        foreigner = Guest(
            id: 3,
            titleCode: "MR",
            firstName: "Anna",
            midName: "",
            lastName: "Lee",
            nickName: "Ann",
            nationalityCode: "USA",
            countryCode: "USA",
            birthdate: sampleDate("1992-02-02"),
            citizenCardID: "",
            passportNo: "C12345678",
            gender: .female,
            email: "anna@email.com",
            phone: "0876543210",
            note: "",
            hotelId: 103,
            companyId: nil,
            isFirst: false,
            isHidden: false,
            address: sampleAddress(),
            occupation: "Artist",
            createdAt: Date(),
            updatedAt: Date()
        )
        XCTAssertFalse(foreigner.isThaiCitizen)
        XCTAssertTrue(foreigner.isForeigner)
    }

    func test_age() {
        let guest = Guest(
            id: 4,
            titleCode: nil,
            firstName: "Old",
            midName: "",
            lastName: "Man",
            nickName: "Oldie",
            nationalityCode: "THA",
            countryCode: "THA",
            birthdate: sampleDate("2000-01-01"),
            citizenCardID: "",
            passportNo: "",
            gender: .male,
            email: "",
            phone: "",
            note: "",
            hotelId: 0,
            companyId: nil,
            isFirst: false,
            isHidden: false,
            address: sampleAddress(),
            occupation: "",
            createdAt: Date(),
            updatedAt: Date()
        )
        let now = Calendar.current.component(.year, from: Date())
        XCTAssertEqual(guest.age, now - 2000)
    }

    // MARK: - Mutating Methods
    func test_setTHNation_and_setUSNation() {
        var guest = sampleGuest()
        guest.setUSNation()
        XCTAssertEqual(guest.nationalityCode, "USA")
        guest.setTHNation()
        XCTAssertEqual(guest.nationalityCode, "THA")
    }

    // MARK: - Codable Tests
    func test_encodingAndDecoding() throws {
        let guest = sampleGuest()
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(guest)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(Guest.self, from: data)
        XCTAssertEqual(decoded.id, guest.id)
        XCTAssertEqual(decoded.firstName, guest.firstName)
        XCTAssertEqual(decoded.lastName, guest.lastName)
        XCTAssertEqual(decoded.nationalityCode, guest.nationalityCode)
        XCTAssertEqual(decoded.countryCode, guest.countryCode)
        XCTAssertEqual(decoded.citizenCardID, guest.citizenCardID)
        XCTAssertEqual(decoded.passportNo, guest.passportNo)
        XCTAssertEqual(decoded.gender, guest.gender)
        XCTAssertEqual(decoded.email, guest.email)
        XCTAssertEqual(decoded.phone, guest.phone)
        XCTAssertEqual(decoded.address.houseNumber, guest.address.houseNumber)
        XCTAssertEqual(decoded.occupation, guest.occupation)
        XCTAssertEqual(decoded.note, guest.note)
        XCTAssertEqual(decoded.hotelId, guest.hotelId)
        XCTAssertEqual(decoded.companyId, guest.companyId)
        XCTAssertEqual(decoded.isFirst, guest.isFirst)
        XCTAssertEqual(decoded.isHidden, guest.isHidden)
    }

    // MARK: - Gender Enum Tests
    func test_genderTitleAndLogoImageName() {
        XCTAssertEqual(Guest.Gender.male.title, "Male")
        XCTAssertEqual(Guest.Gender.female.title, "Female")
        XCTAssertEqual(Guest.Gender.male.logoImageName, "icon-customer-male")
        XCTAssertEqual(Guest.Gender.female.logoImageName, "icon-customer-female")
    }

    // MARK: - Gender Nil Tests
    func test_initWithNilGender() {
        let guest = sampleGuestWithNilGender()
        XCTAssertEqual(guest.id, 2)
        XCTAssertEqual(guest.firstName, "Jane")
        XCTAssertEqual(guest.lastName, "Smith")
        XCTAssertNil(guest.gender)
        XCTAssertEqual(guest.nationalityCode, "THA")
        XCTAssertEqual(guest.countryCode, "THA")
    }

    func test_genderNilProperties() {
        let guest = sampleGuestWithNilGender()
        // Gender being nil should not affect other computed properties
        XCTAssertEqual(guest.fullName, "Jane Smith")
        XCTAssertEqual(guest.identityID, "9876543210987")
        XCTAssertTrue(guest.isThaiCitizen)
        XCTAssertFalse(guest.isForeigner)
    }

    func test_encodingDecodingWithNilGender() throws {
        let guest = sampleGuestWithNilGender()
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(guest)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(Guest.self, from: data)
        
        XCTAssertEqual(decoded.id, guest.id)
        XCTAssertEqual(decoded.firstName, guest.firstName)
        XCTAssertEqual(decoded.lastName, guest.lastName)
        XCTAssertNil(decoded.gender)
        XCTAssertEqual(decoded.nationalityCode, guest.nationalityCode)
        XCTAssertEqual(decoded.countryCode, guest.countryCode)
    }

    // MARK: - Advanced Encoder/Decoder Tests
    func test_decodingWithMissingOptionalFields() throws {
        let jsonString = """
        {
            "id": 100,
            "first_name": "Test",
            "middle_name": "",
            "last_name": "User",
            "nickname": "",
            "nationality": "THA",
            "country": "THA",
            "id_card_no": "",
            "passport_no": "",
            "email": "",
            "phone": "",
            "address": "",
            "district": "",
            "province": "",
            "zip_code": "",
            "note": "",
            "hotel_id": 1,
            "hidden": false,
            "first_guest": false,
            "created_at": "2022-11-21T21:40:42.072+07:00",
            "updated_at": "2022-11-21T21:40:42.072+07:00",
            "occupation": ""
        }
        """
        
        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let guest = try decoder.decode(Guest.self, from: data)
        
        XCTAssertEqual(guest.id, 100)
        XCTAssertEqual(guest.occupation, "")
    }

    func test_decodingWithInvalidGenderValue() throws {
        let jsonString = """
        {
            "id": 101,
            "first_name": "Invalid",
            "middle_name": "",
            "last_name": "Gender",
            "nickname": "",
            "nationality": "THA",
            "country": "THA",
            "gender": "INVALID_GENDER",
            "id_card_no": "",
            "passport_no": "",
            "email": "",
            "phone": "",
            "address": "",
            "district": "",
            "province": "",
            "zip_code": "",
            "note": "",
            "hotel_id": 1,
            "hidden": false,
            "first_guest": false,
            "created_at": "2022-11-21T21:40:42.072+07:00",
            "updated_at": "2022-11-21T21:40:42.072+07:00",
            "occupation": ""
        }
        """
        
        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let guest = try decoder.decode(Guest.self, from: data)
        XCTAssertEqual(guest.id, 101)
        XCTAssertEqual(guest.firstName, "Invalid")
        XCTAssertNil(guest.gender) // Should be nil due to invalid value
    }

    func test_encodingWithMinimalRequiredFields() throws {
        let guest = sampleMinimalGuest()
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(guest)
        
        // Verify it can be encoded without throwing
        XCTAssertGreaterThan(data.count, 0)
        
        // Verify it can be decoded back
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(Guest.self, from: data)
        
        XCTAssertEqual(decoded.id, guest.id)
        XCTAssertEqual(decoded.firstName, guest.firstName)
        XCTAssertNil(decoded.gender)
        XCTAssertNil(decoded.titleCode)
        XCTAssertNil(decoded.birthdate)
        XCTAssertNil(decoded.companyId)
    }

    func test_decodingWithNilDates() throws {
        let jsonString = """
        {
            "id": 102,
            "first_name": "No",
            "middle_name": "",
            "last_name": "Birthdate",
            "nickname": "",
            "nationality": "THA",
            "country": "THA",
            "date_of_birth": null,
            "id_card_no": "",
            "passport_no": "",
            "email": "",
            "phone": "",
            "address": "",
            "district": "",
            "province": "",
            "zip_code": "",
            "note": "",
            "hotel_id": 1,
            "hidden": false,
            "first_guest": false,
            "created_at": "2022-11-21T21:40:42.072+07:00",
            "updated_at": "2022-11-21T21:40:42.072+07:00",
            "occupation": ""
        }
        """
        
        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let guest = try decoder.decode(Guest.self, from: data)
        
        XCTAssertEqual(guest.id, 102)
        XCTAssertEqual(guest.firstName, "No")
        XCTAssertNil(guest.birthdate)
        XCTAssertNil(guest.age) // Age should be nil when birthdate is nil
    }

    func test_codingKeysMapping() throws {
        let guest = sampleGuest()
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(guest)
        
        // Convert to dictionary to verify key mapping
        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        
        // Verify that Swift property names are correctly mapped to JSON keys
        XCTAssertNotNil(json["first_name"])
        XCTAssertNotNil(json["last_name"])
        XCTAssertNotNil(json["middle_name"])
        XCTAssertNotNil(json["nationality"])
        XCTAssertNotNil(json["country"])
        XCTAssertNotNil(json["date_of_birth"])
        XCTAssertNotNil(json["id_card_no"])
        XCTAssertNotNil(json["passport_no"])
        XCTAssertNotNil(json["hotel_id"])
        XCTAssertNotNil(json["company_id"])
        XCTAssertNotNil(json["first_guest"])
        XCTAssertNotNil(json["created_at"])
        XCTAssertNotNil(json["updated_at"])
        XCTAssertNotNil(json["zip_code"])
        
        // Verify that values match expected mappings
        XCTAssertEqual(json["first_name"] as? String, "John")
        XCTAssertEqual(json["nationality"] as? String, "THA")
        XCTAssertEqual(json["hotel_id"] as? Int, 101)
        XCTAssertEqual(json["first_guest"] as? Bool, true)
    }

    func test_ageWithNilBirthdate() {
        let guest = sampleMinimalGuest()
        XCTAssertNil(guest.age)
    }
} 
