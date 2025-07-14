//
//  CustomViewController.swift
//  YourProject
//
//  Created by IntrodexMac on 17/5/2567 BE.
//

import Foundation
import UIKit
import SnapKit

class CustomViewController: UIViewController {
    
//    lazy var nameLabel: UILabel = {
//        let element = UILabel()
//        element.text = "Hello world"
//        element.textAlignment = .left
//        return element
//    }()
    
    //CustomCornerView
    lazy var customCornerView: CustomCornerView = {
        let element = CustomCornerView()
        element.backgroundColor = .red
        element.topLeftRadius = 30
        element.topRightRadius = 30
        element.bottomLeftRadius = 20
        element.bottomRightRadius = 20
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        initConstriantLayout()
    }
    
    
    private func initViews() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(customCornerView)
    }
    
    private func initConstriantLayout() {
        customCornerView.snp.makeConstraints({ make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        })
    }
}

@available(iOS 17, *)
#Preview {
    
    return CustomViewController()
}



class CustomCornerView: UIView {
    
    // Corner radius properties
    var topLeftRadius: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var topRightRadius: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var bottomLeftRadius: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var bottomRightRadius: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let path = UIBezierPath()
        
        // Top-left corner
        path.move(to: CGPoint(x: bounds.minX + topLeftRadius, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX - topRightRadius, y: bounds.minY))
        
        // Top-right corner
        if topRightRadius > 0 {
            path.addArc(withCenter: CGPoint(x: bounds.maxX - topRightRadius, y: bounds.minY + topRightRadius),
                        radius: topRightRadius,
                        startAngle: CGFloat(3 * Double.pi / 2),
                        endAngle: 0,
                        clockwise: true)
        }
        
        // Move to right-bottom corner
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY - bottomRightRadius))
        
        // Bottom-right corner
        if bottomRightRadius > 0 {
            path.addArc(withCenter: CGPoint(x: bounds.maxX - bottomRightRadius, y: bounds.maxY - bottomRightRadius),
                        radius: bottomRightRadius,
                        startAngle: 0,
                        endAngle: CGFloat(Double.pi / 2),
                        clockwise: true)
        }
        
        // Move to bottom-left corner
        path.addLine(to: CGPoint(x: bounds.minX + bottomLeftRadius, y: bounds.maxY))
        
        // Bottom-left corner
        if bottomLeftRadius > 0 {
            path.addArc(withCenter: CGPoint(x: bounds.minX + bottomLeftRadius, y: bounds.maxY - bottomLeftRadius),
                        radius: bottomLeftRadius,
                        startAngle: CGFloat(Double.pi / 2),
                        endAngle: CGFloat(Double.pi),
                        clockwise: true)
        }
        
        // Move to top-left corner
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.minY + topLeftRadius))
        
        // Top-left corner
        if topLeftRadius > 0 {
            path.addArc(withCenter: CGPoint(x: bounds.minX + topLeftRadius, y: bounds.minY + topLeftRadius),
                        radius: topLeftRadius,
                        startAngle: CGFloat(Double.pi),
                        endAngle: CGFloat(3 * Double.pi / 2),
                        clockwise: true)
        }
        
        path.close()
        
        // Apply the path to a CAShapeLayer
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}

// Create and add custom corner view with specific corner radius values
// Create and add custom corner view with specific corner radius values
//       let customView = CustomCornerView(frame: CGRect(x: 50, y: 50, width: 200, height: 200))
//       customView.backgroundColor = .lightGray
//       
//       // Set custom corner radius for each corner
//       customView.topLeftRadius = 30
//       customView.topRightRadius = 30
//       customView.bottomLeftRadius = 10
//       customView.bottomRightRadius = 10
//       
