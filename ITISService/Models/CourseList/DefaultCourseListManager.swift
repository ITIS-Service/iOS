//
//  DefaultCourseListManager.swift
//  ITISService
//
//  Created by Timur Shafigullin on 25/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

struct DefaultCourseListManager<Object>: CourseListManager where Object: Storable {
    
    // MARK: - Instance Methods
    
    func save(_ courseList: CourseList) {
        try? Services.storageContext.deleteAll(Object.self)
        
        try? Services.storageContext.update {
            Translators.courseListTranslator.translate(courseList: courseList)
        }
    }
    
    func fetch() -> CourseList? {
        if let storedObject = Services.storageContext.fetch(Object.self, predicate: nil, sorted: nil).first {
            return Translators.courseListTranslator.translate(storedObject: storedObject as! CoreDataCourseListTranlsator.StoredObject)
        } else {
            return nil
        }
    }
}
