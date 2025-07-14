//
//  PopUpAction.swift
//  YourProject
//
//  Created by IntrodexMac on 16/10/2567 BE.
//


import UIKit

// MARK: - RKDialogAction

struct PopUpMenuActionStyle {
    let normalTextColor: UIColor
    let highlightedTextColor: UIColor
    let disabledTextColor: UIColor
    
    let normalBackgroundColor: UIColor
    let highlightedBackgroundColor: UIColor
    let disabledBackgroundColor: UIColor
    
    let normalFont: UIFont
    let highlightedFont: UIFont
    let disabledFont: UIFont

    static let unselected = PopUpMenuActionStyle(normalTextColor: .black,
                                                 highlightedTextColor: .white,
                                                 disabledTextColor: .gray,
                                                 normalBackgroundColor: .white,
                                                 highlightedBackgroundColor: .black,
                                                 disabledBackgroundColor: .gray,
                                                 normalFont: .systemFont(ofSize: 16),
                                                 highlightedFont: .systemFont(ofSize: 16),
                                                 disabledFont: .systemFont(ofSize: 16))
    
    static let selected = PopUpMenuActionStyle(normalTextColor: .white,
                                               highlightedTextColor: .black,
                                               disabledTextColor: .gray,
                                               normalBackgroundColor: .black,
                                               highlightedBackgroundColor: .white,
                                               disabledBackgroundColor: .gray,
                                               normalFont: .systemFont(ofSize: 16),
                                               highlightedFont: .systemFont(ofSize: 16),
                                               disabledFont: .systemFont(ofSize: 16))
}


public class PopUpMenuAction {
    
    var identifier: String
    var title: String
    var closure: ((_ identifier: String) -> Void)?
    var autoDismissWhenTakeAction: Bool = true
    var accessibilityIdentifier: String?
    var dismiss: (() -> Void)?

    init(identifier: String,
         title: String,
         autoDismissWhenTakeAction: Bool = true,
         accessibilityIdentifier: String? = nil,
         closure: ((_ identifier: String) -> Void)?,
         dismiss: (() -> Void)? = nil) {
        self.identifier = identifier
        self.title = title
        self.autoDismissWhenTakeAction = autoDismissWhenTakeAction
        self.closure = closure
        self.accessibilityIdentifier = accessibilityIdentifier
        self.dismiss = dismiss
    }
    
    deinit {
        print("PopUpMenuAction deinit")
    }

    @objc
    func takeAction() {
        if let closure = closure {
            closure(identifier)
        }
        
        if autoDismissWhenTakeAction {
            if let dismiss = dismiss {
                dismiss()
            }
        }
    }
    
    func toButton(style: PopUpMenuActionStyle) -> UIButton {
        let element = UIButton()
        element.setTitle(title, for: .normal)
        
        element.addTarget(self,
                          action: #selector(takeAction),
                          for: .touchUpInside)
        element.accessibilityIdentifier = accessibilityIdentifier
        
        element.setTitleColor(style.highlightedTextColor, for: .highlighted)
        element.setTitleColor(style.disabledTextColor, for: .disabled)
        element.setTitleColor(style.normalTextColor, for: .normal)
                
        switch element.state {
        case .highlighted:
            element.backgroundColor = style.highlightedBackgroundColor
        case .selected:
            element.backgroundColor = style.highlightedBackgroundColor
        case .disabled:
            element.backgroundColor = style.disabledBackgroundColor
        default:
            element.backgroundColor = style.normalBackgroundColor
        }
        
        element.backgroundColor = .white
        element.isEnabled = true
        
        return element
    }
    
}
