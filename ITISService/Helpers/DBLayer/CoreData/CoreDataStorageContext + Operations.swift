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
    
    // MARK: - Instance Properties
    
    fileprivate var sortDescriptor: Sorted {
        return Sorted(key: "uid", ascending: true)
    }
    
    // MARK: - Instance Methods
    
    fileprivate func createPredicate(withUID uid: Int64) -> NSPredicate {
        return NSPredicate(format: "uid == %d", uid)
    }
    
    // MARK: -
    
    func create<T: Storable>(_ model: T.Type) throws -> T {
        guard let entity = NSEntityDescription.entity(forEntityName: model.entityName, in: self.persistentContainer.viewContext) else {
            fatalError()
        }
        
        let object = NSManagedObject(entity: entity, insertInto: self.persistentContainer.viewContext)
        
        try self.persistentContainer.viewContext.save()
        
        return object as! T
    }
    
    func update(block: @escaping () -> ()) throws {
        block()
        
        try self.persistentContainer.viewContext.save()
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
            self.saveContext()
        }
    }
    
    // MARK: -
    
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?) -> [T] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: model.entityName)
        
        fetchRequest.predicate = predicate
        
        if let sorted = sorted {
            let sort = NSSortDescriptor(key: sorted.key, ascending: sorted.ascending)
            
            fetchRequest.sortDescriptors = [sort]
        }
        
        guard let result = try? self.persistentContainer.viewContext.fetch(fetchRequest) else {
            return []
        }
        
        return result.compactMap { $0 as? T }
    }
    
    func firstOrNew<T: Storable>(_ model: T.Type, id: Int) throws -> T {
        let predicate = self.createPredicate(withUID: Int64(id))
        
        if let object = self.fetch(model, predicate: predicate, sorted: self.sortDescriptor).first {
            return object
        } else {
            return try self.create(model)
        }
    }
}
