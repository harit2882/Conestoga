//
//  News+CoreDataProperties.swift
//  Harit_Thoriya_FE_8953007
//
//  Created by thor on 2023-12-09.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var author: String?
    @NSManaged public var discription: String?
    @NSManaged public var source: String?
    @NSManaged public var title: String?

}
