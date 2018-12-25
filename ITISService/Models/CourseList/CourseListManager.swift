//
//  CourseListManager.swift
//  ITISService
//
//  Created by Timur Shafigullin on 25/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

protocol CourseListManager {
    
    // MARK: - Instance Methods
    
    func save(_ courseList: CourseList)
    func fetch() -> CourseList?
}
