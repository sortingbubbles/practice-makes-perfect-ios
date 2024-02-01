//
//  Activities.swift
//  practice makes perfect
//
//  Created by Ani Chatsatrian on 1/2/24.
//

import Foundation

class ActivitiesViewModel {
  private var activities: [MyActivity] = [
    MyActivity(name: "cycling", frequency: ActivityFrequency.daily, icon: "bicycle", selectedDates: ["2024-01-01", "2024-02-01"]),
    MyActivity(name:"spanish", frequency: ActivityFrequency.daily, icon: "character.bubble.fill", selectedDates: ["2024-01-01", "2024-02-01"]),
    MyActivity(name:"climbing", frequency: ActivityFrequency.monthly, icon: "figure.climbing", selectedDates: ["2024-01-01", "2024-02-01"])
  ]


  func addActivity(name: String, frequency: ActivityFrequency, icon: String) {
    let newActivity = MyActivity(name: name, frequency: frequency, icon: icon, selectedDates: [])
    activities.append(newActivity)
  }


  func getActivities() -> [MyActivity] {
    return activities
  }


  func getFrequency(for name: String) -> Optional<ActivityFrequency> {
    let filteredActivities = activities.filter { $0.name.lowercased() == name.lowercased() }

    guard let activity = filteredActivities.first else {
      return nil
    }

    return activity.frequency
  }

  func getIcon(for name: String) -> Optional<String> {
    let filteredActivities = activities.filter { $0.name.lowercased() == name.lowercased() }

    guard let activity = filteredActivities.first else {
      return nil
    }

    return activity.icon
  }
}
