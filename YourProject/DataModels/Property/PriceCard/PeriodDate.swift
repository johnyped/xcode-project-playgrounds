//
//  PeriodDate.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//
import Foundation

struct PeriodDate: Codable {
    
    var start: Date
    var end: Date
    
    var numberOfNight: Int {
        start.numberOfDaysUntilDateTime(end)
    }
    
    var description: String {
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
    
    init(start: Date,
         end: Date) {
        self.start = start
        self.end = end
    }
}

extension PeriodDate: Equatable {
    static func == (lhs: PeriodDate,
                    rhs: PeriodDate) -> Bool {
        return lhs.start == rhs.start &&
        lhs.end == rhs.end
    }
}
