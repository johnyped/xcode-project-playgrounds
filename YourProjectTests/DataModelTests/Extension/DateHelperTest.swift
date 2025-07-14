//
//  DateHelperTest.swift
//  YourProject
//
//  Created by IntrodexMini on 17/5/2568 BE.
//

import XCTest

final class DateHelperTests: XCTestCase {

    // Date1 is after then Date2
    func testCompareDateShouldReturnOrderedDescendingWhenSelfDateIsGreaterThanOtherDate() {
        // Given
        let calendar = Calendar.current
        let date1 = calendar.date(from: DateComponents(year: 2023, month: 5, day: 17))!
        let date2 = calendar.date(from: DateComponents(year: 2023, month: 5, day: 16))!

        // When
        let result = date1.compareDate(
            with: date2,
            calendar: calendar
        )

        // Then
        XCTAssertEqual(result, .orderedDescending)
    }

    // Date1 is before Date2
    func testCompareDateShouldReturnOrderedAscendingWhenSelfDateIsLessThanOtherDate() {
        // Given
        let calendar = Calendar.current
        let date1 = calendar.date(from: DateComponents(year: 2023, month: 5, day: 16))!
        let date2 = calendar.date(from: DateComponents(year: 2023, month: 5, day: 17))!

        // When
        let result = date1.compareDate(
            with: date2,
            calendar: calendar
        )

        // Then
        XCTAssertEqual(result, .orderedAscending)
    }

    // Date1 is equal to Date2
    func testCompareDateShouldReturnOrderedSameWhenSelfDateEqualsOtherDate() {
        // Given
        let calendar = Calendar.current
        let date1 = calendar.date(from: DateComponents(year: 2023, month: 5, day: 17))!
        let date2 = calendar.date(from: DateComponents(year: 2023, month: 5, day: 17))!

        // When
        let result = date1.compareDate(
            with: date2,
            calendar: calendar
        )

        // Then
        XCTAssertEqual(result, .orderedSame)
    }
}
