import UIKit
import UIKit

class MenuViewController: UIViewController {

    // Callback to send the selected item back to the main view controller
    var onSelection: ((String) -> Void)?

    // Menu view that will be animated
    private let menuView = UIView()

    // Store the source button's frame to animate from its location
    private var sourceFrame: CGRect?

    // Initializer to pass the button frame from the main view controller
    init(sourceFrame: CGRect) {
        self.sourceFrame = sourceFrame
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up background color with full transparency initially
        view.backgroundColor = UIColor.black.withAlphaComponent(0.0)

        // Set up the menu view
        menuView.backgroundColor = UIColor.systemGray6
        menuView.layer.cornerRadius = 10
        menuView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menuView)

        // Set initial frame of menuView to match the button's frame
        if let sourceFrame = sourceFrame {
            menuView.frame = sourceFrame
        }

        // Add buttons to the menu
        let oneDayButton = createMenuButton(title: "1 Day", action: #selector(oneDaySelected))
        let threeMonthButton = createMenuButton(title: "3 Month", action: #selector(threeMonthSelected))
        let sixMonthButton = createMenuButton(title: "6 Month", action: #selector(sixMonthSelected))

        // Arrange buttons in a vertical stack view
        let stackView = UIStackView(arrangedSubviews: [oneDayButton, threeMonthButton, sixMonthButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        menuView.addSubview(stackView)

        // Set up constraints for the stack view inside the menu
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: menuView.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Animate the menu appearing with the desired spring effect
        animateMenuIn()
    }

    // Helper function to create a menu button
    private func createMenuButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }

    // Actions for buttons
    @objc func oneDaySelected() {
        onSelection?("1 Day")
        animateMenuOut()
    }

    @objc func threeMonthSelected() {
        onSelection?("3 Month")
        animateMenuOut()
    }

    @objc func sixMonthSelected() {
        onSelection?("6 Month")
        animateMenuOut()
    }

    // Animate the menu with an expanding effect
    private func animateMenuIn() {
        // Set initial frame of the menu to match the button's frame
        if let sourceFrame = sourceFrame {
            self.menuView.frame = sourceFrame
        }

        // Define the final size for the expanded menu
        let finalFrame = CGRect(x: (view.frame.width - 200) / 2,
                                y: (view.frame.height - 200) / 2,
                                width: 200,
                                height: 200)

        // Animate the menu expansion from button frame to the final size
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut,
                       animations: {
            self.menuView.frame = finalFrame // Expand to full size
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4) // Fade-in background
        }, completion: nil)
    }

    // Animate the menu with a contracting effect
    private func animateMenuOut() {
        // Animate the menu shrinking back to the button's frame
        UIView.animate(withDuration: 0.3,
                       animations: {
            if let sourceFrame = self.sourceFrame {
                self.menuView.frame = sourceFrame // Shrink back to button size
            }
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0) // Fade-out background
        }, completion: { _ in
            self.dismiss(animated: false)
        })
    }
}
