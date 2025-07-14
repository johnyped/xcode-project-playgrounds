//
//  PaginatorDataStoreTest.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import XCTest

final class PaginatorDataStoreTests: XCTestCase {
    
    // MARK: - Test Properties
    var sut: PaginatorDataStore<TestModel>!
    
    // MARK: - Setup and Teardown
    override func setUp() {
        super.setUp()
        sut = PaginatorDataStore()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test Models
    struct TestModel: Codable, Equatable {
        let id: Int
        let name: String
    }
    
    // MARK: - Helper Methods
    private func createTestPaginator(
        page: Int,
        totalPages: Int,
        itemsPerPage: Int = 2,
        totalItems: Int = 6
    ) -> Paginator<TestModel> {
        let startId = (page - 1) * itemsPerPage + 1
        let items = (startId...(startId + itemsPerPage - 1)).map { id in
            TestModel(id: id, name: "Item \(id)")
        }
        return Paginator(
            items: Collection(array: items),
            totalItems: totalItems,
            totalPages: totalPages,
            perPage: itemsPerPage,
            page: page
        )
    }
    
    // MARK: - Initialization Tests
    func testInitEmpty() {
        XCTAssertEqual(sut.items.count, 0)
        XCTAssertEqual(sut.currentPage, 0)
        XCTAssertEqual(sut.totalPages, 0)
        XCTAssertEqual(sut.totalItems, 0)
        XCTAssertEqual(sut.perPage, 20)
        XCTAssertFalse(sut.isLoading)
    }
    
    func testInitWithPaginator() {
        // Given
        let paginator = createTestPaginator(page: 1, totalPages: 3)
        
        // When
        sut = PaginatorDataStore(with: paginator)
        
        // Then
        XCTAssertEqual(sut.items.count, 2)
        XCTAssertEqual(sut.currentPage, 1)
        XCTAssertEqual(sut.totalPages, 3)
        XCTAssertEqual(sut.perPage, 2)
        XCTAssertTrue(sut.hasMorePages)
    }
    
    // MARK: - Append Page Tests
    func testAppendPage() {
        // Given
        let firstPage = createTestPaginator(page: 1, totalPages: 3)
        let secondPage = createTestPaginator(page: 2, totalPages: 3)
        
        // When
        sut.appendPage(firstPage)
        sut.appendPage(secondPage)
        
        // Then
        XCTAssertEqual(sut.items.count, 4)
        XCTAssertEqual(sut.currentPage, 2)
        XCTAssertTrue(sut.hasMorePages)
    }
    
    func testAppendSamePageIsIgnored() {
        // Given
        let page = createTestPaginator(page: 1, totalPages: 3)
        
        // When
        sut.appendPage(page)
        sut.appendPage(page) // Try to append same page again
        
        // Then
        XCTAssertEqual(sut.items.count, 2) // Should still have only first page items
        XCTAssertEqual(sut.currentPage, 1)
    }
    
    // MARK: - Page Management Tests
    func testHasMorePages() {
        // Given
        let lastPage = createTestPaginator(page: 3, totalPages: 3)
        
        // When
        sut.appendPage(lastPage)
        
        // Then
        XCTAssertFalse(sut.hasMorePages)
        XCTAssertEqual(sut.nextPage, 3) // Should stay at current page
    }
    
    func testItemsForPage() {
        // Given
        let firstPage = createTestPaginator(page: 1, totalPages: 2)
        let secondPage = createTestPaginator(page: 2, totalPages: 2)
        
        // When
        sut.appendPage(firstPage)
        sut.appendPage(secondPage)
        
        // Then
        let page1Items = sut.itemsForPage(1)
        let page2Items = sut.itemsForPage(2)
        
        XCTAssertEqual(page1Items.count, 2)
        XCTAssertEqual(page1Items[0].id, 1)
        XCTAssertEqual(page2Items[0].id, 3)
    }
    
    // MARK: - Progress Tests
    func testProgress() {
        // Given
        let firstPage = createTestPaginator(page: 1, totalPages: 3, totalItems: 6)
        
        // When
        sut.appendPage(firstPage)
        
        // Then
        XCTAssertEqual(sut.progress, 2.0/6.0) // 2 items out of 6 total
    }
    
    // MARK: - Reset Tests
    func testReset() {
        // Given
        let page = createTestPaginator(page: 1, totalPages: 3)
        sut.appendPage(page)
        
        // When
        sut.reset()
        
        // Then
        XCTAssertEqual(sut.items.count, 0)
        XCTAssertEqual(sut.currentPage, 0)
        XCTAssertEqual(sut.totalPages, 0)
        XCTAssertEqual(sut.totalItems, 0)
        XCTAssertFalse(sut.isLoading)
    }
    
    // MARK: - Loading State Tests
    func testLoadingState() {
        // Given & When
        sut.setLoading(true)
        
        // Then
        XCTAssertTrue(sut.isLoading)
        
        // When
        sut.setLoading(false)
        
        // Then
        XCTAssertFalse(sut.isLoading)
    }
    
    // MARK: - Observer Tests
    func testUpdateCallback() {
        // Given
        var updateCount = 0
        sut.onUpdate = { updateCount += 1 }
        
        // When
        sut.setLoading(true)
        sut.appendPage(createTestPaginator(page: 1, totalPages: 2))
        sut.reset()
        
        // Then
        XCTAssertEqual(updateCount, 3) // Loading + Append + Reset
    }
}
