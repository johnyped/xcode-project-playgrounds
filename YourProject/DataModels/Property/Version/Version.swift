//
//  Version.swift
//  HomemadeStay
//
//  Created by IntrodexMac on 27/10/2566 BE.
//  Copyright © 2566 BE Fire One One Co., Ltd. All rights reserved.
//

import Foundation

// Ex. 1.1.2 => major.minor.build
struct Version {
    
    static let _1_0_0: Version = .init(major: 1, minor: 0, build: 0)
    
    let majorNumber: Int
    let minorNumber: Int
    let buildNumber: Int
    
    var raw: String {
        "\(majorNumber).\(minorNumber).\(buildNumber)"
    }
    
    var minimiumrRaw: String {
        var text = "\(majorNumber)"
        if minorNumber != 0 {
            text += ".\(minorNumber)"
        }
        
        if buildNumber != 0 {
            text += ".\(buildNumber)"
        }
                
        return text
    }
    
    // input "1.2.3"
    init?(string: String) {
        let result = string.split(separator: ".")
        if result.count <= 0 || result.count > 3 { return nil }
        
        if result.count >= 1 {
            let numberString = String(result[0])
            if let number = Int(numberString) {
                majorNumber = (number >= 1) ? number : 1
            }
            else {
                majorNumber = 1
            }
        }
        else {
            majorNumber = 1
        }
        
        if result.count >= 2 {
            let numberString = String(result[1])
            if let number = Int(numberString) {
                minorNumber = number
            }
            else {
                minorNumber = 0
            }
        }
        else {
            minorNumber = 0
        }
        
        if result.count >= 3 {
            let numberString = String(result[2])
            if let number = Int(numberString) {
                buildNumber = number
            }
            else {
                buildNumber = 0
            }
        }
        else {
            buildNumber = 0
        }
        
    }
    
    init(major: Int,
         minor: Int,
         build: Int) {
        self.majorNumber = (major >= 1) ? major : 1
        self.minorNumber = (minor >= 0) ? minor : 0
        self.buildNumber = (build >= 0) ? build : 0
    }
    
    func isEqualOrHigherThen(version: Version) -> Bool {
        if majorNumber > version.majorNumber {
            return true
        }
        else if majorNumber < version.majorNumber {
            return false
        }
        
        // case majorNumber equal majorNumber
        if minorNumber > version.minorNumber {
            return true
        }
        else if minorNumber < version.minorNumber {
            return false
        }
        
        // case minorNumber equal minorNumber
        if buildNumber >= version.buildNumber {
            return true
        }
        else if buildNumber < version.buildNumber {
            return false
        }
        
        return false
    }
}

extension Version: Comparable {
    public static func < (lhs: Version, rhs: Version) -> Bool {
        if lhs.majorNumber < rhs.majorNumber {
            return true
        } else if lhs.majorNumber > rhs.majorNumber {
            return false
        }
        
        // At this point, major numbers are equal
        if lhs.minorNumber < rhs.minorNumber {
            return true
        } else if lhs.minorNumber > rhs.minorNumber {
            return false
        }
        
        // At this point, major and minor numbers are equal
        if lhs.buildNumber < rhs.buildNumber {
            return true
        } else if lhs.buildNumber > rhs.buildNumber {
            return false
        }
        
        // All components are equal
        return false
    }
}
