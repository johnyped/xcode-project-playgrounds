//
//  CMRate+Channel.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//
import Foundation

extension CMRate {
    struct Channels: Codable {
        let channel000: Bool // beds24
        let channel002: Bool // Bookit.co.nz
        let channel012: Bool // Flipkey.com
        let channel014: Bool // Expedia.com
        let channel017: Bool // Agoda
        let channel019: Bool // Booking.com
        let channel023: Bool // Tablethotels.com
        let channel024: Bool // Hostelworld.com
        let channel027: Bool // Bedandbreakfast.eu
        let channel030: Bool // VRBO / Homeaway
        let channel031: Bool // Bedandbreakfast.nl
        let channel032: Bool // Atraveo.de
        let channel033: Bool // Feratel.com
        let channel034: Bool // Web-rooms.co.nz
        let channel035: Bool // Lastminute.com
        let channel036: Bool // Hotelbeds.com
        let channel042: Bool // OTA
        let channel044: Bool // Hostel International
        let channel046: Bool // Airbnb
        let channel050: Bool // Tomas Travel
        let channel051: Bool // Ostrovok.ru
        let channel052: Bool // Bookeasy.com.au
        let channel053: Bool // Trip
        let channel055: Bool // Tripadvisor Rentals
        let channel056: Bool // Traveloka
        let channel057: Bool // HRS
        let channel059: Bool // Despegar.com
        let channel063: Bool // Vacation-Stay.com
        let channel064: Bool // Hostelsclub.com
        let channel066: Bool // eDreams ODIGEO
        let channel072: Bool // Jomres
        let channel073: Bool // Goibibo
        let channel076: Bool // Travia
        let channel078: Bool // HomeToGo
        let channel083: Bool // Traum-Ferienwohnungen
        let channel086: Bool // Tiket
        let channel087: Bool // Marriott
        let channel999: Bool // beds24 - agents
        
        var selectedKeys: [Key] {
             var result: [Key] = []
             
             if channel000 { result.append(.beds24) }
             if channel002 { result.append(.bookit) }
             if channel012 { result.append(.flipkey) }
             if channel014 { result.append(.expedia) }
             if channel017 { result.append(.agoda) }
             if channel019 { result.append(.booking) }
             if channel023 { result.append(.tablet) }
             if channel024 { result.append(.hostelworld) }
             if channel027 { result.append(.bedandbreakfastEU) }
             if channel030 { result.append(.vrbo) }
             if channel031 { result.append(.bedandbreakfastNL) }
             if channel032 { result.append(.atraveo) }
             if channel033 { result.append(.feratel) }
             if channel034 { result.append(.webRooms) }
             if channel035 { result.append(.lastminute) }
             if channel036 { result.append(.hotelbeds) }
             if channel042 { result.append(.ota) }
             if channel044 { result.append(.hostelInternational) }
             if channel046 { result.append(.airbnb) }
             if channel050 { result.append(.tomasTravel) }
             if channel051 { result.append(.ostrovok) }
             if channel052 { result.append(.bookeasy) }
             if channel053 { result.append(.trip) }
             if channel055 { result.append(.tripadvisorRentals) }
             if channel056 { result.append(.traveloka) }
             if channel057 { result.append(.hrs) }
             if channel059 { result.append(.despegar) }
             if channel063 { result.append(.vacationStay) }
             if channel064 { result.append(.hostelsclub) }
             if channel066 { result.append(.eDreams) }
             if channel072 { result.append(.jomres) }
             if channel073 { result.append(.goibibo) }
             if channel076 { result.append(.travia) }
             if channel078 { result.append(.homeToGo) }
             if channel083 { result.append(.traumFerienwohnungen) }
             if channel086 { result.append(.tiket) }
             if channel087 { result.append(.marriott) }
             if channel999 { result.append(.beds24Agents) }
             
             return result
        }
        
        var selectedKeyTexts: [String] {
            selectedKeys.map({ $0.rawValue })
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.channel000 = try container.decode(Int.self,
                                                   forKey: .channel000).toBool()
            self.channel002 = try container.decode(Int.self,
                                                   forKey: .channel002).toBool()
            self.channel012 = try container.decode(Int.self,
                                                   forKey: .channel012).toBool()
            self.channel014 = try container.decode(Int.self,
                                                   forKey: .channel014).toBool()
            self.channel017 = try container.decode(Int.self,
                                                   forKey: .channel017).toBool()
            self.channel019 = try container.decode(Int.self,
                                                   forKey: .channel019).toBool()
            self.channel023 = try container.decode(Int.self,
                                                   forKey: .channel023).toBool()
            self.channel024 = try container.decode(Int.self,
                                                   forKey: .channel024).toBool()
            self.channel027 = try container.decode(Int.self,
                                                   forKey: .channel027).toBool()
            self.channel030 = try container.decode(Int.self,
                                                   forKey: .channel030).toBool()
            self.channel031 = try container.decode(Int.self,
                                                   forKey: .channel031).toBool()
            self.channel032 = try container.decode(Int.self,
                                                   forKey: .channel032).toBool()
            self.channel033 = try container.decode(Int.self,
                                                   forKey: .channel033).toBool()
            self.channel034 = try container.decode(Int.self,
                                                   forKey: .channel034).toBool()
            self.channel035 = try container.decode(Int.self,
                                                   forKey: .channel035).toBool()
            self.channel036 = try container.decode(Int.self,
                                                   forKey: .channel036).toBool()
            self.channel042 = try container.decode(Int.self,
                                                   forKey: .channel042).toBool()
            self.channel044 = try container.decode(Int.self,
                                                   forKey: .channel044).toBool()
            self.channel046 = try container.decode(Int.self,
                                                   forKey: .channel046).toBool()
            self.channel050 = try container.decode(Int.self,
                                                   forKey: .channel050).toBool()
            self.channel051 = try container.decode(Int.self,
                                                   forKey: .channel051).toBool()
            self.channel052 = try container.decode(Int.self,
                                                   forKey: .channel052).toBool()
            self.channel053 = try container.decode(Int.self,
                                                   forKey: .channel053).toBool()
            self.channel055 = try container.decode(Int.self,
                                                   forKey: .channel055).toBool()
            self.channel056 = try container.decode(Int.self,
                                                   forKey: .channel056).toBool()
            self.channel057 = try container.decode(Int.self,
                                                   forKey: .channel057).toBool()
            self.channel059 = try container.decode(Int.self,
                                                   forKey: .channel059).toBool()
            self.channel063 = try container.decode(Int.self,
                                                   forKey: .channel063).toBool()
            self.channel064 = try container.decode(Int.self,
                                                   forKey: .channel064).toBool()
            self.channel066 = try container.decode(Int.self,
                                                   forKey: .channel066).toBool()
            self.channel072 = try container.decode(Int.self,
                                                   forKey: .channel072).toBool()
            self.channel073 = try container.decode(Int.self,
                                                   forKey: .channel073).toBool()
            self.channel076 = try container.decode(Int.self,
                                                   forKey: .channel076).toBool()
            self.channel078 = try container.decode(Int.self,
                                                   forKey: .channel078).toBool()
            self.channel083 = try container.decode(Int.self,
                                                   forKey: .channel083).toBool()
            self.channel086 = try container.decode(Int.self,
                                                   forKey: .channel086).toBool()
            self.channel087 = try container.decode(Int.self,
                                                   forKey: .channel087).toBool()
            self.channel999 = try container.decode(Int.self,
                                                   forKey: .channel999).toBool()
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(channel000.int, forKey: .channel000)
            try container.encode(channel002.int, forKey: .channel002)
            try container.encode(channel012.int, forKey: .channel012)
            try container.encode(channel014.int, forKey: .channel014)
            try container.encode(channel017.int, forKey: .channel017)
            try container.encode(channel019.int, forKey: .channel019)
            try container.encode(channel023.int, forKey: .channel023)
            try container.encode(channel024.int, forKey: .channel024)
            try container.encode(channel027.int, forKey: .channel027)
            try container.encode(channel030.int, forKey: .channel030)
            try container.encode(channel031.int, forKey: .channel031)
            try container.encode(channel032.int, forKey: .channel032)
            try container.encode(channel033.int, forKey: .channel033)
            try container.encode(channel034.int, forKey: .channel034)
            try container.encode(channel035.int, forKey: .channel035)
            try container.encode(channel036.int, forKey: .channel036)
            try container.encode(channel042.int, forKey: .channel042)
            try container.encode(channel044.int, forKey: .channel044)
            try container.encode(channel046.int, forKey: .channel046)
            try container.encode(channel050.int, forKey: .channel050)
            try container.encode(channel051.int, forKey: .channel051)
            try container.encode(channel052.int, forKey: .channel052)
            try container.encode(channel053.int, forKey: .channel053)
            try container.encode(channel055.int, forKey: .channel055)
            try container.encode(channel056.int, forKey: .channel056)
            try container.encode(channel057.int, forKey: .channel057)
            try container.encode(channel059.int, forKey: .channel059)
            try container.encode(channel063.int, forKey: .channel063)
            try container.encode(channel064.int, forKey: .channel064)
            try container.encode(channel066.int, forKey: .channel066)
            try container.encode(channel072.int, forKey: .channel072)
            try container.encode(channel073.int, forKey: .channel073)
            try container.encode(channel076.int, forKey: .channel076)
            try container.encode(channel078.int, forKey: .channel078)
            try container.encode(channel083.int, forKey: .channel083)
            try container.encode(channel086.int, forKey: .channel086)
            try container.encode(channel087.int, forKey: .channel087)
            try container.encode(channel999.int, forKey: .channel999)
        }
        
//        init(channels: Set<BookingChannel.ChannelAndSubChannel>,
//             beds24Channels: Beds24Channels) {
//            
//            var enbleKeys: [Key] = []
//            
//            beds24Channels.lists.forEach({ _beds24 in
//                if channels.contains(where: {
//                    _beds24.hmsChannelID == $0.channel.id &&
//                    _beds24.hmsSubChannelID == $0.subChannel?.id
//                }) {
//                    if let beds24ChannelKey = _beds24.beds24RateKey,
//                       let key = Key(rawValue: beds24ChannelKey) {
//                        enbleKeys.append(key)
//                    }
//                }
//            })
//            
//            self.channel000 = enbleKeys.contains(.beds24)
//            self.channel002 = enbleKeys.contains(.bookit)
//            self.channel012 = enbleKeys.contains(.flipkey)
//            self.channel014 = enbleKeys.contains(.expedia)
//            self.channel017 = enbleKeys.contains(.agoda)
//            self.channel019 = enbleKeys.contains(.booking)
//            self.channel023 = enbleKeys.contains(.tablet)
//            self.channel024 = enbleKeys.contains(.hostelworld)
//            self.channel027 = enbleKeys.contains(.bedandbreakfastEU)
//            self.channel030 = enbleKeys.contains(.vrbo)
//            self.channel031 = enbleKeys.contains(.bedandbreakfastNL)
//            self.channel032 = enbleKeys.contains(.atraveo)
//            self.channel033 = enbleKeys.contains(.feratel)
//            self.channel034 = enbleKeys.contains(.webRooms)
//            self.channel035 = enbleKeys.contains(.lastminute)
//            self.channel036 = enbleKeys.contains(.hotelbeds)
//            self.channel042 = enbleKeys.contains(.ota)
//            self.channel044 = enbleKeys.contains(.hostelInternational)
//            self.channel046 = enbleKeys.contains(.airbnb)
//            self.channel050 = enbleKeys.contains(.tomasTravel)
//            self.channel051 = enbleKeys.contains(.ostrovok)
//            self.channel052 = enbleKeys.contains(.bookeasy)
//            self.channel053 = enbleKeys.contains(.trip)
//            self.channel055 = enbleKeys.contains(.tripadvisorRentals)
//            self.channel056 = enbleKeys.contains(.traveloka)
//            self.channel057 = enbleKeys.contains(.hrs)
//            self.channel059 = enbleKeys.contains(.despegar)
//            self.channel063 = enbleKeys.contains(.vacationStay)
//            self.channel064 = enbleKeys.contains(.hostelsclub)
//            self.channel066 = enbleKeys.contains(.eDreams)
//            self.channel072 = enbleKeys.contains(.jomres)
//            self.channel073 = enbleKeys.contains(.goibibo)
//            self.channel076 = enbleKeys.contains(.travia)
//            self.channel078 = enbleKeys.contains(.homeToGo)
//            self.channel083 = enbleKeys.contains(.traumFerienwohnungen)
//            self.channel086 = enbleKeys.contains(.tiket)
//            self.channel087 = enbleKeys.contains(.marriott)
//            self.channel999 = enbleKeys.contains(.beds24Agents)
//            
//        }
        
        init(beds24: Bool = false,
             bookit: Bool = false,
             flipkey: Bool = false,
             expedia: Bool = false,
             agoda: Bool = false,
             booking: Bool = false,
             tablet: Bool = false,
             hostelworld: Bool = false,
             bedandbreakfastEU: Bool = false,
             vrbo: Bool = false,
             bedandbreakfastNL: Bool = false,
             atraveo: Bool = false,
             feratel: Bool = false,
             webRooms: Bool = false,
             lastminute: Bool = false,
             hotelbeds: Bool = false,
             ota: Bool = false,
             hostelInternational: Bool = false,
             airbnb: Bool = false,
             tomasTravel: Bool = false,
             ostrovok: Bool = false,
             bookeasy: Bool = false,
             trip: Bool = false,
             tripadvisorRentals: Bool = false,
             traveloka: Bool = false,
             hrs: Bool = false,
             despegar: Bool = false,
             vacationStay: Bool = false,
             hostelsclub: Bool = false,
             eDreams: Bool = false,
             jomres: Bool = false,
             goibibo: Bool = false,
             travia: Bool = false,
             homeToGo: Bool = false,
             traumFerienwohnungen: Bool = false,
             tiket: Bool = false,
             marriott: Bool = false,
             beds24Agents: Bool = false) {
            self.channel000 = beds24
            self.channel002 = bookit
            self.channel012 = flipkey
            self.channel014 = expedia
            self.channel017 = agoda
            self.channel019 = booking
            self.channel023 = tablet
            self.channel024 = hostelworld
            self.channel027 = bedandbreakfastEU
            self.channel030 = vrbo
            self.channel031 = bedandbreakfastNL
            self.channel032 = atraveo
            self.channel033 = feratel
            self.channel034 = webRooms
            self.channel035 = lastminute
            self.channel036 = hotelbeds
            self.channel042 = ota
            self.channel044 = hostelInternational
            self.channel046 = airbnb
            self.channel050 = tomasTravel
            self.channel051 = ostrovok
            self.channel052 = bookeasy
            self.channel053 = trip
            self.channel055 = tripadvisorRentals
            self.channel056 = traveloka
            self.channel057 = hrs
            self.channel059 = despegar
            self.channel063 = vacationStay
            self.channel064 = hostelsclub
            self.channel066 = eDreams
            self.channel072 = jomres
            self.channel073 = goibibo
            self.channel076 = travia
            self.channel078 = homeToGo
            self.channel083 = traumFerienwohnungen
            self.channel086 = tiket
            self.channel087 = marriott
            self.channel999 = beds24Agents
        }
        
        init() {
            channel000 = true
            channel002 = true
            channel012 = true
            channel014 = true
            channel017 = true
            channel019 = true
            channel023 = true
            channel024 = true
            channel027 = true
            channel030 = true
            channel031 = true
            channel032 = true
            channel033 = true
            channel034 = true
            channel035 = true
            channel036 = true
            channel042 = true
            channel044 = true
            channel046 = true
            channel050 = true
            channel051 = true
            channel052 = true
            channel053 = true
            channel055 = true
            channel056 = true
            channel057 = true
            channel059 = true
            channel063 = true
            channel064 = true
            channel066 = true
            channel072 = true
            channel073 = true
            channel076 = true
            channel078 = true
            channel083 = true
            channel086 = true
            channel087 = true
            channel999 = true
        }
        
        func getValue(key: String) -> Bool? {
            switch key {
            case "channel000":
                return channel000
            case "channel002":
                return channel002
            case "channel012":
                return channel012
            case "channel014":
                return channel014
            case "channel017":
                return channel017
            case "channel019":
                return channel019
            case "channel023":
                return channel023
            case "channel024":
                return channel024
            case "channel027":
                return channel027
            case "channel030":
                return channel030
            case "channel031":
                return channel031
            case "channel032":
                return channel032
            case "channel033":
                return channel033
            case "channel034":
                return channel034
            case "channel035":
                return channel035
            case "channel036":
                return channel036
            case "channel042":
                return channel042
            case "channel044":
                return channel044
            case "channel046":
                return channel046
            case "channel050":
                return channel050
            case "channel051":
                return channel051
            case "channel052":
                return channel052
            case "channel053":
                return channel053
            case "channel055":
                return channel055
            case "channel056":
                return channel056
            case "channel057":
                return channel057
            case "channel059":
                return channel059
            case "channel063":
                return channel063
            case "channel064":
                return channel064
            case "channel066":
                return channel066
            case "channel072":
                return channel072
            case "channel073":
                return channel073
            case "channel076":
                return channel076
            case "channel078":
                return channel078
            case "channel083":
                return channel083
            case "channel086":
                return channel086
            case "channel087":
                return channel087
            case "channel999":
                return channel999
            default:
                return nil
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case channel000 = "channel000"
            case channel002 = "channel002"
            case channel012 = "channel012"
            case channel014 = "channel014"
            case channel017 = "channel017"
            case channel019 = "channel019"
            case channel023 = "channel023"
            case channel024 = "channel024"
            case channel027 = "channel027"
            case channel030 = "channel030"
            case channel031 = "channel031"
            case channel032 = "channel032"
            case channel033 = "channel033"
            case channel034 = "channel034"
            case channel035 = "channel035"
            case channel036 = "channel036"
            case channel042 = "channel042"
            case channel044 = "channel044"
            case channel046 = "channel046"
            case channel050 = "channel050"
            case channel051 = "channel051"
            case channel052 = "channel052"
            case channel053 = "channel053"
            case channel055 = "channel055"
            case channel056 = "channel056"
            case channel057 = "channel057"
            case channel059 = "channel059"
            case channel063 = "channel063"
            case channel064 = "channel064"
            case channel066 = "channel066"
            case channel072 = "channel072"
            case channel073 = "channel073"
            case channel076 = "channel076"
            case channel078 = "channel078"
            case channel083 = "channel083"
            case channel086 = "channel086"
            case channel087 = "channel087"
            case channel999 = "channel999"
        }
        
        enum Key: String {
            case beds24 = "channel000"
            case bookit = "channel002"
            case flipkey = "channel012"
            case expedia = "channel014"
            case agoda = "channel017"
            case booking = "channel019"
            case tablet = "channel023"
            case hostelworld = "channel024"
            case bedandbreakfastEU = "channel027"
            case vrbo = "channel030"
            case bedandbreakfastNL = "channel031"
            case atraveo = "channel032"
            case feratel = "channel033"
            case webRooms = "channel034"
            case lastminute = "channel035"
            case hotelbeds = "channel036"
            case ota = "channel042"
            case hostelInternational = "channel044"
            case airbnb = "channel046"
            case tomasTravel = "channel050"
            case ostrovok = "channel051"
            case bookeasy = "channel052"
            case trip = "channel053"
            case tripadvisorRentals = "channel055"
            case traveloka = "channel056"
            case hrs = "channel057"
            case despegar = "channel059"
            case vacationStay = "channel063"
            case hostelsclub = "channel064"
            case eDreams = "channel066"
            case jomres = "channel072"
            case goibibo = "channel073"
            case travia = "channel076"
            case homeToGo = "channel078"
            case traumFerienwohnungen = "channel083"
            case tiket = "channel086"
            case marriott = "channel087"
            case beds24Agents = "channel999"
        }
    }
}
