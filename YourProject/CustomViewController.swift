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
    
    lazy var nameLabel: UILabel = {
        let element = UILabel()
        element.text = "Hello world"
        element.textAlignment = .left
        return element
    }()
    
    // add button
    lazy var button: UIButton = {
        let element = UIButton()
        element.setTitle("Click me", for: .normal)
        element.setTitleColor(.black, for: .normal)
        //element.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        let contextMenuInteraction = UIContextMenuInteraction(delegate: self)
        element.addInteraction(contextMenuInteraction)
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        initConstriantLayout()
    }
    
    @objc func buttonTapped() {
        print("Button tapped")
    }
    
    private func initViews() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(nameLabel)
        self.view.addSubview(button)
    }
    
    private func initConstriantLayout() {
        nameLabel.snp.makeConstraints({ make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        })
        
        button.snp.makeConstraints({ make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(40)
        })
    }
}

extension CustomViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        // Provide the menu configuration
        return UIContextMenuConfiguration(identifier: nil,
                                          previewProvider: nil) { _ in
            let action1 = UIAction(title: "Action 1", image: UIImage(systemName: "star")) { _ in
                // Perform action 1
            }
            let action2 = UIAction(title: "Action 2", image: UIImage(systemName: "heart")) { _ in
                // Perform action 2
            }
            return UIMenu(title: "Options", children: [action1, action2])
        }
    }
    
//    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, previewForHighlightingMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
//        let previewParams = UIPreviewParameters()
//        previewParams.backgroundColor = .clear // Or set a custom color
//        let uiview = UIView()
//        uiview.backgroundColor = .brown
//        let previewTarget = UITargetedPreview(view: uiview, parameters: previewParams)
//        return previewTarget
//    }
}
