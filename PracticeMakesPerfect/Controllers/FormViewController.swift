// FormViewController.swift
import UIKit

protocol FormViewControllerDelegate: AnyObject {
    func formViewControllerDidSubmit(name: String, icon: String)
}


class FormViewController: UIViewController {
    // Form fields
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let iconTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Icon"
        textField.borderStyle = .roundedRect
        return textField
    }()

    // Submit button
  private let submitButton: UIButton = {
      let button = UIButton(type: .system)
      button.setTitle("Submit", for: .normal)
      button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
      return button
  }()

  weak var delegate: FormViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(nameTextField)
        view.addSubview(iconTextField)
        view.addSubview(submitButton)

        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        iconTextField.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            iconTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            iconTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            iconTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            submitButton.topAnchor.constraint(equalTo: iconTextField.bottomAnchor, constant: 40),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func submitButtonTapped() {
          guard let name = nameTextField.text, let icon = iconTextField.text else {
              // Handle invalid input
              return
          }
          delegate?.formViewControllerDidSubmit(name: name, icon: icon)

          // Dismiss the form
          dismiss(animated: true, completion: nil)
      }
}

extension FormViewController {
    convenience init(delegate: FormViewControllerDelegate) {
        self.init()
        self.delegate = delegate
    }
}
