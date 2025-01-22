//
//  AirlineEntity+CoreDataProperties.swift
//  AACodingExercise
//
//  Created by Dancilia Harmon   on 1/22/25.
//
//

import Foundation
import CoreData


extension AirlineEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AirlineEntity> {
        return NSFetchRequest<AirlineEntity>(entityName: "AirlineEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var resultEntity: NSSet?
    @NSManaged public var topicEntity: NSSet?

}

// MARK: Generated accessors for resultEntity
extension AirlineEntity {

    @objc(addResultEntityObject:)
    @NSManaged public func addToResultEntity(_ value: ResultEntity)

    @objc(removeResultEntityObject:)
    @NSManaged public func removeFromResultEntity(_ value: ResultEntity)

    @objc(addResultEntity:)
    @NSManaged public func addToResultEntity(_ values: NSSet)

    @objc(removeResultEntity:)
    @NSManaged public func removeFromResultEntity(_ values: NSSet)

}

// MARK: Generated accessors for topicEntity
extension AirlineEntity {

    @objc(addTopicEntityObject:)
    @NSManaged public func addToTopicEntity(_ value: TopicEntity)

    @objc(removeTopicEntityObject:)
    @NSManaged public func removeFromTopicEntity(_ value: TopicEntity)

    @objc(addTopicEntity:)
    @NSManaged public func addToTopicEntity(_ values: NSSet)

    @objc(removeTopicEntity:)
    @NSManaged public func removeFromTopicEntity(_ values: NSSet)

}

extension AirlineEntity : Identifiable {

}
