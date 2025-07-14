//
//  Reservations.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//
import Foundation

typealias Reservations = Collection<Reservation>

// MARK: Computed properties
extension Reservations {
    
//    var additionalServiceTotalAmount: Double {
//        lists.reduce(0) { (result, reservation) -> Double in
//            result + reservation.additionalServiceTotalAmount
//        }
//    }
//    
//    var totalCost: Double {
//        lists.reduce(0) { (result, reservation) -> Double in
//            result + reservation.totalCostAmount
//        }
//    }
//    
//    // financeBalance = financeTotalReceived + financeTotalRefunded
//    var financeBalance: Double {
//        lists.reduce(0) { (result, reservation) -> Double in
//            result + reservation.financeTotalBalance
//        }
    //}
    
    // financeBalance - totalCost
//    var remainTotal: Double {
//        financeBalance - totalCost
//    }
    
//    var ids: [Int] {
//        lists.map({ $0.id })
//    }
//    
//    var uniqueIDs: Set<Int> {
//        lists.reduce([]) { (result, reservation) -> Set<Int> in
//            result.union([reservation.id])
//        }
//    }
//    
//    var uniqueUnitIDs: Set<Int> {
//        lists.reduce([]) { (result, reservation) -> Set<Int> in
//            result.union(reservation.uniqueUnitIDs)
//        }
//    }
//    
//    // show only 1 guest on mutiple booking
//    var uniqueGuests: Guests {
//        let results = lists.reduce([], { (result, reservation) -> [Guest] in
//            result + reservation.guests.lists
//        })
//        return .init(lists: results).filterbyOnlyUniqueGuest()
//    }
//    
//    var allCheckInDates: [Date] {
//        var datesBuffer: [String] = []
//        var dateResult: [Date] = []
//        // get all available check in date
//        lists.forEach { (rsv) in
//            let checkInDate = rsv.checkInDate.toDateString("yyyy-MM-dd")
//            if datesBuffer.contains(checkInDate) == false {
//                datesBuffer.append(checkInDate)
//                dateResult.append(rsv.checkInDate)
//            }
//        }
//        return dateResult
//    }
//    
//    var allCheckOutDates: [Date] {
//        var datesBuffer: [String] = []
//        var dateResult: [Date] = []
//        // get all available check out date
//        lists.forEach { (rsv) in
//            let checkOutDate = rsv.checkOutDate.toDateString("yyyy-MM-dd")
//            if datesBuffer.contains(checkOutDate) == false {
//                datesBuffer.append(checkOutDate)
//                dateResult.append(rsv.checkOutDate)
//            }
//        }
//        return dateResult
//    }
//    
//    func isExist(id: Int) -> Bool {
//        return lists.contains(where: { (reservation) -> Bool in
//            return reservation.id == id
//        })
//    }
}

// MARK: - Functions
extension Reservations {
    
    func sortedBy(
        by: Reservation.SortBy = .id,
        orderBy: SortOrderBy = .ascending
    ) -> Reservations {
        let sorted: [Reservation]
        switch by {
        case .id:
            sorted = lists.sorted { orderBy == .ascending ? $0.id < $1.id : $0.id > $1.id }
        case .contactNameAlphabet:
            sorted = lists.sorted { orderBy == .ascending ? $0.contacts.fullname < $1.contacts.fullname : $0.contacts.fullname > $1.contacts.fullname }
        case .status:
            sorted = lists.sorted { orderBy == .ascending ? $0.status.rawValue < $1.status.rawValue : $0.status.rawValue > $1.status.rawValue }
        case .totalCost:
//            sorted = lists.sorted { orderBy == .ascending ? $0.totalCostAmount < $1.totalCostAmount : $0.totalCostAmount > $1.totalCostAmount }
            // by pass now
            break
        case .totalPaid:
//            sorted = lists.sorted { orderBy == .ascending ? $0.financeTotalBalance < $1.financeTotalBalance : $0.financeTotalBalance > $1.financeTotalBalance }
            // by pass now
            break
        case .remainCost:
//            sorted = lists.sorted { orderBy == .ascending ? $0.remainPaymentAmount < $1.remainPaymentAmount : $0.remainPaymentAmount > $1.remainPaymentAmount }
            // by pass now
            break
        case .nightCount:
            sorted = lists.sorted { orderBy == .ascending ? $0.numberOfNight < $1.numberOfNight : $0.numberOfNight > $1.numberOfNight }
        case .checkInDate:
            sorted = lists.sorted { orderBy == .ascending ? $0.checkInDate < $1.checkInDate : $0.checkInDate > $1.checkInDate }
        case .checkOutDate:
            sorted = lists.sorted { orderBy == .ascending ? $0.checkOutDate < $1.checkOutDate : $0.checkOutDate > $1.checkOutDate }
        case .createdAt:
            sorted = lists.sorted { orderBy == .ascending ? $0.createdAt < $1.createdAt : $0.createdAt > $1.createdAt }
        case .updatedAt:
            sorted = lists.sorted { orderBy == .ascending ? $0.updatedAt < $1.updatedAt : $0.updatedAt > $1.updatedAt }
        }
        return .init(array: lists)
    }
    
    func filteredBy(by: Reservation.FilterBy) -> Reservations {
        let filtered: [Reservation]
        
        switch by {
        case .id(let id):
            filtered = lists.filter { $0.id == id }
        case .ids(let ids):
            filtered = lists.filter { ids.contains($0.id) }
        case .keyword(let q):
            //filtered = lists.filter { $0.contain(keyword: q) }
            // by pass now
            break
        case .guestId(let id):
            //filtered = lists.filter { $0.guests.contain(id: id) }
            // by pass now
            break
        case .roomId(let id):
            //filtered = lists.filter { $0.uniqueUnitIDs.contains(id) }
            // by pass now
            break
        case .status(let status):
            filtered = lists.filter { $0.status == status }
        case .statuses(let statuses):
            filtered = lists.filter { statuses.contains($0.status) }
        case .date(let date):
            filtered = lists.filter { date.isMoreOrEqualThen($0.checkInDate) && date.isLessOrEqualThen($0.checkOutDate) }
        case .checkInDate(let date):
            filtered = lists.filter { $0.checkInDate.isSameDate(date) }
        case .staythroughDate(let date):
            filtered = lists.filter { date.isMoreThen($0.checkInDate) && date.isLessThen($0.checkOutDate) }
        case .checkOutDate(let date):
            filtered = lists.filter { $0.checkOutDate.isSameDate(date) }
        case .arrivalToday(let date):
            //filtered = lists.filter { $0.isNeedCheckIn(onDate: date) }
            // by pass now
            break
        case .departureToday(let date):
            //filtered = lists.filter { $0.isNeedCheckOut(onDate: date) }
            // by pass now
            break
        case .overCheckIn(let date):
            filtered = lists.filter { $0.checkInDate.isMoreThen(date) }
        case .beforeCheckIn(let date):
            filtered = lists.filter { $0.checkInDate.isLessThen(date) }
        case .channel(let id,let subChannelId):
//            filtered = lists.filter { $0.channelId == channel.channel.id && $0.subChannelId == channel.subChannel?.id }
            // by pass now
            break
        case .channels(let channels):
            // by pass now
            break
            
//            filtered = lists.filter { reservation in
//                channels.contains { channelAndSubChannel in
//                    if let sub = channelAndSubChannel.subChannel {
//                        return reservation.channelId == channelAndSubChannel.channel.id && reservation.subChannelId == sub.id
//                    }
//                    return reservation.channelId == channelAndSubChannel.channel.id
//                }
//            }
        }
        return .init(array: lists)
    }
    
    //    func filter(byID: Int) -> Reservation? {
    //        return lists.filter { (reservation) -> Bool in
    //            return reservation.id == byID
    //        }.first
    //    }
    //
    //    func filter(byIDs: Set<Int>) -> Self {
    //        let result = lists.filter { (reservation) -> Bool in
    //            byIDs.contains(reservation.id)
    //        }
    //        return .init(lists: result)
    //    }
    //
    //    func filter(byKeyword: String) -> Self {
    //        let reult = lists.filter { (reservation) -> Bool in
    //            reservation.contain(keyword: byKeyword)
    //        }
    //        return Reservations(lists: reult)
    //    }
    //
    //    func filter(byGuestID: Int) -> Self {
    //        let result = lists.filter { (reservation) -> Bool in
    //            return reservation.guests.contain(id: byGuestID)
    //        }
    //        return Reservations(lists: result)
    //    }
    //
    //    func filter(byUnitID: Int) -> Self {
    //        let result = lists.filter { (reservation) -> Bool in
    //            return reservation.uniqueUnitIDs.contains(byUnitID)
    //        }
    //        return Reservations(lists: result)
    //    }
    //
    //    func filter(byStatus: Reservation.Status) -> Self {
    //        let result = lists.filter { (reservation) -> Bool in
    //            reservation.status == byStatus
    //        }
    //        return Reservations(lists: result)
    //    }
    //
    //    func filter(byStatuses: [Reservation.Status]) -> Self {
    //        let result = lists.filter { (reservation) -> Bool in
    //            byStatuses.contains(reservation.status)
    //        }
    //        return Reservations(lists: result)
    //    }
    //
    //    func filter(onDate: Date) -> Self {
    //        let result = lists.filter { (reservation) -> Bool in
    //            //reservation.checkInDate.isMoreOrEqualThen(onDate) && reservation.checkOutDate.isLessOrEqualThen(onDate)
    //            onDate.isMoreOrEqualThen(reservation.checkInDate) && onDate.isLessOrEqualThen(reservation.checkOutDate)
    //        }
    //        return Reservations(lists: result)
    //    }
    //
    //    func filter(onCheckInDate: Date) -> Self {
    //        let result = lists.filter { (reservation) -> Bool in
    //            reservation.checkInDate.isSameDate(onCheckInDate)
    //        }
    //        return Reservations(lists: result)
    //    }
    //
    //    func filter(onCheckInDates: [Date]) -> Reservations {
    //        let result = lists.filter { (reservation) -> Bool in
    //            reservation.checkInDate.isSameDate(onCheckInDate)
    //        }
    //        return Reservations(lists: result)
    //    }
    
    //    func filter(onCheckOutDate: Date) -> Self {
    //        let result = lists.filter { (reservation) -> Bool in
    //            reservation.checkOutDate.isSameDate(onCheckOutDate)
    //        }
    //        return Reservations(lists: result)
    //    }
    //
    //    // reservation.checkInDate > date && reservation.checkOutDate < date
    //    func filter(onStayThroughDate: Date) -> Self {
    //        let result = lists.filter { (reservation) -> Bool in
    //            onStayThroughDate.isMoreThen(reservation.checkInDate) && onStayThroughDate.isLessThen(reservation.checkOutDate)
    //        }
    //        return Reservations(lists: result)
    //    }
    //
    //    func filterOnlyArrivalToday(onDate: Date = .init()) -> Self {
    //        let result = lists.filter { (reservation) -> Bool in
    //            reservation.isNeedCheckIn(onDate: onDate)
    //        }
    //        return Reservations(lists: result)
    //    }
    //
    //    func filterOnlyDepartureToday(onDate: Date = .init()) -> Self {
    //        let result = lists.filter { (reservation) -> Bool in
    //            reservation.isNeedCheckOut(onDate: onDate)
    //        }
    //        return Reservations(lists: result)
    //    }
    //
    //    func filter(onOverCheckInDate: Date) -> Self {
    //        let result = lists.filter { (reservation) -> Bool in
    //            reservation.checkInDate.isMoreThen(onOverCheckInDate)
    //        }
    //        return Reservations(lists: result)
    //    }
    //
    //    func filter(onBeforeCheckInDate: Date) -> Self {
    //        let result = lists.filter { (reservation) -> Bool in
    //            reservation.checkInDate.isLessThen(onBeforeCheckInDate)
    //        }
    //        return Reservations(lists: result)
    //    }
    //
    //    func filter(bookingChannel: BookingChannel.ChannelAndSubChannel) -> Reservations {
    //        let result = lists.filter { (reservation) -> Bool in
    //            (reservation.channelID == bookingChannel.channel.id) &&
    //            (reservation.subChannelID == bookingChannel.subChannel?.id)
    //        }
    //
    //        return Reservations(lists: result)
    //    }
    //
    //    func filter(bookingChannels: [BookingChannel.ChannelAndSubChannel]) -> Reservations {
    //        let result = lists.filter { (reservation) -> Bool in
    //            bookingChannels
    //                .contains { channelAndSubChannel in
    //                    if let _subSchnnel = channelAndSubChannel.subChannel {
    //                        return (reservation.channelID == channelAndSubChannel.channel.id) &&
    //                        (reservation.subChannelID == _subSchnnel.id)
    //                    }
    //                    return (reservation.channelID == channelAndSubChannel.channel.id)
    //            }
    //        }
    //
    //        return Reservations(lists: result)
    //    }
    
    //    func sortByContactNameAlphabet() -> Self {
    //        let result = lists.sorted { (reservationA, reservationB) -> Bool in
    //            return reservationA.contactInfo.fullName < reservationB.contactInfo.fullName
    //        }
    //        return Reservations(lists: result)
    //    }
    //
    //    func sortByStatus(byStatuses: [Reservation.Status] = [Reservation.Status.checkedIn,
    //                                                          Reservation.Status.booked,
    //                                                          Reservation.Status.confirmed,
    //                                                          Reservation.Status.checkedOut,
    //                                                          Reservation.Status.noShown,
    //                                                          Reservation.Status.canceled]) -> Reservations {
    //        let result: [Reservation] = (byStatuses.map { (status) -> [Reservation] in
    //            filter(byStatus: status).lists
    //        }.reduce([]) { (result, reservationArray) -> [Reservation] in
    //            result + reservationArray
    //        })
    //        return Reservations(lists: result)
    //    }
    //
    //    func sortByTotalCostH2L() -> Self {
    //        let result = lists.sorted { (reservationA, reservationB) -> Bool in
    //            return reservationA.totalCostAmount > reservationB.totalCostAmount
    //        }
    //        return Reservations(lists: result)
    //    }
    //
    //    func sortByTotalCostL2H() -> Self {
    //        let result = lists.sorted { (reservationA, reservationB) -> Bool in
    //            return reservationA.totalCostAmount < reservationB.totalCostAmount
    //        }
    //        return Reservations(lists: result)
    //    }
    //
    //    func sortByTotalPaidH2L() -> Self {
    //        let result = lists.sorted { (reservationA, reservationB) -> Bool in
    //            return reservationA.financeTotalBalance > reservationB.financeTotalBalance
    //        }
    //        return Reservations(lists: result)
    //    }
    //
    //    func sortByTotalPaidL2H() -> Self {
    //        let result = lists.sorted { (reservationA, reservationB) -> Bool in
    //            return reservationA.financeTotalBalance < reservationB.financeTotalBalance
    //        }
    //        return Reservations(lists: result)
    //    }
    //
    //    func sortByRemainH2L() -> Self {
    //        let result = lists.sorted { (reservationA, reservationB) -> Bool in
    //            return reservationA.remainPaymentAmount > reservationB.remainPaymentAmount
    //        }
    //        return Reservations(lists: result)
    //    }
    //
    //    func sortByRemainL2H() -> Self {
    //        let result = lists.sorted { (reservationA, reservationB) -> Bool in
    //            return reservationA.remainPaymentAmount < reservationB.remainPaymentAmount
    //        }
    //        return Reservations(lists: result)
    //    }
    //
    //    func sortByNightCountL2H() -> Self {
    //        let result = lists.sorted { (reservationA, reservationB) -> Bool in
    //            return reservationA.numberOfNight < reservationB.numberOfNight
    //        }
    //        return Reservations(lists: result)
    //    }
    
    
}
