//
//  GuestProfile.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import Foundation

struct GuestProfile: Codable {
    let info: Guest
    let company: Company?
    let reservationStatistic: ReservationStatistic
    
    enum CodingKeys: String, CodingKey {
        case info
        case company
        case reservationStatistic = "reservation_statistic"
    }
}

struct ReservationStatistic: Codable {
    let years: [YearStatistic]
}

struct YearStatistic: Codable {
    let year: String
    let reservationCount: Int
    let nightCount: Int
    let totalCheckedInNight: Int
    let minCheckInReservedNight: Int
    let maxCheckInReservedNight: Int
    let months: [MonthStatistic]
    
    enum CodingKeys: String, CodingKey {
        case year
        case reservationCount = "reservation_count"
        case nightCount = "night_count"
        case totalCheckedInNight = "total_checked_in_night"
        case minCheckInReservedNight = "min_check_in_reserved_night"
        case maxCheckInReservedNight = "max_check_in_reserved_night"
        case months
    }
}

struct MonthStatistic: Codable {
    let month: String
    let reservedNightCount: ReservedNightCount
    
    enum CodingKeys: String, CodingKey {
        case month
        case reservedNightCount = "reserved_night_count"
    }
}

struct ReservedNightCount: Codable {
    let cancelled: Int
    let checkedIn: Int
    let checkedOut: Int
    
    enum CodingKeys: String, CodingKey {
        case cancelled
        case checkedIn = "checked_in"
        case checkedOut = "checked_out"
    }
}

/*
 json response
 {
     "info": {
         "id": 264,
         "title": null,
         "first_name": "abcd",
         "middle_name": null,
         "last_name": "dop",
         "nationality": "AFG",
         "date_of_birth": "2019-11-28",
         "id_card_no": "",
         "passport_no": "A12345678",
         "gender": "Male",
         "occupation": null,
         "email": "",
         "phone": "",
         "address": null,
         "district": null,
         "province": null,
         "country": "AFG",
         "zip_code": null,
         "note": null,
         "nickname": null,
         "photos": [],
         "document_photos": [],
         "hidden": false,
         "created_at": "2019-11-28T13:51:15.556+07:00",
         "updated_at": "2020-07-15T07:09:03.912+07:00",
         "hotel_id": 105,
         "company_id": null,
         "images": []
     },
     "company": null,
     "reservation_statistic": {
         "years": [
             {
                 "year": "2019",
                 "reservation_count": 1,
                 "night_count": 3,
                 "total_checked_in_night": 3,
                 "min_check_in_reserved_night": 1,
                 "max_check_in_reserved_night": 1,
                 "months": [
                     {
                         "month": "11/2019",
                         "reserved_night_count": {
                             "cancelled": 0,
                             "checked_in": 0,
                             "checked_out": 3,
                             "no_showed": 0,
                             "created": 0,
                             "total": 3
                         },
                         "check_in_reservation_count": 1
                     }
                 ]
             },
             {
                 "year": "2020",
                 "reservation_count": 0,
                 "night_count": 0,
                 "total_checked_in_night": 0,
                 "min_check_in_reserved_night": null,
                 "max_check_in_reserved_night": null,
                 "months": []
             },
             {
                 "year": "2021",
                 "reservation_count": 1,
                 "night_count": 4,
                 "total_checked_in_night": 4,
                 "min_check_in_reserved_night": 2,
                 "max_check_in_reserved_night": 2,
                 "months": [
                     {
                         "month": "03/2021",
                         "reserved_night_count": {
                             "cancelled": 0,
                             "checked_in": 0,
                             "checked_out": 4,
                             "no_showed": 0,
                             "created": 0,
                             "total": 4
                         },
                         "check_in_reservation_count": 1
                     }
                 ]
             }
         ]
     },
     "related_reservations": [
         {
             "year": "2019",
             "months": [
                 {
                     "month": "11/2019",
                     "reservations": [
                         {
                             "id": 512,
                             "uid": "rsvt_5la15znqpb30lz5rmqj",
                             "status": "checked_out",
                             "check_in_date": "2019-11-28",
                             "check_out_date": "2019-12-01",
                             "adult_number": 1,
                             "extra_adult_number": 0,
                             "child_number": 0,
                             "contacts": {
                                 "title": null,
                                 "fullname": "abc",
                                 "email": "avc@email.com",
                                 "tel": "1234567890"
                             },
                             "note": "test",
                             "canceled_reason": null,
                             "document_photos": null,
                             "ota_booking_id": "",
                             "related_reservation_id": null,
                             "data": {
                                 "addition_services": "[\n\n]",
                                 "finance_records": "[\n  {\n    \"note\" : \"\",\n    \"name\" : \"CHECK-OUT PAYMENT\",\n    \"amount\" : 1500,\n    \"timestamp\" : \"28 Nov 2019 13:51\",\n    \"method\" : \"Bank Transfer\"\n  }\n]"
                             },
                             "guest_comment": null,
                             "markers": [],
                             "flags": [],
                             "tags": [],
                             "emoji": null,
                             "checked_in_at": "2019-11-28T13:51:22.214+07:00",
                             "checked_out_at": "2020-08-27T21:58:06.587+07:00",
                             "canceled_at": null,
                             "no_showed_at": null,
                             "created_at": "2019-11-28T13:43:02.888+07:00",
                             "updated_at": "2020-08-27T21:58:06.595+07:00",
                             "hotel_channel_reservation_id": null,
                             "confirmation_info": {
                                 "created_at": null,
                                 "remark": null,
                                 "url": null
                             },
                             "hotel_id": 105,
                             "creator_id": 38,
                             "channel_id": 9,
                             "sub_channel_id": null
                         }
                     ]
                 }
             ]
         },
         {
             "year": "2020",
             "months": []
         },
         {
             "year": "2021",
             "months": [
                 {
                     "month": "03/2021",
                     "reservations": [
                         {
                             "id": 832,
                             "uid": "rsvt_5n72igyck74o3g5rk00",
                             "status": "checked_out",
                             "check_in_date": "2021-03-16",
                             "check_out_date": "2021-03-18",
                             "adult_number": 1,
                             "extra_adult_number": 0,
                             "child_number": 0,
                             "contacts": {
                                 "title": null,
                                 "fullname": "abcd dop",
                                 "email": "",
                                 "tel": ""
                             },
                             "note": "",
                             "canceled_reason": null,
                             "document_photos": null,
                             "ota_booking_id": null,
                             "related_reservation_id": null,
                             "data": null,
                             "guest_comment": "",
                             "markers": null,
                             "flags": null,
                             "tags": [],
                             "emoji": null,
                             "checked_in_at": "2021-03-16T14:23:48.419+07:00",
                             "checked_out_at": "2021-03-16T14:24:09.904+07:00",
                             "canceled_at": null,
                             "no_showed_at": null,
                             "created_at": "2021-03-16T14:09:46.382+07:00",
                             "updated_at": "2021-03-16T14:24:09.918+07:00",
                             "hotel_channel_reservation_id": null,
                             "confirmation_info": {
                                 "created_at": null,
                                 "remark": null,
                                 "url": null
                             },
                             "hotel_id": 105,
                             "creator_id": 38,
                             "channel_id": 10,
                             "sub_channel_id": null
                         }
                     ]
                 }
             ]
         }
     ]
 }
 */
