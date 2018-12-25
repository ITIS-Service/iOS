//
//  DefaultCourseManager.swift
//  ITISService
//
//  Created by Timur Shafigullin on 24/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

struct DefaultCourseManager<Object>: CourseManager where Object: Storable {
    
    // MARK: - Instance Methods
    
    func save(_ courses: [Course]) {
        try? Services.storageContext.update {
            courses.forEach { Translators.courseTranslator.translate(course: $0) }
        }
    }
    
    
}
