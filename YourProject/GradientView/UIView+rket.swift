//
//  UIView+rket.swift
//  FluidGradient
//
//  Created by Peerasak Unsakon on 31/5/2567 BE.
//

import UIKit

extension UIView {
    var rket: RKET<UIView> {
        return RKET(self)
    }
}

extension RKET where Base: UIView {
    func setupGradientBackground(
        position: SKRadialGradientLayer.GradientCenterPosition = .topRight,
        radius: CGFloat,
        width: CGFloat = 1.0,
        height: CGFloat = 1.0,
        shape: SKRadialGradientLayer.GradientShape = .circle,
        angle: CGFloat = 0.0
    ) {
        // Remove any existing gradient layers
        if let sublayers = base.layer.sublayers {
            for layer in sublayers {
                if let gradientLayer = layer as? SKRadialGradientLayer {
                    gradientLayer.removeFromSuperlayer()
                }
            }
        }
        
        let gradientLayer = SKRadialGradientLayer()
        
        // Define the gradient centers based on mode
        switch position {
        case .center:
            gradientLayer.center = CGPoint(x: base.bounds.midX, y: base.bounds.midY)
        case .topLeft:
            gradientLayer.center = CGPoint(x: base.bounds.minX, y: base.bounds.minY)
        case .topRight:
            gradientLayer.center = CGPoint(x: base.bounds.maxX, y: base.bounds.minY)
        case .bottomLeft:
            gradientLayer.center = CGPoint(x: base.bounds.minX, y: base.bounds.maxY)
        case .bottomRight:
            gradientLayer.center = CGPoint(x: base.bounds.maxX, y: base.bounds.maxY)
        case .top:
            gradientLayer.center = CGPoint(x: base.bounds.midX, y: base.bounds.minY)
        case .bottom:
            gradientLayer.center = CGPoint(x: base.bounds.midX, y: base.bounds.maxY)
        case .left:
            gradientLayer.center = CGPoint(x: base.bounds.minX, y: base.bounds.midY)
        case .right:
            gradientLayer.center = CGPoint(x: base.bounds.maxX, y: base.bounds.midY)
        }
        
        gradientLayer.radius = min(base.bounds.size.width, base.bounds.size.height) * radius
        gradientLayer.frame = base.bounds
        gradientLayer.gradientSize = CGSize(width: width, height: height) // Set the gradient size
        gradientLayer.shape = shape // Set the gradient shape
        gradientLayer.angle = angle // Set the gradient angle
        
        // Define your gradient colors
        gradientLayer.colors = [
            UIColor(red: 0.99, green: 0.88, blue: 0.74, alpha: 1.00).cgColor,
            UIColor(red: 0.97, green: 0.91, blue: 0.99, alpha: 1.00).cgColor,
            UIColor(red: 0.89, green: 0.99, blue: 0.99, alpha: 1.00).cgColor
        ]
        
        base.layer.insertSublayer(gradientLayer, at: 0)
    }
}
