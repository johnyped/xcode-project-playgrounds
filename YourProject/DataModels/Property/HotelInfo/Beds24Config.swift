//
//  Beds24Config.swift
//  YourProject
//
//  Created by IntrodexMini on 9/5/2568 BE.
//

struct Beds24Config: Codable {
    let enabledAutoCancelReservationFromCm: Bool
    
    enum CodingKeys: String, CodingKey {
        case enabledAutoCancelReservationFromCm = "enabled_auto_cancel_reservation_from_cm"
    }

    init(enabledAutoCancelReservationFromCm: Bool) {
        self.enabledAutoCancelReservationFromCm = enabledAutoCancelReservationFromCm
    }
}
