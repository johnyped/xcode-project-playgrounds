//
//  CountryList.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import Foundation

struct CountryList {
        
    static let shared: CountryList = .init()
    let lists: [Country]
    var count: Int { return lists.count }
    
    var thCountry: Country? {
        self.country(alpha3Ccode: "THA")
    }
    
    init() {
        guard
            let jsonData = JsonFile(path: "Datasource").data(from: "Other/CountryAndNationality")
        else {
            self.lists = []
            return
        }
        
        self.lists = (try? JSONDecoder().decode([Country].self,
                                               from: jsonData)) ?? []
    }
    
    init(array: [Country]) {
        self.lists = array
    }
    
    // output : ["🇹🇭 ประเทศไทย" , ... ]
    func thCountriesWithFlags() -> [String] {
        lists.map({ $0.thCountryNameWithFlag })
    }
    
    // output : ["🇹🇭 Thailand" , ... ]
    func enCountriesWithFlags() -> [String] {
        lists.map({ $0.thCountryNameWithFlag })
    }
    
    func country(alpha3Ccode: String) -> Country? {
        lists.first(where: { $0.alpha3Ccode == alpha3Ccode })
    }
    
    func search(q: String) -> CountryList {
        let _q = q.lowercased()
        guard
            let thaiData = _q.data(using: .utf8,
                                   allowLossyConversion: true)
        else {
            return CountryList(array: [])
        }
        
        let thaiString = String(data: thaiData,
                                encoding: .utf8) ?? _q
        
        let result: [Country] = lists.filter({
            $0.enName.lowercased().fuzzyMatch(_q) ||
            $0.enNationality.lowercased().fuzzyMatch(_q) ||
            $0.alpha3Ccode.lowercased().contains(_q) ||
            $0.thNameUTF8Encode.contains(thaiString) ||
            $0.thNationalityUTF8Encode.contains(thaiString)
        })
        
        return CountryList(array: result)
    }
    
}

extension CountryList {
    
    struct Country: Codable {
        let id: Int
        let alpha2Ccode: String
        let alpha3Ccode: String
        let thName: String
        let enName: String
        let thNationality: String
        let enNationality: String
        
        var localizeTitle: String {
//            switch Language.shared {
//            case .th:
//                return thName
//            case .en:
//                return enName
//            }
            enName
        }
        
        var localizeCountryNameWithFlag: String {
//            switch Language.shared {
//            case .th:
//                return thCountryNameWithFlag
//            case .en:
//                return enCountryNameWithFlag
//            }
            enCountryNameWithFlag
        }
                
        var thNameUTF8Encode: String {
            guard
                let thaiData = thName.lowercased().data(using: .utf8,
                                                        allowLossyConversion: true)
            else { return thName }
            
            return String(data: thaiData,
                          encoding: .utf8) ?? thName
        }
        
        var thNationalityUTF8Encode: String {
            guard
                let thaiData = thNationality.lowercased().data(using: .utf8,
                                                               allowLossyConversion: true)
            else { return thNationality }
            
            return String(data: thaiData,
                          encoding: .utf8) ?? thNationality
        }
        
        // ex. "TH" -> 🇹🇭
        var flagEmoji: String {
            let base = 127397
            var usv = String.UnicodeScalarView()
            for i in alpha2Ccode.utf16 {
                usv.append(UnicodeScalar(base + Int(i))!)
            }
            return String(usv)
        }
        
        // return "🇹🇭 ประเทศไทย"
        var thCountryNameWithFlag: String {
            "\(flagEmoji) \(thName)"
        }
        
        // return "🇹🇭 Thailand"
        var enCountryNameWithFlag: String {
            "\(flagEmoji) \(enName)"
        }
               
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.id = try container.decode(Int.self,
                                           forKey: .id)
            self.alpha2Ccode = try container.decode(String.self,
                                                    forKey: .alpha2Ccode)
            self.alpha3Ccode = try container.decode(String.self,
                                                    forKey: .alpha3Ccode)
            self.thName = (try? container.decode(String.self,
                                                forKey: .thName)) ?? ""
            self.enName = try container.decode(String.self,
                                                forKey: .enName)
            self.thNationality = (try? container.decode(String.self,
                                                forKey: .thNationality)) ?? ""
            self.enNationality = try container.decode(String.self,
                                                forKey: .enNationality)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(id,
                                 forKey: .id)
            try container.encode(alpha3Ccode,
                                 forKey: .alpha3Ccode)
            try container.encode(thName,
                                 forKey: .thName)
            try container.encode(enName,
                                 forKey: .enName)
            try container.encode(thNationality,
                                 forKey: .thNationality)
            try container.encode(enNationality,
                                 forKey: .enNationality)
        }
        
        
        enum CodingKeys: String,
                         CodingKey {
            case id = "id"
            case alpha2Ccode = "alpha_2_code"
            case alpha3Ccode = "alpha_3_code"
            case thName = "th_country_name"
            case enName = "en_country_name"
            case thNationality = "th_nationality"
            case enNationality = "en_nationality"
        }
        
    }
    
}
