//
//  MenuView.swift
//  YourProject
//
//  Created by IntrodexMac on 16/10/2567 BE.
//

import UIKit
import SnapKit

class MenuView: UIView {

    let identifier: String = UUID().uuidString
    
    var didDismiss: (() -> Void)? = nil

    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.distribution = .fillEqually
        view.isUserInteractionEnabled = true
        return view
    }()

    init() {
        super.init(frame: .zero)

        setupView()
        addSubview(stackView)
        setupLayout()
    }

    func setupView() {
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.isUserInteractionEnabled = true
        self.clipsToBounds = true

        // Add shadow properties
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
    }

    func setupLayout() {
        stackView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview().inset(8)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView(
        popupActions: [PopUpMenuAction],
        minSize: CGSize,
        maxSize: CGSize,
        direction: PopUpMenu.PermitDirectiton,
        position: PopUpMenu.Position,
        targetView: UIView,
        rootView: UIView,
        selectedIndex: Int? = nil
    ) {

        for (index, action) in popupActions.enumerated() {
            action.dismiss = { [weak self] in
                self?.didDismiss?()
                self?.removeFromSuperview()  // Dismiss the menu
            }
            let isSelected = (index == selectedIndex)
            let button = action.toButton(style: isSelected ? .selected : .unselected)
            button.snp.makeConstraints(setupButtonConstraint)

            // Set the button as selected if it matches the selectedIndex
            if isSelected {
                button.isSelected = true
                button.backgroundColor = UIColor.systemBlue // Example color for selected state
            }

            stackView.addArrangedSubview(button)
        }

        // Set the position of the menu view
        let targetFrame = targetView.convert(targetView.bounds, to: rootView)

        // Calculate the size of the menu view
        let menuHeight = min(maxSize.height, max(minSize.height, maxSize.height))

        // Use SnapKit to set constraints instead of manually setting the frame
        self.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(minSize.width)  // Set the minimum width of the menuView
            make.width.lessThanOrEqualTo(maxSize.width)  // Set the maximum width of the menuView
            make.height.greaterThanOrEqualTo(minSize.height)  // Set the minimum height of the menuView
            make.height.lessThanOrEqualTo(maxSize.height)  // Set the maximum height of the menuView

            // Calculate the position based on the direction
            switch direction {
            case .up:
                if targetFrame.minY >= menuHeight + 10 {
                    make.bottom.equalTo(targetView.snp.top).offset(-10)  // Position above
                } else {
                    make.top.equalTo(targetView.snp.bottom).offset(10)  // Position below
                }
            case .down:
                if (rootView.bounds.height - targetFrame.maxY) >= menuHeight + 10 {
                    make.top.equalTo(targetView.snp.bottom).offset(10)  // Position below
                } else {
                    make.bottom.equalTo(targetView.snp.top).offset(-10)  // Position above
                }
            }

            // Adjust position based on the Position enum
            switch position {
            case .left:
                make.left.equalTo(targetView.snp.left)  // Align left
            case .right:
                make.right.equalTo(targetView.snp.right)  // Align right
            case .center:
                make.centerX.equalTo(targetView)  // Center horizontally
            }
        }
    }
    
    func setupButtonConstraint(make: ConstraintMaker) {
        make.height.equalTo(44)
    }
}

class MenuViewBackground: UIView {}
