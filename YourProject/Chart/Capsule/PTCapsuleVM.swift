//
//  PTCapsuleVM.swift
//  YourProject
//
//  Created by IntrodexMac on 24/10/2567 BE.
//
import UIKit

struct PTCapsuleVM {
    let title: String
    let value: String
    let frame: CGRect
    let textColor: UIColor
    let backgroundColor: UIColor
    
    init(title: String,
         value: String,
         frame: CGRect,
         textColor: UIColor,
         backgroundColor: UIColor) {
        self.title = title
        self.value = value
        self.frame = frame
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
}
