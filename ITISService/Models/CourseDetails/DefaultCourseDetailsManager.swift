//
//  DefaultCourseDetailsManager.swift
//  ITISService
//
//  Created by Timur Shafigullin on 18/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

struct DefaultCourseDetailsManager<Object>: CourseDetailsManager where Object: Storable {
    
    // MARK: - Instance Properties
    
    var didStatusChangeEvent = Event<Int>()
    var didUpdateEvent = Event<Int>()
    
    // MARK: - Instance Methods
    
    func save(_ courseDetails: CourseDetails) {
        try? Services.storageContext.update {
            Translators.courseDetailsTranslator.translate(courseDetails: courseDetails)
        }
    }
    
    func fetch(withCourseID id: Int) -> CourseDetails? {
        let predicate = NSPredicate(format: "course.uid == %d", id)
        let sorted = Sorted(key: "uid", ascending: true)
        
        if let storedObject = Services.storageContext.fetch(Object.self, predicate: predicate, sorted: sorted).first, let storable = storedObject as? CoreDataCourseDetailsTranslator.StoredObject {
            return Translators.courseDetailsTranslator.translate(storedObject: storable)
        } else {
            return nil
        }
    }
}
