//
//  PTCapsuleView.swift
//  YourProject
//
//  Created by IntrodexMac on 24/10/2567 BE.
//

import SnapKit
import UIKit

class PTCapsuleView: UIView {
    private let leftTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Left"
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()

    private let rightTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "Right"
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private(set) var vm: PTCapsuleVM?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        addSubview(leftTitleLabel)
        addSubview(rightTitleLabel)

        initLayout()
        
        self.layer.cornerRadius = 9
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    func initLayout() {
        leftTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(30)
        }

        rightTitleLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(8)
            make.top.bottom.equalToSuperview()
            make.left.equalTo(leftTitleLabel.snp.right).offset(8)
        }
    }

    func bind(_ vm: PTCapsuleVM) {
        self.vm = vm
        
        leftTitleLabel.text = vm.title
        rightTitleLabel.text = vm.value
        
        backgroundColor = vm.backgroundColor
        leftTitleLabel.textColor = vm.textColor
        rightTitleLabel.textColor = vm.textColor
    }
                  
}
