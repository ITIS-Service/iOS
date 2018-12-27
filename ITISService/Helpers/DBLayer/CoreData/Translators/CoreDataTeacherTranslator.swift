//
//  CoreDataTeacherTranslator.swift
//  ITISService
//
//  Created by Timur Shafigullin on 26/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

struct CoreDataTeacherTranslator: TeacherTranslator {
    
    typealias StoredObject = DefaultTeacher
    
    // MARK: - Instance Properties
    
    let storageContext: StorageContext
    
    // MARK: - Instance Methods
    
    @discardableResult
    func translate(teacher: Teacher) -> DefaultTeacher {
        guard let storedObject = try? self.storageContext.firstOrNew(StoredObject.self, id: teacher.id) else {
            fatalError()
        }
        
        storedObject.uid = Int64(teacher.id)
        storedObject.firstName = teacher.firstName
        storedObject.lastName = teacher.lastName
        storedObject.email = teacher.email
        storedObject.link = teacher.link.absoluteString
        
        return storedObject
    }
    
    func translate(storedObject: DefaultTeacher) -> Teacher {
        guard let id = Int(exactly: storedObject.uid) else {
            fatalError()
        }
        
        guard let link = URL(string: storedObject.link!) else {
            fatalError()
        }
        
        return Teacher(id: id, firstName: storedObject.firstName!, lastName: storedObject.lastName!, email: storedObject.email!, link: link)
    }
}
