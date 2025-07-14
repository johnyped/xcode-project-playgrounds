//
//  StringExtension.swift
//  HomeMadeStay
//
//  Created by Introdex on 7/14/2559 BE.
//  Copyright © 2559 Fire One One Co.,Ltd. All rights reserved.
//

import Foundation


extension String {
    
    enum StringError: Error {
        case errorOnConvertion
    }
    
    func toDate(_ byDateFormat: String,
                locale: Locale? = nil) -> Date? {
        // convert to NSDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = byDateFormat
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = locale ?? Locale(identifier: "en")
        return dateFormatter.date(from: self)
    }    
    
    func tryToDate(_ byDateFormat: String,
                   locale: Locale? = nil) throws -> Date {
        // convert to NSDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = byDateFormat
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = locale ?? Locale(identifier: "en")
        
        guard 
            let date =  dateFormatter.date(from: self)
        else { throw StringError.errorOnConvertion }
        
        return date
    }
    
    static func nilSafe(_ text: String?) -> String {
        guard let string = text else { return "." }
        guard string.isEmpty == false else { return "." }
        return string
    }
    
    // Split contact name into firstname and last name
    func splitFullName() -> (firstName: String , lastName: String) {
        
        let splitLists = self.components(separatedBy: " ")
        
        var firstName   = ""
        var lastName    = ""
        for index in 0..<splitLists.count {
            switch index {
            case 0:
                firstName   = splitLists[0]
                
            default:
                if splitLists[index] != "" {
                    lastName += splitLists[index]
                }
            }
        }
        return (firstName , lastName)
    }
    
    // replace "+" with ""
    func replace(_ target: String,
                 withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }

    func nonBlank() -> String {
        if self == "" {
            return "Not found".localized
        }else {
            return self
        }
    }
    
    func firstAlphabet() -> String {
        let matches = self.matches(for: "[A-Za-z]|[ก-ฮ]")
        guard matches.isEmpty == false else {
            if let firstChar = self.first {
                return String(describing: firstChar).uppercased()
            }
            return "?"
        }
        return matches.first!.uppercased()
    }
    
    func matches(for regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
        
    func subString(limit: Int) -> String {
        if limit > self.count {
            return self
        }
        
        let start = self.startIndex
        let end = self.index(start,
                            offsetBy: limit)
        return String(self[start..<end])
    }
}


extension String {
    
    var localized: String {
        return NSLocalizedString(self,
                                 tableName: nil,
                                 bundle: Bundle.main,
                                 value: "",
                                 comment: "")
    }
  
}

extension String {
    
    func tryToBool() throws -> Bool {
        guard 
            let bool = self.toBool()
        else { throw StringError.errorOnConvertion }
        
        return bool
    }
    
    func toBool() -> Bool? {
        switch self.lowercased() {
        case "true", "yes", "1":
            return true
        case "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    func toBoolValue() -> Bool {
        return self.toBool() ?? false
    }

}


extension String {
    // convert string "0.0000" to double type
    var toDouble: Double? {
        let text = self.replace(",",
                               withString: "")
        return Double(text)
    }
    
    var toInt: Int? {
        return Int(self)
    }
    
    // convert string with date format "2019-01-29" to date type
    func toDate(dateFormat: String,
                locale: Locale? = nil) -> Date? {
        return self.toDate(dateFormat,
                           locale: locale)
    }
    
    func trytoInt() throws -> Int {
        guard let double = self.toInt else {
            throw NSError(domain: "Cannot convert string to Int",
                          code: 0,
                          userInfo: nil)
        }
        
        return double
    }
    
    func tryToDate(dateFormat: String,
                locale: Locale? = nil) throws -> Date {
        guard let date = self.toDate(dateFormat: dateFormat,
                                     locale: locale) else {
            throw NSError(domain: "Cannot convert string to date",
                            code: 0,
                            userInfo: nil)
        }
        
        return date
    }
        
    func tryToDouble() throws -> Double {
        guard let double = self.toDouble else {
            throw NSError(domain: "Cannot convert string to double",
                          code: 0,
                          userInfo: nil)
        }
        
        return double
    }
   
  
}
