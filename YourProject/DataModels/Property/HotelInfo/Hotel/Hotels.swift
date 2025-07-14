//
//  Hotels.swift
//  YourProject
//
//  Created by IntrodexMini on 26/2/2568 BE.
//

typealias Hotels = Collection<Hotel>

//MARK: Computed properties
extension Hotels {   
    
    var hotelNames: [String] {
        return lists.map { $0.name }
    }
      
}

//MARK: Additional functions
extension Hotels {
    
//    func findHotel(byId id: Int) -> Hotel? {
//        return lists.first { $0.id == id }
//    }
//    
//    func findHotels(byStatus status: String) -> [Hotel] {
//        return lists.filter { $0.status == status }
//    }
    
    // Function with multiple parameters
//    func findHotels(withName nameContains: String,
//                    andStatus status: String? = nil) -> [Hotel] {
//        return lists.filter { hotel in
//            let nameMatches = hotel.name.lowercased().contains(nameContains.lowercased())
//            let statusMatches = status == nil ? true : hotel.status == status
//            return nameMatches && statusMatches
//        }
//    }
//    
//    func filterByName(_ name: String) -> Hotels {
//        return Hotels(array: lists.filter({ $0.name == name }))
//    }
    
    func filterBy(
        by: Hotel.FilterBy
    ) -> Hotels {
        switch by {
        case .id(let id):
            let result = lists.filter({
                $0.id == id
            })
            
            return .init(array: result)
            
        case .name(let name):
            let result = lists.filter({
                $0.name.lowercased().contains(name.lowercased())
            })
            
            return .init(array: result)
            
        case .status(let status):
            let result = lists.filter({
                $0.status == status
            })
            
            return .init(array: result)
        }
    }
    
    func sortedBy(
        by: Hotel.SortBy = .name,
        orderBy: SortOrderBy = .ascending
    ) -> Hotels {
        switch by {
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
    
}
