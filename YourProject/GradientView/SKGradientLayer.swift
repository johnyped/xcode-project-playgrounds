//
//  SKGradientLayer.swift
//  RKGradient
//
//  Created by Peerasak Unsakon on 31/5/2567 BE.
//

import UIKit

class SKRadialGradientLayer: CALayer {

    enum GradientCenterPosition {
        case center, topLeft, topRight, bottomLeft, bottomRight, top, bottom, left, right
    }

    enum GradientShape {
        case circle
        case oval
    }

    var center: CGPoint = .zero
    var radius: CGFloat = 100.0
    var colors: [CGColor] = [
        UIColor(red: 0.99, green: 0.88, blue: 0.74, alpha: 1.00).cgColor,
        UIColor(red: 0.97, green: 0.91, blue: 0.99, alpha: 1.00).cgColor,
        UIColor(red: 0.89, green: 0.99, blue: 0.99, alpha: 1.00).cgColor
    ]
    var gradientSize = CGSize(width: 200, height: 100)
    var shape: GradientShape = .circle
    var angle: CGFloat = 0.0

    override init() {
        super.init()
        needsDisplayOnBoundsChange = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(in ctx: CGContext) {
        ctx.saveGState()

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations: [CGFloat] = [0.0, 0.5, 1.0]

        if let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations) {
            let startCenter = center
            let endCenter = center

            switch shape {
            case .circle:
                ctx.drawRadialGradient(gradient,
                                       startCenter: startCenter, 
                                       startRadius: 0,
                                       endCenter: endCenter, 
                                       endRadius: radius,
                                       options: [.drawsBeforeStartLocation,
                                                 .drawsAfterEndLocation])
            case .oval:
                // Scale context to achieve oval gradient
                ctx.saveGState()
                
                // Calculate scale ratio
                let scaleX = gradientSize.width / gradientSize.height
                let scaleY = 1 / scaleX

                // Translate context
                ctx.translateBy(x: center.x, y: center.y)
                ctx.rotate(by: angle * .pi / 180) // Rotate by angle
                ctx.scaleBy(x: scaleX, y: scaleY)
                ctx.translateBy(x: -center.x, y: -center.y)
                
                // Adjust radius for scaled coordinates
                let scaledRadius = radius / max(scaleX, scaleY)
                
                ctx.drawRadialGradient(gradient,
                                       startCenter: startCenter, 
                                       startRadius: 0,
                                       endCenter: endCenter, 
                                       endRadius: scaledRadius,
                                       options: [.drawsBeforeStartLocation,
                                                 .drawsAfterEndLocation])
                
                // Restore context
                ctx.restoreGState()
            }
        }

        ctx.restoreGState()
    }
}
