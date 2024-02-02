// FormViewController.swift
import UIKit

protocol FormViewControllerDelegate: AnyObject {
  func formViewControllerDidSubmit(name: String, icon: String)
}

let availableIconNames = ["figure.run", "volleyball", "soccerball", "tennis.racket", "popcorn", "book", "gamecontroller.fill", "character.bubble", "cooktop", "figure.walk"]

class FormViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  var selectedIcon = availableIconNames.first

  private let nameTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Activity"
    textField.borderStyle = .roundedRect
    return textField
  }()

  let pickerView: UIPickerView = {
      let pickerView = UIPickerView()
      return pickerView
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

  private let headerLabel: UILabel = {
    let label = UILabel()
    label.text = "Add an activity"
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.textAlignment = .center
    return label
  }()

  weak var delegate: FormViewControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = "Your Header Title"
    view.backgroundColor = UIColor.systemBackground

    pickerView.delegate = self
    pickerView.dataSource = self
    view.addSubview(headerLabel)
    view.addSubview(nameTextField)
    view.addSubview(pickerView)
    view.addSubview(submitButton)
    view.addSubview(cancelButton)

    headerLabel.translatesAutoresizingMaskIntoConstraints = false
    nameTextField.translatesAutoresizingMaskIntoConstraints = false
    pickerView.translatesAutoresizingMaskIntoConstraints = false
    submitButton.translatesAutoresizingMaskIntoConstraints = false
    cancelButton.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
      headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      nameTextField.heightAnchor.constraint(equalToConstant: 60),
      nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      nameTextField.topAnchor.constraint(equalTo: headerLabel.topAnchor, constant: 60),
      nameTextField.widthAnchor.constraint(equalToConstant: 250),
      pickerView.heightAnchor.constraint(equalToConstant: 80),
      pickerView.leadingAnchor.constraint(equalTo: nameTextField.trailingAnchor, constant: 8),
      pickerView.centerYAnchor.constraint(equalTo: nameTextField.centerYAnchor),
      pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      cancelButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 40),
      cancelButton.rightAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
      submitButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 40),
      submitButton.leftAnchor.constraint(equalTo:view.rightAnchor, constant: -80),
    ])
  }

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    availableIconNames.count
  }

  func pickerView(
      _ pickerView: UIPickerView,
      rowHeightForComponent component: Int
  ) -> CGFloat {
    return 60
  }

  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
      let customView = UIView()

      let imageView = UIImageView()
      imageView.image = UIImage(systemName: availableIconNames[row])
      imageView.translatesAutoresizingMaskIntoConstraints = false
      customView.addSubview(imageView)

      NSLayoutConstraint.activate([
          imageView.centerXAnchor.constraint(equalTo: customView.centerXAnchor),
          imageView.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
          imageView.widthAnchor.constraint(equalToConstant: 40),
          imageView.heightAnchor.constraint(equalToConstant: 40),
      ])

      return customView
  }


  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return availableIconNames[row]
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let selectedOption = availableIconNames[row]
    selectedIcon = selectedOption
  }

  @objc private func submitButtonTapped() {
    guard let name = nameTextField.text, let icon = selectedIcon else {
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
