//
//  LocalPriceCard.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//

import Foundation

struct LocalPriceCard: Codable {
    
    let id: Int
    let title: String
    let description: String
    let dailyPrice: Double
    let totalPrice: Double // price include meal
    let periodTypes: Self.WeekDays
    let exceptionDates: [Date]
    let reservableTypeId: Int
    let reservableType: Self.ReservableKind
    let code: String?
    let color: String?
    let meal: Meal
    let period: PeriodDate?
    let availableChannels: [AvailabelChannel]
    let createdAt: Date
    let updatedAt: Date
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try (container.decodeIfPresent(Int.self, forKey: .id) ?? 0)
        self.title = try (container.decodeIfPresent(String.self, forKey: .title) ?? "")
        self.description = try (container.decodeIfPresent(String.self, forKey: .description) ?? "")
        self.totalPrice = try (container.decodeIfPresent(String.self, forKey: .totalPrice)?.toDouble ?? 0)
        self.dailyPrice = try (container.decodeIfPresent(Double.self, forKey: .price) ?? 0)
        
        let _days = try (container.decodeIfPresent([String].self, forKey: .periodTypes) ?? [])
        self.periodTypes = .init(days: _days)
        
        let _exceptionDates = try (container.decodeIfPresent([String].self, forKey: .exceptionDates) ?? [])
        self.exceptionDates = try _exceptionDates.map({ try $0.tryToDate(dateFormat: FormConfig.DateFormat.yyyyMMdd) })
        
        self.reservableTypeId = try container.decode(Int.self, forKey: .reservableTypeId)
        self.reservableType = try container.decode(Self.ReservableKind.self, forKey: .reservableType)
        self.code = try? container.decode(String.self, forKey: .code)
        self.color = try? container.decode(String.self, forKey: .color)
        
        self.meal = (try? container.decode(Meal.self, forKey: .meal)) ?? .init()
        
        if let _startAt = (try? container.decodeIfPresent(String.self, forKey: .startAt))?.toDate(dateFormat: FormConfig.DateFormat.datetimeISO),
           let _endAt = (try? (container.decodeIfPresent(String.self, forKey: .endAt) ?? ""))?.toDate(dateFormat: FormConfig.DateFormat.datetimeISO) {
            self.period = .init(start: _startAt,
                                end: _endAt)
        }
        else {
            self.period = nil
        }
        
        self.availableChannels = try container.decodeIfPresent([AvailabelChannel].self, forKey: .channels) ?? []
        
        self.createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(FormConfig.DateFormat.datetimeISO)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(FormConfig.DateFormat.datetimeISO)
    }
    
    init(id: Int,
         title: String,
         description: String,
         dailyPrice: Double,
         totalPrice: Double,
         periodTypes: WeekDays,
         exceptionDates: [Date],
         reservableTypeId: Int,
         reservableType: ReservableKind,
         code: String?,
         color: String?,
         meal: Meal,
         period: PeriodDate?,
         availableChannels: [AvailabelChannel],
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.title = title
        self.description = description
        self.dailyPrice = dailyPrice
        self.totalPrice = totalPrice
        self.periodTypes = periodTypes
        self.exceptionDates = exceptionDates
        self.reservableTypeId = reservableTypeId
        self.reservableType = reservableType
        self.code = code
        self.color = color
        self.meal = meal
        self.period = period
        self.availableChannels = availableChannels
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(dailyPrice, forKey: .price)
        try container.encode(totalPrice, forKey: .totalPrice)
        try container.encode(periodTypes.toRawString(), forKey: .periodTypes)
        try container.encode(exceptionDates, forKey: .exceptionDates)
        try container.encode(reservableTypeId, forKey: .reservableTypeId)
        try container.encode(reservableType, forKey: .reservableType)
        try container.encode(code, forKey: .code)
        try container.encode(color, forKey: .color)
        try container.encode(availableChannels, forKey: .channels)
        try container.encode(meal, forKey: .meal)
        try container.encode(period?.start, forKey: .startAt)
        try container.encode(period?.end, forKey: .endAt)
        try container.encode(createdAt.toDateString(FormConfig.DateFormat.datetimeISO),
                             forKey: .createdAt)
        try container.encode(updatedAt.toDateString(FormConfig.DateFormat.datetimeISO),
                             forKey: .updatedAt)
    }
    
    // defualt period is today
    func isAvailable(onDate: Date) -> Bool {
        let isOnPeriod = isAvailableOnPeriod(date: onDate)
        let isOnPeriodTypeDay = isOnAvailableOnPeriodTypes(date: onDate)
        
        return isOnPeriod && isOnPeriodTypeDay
    }
    
    func isAvailableOnPeriod(date: Date) -> Bool {
        // convert onDate to 00:00:00 UTC
        //ex. input 2020-01-13T09:18:23.976+07:00
        let dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZZZZZ"
        
        // convert date UTC
        let date = "\(date.toDateString("yyyy-MM-dd"))T00:00:00.000+00:00".toDate(dateFormat) ?? date
        
        // no period on setting
        guard let period else { return true }
        
        let startAt = period.start
        let endAt = period.end
        
        let isOnPeriod = (date >= startAt) && (date <= endAt)
        return isOnPeriod
    }
    
    func isOnAvailableOnPeriodTypes(date: Date) -> Bool {
        // ignore if days is equal 0
        if periodTypes.days.count == 0 { return true }
        
        return periodTypes.isIncluded(date: date)
    }
    
    func isExpried(date: Date = .init()) -> Bool {
        guard
            let end = period?.end
        else { return false }
        
        let diff = date.days(from: end)
        return diff > 0
    }
    
    func status(date: Date = .init()) -> Status {
        if isExpried(date: date) { return .expired }
        
        return .active
    }
    
}

extension LocalPriceCard: Hashable {
    static func == (lhs: LocalPriceCard,
                    rhs: LocalPriceCard) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension LocalPriceCard {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case price
        case totalPrice = "total_price"
        case periodTypes = "period_types"
        case exceptionDates = "exception_dates"
        case reservableTypeId = "reservable_type_id"
        case reservableType = "reservable_type_type"
        case code
        case color
        case channels
        case meal = "bf"
        case startAt = "start_at"
        case endAt = "end_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

extension LocalPriceCard {
    
    enum Status {
        case active
        case expired
    }
    
    struct WeekDays {
        
        let days: Set<Day>
        
        var rawDays: [String] {
            days.map({ $0.rawValue })
        }
        
        init() {
            self.days = []
        }
        
        init(days: Set<Day>) {
            self.days = days
        }
        
        init(days: [Day]) {
            self.days = Set(days)
        }
        
        init(days: [String]) {
            self.days = Set(days.compactMap { Day(rawValue: $0) })
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let days = try container.decode([String].self)
            self.init(days: days)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(days.map { $0.rawValue })
        }
        
        func toRawString() -> [String] {
            days.map({ $0.rawValue })
        }
        
        func contains(day: Day) -> Bool {
            return days.contains(day)
        }
        
        func contains(day: Date) -> Bool {
            guard let day = Day(dayFromCalendar: day) else {
                return false
            }
            return days.contains(day)
        }
        
        func contains(days: [Day]) -> Bool {
            return days.allSatisfy { self.days.contains($0) }
        }
        
        func contains(days: [Date]) -> Bool {
            return days.allSatisfy { self.contains(day: $0) }
        }
        
        func contains(days: Set<Day>) -> Bool {
            return days.isSubset(of: self.days)
        }
        
        func contains(days: Set<Date>) -> Bool {
            return days.allSatisfy { self.contains(day: $0) }
        }
        
        func isIncluded(date: Date) -> Bool {
            guard
                let day = Day(dayFromCalendar: date)
            else { return false }
            
            switch day {
            case .mon:
                return contains(day: .mon)
            case .tue:
                return contains(day: .tue)
            case .wed:
                return contains(day: .wed)
            case .thu:
                return contains(day: .thu)
            case .fri:
                return contains(day: .fri)
            case .sat:
                return contains(day: .sat)
            case .sun:
                return contains(day: .sun)
            }
        }
        
        enum Day: String, CaseIterable {
            case mon = "Mon"
            case tue = "Tue"
            case wed = "Wed"
            case thu = "Thu"
            case fri = "Fri"
            case sat = "Sat"
            case sun = "Sun"
            
            var description: String {
                switch self {
                case .mon:
                    return "Monday".localized
                case .tue:
                    return "Tuesday".localized
                case .wed:
                    return "Wednesday".localized
                case .thu:
                    return "Thursday".localized
                case .fri:
                    return "Friday".localized
                case .sat:
                    return "Saturday".localized
                case .sun:
                    return "Sunday".localized
                }
            }
            
            // get Day from calendar
            init?(dayFromCalendar: Date) {
                let weekday = Calendar.current.component(.weekday,
                                                         from: dayFromCalendar)
                switch weekday {
                case 1:
                    self = .sun
                case 2:
                    self = .mon
                case 3:
                    self = .tue
                case 4:
                    self = .wed
                case 5:
                    self = .thu
                case 6:
                    self = .fri
                case 7:
                    self = .sat
                default:
                    return nil
                }
                
            }
        }
    }
    
    enum ReservableKind: String, Codable {
        case roomType = "RoomType"
        case bedType = "BedType"
    }
    
    struct Meal: Codable {
        var included: Bool
        var adult: MealRate
        var child: MealRate
        
        var pax: Int {
            guard included else { return 0 }
            return adult.limit + child.limit
        }
        
        enum CodingKeys: String, CodingKey {
            case included
            case adult
            case child
        }
        
        init(included: Bool = false,
             adult: MealRate = MealRate(),
             child: MealRate = MealRate()) {
            self.included = included
            self.adult = adult
            self.child = child
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.included = try (container.decodeIfPresent(Bool.self, forKey: .included) ?? false)
            self.adult = try (container.decodeIfPresent(MealRate.self, forKey: .adult) ?? MealRate())
            self.child = try (container.decodeIfPresent(MealRate.self, forKey: .child) ?? MealRate())
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(included, forKey: .included)
            try container.encode(adult, forKey: .adult)
            try container.encode(child, forKey: .child)
        }
        
    }
    
    struct MealRate: Codable {
        var price: Double
        var limit: Int
        var extraRate: Double
        var extraLimit: Int
        
        enum CodingKeys: String, CodingKey {
            case price
            case limit
            case extraRate = "extra_rate"
            case extraLimit = "extra_limit"
        }
        
        init(price: Double = 0,
             limit: Int = 0,
             extraRate: Double = 0,
             extraLimit: Int = 0) {
            self.price = price
            self.limit = limit
            self.extraRate = extraRate
            self.extraLimit = extraLimit
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.price = try (container.decodeIfPresent(String.self, forKey: .price) ?? "0").tryToDouble()
            self.limit = try (container.decodeIfPresent(Int.self, forKey: .limit) ?? 0)
            self.extraRate = try (container.decodeIfPresent(String.self, forKey: .extraRate) ?? "0").tryToDouble()
            self.extraLimit = try (container.decodeIfPresent(Int.self, forKey: .extraLimit) ?? 0)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(price, forKey: .price)
            try container.encode(limit, forKey: .limit)
            try container.encode(extraRate, forKey: .extraRate)
            try container.encode(extraLimit, forKey: .extraLimit)
        }
    }
    
    struct AvailabelChannel: Codable, Hashable {
        let channelID: Int
        let subChannelID: Int?
        
        enum CodingKeys: String, CodingKey {
            case channelID = "channel_id"
            case subChannelID = "sub_channel_id"
        }
        
        init(channelID: Int,
             subChannelID: Int?) {
            self.channelID = channelID
            self.subChannelID = subChannelID
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.channelID = try container.decode(Int.self, forKey: .channelID)
            self.subChannelID = try? container.decode(Int.self, forKey: .subChannelID)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(channelID, forKey: .channelID)
            try container.encode(subChannelID, forKey: .subChannelID)
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(channelID)
            hasher.combine(subChannelID)
        }
    }
}


/*
 {
 "id": 260,
 "title": "9999",
 "description": "",
 "price": 9999.0,
 "total_price": "9999.0",
 "period_types": [
 "Sun",
 "Fri",
 "Tue",
 "Mon",
 "Wed",
 "Sat",
 "Thu"
 ],
 "exception_dates": [],
 "reservable_type_id": 179,
 "reservable_type_type": "RoomType",
 "code": null,
 "color": null,
 "bf": {
 "included": false,
 "adult": {
 "price": "0.0",
 "limit": 0,
 "extra_rate": "0.0",
 "extra_limit": 0
 },
 "child": {
 "price": "0.0",
 "limit": 0,
 "extra_rate": "0.0",
 "extra_limit": 0
 }
 },
 "channels": [
 {
 "channel_id": 7,
 "sub_channel_id": 11
 },
 {
 "channel_id": 7,
 "sub_channel_id": 21
 },
 {
 "channel_id": 4,
 "sub_channel_id": 31
 },
 {
 "channel_id": 7,
 "sub_channel_id": 3
 },
 {
 "channel_id": 4,
 "sub_channel_id": 23
 },
 {
 "channel_id": 7,
 "sub_channel_id": 28
 },
 {
 "channel_id": 7,
 "sub_channel_id": 18
 },
 {
 "channel_id": 7,
 "sub_channel_id": 15
 },
 {
 "channel_id": 6,
 "sub_channel_id": null
 },
 {
 "channel_id": 7,
 "sub_channel_id": 27
 },
 {
 "channel_id": 9,
 "sub_channel_id": null
 },
 {
 "channel_id": 7,
 "sub_channel_id": 12
 },
 {
 "channel_id": 7,
 "sub_channel_id": 16
 },
 {
 "channel_id": 7,
 "sub_channel_id": 17
 },
 {
 "channel_id": 7,
 "sub_channel_id": 35
 },
 {
 "channel_id": 7,
 "sub_channel_id": 29
 },
 {
 "channel_id": 7,
 "sub_channel_id": 1
 },
 {
 "channel_id": 7,
 "sub_channel_id": 19
 },
 {
 "channel_id": 7,
 "sub_channel_id": 22
 },
 {
 "channel_id": 7,
 "sub_channel_id": 10
 },
 {
 "channel_id": 7,
 "sub_channel_id": 26
 },
 {
 "channel_id": 8,
 "sub_channel_id": null
 },
 {
 "channel_id": 7,
 "sub_channel_id": 32
 },
 {
 "channel_id": 7,
 "sub_channel_id": 9
 },
 {
 "channel_id": 4,
 "sub_channel_id": 7
 },
 {
 "channel_id": 10,
 "sub_channel_id": null
 },
 {
 "channel_id": 7,
 "sub_channel_id": 25
 },
 {
 "channel_id": 11,
 "sub_channel_id": null
 },
 {
 "channel_id": 7,
 "sub_channel_id": 14
 },
 {
 "channel_id": 5,
 "sub_channel_id": null
 },
 {
 "channel_id": 7,
 "sub_channel_id": 30
 },
 {
 "channel_id": 7,
 "sub_channel_id": 4
 },
 {
 "channel_id": 7,
 "sub_channel_id": 20
 },
 {
 "channel_id": 7,
 "sub_channel_id": 33
 },
 {
 "channel_id": 7,
 "sub_channel_id": 8
 },
 {
 "channel_id": 7,
 "sub_channel_id": 13
 },
 {
 "channel_id": 7,
 "sub_channel_id": 24
 }
 ],
 "pinned": false,
 "start_at": null,
 "end_at": null,
 "created_at": "2024-04-20T13:49:20.614+07:00",
 "updated_at": "2024-04-20T13:49:20.620+07:00",
 "hotel_id": 105
 }
 */
