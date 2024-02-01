//
//  Activity+CoreDataProperties.swift
//  PracticeMakesPerfect
//
//  Created by Ani Chatsatrian on 1/2/24.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var name: String?
    @NSManaged public var icon: String?

}

extension Activity : Identifiable {

}
