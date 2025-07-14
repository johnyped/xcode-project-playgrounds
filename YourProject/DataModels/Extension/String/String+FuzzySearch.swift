//
//  String+FuzzySearch.swift
//  HomemadeStay
//
//  Created by IntrodexMac on 13/7/2565 BE.
//  Copyright © 2565 BE Fire One One Co., Ltd. All rights reserved.
//

import Foundation

extension String {
    
    // Ref https://www.objc.io/blog/2020/08/18/fuzzy-search/
    func fuzzyMatch(_ needle: String) -> Bool {
        if needle.isEmpty { return true }
        var remainder = needle[...]
        for char in self {
            if char == remainder[remainder.startIndex] {
                remainder.removeFirst()
                if remainder.isEmpty { return true }
            }
        }
        return false
    }
    
}

    
