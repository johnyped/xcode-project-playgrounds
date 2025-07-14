//
//  PopUpMenu.swift
//  YourProject
//
//  Created by IntrodexMac on 16/10/2567 BE.
//

import UIKit

class PopUpMenu {
    
    private var rootView: UIView
    private var actions: [PopUpMenuAction] = []
        
    var didDismiss: (() -> Void)? = nil
    
    var menuView: MenuView? // Updated to use MenuView
    var selectedIndex: Int?
    
    var dismissOnTapOutside: Bool = true {
        didSet {
            placeHolderView.isUserInteractionEnabled = dismissOnTapOutside
        }
    }
    
    lazy var placeHolderView: MenuViewBackground = {
        let elment = MenuViewBackground()
        elment.backgroundColor = .gray
        elment.alpha = 0.5
        
        let tapToDismissGesture = UITapGestureRecognizer(target: self,
                                                     action: #selector(handleTapOutside))
        elment.addGestureRecognizer(tapToDismissGesture)
        elment.isUserInteractionEnabled = true
        return elment
    }()
    
    init(rootView: UIView) {
        self.rootView = rootView
    }

    func present(targetView: UIView,
                 minSize: CGSize = .zero,
                 maxSize: CGSize = .init(width: 1000,
                                         height: 1000),
                 direction: PermitDirectiton = .up,
                 position: Position = .right,
                 actions: [PopUpMenuAction],
                 selectedIndex: Int? = nil) {

        let identifiers = actions.map { $0.identifier }
        let uniqueIdentifiers = Set(identifiers)
        
        if identifiers.count != uniqueIdentifiers.count {
            fatalError("Duplicate identifiers found in actions.")
        }
        
        removePreviousMenu()

        self.actions = actions

        menuView = MenuView()
        menuView?.didDismiss = { [weak self] in
            self?.dismissMenu()
        }
        
        guard let menuView = menuView else { return }
        
        rootView.addSubview(placeHolderView)
        rootView.bringSubviewToFront(targetView)
        rootView.addSubview(menuView)
        
        placeHolderView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        menuView.setupView(popupActions: actions,
                           minSize: minSize,
                           maxSize: maxSize,
                           direction: direction,
                           position: position,
                           targetView: targetView,
                           rootView: rootView,
                           selectedIndex: selectedIndex)
    }
    
    func removePreviousMenu() {
        rootView.subviews.forEach { subview in
            if subview is MenuView {
                subview.snp.removeConstraints()
                subview.removeFromSuperview()
            }
            if subview is MenuViewBackground {
                subview.snp.removeConstraints()
                subview.removeFromSuperview()
            }
        }
    }
    
    @objc
    func handleTapOutside(_ sender: UITapGestureRecognizer) {
        print("Tap outside detected")
        dismissMenu()
    }
    
    func dismissMenu() {
        menuView?.snp.removeConstraints()
        menuView?.removeFromSuperview()
        
        placeHolderView.snp.removeConstraints()
        placeHolderView.removeFromSuperview()
        
        didDismiss?()
    }
    

}

extension PopUpMenu {
    enum PermitDirectiton {
        case up
        case down
    }

    // Frame position when present with related to this config
    enum Position {
        case left // present on align same left on targetView
        case right // present on align same right on targetView
        case center // present on align center on targetView
    }
}
