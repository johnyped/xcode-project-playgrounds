//
//  CustomViewController.swift
//  YourProject
//
//  Created by IntrodexMac on 17/5/2567 BE.
//

import Foundation
import UIKit
import SnapKit
import FloatingPanel

class CustomViewController: UIViewController, UIScrollViewDelegate {
    
    // contentVC to insert in FloatingPanel
    let contentVC = ContentViewController()
    
    lazy var fpc: FloatingPanelController = {
        let element = FloatingPanelController()
        
        // enable tap background Backdrop to dismiss panel
        element.backdropView.backgroundColor = .clear
        element.backdropView.dismissalTapGestureRecognizer.isEnabled = true

        element.delegate = self // optional
        element.layout = MyFloatingPanelLayout()
        element.behavior = CustomPanelBehavior()
        element.contentMode = .fitToBounds // make contentView scalable
        
        // make surfaceView top left-right round cornor
        element.surfaceView.backgroundColor = .brown
        element.surfaceView.layer.cornerRadius = 20
        element.surfaceView.clipsToBounds = true
        element.surfaceView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        // set grabberHandleView color
        let grabberViewColor = UIColor.from(hex: "#3C3C43").withAlphaComponent(0.3)
        element.surfaceView.grabberHandle.backgroundColor = grabberViewColor
        
        // init contentVC
        element.set(contentViewController: contentVC)
        
        element.trackingScrollView?.delegate = self

        return element
    }()
    
    lazy var nameLabel: UILabel = {
        let element = UILabel()
        element.text = "Hello world"
        element.textAlignment = .left
        return element
    }()
    
    lazy var showButton: UIButton = {
        let element = UIButton(type: .custom)
        element.setTitle("Show Panel",
                         for: .normal)
        element.setTitleColor(.white,
                              for: .normal)
        element.backgroundColor = .darkGray
        element.isEnabled = true
        element.addTarget(self,
                          action: #selector(showPanelVC),
                          for: .touchUpInside)
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        initConstriantLayout()
    }
        
    @objc
    func showPanelVC() {
        self.present(fpc,
                     animated: true,
                     completion: nil)
        
        // another call method
        //fpc.addPanel(toParent: self)
    }
    
    @objc
    func dismissPanel() {
        fpc.dismiss(animated: true,
                    completion: nil)
    }
    
    private func initViews() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(nameLabel)
        self.view.addSubview(showButton)
    }
    
    private func initConstriantLayout() {
        nameLabel.snp.makeConstraints({ make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        })
        
        showButton.snp.makeConstraints { make in
            make.centerX.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(100)
            make.height.equalTo(44)
        }
    }
    
}

extension CustomViewController: FloatingPanelControllerDelegate {

    // prevent to scroll bouncing over frame
    func floatingPanelDidMove(_ vc: FloatingPanelController) {
        if vc.isAttracting == false {
            let loc = vc.surfaceLocation
            let minY = vc.surfaceLocation(for: .full).y - 6.0
            let maxY = vc.surfaceLocation(for: .half).y + 6.0
            vc.surfaceLocation = CGPoint(x: loc.x, y: min(max(loc.y, minY), maxY))
        }
    }
    
    // enable / disable for draging
//    func floatingPanelShouldBeginDragging(_ vc: FloatingPanelController) -> Bool {
//        return aCondition ?  false : true
//    }
    
}

extension UIColor {
    static func from(hex: String) -> UIColor {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if cString.count != 6 {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

class MyFloatingPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half
    let anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [
        .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0,
                                        edge: .top,
                                         referenceGuide: .safeArea),
        .half: FloatingPanelLayoutAnchor(fractionalInset: 0.4,
                                         edge: .top,
                                         referenceGuide: .safeArea),
    ]
    
    // return 1 to make backdrop visible to touch
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        1
    }

}

class CustomPanelBehavior: FloatingPanelBehavior {
    func shouldProjectMomentum(_ fpc: FloatingPanelController, to proposedState: FloatingPanelState) -> Bool {
        return true
    }

    func interactionAnimator(_ fpc: FloatingPanelController, to targetState: FloatingPanelState, with velocity: CGPoint) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: 0.25, dampingRatio: 1.0) // Adjust dampingRatio as needed
    }
    
    func removalInteractionAnimator(_ fpc: FloatingPanelController, with velocity: CGPoint) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: 0.25, dampingRatio: 1.0) // Adjust dampingRatio as needed
    }
}

class ContentViewController: UIViewController {
    
    //header view
    lazy var headerView: UIView = {
        let element = UIView()
        //show broder
        element.layer.borderWidth = 1
        element.layer.borderColor = UIColor.red.cgColor
        //element.backgroundColor = .yellow
        return element
    }()
    
    //content view
    lazy var contentView: UIView = {
        let element = UIView()
        element.layer.borderWidth = 1
        element.layer.borderColor = UIColor.red.cgColor
        //element.backgroundColor = .green
        return element
    }()
    
    //closeButton
    lazy var closeButton: UIButton = {
        let element = UIButton(type: .custom)
        element.setTitle("Close",
                         for: .normal)
        element.setTitleColor(.white,
                              for: .normal)
        //element.backgroundColor = .darkGray
        element.isEnabled = true
        element.addTarget(self,
                          action: #selector(closePanelVC),
                          for: .touchUpInside)
        return element
    }()
    
    lazy var footerLabel: UILabel = {
        let element = UILabel()
        element.text = "Footer Label"
        element.textAlignment = .center
        element.layer.borderWidth = 1
        element.layer.borderColor = UIColor.red.cgColor
        return element
    }()
    
    private let gradientView = UIView()
    
    @objc
    func closePanelVC() {
        self.dismiss(animated: true,
                     completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initGAView()
        
        initViews()
        initConstriantLayout()
    }
    
    func initGAView() {
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
        //backgroundView.addSubview(gradientView)
        self.view.addSubview(gradientView)
        gradientView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        gradientView.layoutIfNeeded()
        gradientLayer.frame = gradientView.bounds
        
        if let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = gradientView.bounds
        }
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // ignore for re-rendering
//        if let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer {
//            gradientLayer.frame = gradientView.bounds
//        }
    }
    
    private func initViews() {
        self.view.backgroundColor = .white
        self.view.clipsToBounds = true
        self.view.layer.cornerRadius = 20
        self.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
                
        headerView.addSubview(closeButton)
        
        self.view.addSubview(headerView)
        self.view.addSubview(contentView)
        self.view.addSubview(footerLabel)
    }
    
    private func initConstriantLayout() {
        
        closeButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(20)
            make.height.equalToSuperview()
        }
        
        headerView.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(44)
        })
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(footerLabel.snp.top)
        }
        
        footerLabel.snp.makeConstraints({ make in
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        })
        
    }
}


