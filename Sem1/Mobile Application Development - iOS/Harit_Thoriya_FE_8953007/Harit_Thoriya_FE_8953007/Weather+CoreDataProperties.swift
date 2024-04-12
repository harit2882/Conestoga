//
//  Weather+CoreDataProperties.swift
//  Harit_Thoriya_FE_8953007
//
//  Created by thor on 2023-12-09.
//
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var humidity: Int16
    @NSManaged public var temprature: Double
    @NSManaged public var weatherType: String?
    @NSManaged public var wind: Double

}
