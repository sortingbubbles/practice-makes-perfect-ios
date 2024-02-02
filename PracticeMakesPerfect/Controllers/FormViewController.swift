// FormViewController.swift
import UIKit

protocol FormViewControllerDelegate: AnyObject {
    func formViewControllerDidSubmit(name: String, icon: String)
}

let availableIconNames = ["figure.run", "bicycle", "volleyball", "soccerball", "tennis.racket", "popcorn", "book", "gamecontroller.fill", "character.bubble", "cooktop", "figure.walk"]


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

  
  private let submitButton: UIButton = {
      let button = UIButton(type: .system)
      button.setTitle("Submit", for: .normal)
      button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
      return button
  }()

private let cancelButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Cancel", for: .normal)
  button.tintColor = UIColor.red
    button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    return button
}()


  weak var delegate: FormViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(nameTextField)
        view.addSubview(iconTextField)
        view.addSubview(submitButton)
        view.addSubview(cancelButton)

        nameTextField.translatesAutoresizingMaskIntoConstraints = false
      iconTextField.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 60),
            iconTextField.heightAnchor.constraint(equalToConstant: 60),

            iconTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            iconTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            iconTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            submitButton.topAnchor.constraint(equalTo: iconTextField.bottomAnchor, constant: 40),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cancelButton.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 10),
            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    @objc private func submitButtonTapped() {
          guard let name = nameTextField.text, let icon = iconTextField.text else {
              // Handle invalid input
              return
          }
          delegate?.formViewControllerDidSubmit(name: name, icon: icon)

          dismiss(animated: true, completion: nil)
      }

  @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension FormViewController {
    convenience init(delegate: FormViewControllerDelegate) {
        self.init()
        self.delegate = delegate
    }
}
