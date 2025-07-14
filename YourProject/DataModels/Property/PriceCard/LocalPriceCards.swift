//
//  LocalPriceCards.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//
import Foundation

typealias LocalPriceCards = Collection<LocalPriceCard>

// MARK: Computed properties
extension LocalPriceCards {

}

// MARK: - Functions
extension LocalPriceCards {
    func filter(id: Int) -> LocalPriceCard? {
        lists.first(where: { $0.id == id })
    }
    
    func filter(onDate: Date) -> Self {
        let result = lists.filter({ $0.isAvailable(onDate: onDate) })
        return .init(array: result)
    }
    
    func filter(active: Bool,
                date: Date = .init()) -> Self {
        let result = lists.filter({ $0.isExpried(date: date) == !active })
        return .init(array: result)
    }
    
    func filter(status: LocalPriceCard.Status,
                date: Date = .init()) -> Self {
        let result = lists.filter({ $0.status(date: date) == status })
        return .init(array: result)
    }
    
    func filter(channelID: Int,
                subChannelID: Int? = nil) -> Self {
        let result = lists.filter({
            guard $0.availableChannels.count > 0 else { return false }
            
            return $0.availableChannels.contains(where: {
                if let subChannelID {
                    return $0.channelID == channelID &&
                        $0.subChannelID == subChannelID
                }
                return $0.channelID == channelID
            })
        })
                        
        return .init(array: result)
    }
    
    func filter(period: PeriodDate) -> Self {
        let result: [LocalPriceCard] = lists.compactMap { pc in
            
            // check available at all period date
            let numberOfNight = period.numberOfNight
            let eachDateResult: [Bool] = (0..<numberOfNight).map { day in
                let date = period.start.goNext(days: day)
                return pc.isAvailable(onDate: date)
            }
            
            // expect all eachDateResult is true
            let isAvailable = eachDateResult.reduce(true, { $0 && $1 })
            if isAvailable {
                return pc
            }
            
            return nil
        }
        
        return .init(array: Array(result))
    }
    
    func filter(reservableKind: LocalPriceCard.ReservableKind,
                reservableTypeID: Int) -> Self {
        let result = lists.filter({
            ($0.reservableType == reservableKind) &&
            ($0.reservableTypeId == reservableTypeID)
        })
        return .init(array: result)
    }
    
//    func filter(unitType: UnitTypeProtocol) -> Self {
//        switch unitType {
//        case let unitType as RoomUnitType:
//            return self.filter(reservableKind: .roomType,
//                               reservableTypeID: unitType.id)
//        case let unitType as BedUnitType:
//            return self.filter(reservableKind: .bedType,
//                               reservableTypeID: unitType.id)
//        default:
//            return self
//        }
//    }
    
    func sorted(active: Bool) -> Self {
        let activeLists = filter(active: true).lists
        let expriedLists = filter(active: false).lists
        
        let activeFirstLists = activeLists + expriedLists
        let expriedFirstLists = expriedLists + activeLists
        
        let newList = active ? activeFirstLists : expriedFirstLists
        return .init(array: newList)
    }
    
    func sortedByTitle() -> Self {
        let sorted = lists.sorted(by: { $0.title < $1.title })
        return .init(array: sorted)
    }
    
    func sortedByTotalPrice() -> Self {
        let sorted = lists.sorted(by: { $0.totalPrice < $1.totalPrice })
        return .init(array: sorted)
    }
    
    func insert(newPriceCard: LocalPriceCard) -> Self {
        // checkis not exist in list
        let isExist = lists.contains(where: { $0.id == newPriceCard.id })
        guard !isExist else { return self }
        
        var newLists = lists
        newLists.append(newPriceCard)
        return .init(array: newLists)
    }
    
    func replace(updatePriceCard: LocalPriceCard) -> Self {
        // check is not exist in list then will insert
        let isExist = lists.contains(where: { $0.id == updatePriceCard.id })
        guard isExist else { return insert(newPriceCard: updatePriceCard) }
        
        //replace
        let newLists = lists.map({
            ($0.id == updatePriceCard.id) ? updatePriceCard : $0
        })
        return .init(array: newLists)
    }
    
    func remove(priceCardID: Int) -> Self {
        let newLists = lists.filter({ $0.id != priceCardID })
        return .init(array: newLists)
    }
}


