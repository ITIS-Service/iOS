//
//  CoreDataStorageContext + Operations.swift
//  ITISService
//
//  Created by Timur Shafigullin on 07/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation
import CoreData

extension CoreDataStorageContext {
    
    // MARK: - Instance Methods
    
    func create<T: Storable>(_ model: T.Type, completion: @escaping (T) -> ()) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: model.entityName, in: self.persistentContainer.viewContext) else {
            return
        }
        
        let object = NSManagedObject(entity: entity, insertInto: self.persistentContainer.viewContext)
        
        try self.persistentContainer.viewContext.save()
        
        completion(object as! T)
    }
    
    func update(block: @escaping () -> ()) throws {
        try self.persistentContainer.viewContext.save()
        
        block()
    }
    
    // MARK: -
    
    func delete(object: Storable) throws {
        self.persistentContainer.viewContext.delete(object as! NSManagedObject)
    }
    
    func deleteAll<T: Storable>(_ model: T.Type) throws {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: model.entityName)
        
        fetchRequest.returnsObjectsAsFaults = false
        
        let results = try self.persistentContainer.viewContext.fetch(fetchRequest)
        
        for object in results {
            guard let objectData = object as? NSManagedObject else {
                continue
            }
            
            self.persistentContainer.viewContext.delete(objectData)
        }
    }
    
    // MARK: -
    
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: ([T]) -> ()) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: model.entityName)
        
        fetchRequest.predicate = predicate
        
        if let sorted = sorted {
            let sort = NSSortDescriptor(key: sorted.key, ascending: sorted.ascending)
            
            fetchRequest.sortDescriptors = [sort]
        }
        
        guard let result = try? self.persistentContainer.viewContext.fetch(fetchRequest) else {
            return completion([])
        }
        
        completion(result.compactMap { $0 as? T })
    }
}
