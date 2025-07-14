//
//  NSDateExtension.swift
//  HomeMadeStay
//
//  Created by Introdex on 7/14/2559 BE.
//  Copyright © 2559 Fire One One Co.,Ltd. All rights reserved.
//

import Foundation


extension Date {
    
    static func now() -> Date {
        Date()
    }
    
    // is self <= date
    func isLessOrEqualThen(_ compareDate:Date) -> Bool {
        
        let calendar            = Calendar.current
        let components          = (calendar as NSCalendar).components([.day , .month , .year], from: self)
        let compareComponents   = (calendar as NSCalendar).components([.day , .month , .year], from: compareDate)
        
        let day             = Int(components.day!)
        let month           = Int(components.month!)
        let year            = Int(components.year!)
        
        let compareDay     = Int(compareComponents.day!)
        let compareMonth   = Int(compareComponents.month!)
        let compareYear    = Int(compareComponents.year!)
        
        // compare year
        if year > compareYear {
            return false
        }
        else if year < compareYear {
            return true
        }
        else if year == compareYear {
            // compaere month
            if month > compareMonth {
                return false
            }
            else if month < compareMonth {
                return true
            }
            else if month == compareMonth {
                // compate day
                if day > compareDay {
                    return false
                }
                else if day < compareDay {
                    return true
                }
                else if day == compareDay {
                    return true
                }
            }
        }
        
        return false
        
    }
    
    func isLessThen(_ compareDate:Date) -> Bool {
        let calendar            = Calendar.current
        let components          = (calendar as NSCalendar).components([.day , .month , .year], from: self)
        let compareComponents   = (calendar as NSCalendar).components([.day , .month , .year], from: compareDate)
        
        let day             = Int(components.day!)
        let month           = Int(components.month!)
        let year            = Int(components.year!)
        
        let compareDay     = Int(compareComponents.day!)
        let compareMonth   = Int(compareComponents.month!)
        let compareYear    = Int(compareComponents.year!)
        
        // compare year
        if year > compareYear {
            return false
        }
        else if year < compareYear {
            return true
        }
        else if year == compareYear {
            // compaere month
            if month > compareMonth {
                return false
            }
            else if month < compareMonth {
                return true
            }
            else if month == compareMonth {
                // compate day
                if day > compareDay {
                    return false
                }
                else if day < compareDay {
                    return true
                }
                else if day == compareDay {
                    return false
                }
            }
        }
        
        return false
    }
    
    // is self >= date
    func isMoreOrEqualThen(_ compareDate:Date) -> Bool {
        
        let calendar            = Calendar.current
        let components          = calendar.dateComponents([.day, .month, .year], from: self)
        let compareComponents   = calendar.dateComponents([.day, .month, .year], from: compareDate)
        let day             = Int(components.day!)
        let month           = Int(components.month!)
        let year            = Int(components.year!)
        
        let compareDay     = Int(compareComponents.day!)
        let compareMonth   = Int(compareComponents.month!)
        let compareYear    = Int(compareComponents.year!)
        
        // compare year
        if year > compareYear {
            return true
        }
        else if year < compareYear {
            return false
        }
        else if year == compareYear {
            // compaere month
            if month > compareMonth {
                return true
            }
            else if month < compareMonth {
                return false
            }
            else if month == compareMonth {
                // compate day
                if day > compareDay {
                    return true
                }
                else if day < compareDay {
                    return false
                }
                else if day == compareDay {
                    return true
                }
            }
        }
        
        return false
        
    }
    
    func isMoreThen(_ compareDate:Date) -> Bool {
        
        let calendar            = Calendar.current                
        let components          = calendar.dateComponents([.day, .month, .year], from: self)
        let compareComponents   = calendar.dateComponents([.day, .month, .year], from: compareDate)
        let day             = Int(components.day!)
        let month           = Int(components.month!)
        let year            = Int(components.year!)
        
        let compareDay     = Int(compareComponents.day!)
        let compareMonth   = Int(compareComponents.month!)
        let compareYear    = Int(compareComponents.year!)
        
        // compare year
        if year > compareYear {
            return true
        }
        else if year < compareYear {
            return false
        }
        else if year == compareYear {
            // compaere month
            if month > compareMonth {
                return true
            }
            else if month < compareMonth {
                return false
            }
            else if month == compareMonth {
                // compate day
                if day > compareDay {
                    return true
                }
                else if day < compareDay {
                    return false
                }
                else if day == compareDay {
                    return false
                }
            }
        }
        
        return false
        
    }
    
    func isSameDate(_ compareDate: Date) -> Bool {
        
        let calendar            = Calendar.current
        let components          = calendar.dateComponents([.day, .month, .year], from: self)
        let compareComponents   = calendar.dateComponents([.day, .month, .year], from: compareDate)
        let day             = Int(components.day!)
        let month           = Int(components.month!)
        let year            = Int(components.year!)
        
        let compareDay     = Int(compareComponents.day!)
        let compareMonth   = Int(compareComponents.month!)
        let compareYear    = Int(compareComponents.year!)
        
        return  (year == compareYear) &&
            (month == compareMonth) &&
            (day == compareDay)
    }
    
    func isSameMonth(_ compareDate: Date) -> Bool {
        let calendar            = Calendar.current
        let components          = calendar.dateComponents([.month, .year], from: self)
        let compareComponents   = calendar.dateComponents([.month, .year], from: compareDate)
        let month           = Int(components.month!)
        let year            = Int(components.year!)
        
        let compareMonth   = Int(compareComponents.month!)
        let compareYear    = Int(compareComponents.year!)
        
        return  (year == compareYear) && (month == compareMonth)
    }
    
    func isSameYear(_ compareDate: Date) -> Bool {
        let calendar            = Calendar.current
        let components          = calendar.dateComponents([.year], from: self)
        let compareComponents   = calendar.dateComponents([.year], from: compareDate)
        let year            = Int(components.year!)
        let compareYear    = Int(compareComponents.year!)
        return  (year == compareYear)
    }
    
    
    func isToday() -> Bool {
        return self.isSameDate(Date())
    }
    
    func isFalls(between startDate: Date, endDate: Date) -> Bool {
        return (startDate...endDate).contains(self)
    }
    
    func numberOfDaysUntilDateTime(_ toDateTime: Date) -> Int {
        return Date.numberOfDaysBetween(self, end: toDateTime)
    }
    
    static func dateFrom(_ year : Int , month : Int , day : Int) -> Date? {
        
        let calendar        = Calendar.current
        var components      = DateComponents()
        components.day      = day
        components.month    = month
        components.year     = year
        components.hour     = 0
        components.minute   = 0
        components.second   = 0
        
        return calendar.date(from: components)
    }
 
    func toDateString(_ strDateFormat: String) -> String {
        // parser to date string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strDateFormat
        
        // format 20XX-XX-XX
        dateFormatter.calendar = Calendar(identifier: Calendar.Identifier.gregorian) // use fix calendar
        let localeString = "DATE_LOCALE".localized //"en_US".localized
        dateFormatter.locale = Locale(identifier: localeString)
        return dateFormatter.string(from: self)
    }
    
    // suggest by ai
//    private static let isoDateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
//        return formatter
//    }()
    
    func toDateString(_ strDateFormat: String,
                      timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strDateFormat
        dateFormatter.calendar = Calendar(identifier: Calendar.Identifier.gregorian) // use fix calendar
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: self)
    }
    
    func toDateString(_ strDateFormat: String,
                      locale: Locale = Locale.current,
                      calendar: Calendar.Identifier = .gregorian) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strDateFormat
        dateFormatter.calendar = Calendar(identifier: calendar)
        dateFormatter.locale = locale
        return dateFormatter.string(from: self)
    }

    func getTomorrowDate() -> Date? {
        var calendar = Calendar.current
        calendar.locale = Locale.current
        let tomorrow = calendar.date(byAdding: .day,
                                      value: 1,
                                      to: self)
        return tomorrow        
    }

    func getYesterdayDate() -> Date? {
        var calendar = Calendar.current
        calendar.locale = Locale.current
        let yesterday = calendar.date(byAdding: .day,
                                      value: -1,
                                      to: self)
        return yesterday
    }
    
    func goBack(days: Int) -> Date {
        let backDay = (Calendar.current as NSCalendar).date(byAdding: .day,
                                                              value: -1*days,
                                                              to: self,
                                                              options: NSCalendar.Options(rawValue: 0))
        return backDay!
    }

    
    func goBack(months: Int) -> Date {
        let backMonth = (Calendar.current as NSCalendar).date(byAdding: .month,
                                                              value: -1*months,
                                                              to: self,
                                                              options: NSCalendar.Options(rawValue: 0))
        return backMonth!
    }
    
    func goBack(years: Int) -> Date {
        let backYear = (Calendar.current as NSCalendar).date(byAdding: .year,
                                                              value: -1*years,
                                                              to: self,
                                                              options: NSCalendar.Options(rawValue: 0))
        return backYear!
    }
    
    func goNext(days: Int) -> Date {
        let nextDay = (Calendar.current as NSCalendar).date(byAdding: .day,
                                                              value: 1*days,
                                                              to: self,
                                                              options: NSCalendar.Options(rawValue: 0))
        return nextDay!
    }

    func goNext(months: Int) -> Date {
        let nextMonth = (Calendar.current as NSCalendar).date(byAdding: .month,
                                                              value: 1*months,
                                                              to: self,
                                                              options: NSCalendar.Options(rawValue: 0))
        return nextMonth!
    }
    
    func goNext(years: Int) -> Date {
        let nextYear = (Calendar.current as NSCalendar).date(byAdding: .year,
                                                             value: years,
                                                             to: self,
                                                             options: NSCalendar.Options(rawValue: 0))
        return nextYear!
    }
    
    func goDate(component: Calendar.Component,
                value: Int) -> Date {
        return Calendar.current.date(byAdding: component,
                                     value: value,
                                     to: self)!
    }
    
    func getPreviosMonth() -> Date {
        let lastMonth = (Calendar.current as NSCalendar).date(byAdding: .month, value: -1, to: self, options: NSCalendar.Options(rawValue: 0))
        return lastMonth!
    }
    
    func getNextMonth() -> Date {
        let nextMonth = (Calendar.current as NSCalendar).date(byAdding: .month, value: 1, to: self, options: NSCalendar.Options(rawValue: 0))
        return nextMonth!
    }
    
    func getPreviosYear() -> Date {
        let lastYear = (Calendar.current as NSCalendar).date(byAdding: .year, value: -1, to: self, options: NSCalendar.Options(rawValue: 0))
        return lastYear!
    }
    
    func getNextYear() -> Date {
        let nextYear = (Calendar.current as NSCalendar).date(byAdding: .year, value: 1, to: self, options: NSCalendar.Options(rawValue: 0))
        return nextYear!
    }
    
    func getDateAfter(_ numberOfDay: Int) -> Date? {
        //let today = NSDate()
        let dayAfter = (Calendar.current as NSCalendar).date(
            byAdding: .day,
            value: numberOfDay,
            to: self, //today ,
            options: NSCalendar.Options(rawValue: 0))
        
        return dayAfter
        
    }
    
    static func numberOfDaysBetween(_ start: Date,
                                    end: Date) -> Int {
        let calendar = Calendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: start)
        let date2 = calendar.startOfDay(for: end)
        
        let flags = NSCalendar.Unit.day
        let components = (calendar as NSCalendar).components(flags,
                                                             from: date1,
                                                             to: date2,
                                                             options: [])
        
        return components.day!
    }
    
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year],
                                               from: date,
                                               to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month],
                                               from: date,
                                               to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear],
                                               from: date,
                                               to: self).weekOfYear ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day],
                                               from: date,
                                               to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour],
                                               from: date,
                                               to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute],
                                               from: date,
                                               to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second],
                                               from: date,
                                               to: self).second ?? 0
    }
    
    func dateNumber() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,
                                                  .month,
                                                  .day],
                                                 from: self)
        return Int(components.day!)
    }
    
    func monthNumber() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,
                                                  .month,
                                                  .day],
                                                 from: self)
        return Int(components.month!)
    }
    
    func yearNumber() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,
                                                  .month,
                                                  .day],
                                                 from: self)
        return Int(components.year!)
    }
    
    func daysInMonth() -> Int {
        let calendar = Calendar.current
        let range = calendar.range(of: .day,
                                   in: .month,
                                   for: self)!
        return  range.count
    }
    
    func getDateInSameMonth(number: Int) -> Date? {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year,
                                                  .month,
                                                  .day],
                                                 from: self)
        components.day = number
        return calendar.date(from: components)
    }
    
    func isWeekEnd() -> Bool {
        let weekday = Calendar.current.component(.weekday,
                                                 from: self)
        
        return (weekday == 7) || (weekday == 1) // sat or sun
    }
    
    func startOfWeek() -> Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.yearForWeekOfYear,
                                                      .weekOfYear],
                                                     from: Date())
        return calendar.date(from: dateComponents)!
    }
    
    func endOfWeek() -> Date {
        let calendar = Calendar.current
        let startOf = self.startOfWeek()
        var dummyComponents = DateComponents()
        dummyComponents.day = 6
        let endOfWeek = calendar.date(byAdding: dummyComponents, to: startOf)!
        return endOfWeek
    }
    
    func startOf(component: Calendar.Component) -> Date {
        
        let selectComponents = Date.getDateComponents(component: component)
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents(selectComponents,
                                                     from: self)
        return calendar.date(from: dateComponents)!
    }
    
    func endOf(component: Calendar.Component) -> Date {
        
        let calendar = Calendar.current
        let startOf = self.startOf(component: component)
        
        var dummyComponents = DateComponents()
        
        switch component {
        case .year:
            dummyComponents.day = -1
            dummyComponents.year = 1
        case .month:
            dummyComponents.day = -1
            dummyComponents.month = 1
        case .day:
            dummyComponents.hour = -1
            dummyComponents.day = 1
        default:
            dummyComponents.day = -1
        }
        
        let endOf = calendar.date(byAdding: dummyComponents,
                                  to: startOf)!
        
        return endOf
    }
    
    func lastMonth() -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = -1
        let date = calendar.date(byAdding: components,
                                 to: self)!
        return date.startOf(component: .month)
    }
    
    func nextMonth() -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = 1
        let date = calendar.date(byAdding: components,
                                 to: self)!
        return date.startOf(component: .month)
    }
    
    func beforeDayDatetime() -> Date? {
        var calendar = Calendar.current
        calendar.locale = Locale.current
        var components = calendar.dateComponents([.day,
                                                  .month,
                                                  .year],
                                                 from: self)
        components.hour = 0
        components.minute = 0
        components.second = 0
        components.nanosecond = 0
        return calendar.date(from: components)
    }
    
    func beforeMidnightDatetime() -> Date? {
        var calendar = Calendar.current
        calendar.locale = Locale.current
        var components = calendar.dateComponents([.day,
                                                  .month,
                                                  .year],
                                                 from: self)
        components.hour = 23
        components.minute = 59
        components.second = 59
        components.nanosecond = 999
        return calendar.date(from: components)
    }
    
    func isFirstDayOfMonth() -> Bool {
        return self.dateNumber() == 1
    }
    
    func isLastDayOfMonth() -> Bool {
        return self.dateNumber() == self.daysInMonth()
    }
    
    static func toString(from start: Date,
                         to end: Date) -> String {
        // date format
        let fullDateFormat = "dd MMM yyyy"
        let dayDateFormat = "dd"
        let dayMonthDateFormat = "dd MMM"
        
        //let localeString = "en_US".localized
        //let locale = Locale(identifier: localeString)
        let locale = Locale.current
        
        guard
            !start.isSameDate(end)
            else {
                return end.toDateString(fullDateFormat,
                                        locale: locale)
        }
        var startString = ""
        var endString = ""
        
        if start.isSameMonth(end) {
            startString = start.toDateString(dayDateFormat,
                                             locale: locale)
            endString = end.toDateString(fullDateFormat,
                                         locale: locale)
        }
        else if start.isSameYear(end) {
            startString = start.toDateString(dayMonthDateFormat,
                                             locale: locale)
            endString = end.toDateString(fullDateFormat,
                                         locale: locale)
        }
        else {
            startString = start.toDateString(fullDateFormat,
                                             locale: locale)
            endString = end.toDateString(fullDateFormat,
                                         locale: locale)
        }
        
        return "\(startString) - \(endString)"
    }
    
    static func toDatetimeString(from start: Date,                         
                                 to end: Date) -> String {
        // date format
        let fullDateFormat = "dd MMM yyyy HH:mm"
        
        let locale = Locale.current
        
        var startString = start.toDateString(fullDateFormat,
                                             locale: locale)
        var endString = end.toDateString(fullDateFormat,
                                         locale: locale)
        return "\(startString) - \(endString)"
    }
    
    private static func getDateComponents(component: Calendar.Component) -> Set<Calendar.Component> {
        let components = [Calendar.Component.year,
                          Calendar.Component.month,
                          Calendar.Component.day,
                          Calendar.Component.hour,
                          Calendar.Component.minute,
                          Calendar.Component.second]
        
        var selectComponents: Set<Calendar.Component> = []
        
        for cursorComponent in components {
            selectComponents.insert(cursorComponent)
            if cursorComponent == component { break }
        }
        
        return selectComponents
    }
}
