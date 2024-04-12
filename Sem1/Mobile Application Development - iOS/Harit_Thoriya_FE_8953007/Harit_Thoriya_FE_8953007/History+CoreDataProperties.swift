//
//  History+CoreDataProperties.swift
//  Harit_Thoriya_FE_8953007
//
//  Created by thor on 2023-12-09.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var historyId: UUID?
    @NSManaged public var originSource: String?
    @NSManaged public var dateTime: Date?
    @NSManaged public var searchName: String?
    @NSManaged public var result: Result?

}

extension History : Identifiable {

}
