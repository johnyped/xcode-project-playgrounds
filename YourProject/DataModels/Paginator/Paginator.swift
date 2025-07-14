//
//  Paginator.swift
//  YourProject
//
//  Created by IntrodexMini on 6/5/2568 BE.
//

import Foundation

struct Paginator<T: Codable>: Codable {
    let items: Collection<T>
    let totalItems: Int
    let totalPages: Int
    let perPage: Int
    let page: Int

    enum CodingKeys: String,
        CodingKey
    {
        case items
        case totalItems = "total_items"
        case totalPages = "total_pages"
        case perPage = "per_page"
        case page
    }

    init(
        items: Collection<T>,
        totalItems: Int,
        totalPages: Int,
        perPage: Int,
        page: Int
    ) {
        self.items = items
        self.totalItems = totalItems
        self.totalPages = totalPages
        self.perPage = perPage
        self.page = page
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let itemArray = try container.decode(
            [T].self,
            forKey: .items
        )
        self.items = Collection(array: itemArray)
        self.totalItems = try container.decode(
            Int.self,
            forKey: .totalItems
        )
        self.totalPages = try container.decode(
            Int.self,
            forKey: .totalPages
        )
        self.perPage = try container.decode(
            Int.self,
            forKey: .perPage
        )
        self.page = try container.decode(
            Int.self,
            forKey: .page
        )
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(
            items.lists,
            forKey: .items
        )
        try container.encode(
            totalItems,
            forKey: .totalItems
        )
        try container.encode(
            totalPages,
            forKey: .totalPages
        )
        try container.encode(
            perPage,
            forKey: .perPage
        )
        try container.encode(
            page,
            forKey: .page
        )
    }
}

/* JSON Example
{
    "items": [

    ],
    "total_items": 26,
    "total_pages": 2,
    "per_page": 20,
    "page": 1
}
*/