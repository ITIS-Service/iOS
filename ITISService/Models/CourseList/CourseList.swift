//
//  ListCourses.swift
//  ITISService
//
//  Created by Timur Shafigullin on 23/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

struct CourseList: Codable {
    
    let userCourses: [Course]
    let suggestedCourses: [Course]
    let allCourses: [Course]
    
}
