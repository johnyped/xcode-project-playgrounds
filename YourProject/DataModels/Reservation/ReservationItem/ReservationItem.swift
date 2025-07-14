//
//  ReservationItem.swift
//  YourProject
//
//  Created by IntrodexMini on 12/5/2568 BE.
//

import Foundation

struct ReservationItem: Codable {
    let id: Int
    let reservedDate: Date
    let totalPrice: Double
    
    let reservableType: ReservableType
    let reservableId: Int
    
    let data: Data
    let priceCardId: Int?
    
    let createdAt: Date
    let updatedAt: Date
    
    // can be baseRate , customRate , priceCardRate from use selected
    var selectedRate: Double {
        data.selectedRate
    }
    
    var extraAdultTotal: Double {
        data.extraAdultTotal
    }

    var extraChildTotal: Double {
        data.extraChildTotal
    }
    
    var extraAdultMealTotal: Double {
        data.extraAdultMealTotal
    }
    
    var extraChildMealTotal: Double {
        data.extraChildMealTotal
    }

    init(id: Int,
         reservedDate: Date,
         totalPrice: Double,
         reservableType: ReservableType,
         reservableId: Int,
         data: Data,
         priceCardId: Int?,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.reservedDate = reservedDate
        self.totalPrice = totalPrice
        self.reservableType = reservableType
        self.reservableId = reservableId
        self.data = data
        self.priceCardId = priceCardId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        reservedDate = try container.decode(String.self, forKey: .reservedDate).tryToDate(dateFormat: FormConfig.DateFormat.yyyyMMdd)
        totalPrice = try container.decode(String.self, forKey: .totalPrice).tryToDouble()
        reservableType = try container.decode(ReservableType.self, forKey: .reservableType)
        data = try container.decode(Data.self, forKey: .data)
        reservableId = try container.decode(Int.self, forKey: .reservableId)
        priceCardId = try container.decodeIfPresent(Int.self, forKey: .priceCardId)
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(reservedDate.toDateString(FormConfig.DateFormat.yyyyMMdd), forKey: .reservedDate)
        try container.encode(totalPrice, forKey: .totalPrice)
        try container.encode(reservableType, forKey: .reservableType)
        try container.encode(data, forKey: .data)
        try container.encode(reservableId, forKey: .reservableId)
        try container.encodeIfPresent(priceCardId, forKey: .priceCardId)
        try container.encode(createdAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .updatedAt)
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case reservedDate = "reserved_date"
        case totalPrice = "total_price"
        case reservableType = "reservable_type"
        case data
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case reservableId = "reservable_id"
        case priceCardId = "price_card_id"
    }
    
}

extension ReservationItem {
    
    enum FilterBy {
        case id(id: Int)
        case reservableId(id: Int)
        case reservableType(type: ReservationItem.ReservableType)
        case date(date: Date)
        case beforeDate(date: Date)
        case afterDate(date: Date)
    }
    
    enum SortBy {
        case id
        case reservableDate
        case createdAt
        case updatedAt
    }
    
    enum ReservableType: String, Codable {
        case room = "ROOM"
    }
    
    struct Data: Codable {
        let isCustomRate: Bool
        let selectedRate: Double
        let extraAdultRate: Double
        let extraAdultQty: Int
        let extraChildRate: Double
        let extraChildQty: Int
        
        let mealIncluded: Bool
        let adultMealLimit: Int
        let adultMealRate: Double
        let childMealLimit: Int
        let childMealRate: Double
        
        let extraAdultMealRate: Double
        let extraAdultMealQty: Int
        let extraChildMealRate: Double
        let extraChildMealQty: Int
            
        var totalMealAdultCount: Int {
            if mealIncluded {
                return adultMealLimit + extraAdultMealQty
            }
            return 0
        }
        
        var totalMealChildCount: Int {
            if mealIncluded {
                return childMealLimit + extraChildMealQty
            }
            return 0
        }
        
        // extra guest
        var extraAdultTotal: Double {
            extraAdultRate * Double(extraAdultQty)
        }
        
        var extraChildTotal: Double {
            extraChildRate * Double(extraChildQty)
        }
        
        var extraGuestTotal: Double {
            extraAdultTotal + extraChildTotal
        }
        
        // extra meal
        var extraGuestlMealCount: Int {
            if mealIncluded {
                return extraAdultMealQty + extraChildMealQty
            }
            return 0
        }
        
        var extraAdultMealTotal: Double {
            if mealIncluded {
                return extraAdultMealRate * Double(extraAdultMealQty)
            }
            return 0
        }
        
        var extraChildMealTotal: Double {
            if mealIncluded {
                return extraChildMealRate * Double(extraChildMealQty)
            }
            return 0
        }
        
        var extraGuestMealTotal: Double {
            extraAdultMealTotal + extraChildMealTotal
        }
        
        var grandTotal: Double {
            selectedRate + extraGuestTotal + extraGuestMealTotal
        }
        
        init(isCustomRate: Bool,
             selectedRate: Double,
             extraAdultRate: Double,
             extraAdultQty: Int,
             extraChildRate: Double,
             extraChildQty: Int,
             mealIncluded: Bool,
             adultMealLimit: Int,
             adultMealRate: Double,
             childMealLimit: Int,
             childMealRate: Double,
             extraAdultMealRate: Double,
             extraAdultMealQty: Int,
             extraChildMealRate: Double,
             extraChildMealQty: Int) {
            self.isCustomRate = isCustomRate
            self.selectedRate = selectedRate
            self.extraAdultRate = extraAdultRate
            self.extraAdultQty = extraAdultQty
            self.extraChildRate = extraChildRate
            self.extraChildQty = extraChildQty
            self.mealIncluded = mealIncluded
            self.adultMealLimit = adultMealLimit
            self.adultMealRate = adultMealRate
            self.childMealLimit = childMealLimit
            self.childMealRate = childMealRate
            self.extraAdultMealRate = extraAdultMealRate
            self.extraAdultMealQty = extraAdultMealQty
            self.extraChildMealRate = extraChildMealRate
            self.extraChildMealQty = extraChildMealQty
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            isCustomRate = try container.decode(Bool.self, forKey: .isCustomRate)
            selectedRate = try container.decode(String.self, forKey: .selectedRate).tryToDouble()
            extraAdultRate = (try? container.decode(String.self, forKey: .extraAdultRate).tryToDouble()) ?? 0
            extraAdultQty = (try? container.decode(String.self, forKey: .extraAdultQty).trytoInt()) ?? 0
            extraChildRate = (try? container.decode(String.self, forKey: .extraChildRate).tryToDouble()) ?? 0
            extraChildQty = (try? container.decode(String.self, forKey: .extraChildQty).trytoInt()) ?? 0
            mealIncluded = (try? container.decode(Bool.self, forKey: .mealIncluded)) ?? false
            adultMealLimit = (try? container.decode(String.self, forKey: .adultMealLimit).trytoInt()) ?? 0
            adultMealRate = (try? container.decode(String.self, forKey: .adultMealRate).tryToDouble()) ?? 0
            childMealLimit = (try? container.decode(String.self, forKey: .childMealLimit).trytoInt()) ?? 0
            childMealRate = (try? container.decode(String.self, forKey: .childMealRate).tryToDouble()) ?? 0
            extraAdultMealRate = (try? container.decode(String.self, forKey: .extraAdultMealRate).tryToDouble()) ?? 0
            extraAdultMealQty = (try? container.decode(String.self, forKey: .extraAdultMealQty).trytoInt()) ?? 0
            extraChildMealRate = (try? container.decode(String.self, forKey: .extraChildMealRate).tryToDouble()) ?? 0
            extraChildMealQty = (try? container.decode(String.self, forKey: .extraChildMealQty).trytoInt()) ?? 0
        }
        
        // encode
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(isCustomRate, forKey: .isCustomRate)
            try container.encode(String(selectedRate), forKey: .selectedRate)
            try container.encode(String(extraAdultRate), forKey: .extraAdultRate)
            try container.encode(String(extraAdultQty), forKey: .extraAdultQty)
            try container.encode(String(extraChildRate), forKey: .extraChildRate)
            try container.encode(String(extraChildQty), forKey: .extraChildQty)
            try container.encode(mealIncluded, forKey: .mealIncluded)
            try container.encode(String(adultMealLimit), forKey: .adultMealLimit)
            try container.encode(String(adultMealRate), forKey: .adultMealRate)
            try container.encode(String(childMealLimit), forKey: .childMealLimit)
            try container.encode(String(childMealRate), forKey: .childMealRate)
            try container.encode(String(extraAdultMealRate), forKey: .extraAdultMealRate)
            try container.encode(String(extraAdultMealQty), forKey: .extraAdultMealQty)
            try container.encode(String(extraChildMealRate), forKey: .extraChildMealRate)
            try container.encode(String(extraChildMealQty), forKey: .extraChildMealQty)
        }
                
        enum CodingKeys: String, CodingKey {
            case date
            case isCustomRate = "is_custom_rate"
            case selectedRate = "price_card_rate"
            case extraAdultRate = "extra_bed_rate"
            case extraAdultQty = "extra_bed_number"
            case extraChildRate = "extra_person_rate"
            case extraChildQty = "extra_person_number"
            case mealIncluded = "meal_included"
            case adultMealLimit = "adult_meal_limit"
            case adultMealRate = "adult_meal_rate"
            case childMealLimit = "child_meal_limit"
            case childMealRate = "child_meal_rate"
            case extraAdultMealRate = "extra_adult_meal_rate"
            case extraAdultMealQty = "extra_adult_meal_number"
            case extraChildMealRate = "extra_child_meal_rate"
            case extraChildMealQty = "extra_child_meal_number"
        }
        
    }
}


/*
new response rev2
 {
     "id": 4119,
     "reserved_date": "2024-05-23",
     "total_price": "1390.77",
     "reservable_type": "ROOM",
     "data": {
         "child_meal_limit": 0,
         "adult_meal_limit": 0,
         "extra_person_rate": "999.0",
         "child_meal_rate": "0.0",
         "extra_child_meal_number": 0,
         "extra_adult_meal_number": 0,
         "extra_bed_rate": "888.0",
         "extra_adult_meal_rate": "0.0",
         "extra_bed_number": 0,
         "is_custom_rate": true,
         "extra_person_number": 0,
         "extra_child_meal_rate": "0.0",
         "meal_included": false,
         "adult_meal_rate": "0.0",
         "price_card_rate": "1390.77"
     },
     "created_at": "2024-06-01T08:19:07.185+07:00",
     "updated_at": "2024-06-01T08:19:07.185+07:00",
     "reservable_id": 623,
     "price_card_id": null
 }
 */
