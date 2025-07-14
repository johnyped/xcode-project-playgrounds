//
//  PaginatorDataStore.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import Foundation

class PaginatorDataStore<T: Codable> {
    
    // Stored properties
    private(set) var items: [T] = []
    private(set) var currentPage: Int = 0
    private(set) var totalPages: Int = 0
    private(set) var totalItems: Int = 0
    private(set) var perPage: Int = 20
    private(set) var isLoading: Bool = false
    
    // Computed properties
    var hasMorePages: Bool {
        currentPage < totalPages
    }
    
    var nextPage: Int {
        hasMorePages ? currentPage + 1 : currentPage
    }
        
    // Get loading progress
    var progress: Double {
        guard totalItems > 0 else { return 0.0 }
        return Double(items.count) / Double(totalItems)
    }
    
    // Subscribe to updates
    var onUpdate: (() -> Void)?
    
    // Initialize empty store
    init() {}
    
    // Initialize with initial page
    init(with paginator: Paginator<T>) {
        appendPage(paginator)
    }
    
    // Append a new page of data
    func appendPage(_ paginator: Paginator<T>) {
        // Prevent adding same page
        guard paginator.page > currentPage else { return }

        items.append(contentsOf: paginator.items.lists)
        currentPage = paginator.page
        totalPages = paginator.totalPages
        totalItems = paginator.totalItems
        perPage = paginator.perPage
        notifyUpdate()
    }
    
    // Reset store
    func reset() {
        items.removeAll()
        currentPage = 0
        totalPages = 0
        totalItems = 0
        isLoading = false
        notifyUpdate()
    }
    
    // Set loading state
    func setLoading(_ loading: Bool) {
        isLoading = loading
        notifyUpdate()
    }
    
    // Get items for a specific page
    func itemsForPage(_ page: Int) -> [T] {
        let startIndex = (page - 1) * perPage
        let endIndex = min(startIndex + perPage, items.count)
        guard startIndex < items.count else { return [] }
        return Array(items[startIndex..<endIndex])
    }
    
    // Check if we have loaded a specific page
    func hasLoadedPage(_ page: Int) -> Bool {
        let expectedItemCount = page * perPage
        return items.count >= expectedItemCount || items.count == totalItems
    }
    
    // Notify observers of updates
    private func notifyUpdate() {
        onUpdate?()
    }
}

// MARK: - CustomStringConvertible
extension PaginatorDataStore: CustomStringConvertible {
    var description: String {
        """
        PaginatorDataStore:
        - Items: \(items.count)
        - Current Page: \(currentPage)
        - Total Pages: \(totalPages)
        - Total Items: \(totalItems)
        - Per Page: \(perPage)
        - Progress: \(String(format: "%.1f%%", progress * 100))
        - Has More Pages: \(hasMorePages)
        """
    }
}
