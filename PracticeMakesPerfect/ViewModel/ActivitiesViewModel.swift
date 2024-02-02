//
//  Activities.swift
//  practice makes perfect
//
//  Created by Ani Chatsatrian on 1/2/24.
//

import Foundation

class ActivitiesViewModel {
  private var activities: [Activity] = [
    Activity(
      name: "cycling",
      icon: "bicycle",
      selectedDates: ["2024-01-06", "2024-02-01"]
    ),
    Activity(name:"climbing",
      icon: "figure.climbing",
      selectedDates: ["2024-01-07", "2024-02-02"]
    )
  ]


  func addActivity(name: String, icon: String) {
    let newActivity = Activity(name: name, icon: icon, selectedDates: [])
    activities.append(newActivity)
  }


  func getActivities() -> [Activity] {
    return activities
  }

  func getIcon(for name: String) -> Optional<String> {
    let filteredActivities = activities.filter { $0.name.lowercased() == name.lowercased() }

    guard let activity = filteredActivities.first else {
      return nil
    }

    return activity.icon
  }
}
