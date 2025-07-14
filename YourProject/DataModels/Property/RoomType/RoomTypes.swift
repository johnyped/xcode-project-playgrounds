//
//  RoomTypes.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//

typealias RoomTypes = Collection<RoomType>

// MARK: Computed properties
extension RoomTypes {

}

// MARK: - Functions
extension RoomTypes {

    func sortedBy(
        by: RoomType.SortBy = .id,
        orderBy: SortOrderBy = .ascending
    ) -> RoomTypes {
        switch by {
        case .id:
            let result = lists.sorted(by: {
                switch orderBy {
                case .descending:
                    return $0.id > $1.id
                case .ascending:
                    return $0.id < $1.id
                }
            })
            return .init(array: result)
            
        case .name:
            let result = lists.sorted(by: {
                switch orderBy {
                case .descending:
                    return $0.name > $1.name
                case .ascending:
                    return $0.name < $1.name
                }
            })
            return .init(array: result)
            
        case .baseRate:
            let result = lists.sorted(by: {
                switch orderBy {
                case .descending:
                    return $0.baseRate > $1.baseRate
                case .ascending:
                    return $0.baseRate < $1.baseRate
                }
            })
            return .init(array: result)
            
        case .createdAt:
            let result = lists.sorted(by: {
                switch orderBy {
                case .descending:
                    return $0.createdAt > $1.createdAt
                case .ascending:
                    return $0.createdAt < $1.createdAt
                }
            })
            return .init(array: result)
            
        case .updatedAt:
            let result = lists.sorted(by: {
                switch orderBy {
                case .descending:
                    return $0.updatedAt > $1.updatedAt
                case .ascending:
                    return $0.updatedAt < $1.updatedAt
                }
            })
            return .init(array: result)
        }
    }
    
    func filteredBy(
        by: RoomType.FilterBy
    ) -> RoomTypes {
        switch by {
        case .id(let id):
            let result = lists.filter({ $0.id == id })
            return .init(array: result)
            
        case .ids(let ids):
            let result = lists.filter({ ids.contains($0.id) })
            return .init(array: result)
            
//        case .roomStatus(let status):
//            let result = lists.filter({ roomType in
//                let rooms = Rooms(array: []) // Need to implement room relationship
//                return rooms.filteredBy(by: .status(status)).lists.count > 0
//            })
//            return .init(array: result)
        }
    }
    
//    func filter(byID: Int) -> RoomType? {
//        lists.filter({ $0.id == byID }).first
//    }
//    
//    func sorted() -> RoomTypes {
//        let sorted = lists.sorted(by: { $0.name < $1.name })
//        return .init(array: sorted)
//    }
    
//    func roomType(matchUnitID: Int) -> RoomType? {
//        let filtered = lists.filter({
//            $0.rooms.filter(unitIDs: [matchUnitID]).count > 0
//        })
//        return filtered.first
//    }
    
//    func filter(unitIDs: Set<Int>) -> RoomTypes {
//        let filtered = lists.filter({
//            let existUnitIDs = $0.rooms.uniqueIDs
//            return unitIDs.intersection(existUnitIDs).count > 0
//        })
//        return .init(array: filtered)
//    }
    
    // return unitType contain units.count > 0
//    func filter(status: Room.Status) -> RoomTypes {
//        let filtered = lists.filter({
//            let existUnits = $0.rooms.filter(status: status)
//            return existUnits.count > 0
//        })
//        return .init(array: filtered)
//    }


}

