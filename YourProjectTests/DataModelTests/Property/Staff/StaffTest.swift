//
//  StaffTest.swift
//  YourProject
//
//  Created by IntrodexMac on 10/5/2568 BE.
//

import XCTest

final class StaffTest: XCTestCase {
    
    func testStaffDecoding() throws {
        // Given
        let jsonString = """
        {
            "id": 36,
            "status": "ACTIVE",
            "role": "FRONT_DESK",
            "user_id": 127,
            "username": "demo_staff123@email.com",
            "email": "demo_staff123@email.com",
            "first_name": "rrr",
            "last_name": "fff",
            "phone_number": "[[rpr[e",
            "id_card": "3434434",
            "logo_image": "https://example.com/image.png",
            "sign_signature_image": null,
            "hotel_id": 105,
            "created_at": "2021-11-16T13:17:05.109+07:00",
            "updated_at": "2021-11-16T13:17:05.109+07:00"
        }
        """
        
        let jsonData = jsonString.data(using: .utf8)!
        
        // When
        let staff = try JSONDecoder().decode(Staff.self, from: jsonData)
        
        // Then
        XCTAssertEqual(staff.id, 36)
        XCTAssertEqual(staff.status, .active)
        XCTAssertEqual(staff.role, .frontDesk)
        XCTAssertEqual(staff.userId, 127)
        XCTAssertEqual(staff.username, "demo_staff123@email.com")
        XCTAssertEqual(staff.email, "demo_staff123@email.com")
        XCTAssertEqual(staff.firstName, "rrr")
        XCTAssertEqual(staff.lastName, "fff")
        XCTAssertEqual(staff.phoneNumber, "[[rpr[e")
        XCTAssertEqual(staff.idCard, "3434434")
        XCTAssertEqual(staff.logoImage, "https://example.com/image.png")
        XCTAssertNil(staff.signSignatureImage)
        XCTAssertEqual(staff.hotelId, 105)
    }
    
    func testStaffEncoding() throws {
        // Given
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        let createdAt = dateFormatter.date(from: "2021-11-16T13:17:05.109+07:00")!
        let updatedAt = dateFormatter.date(from: "2021-11-16T13:17:05.109+07:00")!
        
        let staff = Staff(
            id: 36,
            status: .active,
            role: .frontDesk,
            userId: 127,
            username: "demo_staff123@email.com",
            email: "demo_staff123@email.com",
            firstName: "rrr",
            lastName: "fff",
            phoneNumber: "[[rpr[e",
            idCard: "3434434",
            logoImage: "https://example.com/image.png",
            signSignatureImage: nil,
            hotelId: 105,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
        
        // When
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(staff)
        let decodedStaff = try JSONDecoder().decode(Staff.self, from: jsonData)
        
        // Then
        XCTAssertEqual(decodedStaff.id, staff.id)
        XCTAssertEqual(decodedStaff.status, staff.status)
        XCTAssertEqual(decodedStaff.role, staff.role)
        XCTAssertEqual(decodedStaff.userId, staff.userId)
        XCTAssertEqual(decodedStaff.username, staff.username)
        XCTAssertEqual(decodedStaff.email, staff.email)
        XCTAssertEqual(decodedStaff.firstName, staff.firstName)
        XCTAssertEqual(decodedStaff.lastName, staff.lastName)
        XCTAssertEqual(decodedStaff.phoneNumber, staff.phoneNumber)
        XCTAssertEqual(decodedStaff.idCard, staff.idCard)
        XCTAssertEqual(decodedStaff.logoImage, staff.logoImage)
        XCTAssertEqual(decodedStaff.signSignatureImage, staff.signSignatureImage)
        XCTAssertEqual(decodedStaff.hotelId, staff.hotelId)
    }
    
    func testStaffStatusEnum() {
        // Test all cases
        XCTAssertEqual(Staff.Status.active.rawValue, "ACTIVE")
        XCTAssertEqual(Staff.Status.inactive.rawValue, "INACTIVE")
        
        // Test descriptions
        XCTAssertEqual(Staff.Status.active.description, "Active")
        XCTAssertEqual(Staff.Status.inactive.description, "Inactive")
    }
    
    func testStaffRoleEnum() {
        // Test all cases
        XCTAssertEqual(Staff.Role.frontDesk.rawValue, "FRONT_DESK")
        XCTAssertEqual(Staff.Role.manager.rawValue, "MANAGER")
        XCTAssertEqual(Staff.Role.maid.rawValue, "MAID")
        XCTAssertEqual(Staff.Role.accountant.rawValue, "ACCOUNTANT")        
        
        // Test descriptions
        XCTAssertEqual(Staff.Role.frontDesk.description, "Front Desk")
        XCTAssertEqual(Staff.Role.manager.description, "Manager")
        XCTAssertEqual(Staff.Role.maid.description, "Maid")
        XCTAssertEqual(Staff.Role.accountant.description, "Accountant")
    }
}

