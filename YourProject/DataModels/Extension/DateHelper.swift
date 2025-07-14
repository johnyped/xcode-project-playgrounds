//
//  DateHelper.swift
//  YourProject
//
//  Created by IntrodexMini on 17/5/2568 BE.
//
import Foundation

extension Date {

    /// Compares two dates ignoring time components, returning their relative ordering
    /// 
    /// This method compares dates based only on year, month and day components, ignoring time of day.
    /// 
    /// - Parameter date: The date to compare with
    /// - Returns: A ComparisonResult indicating the ordering:
    ///   - .orderedAscending if self is earlier than the parameter date
    ///   - .orderedDescending if self is later than the parameter date  
    ///   - .orderedSame if the dates are the same
    ///
    /// Example:
    /// ```
    /// let date1 = Date() // 2023-05-17 10:30:00
    /// let date2 = Date() // 2023-05-16 15:45:00
    /// 
    /// let result = date1.compareDate(with: date2)
    /// // result = .orderedDescending (since May 17 is after May 16)
    /// ```
    /// ```
    /// let date3 = Date() // 2023-05-17 08:00:00
    /// let date4 = Date() // 2023-05-17 20:00:00
    /// 
    /// let result = date3.compareDate(with: date4) 
    /// // result = .orderedSame (since both dates are on May 17, ignoring time)
    /// ```
    /// ```
    /// let date5 = Date() // 2023-05-16 10:30:00
    /// let date6 = Date() // 2023-05-17 09:45:00
    /// 
    /// let result = date5.compareDate(with: date6)
    /// // result = .orderedAscending (since May 16 is before May 17)
    /// ```

    func compareDate(with date: Date,
                     calendar: Calendar = .current,
                     locale: Locale = .current) -> ComparisonResult {
        
        let selfComponents = calendar.dateComponents([.year, .month, .day], from: self)
        let otherComponents = calendar.dateComponents([.year, .month, .day], from: date)
        
        guard let selfDate = calendar.date(from: selfComponents),
              let otherDate = calendar.date(from: otherComponents) else {
            return .orderedSame
        }
        
        if selfDate > otherDate {
            return .orderedDescending
        } else if selfDate < otherDate {
            return .orderedAscending
        }
        return .orderedSame
    }

    /// Creates a Date from the specified year, month and day components
    /// 
    /// - Parameters:
    ///   - year: The year component
    ///   - month: The month component (1-12)
    ///   - day: The day component (1-31)
    ///   - calendar: Calendar to use, defaults to current calendar
    /// - Returns: Optional Date created from the components, nil if invalid
    ///
    /// Example:
    /// ```
    /// let date = Date.from(year: 2023, month: 5, day: 17)
    /// // Creates date for May 17, 2023
    /// ```
    static func from(
        year: Int,
        month: Int,
        day: Int,
        calendar: Calendar = Calendar.current
    ) -> Date? {
        let components = DateComponents(
            calendar: calendar,
            year: year,
            month: month,
            day: day
        )
        return calendar.date(from: components)
    }

    
}
