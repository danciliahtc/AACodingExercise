//
//  CoreDataManager.swift
//  AACodingExercise
//
//  Created by Dancilia Harmon   on 1/21/25.
//

import Foundation
import CoreData

class CoreDataManager {
    
    // make a singleton - when you create database, you make one single connection to the database, so new instances will not open. so singleton class is created to only create one object of that class. pattern provided by all the languages. how to create one object of that class? restrict access to that class by using private, then create a static property called shared, so you can access the persistent conatiner by class level. remember this syntax, private and then static.
    
    static let shared = CoreDataManager()
    private init() {
        
    }
    
    
    // Mark: - Core Data Stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "AACodindExCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
