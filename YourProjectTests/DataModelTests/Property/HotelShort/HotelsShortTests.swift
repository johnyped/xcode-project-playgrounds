//
//  HotelsShortTests.swift
//  YourProject
//
//  Created by IntrodexMini on 9/5/2568 BE.
//

import Testing
import Foundation

struct HotelsShortTests {
    
    // MARK: - Computed Properties Tests
    
    @Test("Test hotelNames")
    func test_hotelNames() throws {
        // Arrange
        let hotels = createSampleHotels()
        
        // Act & Assert
        assert(hotels.hotelNames == ["Hotel A", "Hotel B", "Hotel C"])
    }
    
    // MARK: - Sorting Tests
    
    @Test("Test sorting by name in ascending order")
    func test_sortByNameAscending() throws {
        // Arrange
        let hotels = createSampleHotels()
        
        // Act
        let sorted = hotels.sortedBy(by: .name, orderBy: .ascending)
        
        // Assert
        assert(sorted.lists.map(\.name) == ["Hotel A", "Hotel B", "Hotel C"])
    }
    
    @Test("Test sorting by name in descending order")
    func test_sortByNameDescending() throws {
        // Arrange
        let hotels = createSampleHotels()
        
        // Act
        let sorted = hotels.sortedBy(by: .name, orderBy: .descending)
        
        // Assert
        assert(sorted.lists.map(\.name) == ["Hotel C", "Hotel B", "Hotel A"])
    }
    
    @Test("Test sorting by ID in ascending order")
    func test_sortByIdAscending() throws {
        // Arrange
        let hotels = createSampleHotels()
        
        // Act
        let sorted = hotels.sortedBy(by: .id, orderBy: .ascending)
        
        // Assert
        assert(sorted.lists.map(\.id) == [1, 2, 3])
    }
    
    @Test("Test sorting by ID in descending order")
    func test_sortByIdDescending() throws {
        // Arrange
        let hotels = createSampleHotels()
        
        // Act
        let sorted = hotels.sortedBy(by: .id, orderBy: .descending)
        
        // Assert
        assert(sorted.lists.map(\.id) == [3, 2, 1])
    }
    
    @Test("Test sorting by creation date in ascending order")
    func test_sortByCreatedAtAscending() throws {
        // Arrange
        let hotels = createSampleHotels()
        
        // Act
        let sorted = hotels.sortedBy(by: .createdAt, orderBy: .ascending)
        
        // Assert
        assert(sorted.lists.map { $0.createdAt.timeIntervalSince1970 } == [1000, 3000, 5000])
    }
    
    @Test("Test sorting by creation date in descending order")
    func test_sortByCreatedAtDescending() throws {
        // Arrange
        let hotels = createSampleHotels()
        
        // Act
        let sorted = hotels.sortedBy(by: .createdAt, orderBy: .descending)
        
        // Assert
        assert(sorted.lists.map { $0.createdAt.timeIntervalSince1970 } == [5000, 3000, 1000])
    }
    
    @Test("Test sorting by update date in ascending order")
    func test_sortByUpdatedAtAscending() throws {
        // Arrange
        let hotels = createSampleHotels()
        
        // Act
        let sorted = hotels.sortedBy(by: .updatedAt, orderBy: .ascending)
        
        // Assert
        assert(sorted.lists.map { $0.updatedAt.timeIntervalSince1970 } == [2000, 4000, 6000])
    }
    
    @Test("Test sorting by update date in descending order")
    func test_sortByUpdatedAtDescending() throws {
        // Arrange
        let hotels = createSampleHotels()
        
        // Act
        let sorted = hotels.sortedBy(by: .updatedAt, orderBy: .descending)
        
        // Assert
        assert(sorted.lists.map { $0.updatedAt.timeIntervalSince1970 } == [6000, 4000, 2000])
    }
    
    // MARK: - Helper Methods
    
    private func createSampleHotels() -> HotelsShort {
        let hotel1 = HotelShort(
            id: 1,
            status: .created,
            name: "Hotel A",
            quote: "Great hotel",
            hotelLogo300: "logo1.jpg",
            headerLogoPhotos: ["header1.jpg"],
            bannerImage: "banner1.jpg",
            logoImage: "logo1.jpg",
            createdAt: Date(timeIntervalSince1970: 1000),
            updatedAt: Date(timeIntervalSince1970: 2000)
        )
        
        let hotel2 = HotelShort(
            id: 2,
            status: .created,
            name: "Hotel B",
            quote: nil,
            hotelLogo300: nil,
            headerLogoPhotos: [],
            bannerImage: nil,
            logoImage: nil,
            createdAt: Date(timeIntervalSince1970: 3000),
            updatedAt: Date(timeIntervalSince1970: 4000)
        )
        
        let hotel3 = HotelShort(
            id: 3,
            status: .created,
            name: "Hotel C",
            quote: "Amazing view",
            hotelLogo300: "logo3.jpg",
            headerLogoPhotos: ["header3.jpg", "header3b.jpg"],
            bannerImage: "banner3.jpg",
            logoImage: "logo3.jpg",
            createdAt: Date(timeIntervalSince1970: 5000),
            updatedAt: Date(timeIntervalSince1970: 6000)
        )
        
        return HotelsShort(array: [hotel1, hotel2, hotel3])
    }
}
