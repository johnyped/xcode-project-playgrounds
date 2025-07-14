//
//  Untitled.swift
//  YourProject
//
//  Created by IntrodexMac on 21/10/2567 BE.
//

import DGCharts
import Foundation
import UIKit

// MARK: - RKLineChartRenderer

class RKLineChartRenderer: LineChartRenderer {
    internal var _xBounds = XBounds() // Reusable XBounds object
    private(set) var maxPrice: Double?
    private(set) var minPirce: Double?

    convenience init(dataProvider: LineChartDataProvider,
                     animator: Animator,
                     viewPortHandler: ViewPortHandler,
                     maxPrice: Double?,
                     minPrice: Double?) {
        self.init(dataProvider: dataProvider,
                  animator: animator,
                  viewPortHandler: viewPortHandler)
        self.minPirce = minPrice
        self.maxPrice = maxPrice
    }

    override func drawValues(context: CGContext) {
        guard
            let dataProvider = dataProvider,
            let lineData = dataProvider.lineData
        else { return }

        if isDrawingValuesAllowed(dataProvider: dataProvider) {
            let phaseY = animator.phaseY

            var pt = CGPoint()

            for i in lineData.indices {
                guard let
                    dataSet = lineData[i] as? LineChartDataSetProtocol
                else { continue }

                let valueFont = dataSet.valueFont

                let formatter = dataSet.valueFormatter

                let angleRadians = 0.0

                let trans = dataProvider.getTransformer(forAxis: dataSet.axisDependency)
                let valueToPixelMatrix = trans.valueToPixelMatrix

                let iconsOffset = dataSet.iconsOffset

                // make sure the values do not interfear with the circles
                var valOffset = Int(dataSet.circleRadius * 1.75)

                if !dataSet.isDrawCirclesEnabled {
                    valOffset = valOffset / 2
                }

                _xBounds.set(chart: dataProvider, dataSet: dataSet, animator: animator)

                for j in _xBounds {
                    guard let e = dataSet.entryForIndex(j) else { break }

                    pt.x = CGFloat(e.x)
                    pt.y = CGFloat(e.y * phaseY)
                    pt = pt.applying(valueToPixelMatrix)

                    if !viewPortHandler.isInBoundsRight(pt.x) {
                        break
                    }

                    if !viewPortHandler.isInBoundsLeft(pt.x) || !viewPortHandler.isInBoundsY(pt.y) {
                        continue
                    }

                    guard dataSet.isDrawIconsEnabled else { continue }
                    guard let icon = e.icon else { continue }

                    /// Draw icon
                    var iconCenterPoint = CGPoint(x: pt.x + iconsOffset.x,
                                                  y: pt.y + iconsOffset.y)

                    /// find icon y position
                    if e.y == maxPrice {
                        iconCenterPoint.y += -12
                    } else if e.y == minPirce {
                        iconCenterPoint.y += 12
                    }

                    /// find icon x postion
                    let iconPadding: CGFloat = 6
                    iconCenterPoint.x = min(viewPortHandler.contentWidth - icon.size.width / 2 - iconPadding,
                                            max(iconCenterPoint.x, icon.size.width / 2 + iconPadding))

                    context.drawImage(icon,
                                      atCenter: iconCenterPoint,
                                      size: icon.size)
                    /// End Draw icon

                    /// Draw text
                    let textSpace: CGFloat = 4
                    var textPoint = CGPoint(x: iconCenterPoint.x + icon.size.width + textSpace,
                                            y: iconCenterPoint.y - valueFont.lineHeight / 2)

//                    var textPoint = CGPoint(x: iconCenterPoint.x + icon.size.width + textSpace,
//                                            y: iconCenterPoint
//                                                .y - (Styles.Typography.textRegular.properties.lineHeightForSingleLine / 2))
                    let text = formatter.stringForValue(e.y,
                                                        entry: e,
                                                        dataSetIndex: i,
                                                        viewPortHandler: viewPortHandler)
                    let isCanDrawTextInRightSideOfIcon = isText(text,
                                                                InBoundsRightOfX: textPoint.x,
                                                                viewPortHandler: viewPortHandler,
                                                                iconCenterPoint: iconCenterPoint,
                                                                font: valueFont)

                    /// mark text in left side of icon if right space not enough
                    if !isCanDrawTextInRightSideOfIcon {
                        textPoint.x = iconCenterPoint.x - icon.size.width - textSpace
                    }

                    context.drawText(text,
                                     at: textPoint,
                                     align: isCanDrawTextInRightSideOfIcon ? .left : .right,
                                     angleRadians: angleRadians,
                                     attributes: [
                                         .font: valueFont,
                                         .foregroundColor: dataSet.valueTextColorAt(j),
                                     ])

                    /// Draw border
                    let padding: CGFloat = 8
                    let borderHeight: CGFloat = 16
                    let widthPadding: CGFloat = 18
                    let textWidth = text.size(withAttributes: [.font: valueFont]).width
                    let borderRect: CGRect

                    if isCanDrawTextInRightSideOfIcon {
                        borderRect = CGRect(x: iconCenterPoint.x - padding,
                                            y: iconCenterPoint.y - borderHeight / 2,
                                            width: icon.size.width + textWidth + widthPadding,
                                            height: borderHeight)
                    } else {
                        borderRect = CGRect(x: iconCenterPoint.x - padding - icon.size.width - textWidth - 2,
                                            y: iconCenterPoint.y - borderHeight / 2,
                                            width: icon.size.width + textWidth + widthPadding,
                                            height: borderHeight)
                    }

                    context.setLineWidth(1)
                    context.setStrokeColor(UIColor.gray.cgColor)
                    let borderPath = UIBezierPath(roundedRect: borderRect, cornerRadius: 9)
                    context.addPath(borderPath.cgPath)
                    context.strokePath()
                    /// End Draw border
                }
            }
        }
    }
}

private extension RKLineChartRenderer {
    func isText(_ text: String,
                InBoundsRightOfX x: CGFloat,
                viewPortHandler: ViewPortHandler,
                iconCenterPoint: CGPoint,
                font: NSUIFont) -> Bool {
        let x = floor(x * 100.0) / 100.0
        let textSize = TextHelper.textSize(font: font,
                                           text: text)
        let result = (viewPortHandler.contentRect.origin.x + viewPortHandler.contentRect.size.width - x) > (textSize.width + 10)
        // .,., let result = (iconCenterPoint.x + viewPortHandler.contentRect.size.width - x) > (textSize.width + 10)

        return result
    }
}
