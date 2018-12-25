//
//  CoreDataCourseTranslator.swift
//  ITISService
//
//  Created by Timur Shafigullin on 24/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

struct CoreDataCourseTranslator: CourseTranslator {
    
    typealias StoredObject = DefaultCourse
    
    // MARK: - Instance Properties
    
    let storageContext: StorageContext
    
    // MARK: - Instance Methods
    
    @discardableResult
    func translate(course: Course) -> DefaultCourse {
        guard let storedObject = try? self.storageContext.firstOrNew(StoredObject.self, id: course.id) else {
            fatalError()
        }
        
        storedObject.uid = Int64(course.id)
        storedObject.name = course.name
        storedObject.courseDescription = course.description
        
        return storedObject
    }
    
    func translate(storedObject: DefaultCourse) -> Course {
        guard let id = Int(exactly: storedObject.uid) else {
            fatalError()
        }
        
        guard let name = storedObject.name else {
            fatalError()
        }
        
        guard let description = storedObject.courseDescription else {
            fatalError()
        }
        
        return Course(id: id, name: name, description: description)
    }
    
}
