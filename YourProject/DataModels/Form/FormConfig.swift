//
//  FormConfig.swift
//  HomemadeStay
//
//  Created by IntrodexMac on 7/9/2566 BE.
//  Copyright © 2566 BE Fire One One Co., Ltd. All rights reserved.
//

import Foundation

typealias InputTextRange = (min: Int, max: Int)
typealias InputDateRange = (minDate: Date, maxDate: Date)

struct FormConfig {
    
    struct DateFormat {
        // 2020-01-13T09:18:23.976+07:00
        static let datetimeISO = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZZZZZ"
        static let yyyyMMdd = "yyyy-MM-dd"
        static let yyyyMM = "yyyy-MM"
        static let yyyy = "yyyy"
        static let yyyyMMddHHmm = "yyyy-MM-dd HH:mm"
        static let EddMMMyyyy = "E dd MMM yyyy"
        static let ddMMMyyyy = "dd MMM yyyy"
    }
    
    struct TextRange {
        static let passport: InputTextRange = (0,20)
        static let citizenID: InputTextRange = (0,13)
        static let name: InputTextRange = (0,200)
        static let email: InputTextRange = (0,150)
        static let phone: InputTextRange = (0,13)
        static let memo: InputTextRange = (0,500)
        static let address: InputTextRange = (0,400)
        static let password: InputTextRange = (0,30)
        static let rateCode: InputTextRange = (0,5)
        
        static let companyBranchName: InputTextRange = (0,100)
        static let companyBranchCode: InputTextRange = (0,7)
        static let taxID: InputTextRange = (0,13)
    }
    
    struct CharWhiteList {
        static let numberForTextfield: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0",""]
        static let phoneForTextfield: String = "0123456789."
    }
    
    struct DateRange {
//        static var birthDate: InputDateRange {
//            let today = Date()
//            let minDate = today.goBack(years: 100)
//            let maxDate = today.getYesterdayDate()!
//            return (minDate, maxDate)
//        }
    }
    
    
}
