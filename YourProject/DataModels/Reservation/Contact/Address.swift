//
//  Address.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//


import Foundation

struct Address { //: Codable {
    
    let houseNumber: String
    let district: String
    let province: String
    let countryCode: String
    let zipCode: String
    
    var fullDescription: String {
        var text = ""
        if houseNumber.isEmpty == false { text += houseNumber }
        if district.isEmpty == false {
            if text.isEmpty == false {
                text += ", "
            }
            text += district
        }
        if province.isEmpty == false {
            if text.isEmpty == false {
                text += ", "
            }
            text += province
        }
        if zipCode.isEmpty == false {
            if text.isEmpty == false {
                text += ", "
            }
            text += zipCode
        }
        
        return text
    }
    
    var fullDescriptionForDocument: String {
        var text = ""
        if district.isEmpty == false {
            if text.isEmpty == false {
                text += " "
            }
            text += district
        }
        if province.isEmpty == false {
            if text.isEmpty == false {
                text += " "
            }
            text += province
        }
        if zipCode.isEmpty == false {
            if text.isEmpty == false {
                text += " "
            }
            text += zipCode
        }
        
        return text
    }
    
    var country: String {
        guard
            countryCode.count > 0
        else { return "" }
        
        return Nationality(alpha3Code: countryCode).countryName
    }
    
    var countryNameWithFlag: String {
        guard
            countryCode.count > 0
        else { return "" }
        
        return Nationality(alpha3Code: countryCode).countryNameWithFlag
    }
    
    init(nationality: Nationality) {
        houseNumber = ""
        district = ""
        province = ""
        zipCode = ""
        countryCode = nationality.countryCode
    }
    
    // init all with string
    init(houseNumber: String = "",
         district: String = "",
         province: String = "",
         zipCode: String = "",
         nationality: Nationality = Nationality.thai) {
        self.houseNumber = houseNumber
        self.district = district
        self.province = province
        self.zipCode = zipCode
        self.countryCode = nationality.countryCode
    }
    
    init(houseNumber: String,
         district: String,
         province: String,
         zipCode: String,
         countryCode: String) {
        self.houseNumber = houseNumber
        self.district = district
        self.province = province
        self.zipCode = zipCode
        self.countryCode = countryCode
    }
}
