//
//  AirlineEntity+CoreDataProperties.swift
//  AACodingExercise
//
//  Created by Dancilia Harmon   on 1/23/25.
//
//

import Foundation
import CoreData


extension AirlineEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AirlineEntity> {
        return NSFetchRequest<AirlineEntity>(entityName: "AirlineEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var results: NSSet?
    @NSManaged public var topics: NSSet?

}

// MARK: Generated accessors for results
extension AirlineEntity {

    @objc(addResultsObject:)
    @NSManaged public func addToResults(_ value: ResultEntity)

    @objc(removeResultsObject:)
    @NSManaged public func removeFromResults(_ value: ResultEntity)

    @objc(addResults:)
    @NSManaged public func addToResults(_ values: NSSet)

    @objc(removeResults:)
    @NSManaged public func removeFromResults(_ values: NSSet)

}

// MARK: Generated accessors for topics
extension AirlineEntity {

    @objc(addTopicsObject:)
    @NSManaged public func addToTopics(_ value: TopicEntity)

    @objc(removeTopicsObject:)
    @NSManaged public func removeFromTopics(_ value: TopicEntity)

    @objc(addTopics:)
    @NSManaged public func addToTopics(_ values: NSSet)

    @objc(removeTopics:)
    @NSManaged public func removeFromTopics(_ values: NSSet)

}

extension AirlineEntity : Identifiable {

}
