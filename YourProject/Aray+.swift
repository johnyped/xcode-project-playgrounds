//
//  Aray+.swift
//  YourProject
//
//  Created by IntrodexMac on 10/10/2567 BE.
//
import Foundation

extension Array {
    func valueAtIndex<T>(index: Int) -> T? {
        return index >= 0 && index < count ? self[index] as? T : nil
    }
}
