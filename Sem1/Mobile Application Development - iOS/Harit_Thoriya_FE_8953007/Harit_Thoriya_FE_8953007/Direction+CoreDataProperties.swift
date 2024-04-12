//
//  Direction+CoreDataProperties.swift
//  Harit_Thoriya_FE_8953007
//
//  Created by thor on 2023-12-09.
//
//

import Foundation
import CoreData


extension Direction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Direction> {
        return NSFetchRequest<Direction>(entityName: "Direction")
    }

    @NSManaged public var distance: Double
    @NSManaged public var endPoint: String?
    @NSManaged public var startPoint: String?
    @NSManaged public var travelType: String?

}
