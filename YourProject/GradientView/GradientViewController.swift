//
//  GradientViewController.swift
//  RKGradient
//
//  Created by Peerasak Unsakon on 31/5/2567 BE.
//

import UIKit
import SnapKit

class GradientViewController: UIViewController {
    
    private let backgroundView = UIView()
    private let gradientView = UIView()
    private let textLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        demoTextClipping()
    }
    
    func demoTextClipping() {
        // Set up the red background
        view.backgroundColor = .red
        
        // Create the backgroundView
        backgroundView.backgroundColor = .black
        backgroundView.layer.cornerRadius = 30
        backgroundView.clipsToBounds = true
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(100)
        }
        
        // Create the gradient view
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.systemRed.cgColor,
            UIColor.systemBlue.cgColor,
            UIColor.systemTeal.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientView.layer.addSublayer(gradientLayer)
        backgroundView.addSubview(gradientView)
        gradientView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        gradientView.layoutIfNeeded()
        gradientLayer.frame = gradientView.bounds
        
        // Create the mask label
        textLabel.text = "Try search by AI"
        textLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        textLabel.textAlignment = .center
        textLabel.backgroundColor = .clear
        textLabel.textColor = .white
        
        gradientView.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        // Apply the mask to the gradient view
        gradientView.mask = textLabel
    }
    
    func demoMultipleViews() {
        // Define stack view
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        // Add stack view to main view
        view.addSubview(stackView)
        
        // Set stack view constraints using SnapKit
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        let firstView: SKGradientView = {
            let element = SKGradientView()
            element.gradientMode = .right
            element.gradientShape = .oval
            element.gradientRadius = 2.0
            element.gradientAngle = 115.0
            element.gradientWidth = 1
            element.gradientHeight = 2
            element.layer.cornerRadius = 10
            element.layer.masksToBounds = true
            element.layer.borderColor = UIColor.black.cgColor
            element.layer.borderWidth = 1.0
            return element
        }()
        
        let secondView: SKGradientView = {
            let element = SKGradientView()
            element.gradientMode = .center
            element.gradientShape = .circle
            element.gradientRadius = 1.0
            element.layer.cornerRadius = 10
            element.layer.masksToBounds = true
            element.layer.borderColor = UIColor.black.cgColor
            element.layer.borderWidth = 1.0
            return element
        }()
        
        
        stackView.addArrangedSubview(firstView)
        stackView.addArrangedSubview(secondView)
        
        firstView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width).multipliedBy(0.8)
        }
        
        secondView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width).multipliedBy(0.8)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = gradientView.bounds
        }
    }
}

class SKGradientView: UIView {
    
    var gradientMode: SKRadialGradientLayer.GradientCenterPosition = .center
    var gradientRadius: CGFloat = 1.0
    var gradientWidth: CGFloat = 100.0
    var gradientHeight: CGFloat = 100.0
    var gradientShape: SKRadialGradientLayer.GradientShape = .circle
    var gradientAngle: CGFloat = 0.0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupGradient()
    }
    
    private func setupGradient() {
        self.rket.setupGradientBackground(
            position: gradientMode,
            radius: gradientRadius,
            width: gradientWidth,
            height: gradientHeight,
            shape: gradientShape,
            angle: gradientAngle)
    }
}

class MaskingView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMaskingLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupMaskingLayer()
    }

    private func setupMaskingLayer() {
        // Background layer with plain color
        let backgroundLayer = CALayer()
        backgroundLayer.frame = bounds
        backgroundLayer.backgroundColor = UIColor.systemIndigo.cgColor // Replace with your desired color
        layer.addSublayer(backgroundLayer)
        
        // Text layer
        let textLayer = CATextLayer()
        textLayer.frame = bounds
        
        let textString = "Try search by AI"
        let font = UIFont.systemFont(ofSize: 32, weight: .bold) // Replace with your desired font and size
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black // We will use the mask to create transparency
        ]
        
        let attributedString = NSAttributedString(string: textString, attributes: textAttributes)
        textLayer.string = attributedString
        textLayer.isWrapped = true
        textLayer.contentsScale = UIScreen.main.scale
        
        layer.addSublayer(textLayer)
        
        // Mask layer
        let maskLayer = CALayer()
        maskLayer.frame = bounds
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.mask = textLayer
        
        backgroundLayer.addSublayer(maskLayer)
    }
}
