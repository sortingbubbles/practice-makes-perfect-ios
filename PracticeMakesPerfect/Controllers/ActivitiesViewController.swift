//
//  ViewController.swift
//  PracticeMakesPerfect
//
//  Created by Ani Chatsatrian on 1/2/24.
//

import Combine
import UIKit

class ActivitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FormViewControllerDelegate, CalendarDelegate {
  @Published var items: [MyActivity] = [
    MyActivity(name: "cycling", frequency: ActivityFrequency.daily, icon: "bicycle", selectedDates: ["2024-01-01", "2024-02-01"]),
    MyActivity(name:"spanish", frequency: ActivityFrequency.daily, icon: "character.bubble.fill", selectedDates: ["2024-01-01", "2024-02-01"]),
    MyActivity(name:"climbing", frequency: ActivityFrequency.monthly, icon: "figure.climbing", selectedDates: [])
  ]

  private var cancellables: Set<AnyCancellable> = []

  var tableView: UITableView! = UITableView()
  var selectedIndex: Int = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    $items
       .receive(on: DispatchQueue.main)
       .sink { [weak self] _ in
           self?.tableView.reloadData()
       }
       .store(in: &cancellables)
    self.title = "Practice Makes Perfect"
    setup()
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    tableView.delegate = self
    tableView.dataSource = self
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = ActivityTableViewCell(style: .default, reuseIdentifier: ActivityTableViewCell.identifier)

    cell.titleLabel.text = items[indexPath.row].name
    cell.titleLabel.textColor = UIColor.label
    cell.iconImageView.image = UIImage(systemName: items[indexPath.row].icon)
    cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

    return cell

  }
  func tableView(_ tableView: UITableView,
             heightForRowAt indexPath: IndexPath) -> CGFloat {
     // Make the first row larger to accommodate a custom cell.
        return 70



  }



  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedIndex = indexPath.row
    let selectedActivity = items[indexPath.row]

    let calendarViewController = CalendarViewController(activity: selectedActivity)
    calendarViewController.delegate = self
    navigationController?.pushViewController(calendarViewController, animated: true)
  }

 func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
          items.remove(at: indexPath.row)
          tableView.deleteRows(at: [indexPath], with: .fade)
      }
  }



  func formViewControllerDidSubmit(name: String, icon: String) {
    let newItem = MyActivity(name: name, frequency: ActivityFrequency.daily, icon: icon, selectedDates: [])
    items.append(newItem)
    tableView.reloadData()
    dismiss(animated: true, completion: nil)
  }

  func deleteItem(at index: Int) {
      items.remove(at: index)
  }

  @objc func addButtonTapped(sender: UIButton) {
    present(FormViewController(delegate: self), animated: true, completion: nil)
  }

  func didSelectDate(_ date: String) {
    let selectedItem = items[selectedIndex]
    var combinedSelectedDates = selectedItem.selectedDates
    combinedSelectedDates.append(date)
    items[selectedIndex] = MyActivity(name: selectedItem.name, frequency: selectedItem.frequency, icon: selectedItem.icon, selectedDates: combinedSelectedDates)
    print(items)
  }

  func didDeselectDate(_ date: String) {
    let selectedItem = items[selectedIndex]
    let updatedSelectedDates = selectedItem.selectedDates.filter { $0 != date }

    items[selectedIndex] = MyActivity(name: selectedItem.name, frequency: selectedItem.frequency, icon: selectedItem.icon, selectedDates: updatedSelectedDates)

  }
      

  func setup() {
    self.view.backgroundColor = .systemBackground

    let createButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .done, target: self, action: #selector(addButtonTapped(sender:)))
    navigationItem.rightBarButtonItem = createButton

    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor.secondarySystemBackground
    appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
    navigationItem.standardAppearance = appearance
    navigationItem.scrollEdgeAppearance = appearance
    navigationItem.compactAppearance = appearance 


    let buttonAppearance = UIBarButtonItemAppearance()
    buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.label]
    navigationItem.standardAppearance?.buttonAppearance = buttonAppearance
    navigationItem.compactAppearance?.buttonAppearance = buttonAppearance

  }
}

