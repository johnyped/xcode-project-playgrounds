//
//  Beds24Feature.swift
//  YourProject
//
//  Created by IntrodexMini on 9/5/2568 BE.
//


struct ChannelManagerFeature: Codable {
    let enabled: Bool
    let otas: [Ota]
    let otaRateCodes: [String: RateCodeList]
    
    enum CodingKeys: String, CodingKey {
        case enabled
        case otas = "otas"
        case otaRateCodes = "ota_rate_codes"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        enabled = try container.decode(Bool.self, forKey: .enabled)
        
        // Handle otas which might be missing in some responses
        if container.contains(.otas) {
            otas = try container.decode([Ota].self, forKey: .otas)
        } else {
            otas = []
        }
        
        // Handle otaRateCodes which is a dictionary with dynamic keys
        if container.contains(.otaRateCodes) {
            let rateCodesContainer = try container.nestedContainer(keyedBy: DynamicCodingKeys.self, forKey: .otaRateCodes)
            var tempRateCodes = [String: RateCodeList]()
            
            for key in rateCodesContainer.allKeys {
                if let value = try? rateCodesContainer.decode([RateCode].self, forKey: key) {
                    tempRateCodes[key.stringValue] = RateCodeList(rateCodes: value)
                }
            }
            otaRateCodes = tempRateCodes
        } else {
            otaRateCodes = [:]
        }
    }

    init(enabled: Bool,
     otas: [Ota],
      otaRateCodes: [String: RateCodeList]) {
        self.enabled = enabled
        self.otas = otas
        self.otaRateCodes = otaRateCodes
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(enabled, forKey: .enabled)
        try container.encode(otas, forKey: .otas)
        
        var rateCodesContainer = container.nestedContainer(keyedBy: DynamicCodingKeys.self, forKey: .otaRateCodes)
        for (key, value) in otaRateCodes {
            try rateCodesContainer.encode(value.rateCodes, forKey: DynamicCodingKeys(stringValue: key)!)
        }
    }
    
    // Helper struct for dynamic keys
    struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }
        
        init?(intValue: Int) {
            self.stringValue = "\(intValue)"
            self.intValue = intValue
        }
    }
}

// Helper struct to wrap the array of rate codes
struct RateCodeList: Codable {
    let rateCodes: [RateCode]
    
    init(rateCodes: [RateCode]) {
        self.rateCodes = rateCodes
    }
}

// Rate code model
struct RateCode: Codable {
    let code: String
    let name: String
}

struct Ota: Codable {
    let otaName: String
    let beds24Id: String?
    let enabledSyncAllotment: Bool
    let enabledSyncRate: Bool
    
    enum CodingKeys: String, CodingKey {
        case otaName = "ota_name"
        case beds24Id = "beds24_id"
        case enabledSyncAllotment = "enabled_sync_allotment"
        case enabledSyncRate = "enabled_sync_rate"
    }
}

/*
 {
     "enabled": true,
     "otas": [
         {
             "ota_name": "booking.com",
             "beds24_id": null,
             "enabled_sync_allotment": false,
             "enabled_sync_rate": false
         },
         {
             "ota_name": "agoda",
             "beds24_id": null,
             "enabled_sync_allotment": false,
             "enabled_sync_rate": false
         },
         {
             "ota_name": "airbnb",
             "beds24_id": null,
             "enabled_sync_allotment": false,
             "enabled_sync_rate": false
         }
     ],
     "ota_rate_codes": {
         "ctripRateCode": [
             {
                 "code": "C20774025",
                 "name": "CTrip"
             },
             {
                 "code": "9705762",
                 "name": "Standard"
             }
         ],
         "traviaRateCode": [
             {
                 "code": "2T0774025",
                 "name": "Travia"
             },
             {
                 "code": "9705762",
                 "name": "Standard"
             }
         ],
         "agodacomRateCode": [
             {
                 "code": "A20774025",
                 "name": "Agoda"
             },
             {
                 "code": "9705762",
                 "name": "Standard"
             }
         ],
         "bookingcomRateCode": [
             {
                 "code": "20774025",
                 "name": "None Refund"
             },
             {
                 "code": "9705762",
                 "name": "Standard"
             }
         ],
         "expediacomRateCode": [
             {
                 "code": "E20774025",
                 "name": "Expedia"
             },
             {
                 "code": "9705762",
                 "name": "Standard"
             }
         ],
         "travelokacomRateCode": [
             {
                 "code": "T20774025",
                 "name": "Traveloka"
             },
             {
                 "code": "9705762",
                 "name": "Standard"
             }
         ]
     }
 }
 */
