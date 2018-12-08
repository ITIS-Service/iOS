//
//  CoreDataGroupTranslator.swift
//  ITISService
//
//  Created by Timur Shafigullin on 08/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

struct CoreDataGroupTranslator: GroupTranslator {
    
    typealias StoredObject = DefaultGroup
    
    // MARK: - Instance Properties
    
    let storageContext: StorageContext
    
    // MARK: - Instance Methods
    
    @discardableResult
    func translate(group: Group) -> DefaultGroup {
        guard let storedObject = try? self.storageContext.firstOrNew(StoredObject.self, id: group.id) else {
            fatalError()
        }
        
        storedObject.uid = Int64(group.id)
        storedObject.name = group.name
        storedObject.course = Int16(group.course ?? 0)
        
        return storedObject
    }
    
    func translate(storedObject: DefaultGroup) -> Group {
        guard let id = Int(exactly: storedObject.uid) else {
            fatalError()
        }
        
        guard let course = Int(exactly: storedObject.course) else {
            fatalError()
        }
        
        return Group(id: id, name: storedObject.name, course: course)
    }
}
