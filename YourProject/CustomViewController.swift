//
//  CustomViewController.swift
//  YourProject
//
//  Created by IntrodexMac on 17/5/2567 BE.
//

import Foundation
import SnapKit
import UIKit

class CustomViewController: UIViewController {

    lazy var nameLabel: UILabel = {
        let element = UILabel()
        element.text = "Hello world"
        element.textAlignment = .left
        return element
    }()

    // MARK: Popup Button
    lazy var popUpButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("Menu", for: .normal)
        element.setTitleColor(.white, for: .normal)
        element.backgroundColor = .darkGray
        element.layer.cornerRadius = 5
        element.clipsToBounds = true

        let menu = UIMenu(
            image: nil,
            options: .displayInline,
            children: [
                UIAction(
                    title: "Action 1",
                    image: nil,
                    selectedImage: nil,
                    state: .on,
                    handler: popUpButton1Action),
                UIAction(
                    title: "Action 2Action 2Action 2Action 2Action 2Action 2Action 2Action 2Action 2",
                    image: nil,
                    selectedImage: nil,
                    handler: popUpButton2Action),
            UIAction(
                title: "Action 3",
                image: nil,
                selectedImage: nil,
                handler: popUpButton2Action),
            UIAction(
                title: "Action 4",
                image: nil,
                selectedImage: nil,
                handler: popUpButton2Action),
            UIAction(
                title: "Action 5",
                image: nil,
                selectedImage: nil,
                handler: popUpButton2Action),
            UIAction(
                title: "Action 6",
                image: nil,
                selectedImage: nil,
                handler: popUpButton2Action),
            UIAction(
                title: "Action 7",
                image: nil,
                selectedImage: nil,
                handler: popUpButton2Action),
            UIAction(
                title: "Action 8",
                image: nil,
                selectedImage: nil,
                handler: popUpButton2Action),
            UIAction(
                title: "Action 9",
                image: nil,
                selectedImage: nil,
                handler: popUpButton2Action),
            UIAction(
                title: "Action 10",
                image: nil,
                selectedImage: nil,
                handler: popUpButton2Action),
            UIAction(
                title: "Action 11",
                image: nil,
                selectedImage: nil,
                handler: popUpButton2Action),
            UIAction(
                title: "Action 12",
                image: nil,
                selectedImage: nil,
                handler: popUpButton2Action),
            UIAction(
                title: "Action 13",
                image: nil,
                selectedImage: nil,
                handler: popUpButton2Action),
            UIAction(
                title: "Action 14",
                image: nil,
                selectedImage: nil,
                handler: popUpButton2Action),
            UIAction(
                title: "Action 15",
                image: nil,
                selectedImage: nil,
                handler: popUpButton2Action),
            UIAction(
                title: "Action 16",
                image: nil,
                selectedImage: nil,
                handler: popUpButton2Action),
            UIAction(
                title: "Action 17",
                image: nil,
                selectedImage: nil,
                handler: popUpButton2Action),
            UIAction(
                title: "Action 18",
                image: nil,
                selectedImage: nil,
                handler: popUpButton2Action),
            UIAction(
                title: "Action 19",
                image: nil,
                selectedImage: nil,
                handler: popUpButton2Action),
            UIAction(
                title: "Action 20",
                image: nil,
                selectedImage: nil,
                handler: popUpButton2Action),
            UIAction(
                title: "Action 21",
                image: nil,
                selectedImage: nil,
                handler: popUpButton2Action)
            ])

        element.menu = menu
        element.showsMenuAsPrimaryAction = true
        element.changesSelectionAsPrimaryAction = true

        return element
    }()

    lazy var popUp2Button: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("Menu 2", for: .normal)
        element.setTitleColor(.white, for: .normal)
        element.backgroundColor = .darkGray
        element.layer.cornerRadius = 5
        element.clipsToBounds = true
        //element.addTarget(self, action: #selector(presentCustomMenu(from:)), for: .touchUpInside)
        element.addTarget(self, action: #selector(showMenu(from:)), for: .touchUpInside)
        return element
    }()

    lazy var popUp3Button: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("Menu 3", for: .normal)
        element.setTitleColor(.white, for: .normal)
        element.backgroundColor = .darkGray
        element.layer.cornerRadius = 5
        element.clipsToBounds = true
        element.addTarget(self, action: #selector(toggleDropdown), for: .touchUpInside)
        return element
    }()

    let tableView = UITableView()
    let transparentView = UIView()

    let menus: [String] = ["Menu 1", "Menu 2", "Menu 3", "Menu 4"]
    func addTableView(frames: CGRect) {
        transparentView.backgroundColor = UIColor.clear
        transparentView.frame = self.view.frame
        self.view.addSubview(transparentView)

        tableView.rowHeight = 40
        let tableVeiwHeight = (menus.count > 3) ? 120.0 : CGFloat(menus.count) * tableView.rowHeight
        tableView.frame = CGRect(
            x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width,
            height: tableVeiwHeight)
        self.view.addSubview(tableView)

        tableView.layer.cornerRadius = 5
        tableView.separatorStyle = .none
        tableView.layer.borderColor = UIColor.systemGray5.cgColor
        tableView.layer.borderWidth = 1.0

        tableView.selectRow(
            at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)

        popUp3Button.setTitle(menus[0], for: .normal)

        let tapgesture = UITapGestureRecognizer(
            target: self,
            action: #selector(hideTableView))
        transparentView.addGestureRecognizer(tapgesture)

        tableView.isHidden = true
        transparentView.isHidden = true
    }

    private func showTableView(frames: CGRect) {

        tableView.frame = CGRect(
            x: frames.origin.x,
            y: frames.origin.y + frames.height,
            width: frames.width,
            height: tableView.frame.height)
        tableView.isHidden = false
        transparentView.isHidden = false
    }

    @objc private func hideTableView() {
        tableView.isHidden = true
        transparentView.isHidden = true
    }

    @objc
    func popUpButton1Action(_ sender: UIAction) {
        print("Selected item: popUpButton1Action")
    }

    @objc
    func popUpButton2Action(_ sender: UIAction) {
        print("Selected item: popUpButton2Action")
    }

    //MARK : availabel on iPad
    @objc
    func presentCustomMenu(from button: UIButton) {
        let customMenuVC = MenuViewController(sourceFrame: .zero)
        customMenuVC.modalPresentationStyle = .popover

        if let popoverController = customMenuVC.popoverPresentationController {
            popoverController.sourceView = button
            popoverController.sourceRect = button.bounds
            popoverController.permittedArrowDirections = .up
            popoverController.backgroundColor = UIColor.systemGray6  // Set popover background color
        }

        self.present(customMenuVC, animated: true)
    }

    @objc
    func showMenu(from button: UIButton) {
        let buttonFrame = popUp2Button.frame

        // Pass the button's frame to the custom menu view controller
        let menuVC = MenuViewController(sourceFrame: buttonFrame)
        menuVC.modalPresentationStyle = .overFullScreen  // Present over current context
        menuVC.modalTransitionStyle = .crossDissolve  // Smooth transition

        // Callback to update button title when an item is selected
        menuVC.onSelection = { [weak self] selectedItem in
            self?.popUp2Button.setTitle(selectedItem, for: .normal)
        }

        // Present the custom menu
        present(menuVC, animated: false)
    }

    @objc
    func showTableMenu(from button: UIButton) {

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        initConstriantLayout()

        //setupDropdownButton()
        setupDropdownTableView()
    }

    private func initViews() {
        self.view.backgroundColor = .white

        self.view.addSubview(nameLabel)
        self.view.addSubview(popUpButton)
        self.view.addSubview(popUp2Button)
        self.view.addSubview(popUp3Button)
    }

    private func initConstriantLayout() {
        nameLabel.snp.makeConstraints({ make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        })

        popUpButton.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(100)
            make.width.equalTo(200)
            make.height.equalTo(30)
            make.right.equalToSuperview().offset(-20)
        })

        popUp2Button.snp.makeConstraints({ make in
            make.top.equalTo(popUpButton.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(30)
            make.right.equalToSuperview().offset(-20)
        })

        popUp3Button.snp.makeConstraints({ make in
            make.top.equalTo(popUp2Button.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(30)
            make.right.equalToSuperview().offset(-20)
        })
    }

    // UI Elements
    let dropdownTableView = UITableView()
    let dropdownBGView = UIView()

    // Data
    let options = ["Option 1", "Option 2", "Option 3", "Option 4"]
    var isDropdownOpen = false

    func setupDropdownTableView() {
        // dropdownBGView
        dropdownBGView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleDropdown)))
        dropdownBGView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        dropdownBGView.isHidden = true
        
        view.addSubview(dropdownBGView)
        dropdownBGView.snp.makeConstraints({ make in
            make.top.bottom.left.right.equalToSuperview()
        })
        
        // Register the MenuTableCell with the table view
        dropdownTableView.register(MenuTableCell.self, forCellReuseIdentifier: "MenuTableCell")

        // Configure dropdown table view
        dropdownTableView.delegate = self
        dropdownTableView.dataSource = self
        dropdownTableView.layer.borderWidth = 1
        dropdownTableView.layer.borderColor = UIColor.systemGray.cgColor
        dropdownTableView.layer.cornerRadius = 8
        dropdownTableView.isHidden = true
        dropdownTableView.allowsMultipleSelection = false

        // Layout dropdown table view
        dropdownTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dropdownTableView)

        dropdownTableView.snp.makeConstraints({ make in
            make.top.equalTo(popUp3Button.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.right.equalToSuperview().offset(-20)
        })
             
    }

    @objc func toggleDropdown() {
        isDropdownOpen.toggle()
        
        dropdownTableView.isHidden = !isDropdownOpen
        dropdownBGView.isHidden = !isDropdownOpen
    }

}

// MARK: - UITableViewDelegate and UITableViewDataSource Methods
extension CustomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "MenuTableCell") as? MenuTableCell
            ?? MenuTableCell(style: .default, reuseIdentifier: "MenuTableCell")
        cell.titleLabel.text = options[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOption = options[indexPath.row]
        popUp3Button.setTitle(selectedOption, for: .normal)

        // Toggle the highlight color of the selected cell
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.contentView.backgroundColor = cell.isSelected ? UIColor.lightGray : UIColor.clear
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.toggleDropdown()
        }
    }

    // Optional: Reset cell background color when deselected
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.contentView.backgroundColor = UIColor.clear
        }
    }
}

class MenuTableCell: UITableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView)
        }
    }
}
