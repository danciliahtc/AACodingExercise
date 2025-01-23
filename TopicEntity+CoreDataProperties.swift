//
//  TopicEntity+CoreDataProperties.swift
//  AACodingExercise
//
//  Created by Dancilia Harmon   on 1/23/25.
//
//

import Foundation
import CoreData


extension TopicEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopicEntity> {
        return NSFetchRequest<TopicEntity>(entityName: "TopicEntity")
    }

    @NSManaged public var firstURL: String?
    @NSManaged public var text: String?
    @NSManaged public var airline: AirlineEntity?

}

extension TopicEntity : Identifiable {

}
