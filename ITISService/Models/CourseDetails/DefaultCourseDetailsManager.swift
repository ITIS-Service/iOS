//
//  DefaultCourseDetailsManager.swift
//  ITISService
//
//  Created by Timur Shafigullin on 18/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

struct DefaultCourseDetailsManager: CourseDetailsManager {
    
    var didStatusChangeEvent = Event<Int>()
    var didUpdateEvent = Event<Int>()
    
}
