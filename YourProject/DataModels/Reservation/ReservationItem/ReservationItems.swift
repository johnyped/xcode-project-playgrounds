//
//  ReservationItems.swift
//  YourProject
//
//  Created by IntrodexMini on 12/5/2568 BE.
//
import Foundation

typealias ReservationItems = Collection<ReservationItem>

// MARK: Computed properties
extension ReservationItems {
    
    var grandTotal: Double {        
        lists.map({$0.totalPrice}).reduce(0, +)
    }
    
    var selectedRate: Double {            
        lists.map({$0.selectedRate}).reduce(0, +)
    }
    
    var extraAdultTotal: Double {        
        lists.map({$0.extraAdultTotal}).reduce(0, +)
    }

    var extraChildTotal: Double {
        lists.map({$0.extraChildTotal}).reduce(0, +)
    }
    
    var extraAdultMealTotal: Double {
        lists.map({$0.extraAdultMealTotal}).reduce(0, +)
    }
    
    var extraChildMealTotal: Double {
        lists.map({$0.extraChildMealTotal}).reduce(0, +)
    }
    
    var roomIDs: Set<Int> {
        Set(lists
            .filter { $0.reservableType == .room }
            .map { $0.reservableId })
    }
    
    var unitCount: Int {
        roomIDs.count
    }
    
    var maxMealLimit: ReservationItem? {
        let result = lists.filter({ $0.data.mealIncluded == true }).max {
            $0.data.adultMealLimit > $1.data.adultMealLimit &&
            $0.data.childMealLimit > $1.data.childMealLimit
        }
        return result
    }
    
    var mealExist: Bool {
        lists.contains(where: { $0.data.mealIncluded == true })
    }
}

// MARK: - Functions
extension ReservationItems {
        
    func sortedBy(
        by: ReservationItem.SortBy = .id,
        orderBy: SortOrderBy = .ascending
    ) -> ReservationItems {
        let sorted: [ReservationItem]
        switch by {
        case .id:
            sorted = lists.sorted { orderBy == .ascending ? $0.id < $1.id : $0.id > $1.id }
        case .reservableDate:
            sorted = lists.sorted { orderBy == .ascending ? $0.reservedDate < $1.reservedDate : $0.reservedDate > $1.reservedDate }
        case .createdAt:
            sorted = lists.sorted { orderBy == .ascending ? $0.createdAt < $1.createdAt : $0.createdAt > $1.createdAt }
        case .updatedAt:
            sorted = lists.sorted { orderBy == .ascending ? $0.updatedAt < $1.updatedAt : $0.updatedAt > $1.updatedAt }
        }
        return .init(array: sorted)
    }
    
    func filteredBy(
        by: ReservationItem.FilterBy
    ) -> ReservationItems {
        let filtered: [ReservationItem]
        switch by {
        case .id(let id):
            filtered = lists.filter { $0.id == id }
        case .reservableId(let id):
            filtered = lists.filter { $0.reservableId == id }
        case .reservableType(let type):
            filtered = lists.filter { $0.reservableType == type }
        case .date(let date):
            // date is equal to reservedDate
            filtered = lists.filter { $0.reservedDate.compareDate(with: date) == .orderedSame }
        case .beforeDate(let date):
            // date is before reservedDate
            filtered = lists.filter { $0.reservedDate.compareDate(with: date) == .orderedAscending }
        case .afterDate(let date):
            // date is after reservedDate
            filtered = lists.filter { $0.reservedDate.compareDate(with: date) == .orderedDescending }
        }
        return .init(array: filtered)
    }
    
}
