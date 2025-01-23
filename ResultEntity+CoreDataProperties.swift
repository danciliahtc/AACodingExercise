//
//  ResultEntity+CoreDataProperties.swift
//  AACodingExercise
//
//  Created by Dancilia Harmon   on 1/23/25.
//
//

import Foundation
import CoreData


extension ResultEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ResultEntity> {
        return NSFetchRequest<ResultEntity>(entityName: "ResultEntity")
    }

    @NSManaged public var firstURL: String?
    @NSManaged public var text: String?
    @NSManaged public var airline: AirlineEntity?

}

extension ResultEntity : Identifiable {

}
