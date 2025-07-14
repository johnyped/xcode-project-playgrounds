//
//  CMRate+RateCodes.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//
import Foundation

extension CMRate {
    
    struct RateCodes: Codable {
        let otaRateCode: String
        let ctripRateCode: String
        let hrsdeRateCode: String
        let odigeoRateCode: String
        let traviaRateCode: String
        let feratelRateCode: String
        let agodaRateCode: String
        let bookingcomRateCode: String
        let expediaRateCode: String
        let ostrovokruRateCode: String
        let tomastravelRateCode: String
        let hotelbedsRateCode: String
        let lateroomsRateCode: String
        let travelokaRateCode: String
        let lastminuteRateCode: String
        let hostelworldRateCode: String
        let travelocityRateCode: String
        let budgetplacesRateCode: String
        let tablethotelsRateCode: String

        init(otaRateCode: String,
             ctripRateCode: String,
             hrsdeRateCode: String,
             odigeoRateCode: String,
             traviaRateCode: String,
             feratelRateCode: String,
             agodaRateCode: String,
             bookingcomRateCode: String,
             expediaRateCode: String,
             ostrovokruRateCode: String,
             tomastravelRateCode: String,
             hotelbedsRateCode: String,
             lateroomsRateCode: String,
             travelokaRateCode: String,
             lastminuteRateCode: String,
             hostelworldRateCode: String,
             travelocityRateCode: String,
             budgetplacesRateCode: String,
             tablethotelsRateCode: String) {
            self.otaRateCode = otaRateCode
            self.ctripRateCode = ctripRateCode
            self.hrsdeRateCode = hrsdeRateCode
            self.odigeoRateCode = odigeoRateCode
            self.traviaRateCode = traviaRateCode
            self.feratelRateCode = feratelRateCode
            self.agodaRateCode = agodaRateCode
            self.bookingcomRateCode = bookingcomRateCode
            self.expediaRateCode = expediaRateCode
            self.ostrovokruRateCode = ostrovokruRateCode
            self.tomastravelRateCode = tomastravelRateCode
            self.hotelbedsRateCode = hotelbedsRateCode
            self.lateroomsRateCode = lateroomsRateCode
            self.travelokaRateCode = travelokaRateCode
            self.lastminuteRateCode = lastminuteRateCode
            self.hostelworldRateCode = hostelworldRateCode
            self.travelocityRateCode = travelocityRateCode
            self.budgetplacesRateCode = budgetplacesRateCode
            self.tablethotelsRateCode = tablethotelsRateCode
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.otaRateCode = try container.decode(String.self,
                                                    forKey: .otaRateCode)
            self.ctripRateCode = try container.decode(String.self,
                                                      forKey: .ctripRateCode)
            self.hrsdeRateCode = try container.decode(String.self,
                                                      forKey: .hrsdeRateCode)
            self.odigeoRateCode = try container.decode(String.self,
                                                       forKey: .odigeoRateCode)
            self.traviaRateCode = try container.decode(String.self,
                                                       forKey: .traviaRateCode)
            self.feratelRateCode = try container.decode(String.self,
                                                        forKey: .feratelRateCode)
            self.agodaRateCode = try container.decode(String.self,
                                                         forKey: .agodacomRateCode)
            self.bookingcomRateCode = try container.decode(String.self,
                                                           forKey: .bookingcomRateCode)
            self.expediaRateCode = try container.decode(String.self,
                                                           forKey: .expediacomRateCode)
            self.ostrovokruRateCode = try container.decode(String.self,
                                                           forKey: .ostrovokruRateCode)
            self.tomastravelRateCode = try container.decode(String.self,
                                                            forKey: .tomastravelRateCode)
            self.hotelbedsRateCode = try container.decode(String.self,
                                                             forKey: .hotelbedscomRateCode)
            self.lateroomsRateCode = try container.decode(String.self,
                                                             forKey: .lateroomscomRateCode)
            self.travelokaRateCode = try container.decode(String.self,
                                                             forKey: .travelokacomRateCode)
            self.lastminuteRateCode = try container.decode(String.self,
                                                              forKey: .lastminutecomRateCode)
            self.hostelworldRateCode = try container.decode(String.self,
                                                               forKey: .hostelworldcomRateCode)
            self.travelocityRateCode = try container.decode(String.self,
                                                               forKey: .travelocitycomRateCode)
            self.budgetplacesRateCode = try container.decode(String.self,
                                                                forKey: .budgetplacescomRateCode)
            self.tablethotelsRateCode = try container.decode(String.self,
                                                                forKey: .tablethotelscomRateCode)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(otaRateCode, forKey: .otaRateCode)
            try container.encode(ctripRateCode, forKey: .ctripRateCode)
            try container.encode(hrsdeRateCode, forKey: .hrsdeRateCode)
            try container.encode(odigeoRateCode, forKey: .odigeoRateCode)
            try container.encode(traviaRateCode, forKey: .traviaRateCode)
            try container.encode(feratelRateCode, forKey: .feratelRateCode)
            try container.encode(agodaRateCode, forKey: .agodacomRateCode)
            try container.encode(bookingcomRateCode, forKey: .bookingcomRateCode)
            try container.encode(expediaRateCode, forKey: .expediacomRateCode)
            try container.encode(ostrovokruRateCode, forKey: .ostrovokruRateCode)
            try container.encode(tomastravelRateCode, forKey: .tomastravelRateCode)
            try container.encode(hotelbedsRateCode, forKey: .hotelbedscomRateCode)
            try container.encode(lateroomsRateCode, forKey: .lateroomscomRateCode)
            try container.encode(travelokaRateCode, forKey: .travelokacomRateCode)
            try container.encode(lastminuteRateCode, forKey: .lastminutecomRateCode)
            try container.encode(hostelworldRateCode, forKey: .hostelworldcomRateCode)
            try container.encode(travelocityRateCode, forKey: .travelocitycomRateCode)
            try container.encode(budgetplacesRateCode, forKey: .budgetplacescomRateCode)
            try container.encode(tablethotelsRateCode, forKey: .tablethotelscomRateCode)
        }
        
        init() {
            self.otaRateCode = ""
            self.ctripRateCode = ""
            self.hrsdeRateCode = ""
            self.odigeoRateCode = ""
            self.traviaRateCode = ""
            self.feratelRateCode = ""
            self.agodaRateCode = ""
            self.bookingcomRateCode = ""
            self.expediaRateCode = ""
            self.ostrovokruRateCode = ""
            self.tomastravelRateCode = ""
            self.hotelbedsRateCode = ""
            self.lateroomsRateCode = ""
            self.travelokaRateCode = ""
            self.lastminuteRateCode = ""
            self.hostelworldRateCode = ""
            self.travelocityRateCode = ""
            self.budgetplacesRateCode = ""
            self.tablethotelsRateCode = ""
        }
        
        enum CodingKeys: String, CodingKey {
            case otaRateCode = "otaRateCode"
            case ctripRateCode = "ctripRateCode"
            case hrsdeRateCode = "hrsdeRateCode"
            case odigeoRateCode = "odigeoRateCode"
            case traviaRateCode = "traviaRateCode"
            case feratelRateCode = "feratelRateCode"
            case agodacomRateCode = "agodacomRateCode"
            case bookingcomRateCode = "bookingcomRateCode"
            case expediacomRateCode = "expediacomRateCode"
            case ostrovokruRateCode = "ostrovokruRateCode"
            case tomastravelRateCode = "tomastravelRateCode"
            case hotelbedscomRateCode = "hotelbedscomRateCode"
            case lateroomscomRateCode = "lateroomscomRateCode"
            case travelokacomRateCode = "travelokacomRateCode"
            case lastminutecomRateCode = "lastminutecomRateCode"
            case hostelworldcomRateCode = "hostelworldcomRateCode"
            case travelocitycomRateCode = "travelocitycomRateCode"
            case budgetplacescomRateCode = "budgetplacescomRateCode"
            case tablethotelscomRateCode = "tablethotelscomRateCode"
        }
        enum Key: String {
            case ota = "otaRateCode"
            case ctrip = "ctripRateCode"
            case hrsde = "hrsdeRateCode"
            case odigeo = "odigeoRateCode"
            case travia = "traviaRateCode"
            case feratel = "feratelRateCode"
            case agodacom = "agodacomRateCode"
            case bookingcom = "bookingcomRateCode"
            case expediacom = "expediacomRateCode"
            case ostrovokru = "ostrovokruRateCode"
            case tomastravel = "tomastravelRateCode"
            case hotelbedscom = "hotelbedscomRateCode"
            case lateroomscom = "lateroomscomRateCode"
            case travelokacom = "travelokacomRateCode"
            case lastminutecom = "lastminutecomRateCode"
            case hostelworldcom = "hostelworldcomRateCode"
            case travelocitycom = "travelocitycomRateCode"
            case budgetplacescom = "budgetplacescomRateCode"
            case tablethotelscom = "tablethotelscomRateCode"
        }
        
            
    }
}

extension CMRate.RateCodes: Equatable {
    
    static func == (lhs: CMRate.RateCodes, rhs: CMRate.RateCodes) -> Bool {
        return lhs.otaRateCode == rhs.otaRateCode &&
            lhs.ctripRateCode == rhs.ctripRateCode &&
            lhs.hrsdeRateCode == rhs.hrsdeRateCode &&
            lhs.odigeoRateCode == rhs.odigeoRateCode &&
            lhs.traviaRateCode == rhs.traviaRateCode &&
            lhs.feratelRateCode == rhs.feratelRateCode &&
            lhs.agodaRateCode == rhs.agodaRateCode &&
            lhs.bookingcomRateCode == rhs.bookingcomRateCode &&
            lhs.expediaRateCode == rhs.expediaRateCode &&
            lhs.ostrovokruRateCode == rhs.ostrovokruRateCode &&
            lhs.tomastravelRateCode == rhs.tomastravelRateCode &&
            lhs.hotelbedsRateCode == rhs.hotelbedsRateCode &&
            lhs.lateroomsRateCode == rhs.lateroomsRateCode &&
            lhs.travelokaRateCode == rhs.travelokaRateCode &&
            lhs.lastminuteRateCode == rhs.lastminuteRateCode &&
            lhs.hostelworldRateCode == rhs.hostelworldRateCode &&
            lhs.travelocityRateCode == rhs.travelocityRateCode &&
            lhs.budgetplacesRateCode == rhs.budgetplacesRateCode &&
            lhs.tablethotelsRateCode == rhs.tablethotelsRateCode
    }
    
}
