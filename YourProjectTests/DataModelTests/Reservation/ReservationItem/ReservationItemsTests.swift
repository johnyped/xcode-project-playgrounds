//
//  ReservationItemsTests.swift
//  YourProject
//
//  Created by IntrodexMini on 16/5/2568 BE.
//

import XCTest


final class ReservationItemsTests: XCTestCase {
    
    // MARK: - Helper Methods
    
    private func sampleData() -> ReservationItem.Data {
        return ReservationItem.Data(
            isCustomRate: true,
            selectedRate: 1000.25,
            extraAdultRate: 200.50,
            extraAdultQty: 2,
            extraChildRate: 150.75, 
            extraChildQty: 1,
            mealIncluded: true,
            adultMealLimit: 2,
            adultMealRate: 50.25,
            childMealLimit: 1,
            childMealRate: 30.50,
            extraAdultMealRate: 60.75,
            extraAdultMealQty: 1,
            extraChildMealRate: 40.25,
            extraChildMealQty: 2
        )
    }
    
    private func sampleReservationItem(
        id: Int = 1,
        reservedDate: Date = Date(),
        reservableType: ReservationItem.ReservableType = .room,
        reservableId: Int = 10
    ) throws -> ReservationItem {
        return ReservationItem(
            id: id,
            reservedDate: reservedDate,
            totalPrice: 2000.50,
            reservableType: reservableType,
            reservableId: reservableId,
            data: sampleData(),
            priceCardId: nil,
            createdAt: Date(timeIntervalSince1970: 1000),
            updatedAt: Date(timeIntervalSince1970: 2000)
        )
    }
    
    // MARK: - Computed Properties Tests
    
    func test_grandTotal() throws {
        // Given
        let item1 = try sampleReservationItem(id: 1)
        let item2 = try sampleReservationItem(id: 2)
        let items = ReservationItems(array: [item1, item2])
        
        // When
        let total = items.grandTotal
        
        // Then
        XCTAssertEqual(total, 4001.00) // 2000.50 + 2000.50
    }
    
    func test_selectedRate() throws {
        // Given
        let item1 = try sampleReservationItem(id: 1)
        let item2 = try sampleReservationItem(id: 2)
        let items = ReservationItems(array: [item1, item2])
        
        // When
        let total = items.selectedRate
        
        // Then
        XCTAssertEqual(total, 2000.50) // 1000.25 + 1000.25
    }
    
    func test_extraAdultTotal() throws {
        // Given
        let item1 = try sampleReservationItem(id: 1)
        let item2 = try sampleReservationItem(id: 2)
        let items = ReservationItems(array: [item1, item2])
        
        // When
        let total = items.extraAdultTotal
        
        // Then
        XCTAssertEqual(total, 802.00) // (200.50 * 2) * 2
    }
    
    func test_extraChildTotal() throws {
        // Given
        let item1 = try sampleReservationItem(id: 1)
        let item2 = try sampleReservationItem(id: 2)
        let items = ReservationItems(array: [item1, item2])
        
        // When
        let total = items.extraChildTotal
        
        // Then
        XCTAssertEqual(total, 301.50) // (150.75 * 1) * 2
    }
    
    func test_extraAdultMealTotal() throws {
        // Given
        let item1 = try sampleReservationItem(id: 1)
        let item2 = try sampleReservationItem(id: 2)
        let items = ReservationItems(array: [item1, item2])
        
        // When
        let total = items.extraAdultMealTotal
        
        // Then
        XCTAssertEqual(total, 121.50) // (60.75 * 1) * 2
    }
    
    func test_extraChildMealTotal() throws {
        // Given
        let item1 = try sampleReservationItem(id: 1)
        let item2 = try sampleReservationItem(id: 2)
        let items = ReservationItems(array: [item1, item2])
        
        // When
        let total = items.extraChildMealTotal
        
        // Then
        XCTAssertEqual(total, 161.00) // (40.25 * 2) * 2
    }
    
    func test_roomIDs() throws {
        // Given
        let item1 = try sampleReservationItem(reservableId: 10)
        let item2 = try sampleReservationItem(reservableId: 20)
        let item3 = try sampleReservationItem(reservableId: 10)
        let items = ReservationItems(array: [item1, item2, item3])
        
        // When
        let roomIDs = items.roomIDs
        
        // Then
        XCTAssertEqual(roomIDs, Set([10, 20]))
    }
    
    func test_unitCount() throws {
        // Given
        let item1 = try sampleReservationItem(reservableId: 10)
        let item2 = try sampleReservationItem(reservableId: 20)
        let item3 = try sampleReservationItem(reservableId: 10)
        let items = ReservationItems(array: [item1, item2, item3])
        
        // When
        let count = items.unitCount
        
        // Then
        XCTAssertEqual(count, 2)
    }
    
    func test_maxMealLimit() throws {
        // Given
        let data1 = ReservationItem.Data(
            isCustomRate: true,
            selectedRate: 1000.25,
            extraAdultRate: 0,
            extraAdultQty: 0,
            extraChildRate: 0,
            extraChildQty: 0,
            mealIncluded: true,
            adultMealLimit: 3,
            adultMealRate: 0,
            childMealLimit: 2,
            childMealRate: 0,
            extraAdultMealRate: 0,
            extraAdultMealQty: 0,
            extraChildMealRate: 0,
            extraChildMealQty: 0
        )
        
        let data2 = ReservationItem.Data(
            isCustomRate: true,
            selectedRate: 1000.25,
            extraAdultRate: 0,
            extraAdultQty: 0,
            extraChildRate: 0,
            extraChildQty: 0,
            mealIncluded: true,
            adultMealLimit: 2,
            adultMealRate: 0,
            childMealLimit: 1,
            childMealRate: 0,
            extraAdultMealRate: 0,
            extraAdultMealQty: 0,
            extraChildMealRate: 0,
            extraChildMealQty: 0
        )
        
        let item1 = ReservationItem(
            id: 1,
            reservedDate: Date(),
            totalPrice: 1000.25,
            reservableType: .room,
            reservableId: 10,
            data: data1,
            priceCardId: nil,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        let item2 = ReservationItem(
            id: 2,
            reservedDate: Date(),
            totalPrice: 1000.25,
            reservableType: .room,
            reservableId: 20,
            data: data2,
            priceCardId: nil,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        let items = ReservationItems(array: [item1, item2])
        
        // When
        let maxItem = items.maxMealLimit
        
        // Then
        XCTAssertEqual(maxItem?.id, 2)
    }
    
    func test_mealExist() throws {
        // Given
        let item1 = try sampleReservationItem()
        let items = ReservationItems(array: [item1])
        
        // When/Then
        XCTAssertTrue(items.mealExist)
    }
    
    // MARK: - Sorting Tests
    
    func test_sortedById() throws {
        // Given
        let item1 = try sampleReservationItem(id: 2)
        let item2 = try sampleReservationItem(id: 1)
        let items = ReservationItems(array: [item1, item2])
        
        // When
        let sortedAsc = items.sortedBy(by: .id, orderBy: .ascending)
        let sortedDesc = items.sortedBy(by: .id, orderBy: .descending)
        
        // Then
        XCTAssertEqual(sortedAsc.lists.map { $0.id }, [1, 2])
        XCTAssertEqual(sortedDesc.lists.map { $0.id }, [2, 1])
    }
    
    // MARK: - Filtering Tests
    
    func test_filteredById() throws {
        // Given
        let item1 = try sampleReservationItem(id: 1)
        let item2 = try sampleReservationItem(id: 2)
        let items = ReservationItems(array: [item1, item2])
        
        // When
        let filtered = items.filteredBy(by: .id(id: 1))
        
        // Then
        XCTAssertEqual(filtered.lists.count, 1)
        XCTAssertEqual(filtered.lists.first?.id, 1)
    }
    
    func test_filteredByReservableId() throws {
        // Given
        let item1 = try sampleReservationItem(reservableId: 10)
        let item2 = try sampleReservationItem(reservableId: 20)
        let items = ReservationItems(array: [item1, item2])
        
        // When
        let filtered = items.filteredBy(by: .reservableId(id: 10))
        
        // Then
        XCTAssertEqual(filtered.lists.count, 1)
        XCTAssertEqual(filtered.lists.first?.reservableId, 10)
    }
    
    func test_filteredByReservableType() throws {
        // Given
        let item1 = try sampleReservationItem(reservableType: .room)
        let item2 = try sampleReservationItem(reservableType: .room)
        let items = ReservationItems(array: [item1, item2])
        
        // When
        let filtered = items.filteredBy(by: .reservableType(type: .room))
        
        // Then
        XCTAssertEqual(filtered.lists.count, 2)
        XCTAssertEqual(filtered.lists.first?.reservableType, .room)
    }
}
