//
//  HotelShorts.swift
//  YourProject
//
//  Created by IntrodexMini on 9/5/2568 BE.
//

//
//  HotelShorts.swift
//  YourProject
//
//  Created by IntrodexMini on 26/2/2568 BE.
//

typealias HotelsShort = Collection<HotelShort>

//MARK: Computed properties
extension HotelsShort {

    var hotelNames: [String] {
        return lists.map { $0.name }
    }

}

//MARK: Additional functions
extension HotelsShort {
    
    func filterBy(
        by: HotelShort.FilterBy
    ) -> HotelsShort {
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
        by: HotelShort.SortBy = .name,
        orderBy: SortOrderBy = .ascending
    ) -> HotelsShort {
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
