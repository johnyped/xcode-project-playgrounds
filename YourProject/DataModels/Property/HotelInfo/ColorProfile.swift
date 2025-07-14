//
//  ColorProfile.swift
//  YourProject
//
//  Created by IntrodexMini on 9/5/2568 BE.
//

import Foundation

struct ColorProfile: Codable {
    let color: String?
    let backgroundColor: String?
    let fontColor: String?
    
    enum CodingKeys: String, CodingKey {
        case color
        case backgroundColor = "background_color"
        case fontColor = "font_color"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        color = try container.decodeIfPresent(String.self, forKey: .color)
        backgroundColor = try container.decodeIfPresent(String.self, forKey: .backgroundColor)
        fontColor = try container.decodeIfPresent(String.self, forKey: .fontColor)
    }

    init(color: String?,
     backgroundColor: String?,
      fontColor: String?) {
        self.color = color
        self.backgroundColor = backgroundColor
        self.fontColor = fontColor
    }
}
