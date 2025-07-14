//
//  Nationality.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//


import Foundation

struct Nationality {
    
    static let thai: Nationality = Nationality(alpha3Code: "THA")
    
    let nationalityCode: String // alpha-3 code ex."THA"
    let countryCode: String // alpha-3 code ex."THA"
    
    var isForeigner: Bool {
        countryCode != "THA"
    }
    
    init(alpha3Code: String = "THA") {
        self.nationalityCode = alpha3Code
        self.countryCode = alpha3Code
    }
    
    init(nationalityCode: String = "THA",
         countryCode: String = "THA") {
        self.nationalityCode = nationalityCode
        self.countryCode = countryCode
    }
    
    var nationality: String {
        let defaultValue = "Thai" // Thai is default value
        
//        switch Language.shared {
//        case .en:
//            return CountryList.shared.country(alpha3Ccode: nationalityCode)?.enNationality ?? defaultValue.localized
//        case .th:
//            return CountryList.shared.country(alpha3Ccode: nationalityCode)?.thNationality ?? defaultValue.localized
//        }
        return CountryList.shared.country(alpha3Ccode: nationalityCode)?.enNationality ?? defaultValue.localized
    }
    
    var countryNameWithFlag: String {
        let defaultValue = "🇹🇭 \("Thailand".localized)" // Thailand is default value
        
//        switch Language.shared {
//        case .en:
//            return CountryList.shared.country(alpha3Ccode: nationalityCode)?.enCountryNameWithFlag ?? defaultValue.localized
//        case .th:
//            return CountryList.shared.country(alpha3Ccode: nationalityCode)?.thCountryNameWithFlag ?? defaultValue.localized
//        }
      
        return CountryList.shared.country(alpha3Ccode: nationalityCode)?.enCountryNameWithFlag ?? defaultValue.localized
    }
    
    var countryFlag: String {
        let defaultValue = "🇹🇭"
        
        return CountryList.shared.country(alpha3Ccode: nationalityCode)?.flagEmoji ?? defaultValue
    }
    
    var countryName: String {
        let defaultValue = "Thailand".localized
        
//        switch Language.shared {
//        case .en:
//            return CountryList.shared.country(alpha3Ccode: nationalityCode)?.enName ?? defaultValue.localized
//        case .th:
//            return CountryList.shared.country(alpha3Ccode: nationalityCode)?.thName ?? defaultValue.localized
//        }
        
        return CountryList.shared.country(alpha3Ccode: nationalityCode)?.enName ?? defaultValue.localized
    }
    
}
