//
//  Collection.swift
//  YourProject
//
//  Created by IntrodexMini on 26/2/2568 BE.
//

import Foundation

struct Collection<T: Codable>: Codable {
    
    var lists: [T] = []
    var first: T? { return lists.first }
    var count: Int { return lists.count }
    var startIndex: Int { lists.startIndex }    
    var endIndex: Int { lists.endIndex }
    
    subscript(index: Int) -> T { get { return lists[index] } }
    
    init(array: [T] = []) { self.lists = array }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        lists = try container.decode([T].self)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(lists)
    }
    
    func index(after i: Int) -> Int {
        lists.index(after: i)
    }
    
}


