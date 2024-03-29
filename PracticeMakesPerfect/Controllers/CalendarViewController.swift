//
//  ViewController.swift
//  practice makes perfect
//
//  Created by Ani Chatsatrian on 1/2/24.
//

import UIKit

protocol CalendarDelegate: AnyObject {
  func didSelectDate(_ date: String)
  func didDeselectDate(_ date: String)
}

class CalendarViewController: UIViewController, UICalendarViewDelegate {
  weak var delegate: CalendarDelegate?
  private let activity: Activity
  var calendarView: UICalendarView = {
    let myCalendar = UICalendarView()
    myCalendar.calendar = Calendar(identifier: .gregorian)
    return myCalendar
  }()

  init(activity: Activity) {
    self.activity = activity
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = activity.name

    calendarView.delegate = self
    setupCalendarView()
    setupCalendarData()
  }

  func setupCalendarView() {
    view.addSubview(calendarView)
    calendarView.translatesAutoresizingMaskIntoConstraints = false
    calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    calendarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
    calendarView.heightAnchor.constraint(equalToConstant: 500).isActive = true
  }

  func setupCalendarData() {
    let multiDaySelection  = UICalendarSelectionMultiDate(delegate: self)
    multiDaySelection.selectedDates = parseSelectedDates()
    calendarView.selectionBehavior = multiDaySelection
    calendarView.fontDesign = .rounded
    view.backgroundColor = UIColor.systemBackground
    calendarView.tintColor = UIColor.tintColor
  }

  
  func parseSelectedDates() -> [DateComponents] {
    var dateComponents: [DateComponents] = []
    let selectedDates = activity.selectedDates

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"

    for dateString in selectedDates {
      if let date = dateFormatter.date(from: dateString) {
        let components = Calendar(identifier: .gregorian).dateComponents([.year, .month, .day], from: date)
        dateComponents.append(components)
      }
    }

    return dateComponents
  }

}

func transformDateComponent(dateComponents: DateComponents) -> String {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd"

  if let date = dateComponents.date {
    return dateFormatter.string(from: date)
  } else {
    return ""
  }
}

extension CalendarViewController: UICalendarSelectionMultiDateDelegate {
  func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
    delegate?.didSelectDate(transformDateComponent(dateComponents: dateComponents))
  }

  func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
    delegate?.didDeselectDate(transformDateComponent(dateComponents: dateComponents))
  }

  func multiDateSelection(_ selection: UICalendarSelectionMultiDate, canSelectDate dateComponents: DateComponents) -> Bool {
    let currentDate = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    if let providedDate = Calendar.current.date(from: dateComponents),
        providedDate <= Calendar.current.date(from: currentDate)! {
        return true
    }
    return false
  }

  func containsSameDate(dateComponentsArray: [DateComponents], targetDateComponents: DateComponents) -> Bool {
      guard let targetYear = targetDateComponents.year,
            let targetMonth = targetDateComponents.month,
            let targetDay = targetDateComponents.day else {
          return false
      }

      return dateComponentsArray.contains { parsedDateComponents in
          guard let parsedYear = parsedDateComponents.year,
                let parsedMonth = parsedDateComponents.month,
                let parsedDay = parsedDateComponents.day else {
              return false
          }

          return parsedYear == targetYear && parsedMonth == targetMonth && parsedDay == targetDay
      }
  }
}
