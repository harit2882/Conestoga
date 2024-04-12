//
//  Result+CoreDataProperties.swift
//  Harit_Thoriya_FE_8953007
//
//  Created by thor on 2023-12-09.
//
//

import Foundation
import CoreData


extension Result {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Result> {
        return NSFetchRequest<Result>(entityName: "Result")
    }

    @NSManaged public var resultId: UUID?

}

extension Result : Identifiable {

}
