//
//  CoreDataStorageContext.swift
//  ITISService
//
//  Created by Timur Shafigullin on 07/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStorageContext: StorageContext {
    
    // MARK: - Instance Properties
    
    fileprivate var identifier: String
    
    public fileprivate(set) lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.identifier)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Instance Methods
    
    public func saveContext () {
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
    
    // MARK: - Initializers
    
    required init(identifier: String) {
        self.identifier = identifier
    }
    
}
