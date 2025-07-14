//
//  OHLC.swift
//  YourProject
//
//  Created by IntrodexMac on 22/10/2567 BE.
//

import Foundation

struct OHLC {
    let open: Double
    let high: Double
    let low: Double
    let close: Double
    let volume: Double
    let date: Date
}

extension OHLC {
    enum Stub {
        
        
        
        // create 10 random data
        static var simple1: [OHLC] {
            (0 ..< 10).map { index in
                OHLC(open: Double.random(in: 100 ... 200),
                     high: Double.random(in: 200 ... 300),
                     low: Double.random(in: 50 ... 100),
                     close: Double.random(in: 100 ... 200),
                     volume: Double.random(in: 1000 ... 5000),
                     date: Date().addingTimeInterval(Double(index) * 86400)) // 86400 seconds in a day
            }
        }

        static var simple2: [OHLC] {
            (0 ..< 10).map { index in
                OHLC(open: Double.random(in: 100 ... 200),
                     high: Double.random(in: 200 ... 300),
                     low: Double.random(in: 50 ... 100),
                     close: Double.random(in: 100 ... 200),
                     volume: Double.random(in: 1000 ... 5000),
                     date: Date().addingTimeInterval(Double(index) * 86400)) // 86400 seconds in a day
            }
        }
    }
}
