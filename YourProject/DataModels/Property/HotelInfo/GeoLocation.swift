//
//  GeoLocation.swift
//  YourProject
//
//  Created by IntrodexMini on 9/5/2568 BE.
//

struct GeoLocation {
    let latitude: Double
    let longtitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longtitude = "longtitude"
    }
    
    enum Location {
        case bangkok
        
        var geoLocation: GeoLocation {
            switch self {
            case .bangkok:
                return GeoLocation(latitude: 13.7245601,
                                   longtitude: 100.4930266)
            }
        }
    }

    init(latitude: Double,
     longtitude: Double) {
        self.latitude = latitude
        self.longtitude = longtitude
    }
}
