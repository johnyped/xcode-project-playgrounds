//
//  Rooms.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//

typealias Rooms = Collection<Room>

// MARK: Computed properties
extension Rooms {

    var uniqueIDs: Set<Int> {
        Set(lists.map({ $0.id }))
    }
    
    var codes: [String] {
        lists.map({ $0.code })
    }
    
}

// MARK: - Functions
extension Rooms {
    
    func sortedBy(
        by: Room.SortBy = .order,
        orderBy: SortOrderBy = .ascending
    ) -> Rooms {
        switch by {
        case .code:
            let result = lists.sorted(by: {
                switch orderBy {
                case .descending:
                    return $0.code > $1.code
                case .ascending:
                    return $0.code < $1.code
                }
            })
            return .init(array: result)
            
        case .order:
            let result = lists.sorted(by: {
                switch orderBy {
                case .descending:
                    return $0.order > $1.order
                case .ascending:
                    return $0.order < $1.order
                }
            })
            return .init(array: result)

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
        by: Room.FilterBy
    ) -> Rooms {
        switch by {
        case .id(let id):
            let result = lists.filter({ $0.id == id })
            return .init(array: result)
            
        case .roomTypeId(let id):
            let result = lists.filter({ $0.roomTypeId == id })
            return .init(array: result)
            
        case .status(let status):
            let result = lists.filter({ $0.status == status })
            return .init(array: result)
        }
    }    
            
}
