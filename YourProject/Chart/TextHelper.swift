//
//  TextSize.swift
//  POCHomeListKit
//
//  Created by daisyfoto on 3/20/20.
//  Copyright © 2020 AVA. All rights reserved.
//

import Foundation
import UIKit

// MARK: - TextHelper

public struct TextHelper {
    /// Get size for single line by pass label style direct
    /// Example want to get signel of `bodyRegular`
    /// You can send Style.Typography.bodyRegular
    /// It will automatic check language en or th


    /// Get size for single line by Specific `language`
    /// Example want to get signel of `bodyRegular` for language `EN`
    /// You can send Style.Typography.bodyRegular.propertiesEN
    static func sizeForSingleLine(fromText text: String,
                                  font: UIFont) -> CGSize {
        let width: CGFloat = .greatestFiniteMagnitude
        let height: CGFloat = .greatestFiniteMagnitude
        let label = UILabel(frame: CGRect(x: 0,
                                          y: 0,
                                          width: width,
                                          height: height))
        label.numberOfLines = 1

        let attributedString = NSMutableAttributedString(string: text)
        let rang = NSRange(location: 0,
                           length: attributedString.length)
        let lineHeight = font.lineHeight

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight

        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: rang)
        attributedString.addAttribute(.font,
                                      value: font,
                                      range: rang)

        label.attributedText = attributedString
        label.sizeToFit()
        let size = label.frame.size.roundedUp

        return size
    }

    static func numberOfLine(fromText text: String,
                             width: CGFloat,
                             typo: UIFont) -> Int {
        let textHeight = TextHelper.height(fromText: text,
                                           fixWidth: width,
                                           typo: typo)
//        return Int((textHeight / typo.properties.lineHeightForSingleLine).rounded(.up))
        let result = (textHeight / typo.lineHeight)
            .rounded()
            .toInt()

        return result
    }

    static func height(fromText text: String,
                       fixWidth width: CGFloat,
                       typo: UIFont) -> CGFloat {
        return height(fromText: text,
                      fixWidth: width,
                      font: typo)
    }

    static func height(fromText text: String,
                       fixWidth width: CGFloat,
                       font: UIFont,
                       insets: UIEdgeInsets = UIEdgeInsets.zero) -> CGFloat {
        let fontLineHeightRatio = 1.0
        let constrainedSize = CGSize(width: width - insets.left - insets.right,
                                     height: CGFloat.greatestFiniteMagnitude)
        let options: NSStringDrawingOptions = [
            .usesFontLeading,
            .usesLineFragmentOrigin,
        ]

        var attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: font,
        ]

        if fontLineHeightRatio != 1 {
            let lineHeight = font.lineHeight
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 0
            paragraphStyle.minimumLineHeight = lineHeight
            paragraphStyle.maximumLineHeight = lineHeight

            attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }

        var bounds = (text as NSString).boundingRect(with: constrainedSize,
                                                     options: options,
                                                     attributes: attributes,
                                                     context: nil)

        bounds.size.width = width
        bounds.size.height = ceil(bounds.height + insets.top + insets.bottom)

        return bounds.height
    }

    // FIXME: Current useing in `RKLineChartRenderer` refactor latter
    public static func textSize(font: UIFont,
                                text: String,
                                width: CGFloat = .greatestFiniteMagnitude,
                                height: CGFloat = .greatestFiniteMagnitude) -> CGSize {
        let label = UILabel(frame: CGRect(x: 0,
                                          y: 0,
                                          width: width,
                                          height: height))
        label.numberOfLines = 0
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.size
    }
}

public extension TextHelper {
    static func truncatingText(_ text: String,
                               ellipsis: String = "... ",
                               moreText: String,
                               maxLines: Int,
                               width: CGFloat,
                               typo: UIFont) -> String {
        guard maxLines > 0 else { return text }

        let numberOfLine = TextHelper.numberOfLine(fromText: text,
                                                   width: width,
                                                   typo: typo)

        guard numberOfLine > maxLines else { return text }

        var truncatedString = text

        var low = text.startIndex
        var high = text.endIndex

        // binary search substring
        while low != high {
            let offset = text.distance(from: low,
                                       to: high) / 2
            let mid = text.index(low,
                                 offsetBy: offset)

            truncatedString = String(text[..<mid])

            let fullText = truncatedString + ellipsis + moreText
            let fullTextNumberOfLine = TextHelper.numberOfLine(fromText: fullText,
                                                               width: width,
                                                               typo: typo)
            if fullTextNumberOfLine <= maxLines {
                low = text.index(after: mid)
            } else {
                high = mid
            }
        }

        // substring further to try and truncate at the end of a word
        var tempString = truncatedString
        var prevLastChar = "a"
        for _ in 0 ..< 15 {
            if let lastChar = tempString.last {
                if (prevLastChar == " " && String(lastChar) != "") || prevLastChar == "." {
                    truncatedString = tempString
                    break
                } else {
                    prevLastChar = String(lastChar)
                    tempString = String(tempString.dropLast())
                }
            } else {
                break
            }
        }
        let result = truncatedString + ellipsis + moreText

        return result
    }
}

//
//// use for calculate dynamic height of font or uilabel
// public extension TextHelper {
//    static func getTruncatingText(originalString: String,
//                                  ellipsis: String = "... ",
//                                  moreText: String,
//                                  maxLines: Int,
//                                  width: CGFloat,
//                                  font: UIFont) -> String {
//        guard
//            maxLines > 0
//        else { return originalString }
//
//        guard
//            numberOfLinesNeeded(forString: originalString,
//                                width: width,
//                                font: font) > maxLines
//        else { return originalString }
//
//        var truncatedString = originalString
//
//        var low = originalString.startIndex
//        var high = originalString.endIndex
//        // binary search substring
//
//        while low != high {
//            let mid = originalString.index(low,
//                                           offsetBy: originalString.distance(from: low,
//                                                                             to: high) / 2)
//            truncatedString = String(originalString[..<mid])
//            if numberOfLinesNeeded(forString: truncatedString + ellipsis + moreText,
//                                   width: width,
//                                   font: font) <= maxLines {
//                low = originalString.index(after: mid)
//            }
//            else {
//                high = mid
//            }
//        }
//
//        // substring further to try and truncate at the end of a word
//        var tempString = truncatedString
//        var prevLastChar = "a"
//        for _ in 0 ..< 15 {
//            if let lastChar = tempString.last {
//                if (prevLastChar == " " && String(lastChar) != "") || prevLastChar == "." {
//                    truncatedString = tempString
//                    break
//                }
//                else {
//                    prevLastChar = String(lastChar)
//                    tempString = String(tempString.dropLast())
//                }
//            }
//            else {
//                break
//            }
//        }
//
//        return truncatedString + ellipsis + moreText
//    }
//
//    static func numberOfLinesNeeded(forString string: String,
//                                    width: CGFloat,
//                                    font: UIFont) -> Int {
//        let oneLineHeight = "A".size(withAttributes: [NSAttributedString.Key.font: font]).height
//        let totalHeight = getHeight(forString: string,
//                                    width: width,
//                                    font: font)
//        let needed = Int(totalHeight / oneLineHeight)
//
//        return needed
//    }
//
//    static func getHeight(forString string: String,
//                          width: CGFloat,
//                          font: UIFont) -> CGFloat {
//        return string.boundingRect(
//            with: CGSize(width: width,
//                         height: CGFloat.greatestFiniteMagnitude),
//            options: [
//                .usesLineFragmentOrigin,
//                .usesFontLeading,
//            ],
//            attributes: [NSAttributedString.Key.font: font],
//            context: nil
//        ).height
//    }
// }

extension CGSize {
    var roundedUp: CGSize {
        return CGSize(width: width.rounded(.up),
                      height: height.rounded(.up))
    }
}

extension CGFloat {
    func toInt() -> Int {
        return Int(self)
    }
}
