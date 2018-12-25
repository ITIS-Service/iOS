//
//  CourseListTranslator.swift
//  ITISService
//
//  Created by Timur Shafigullin on 25/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

protocol CourseListTranslator {
    
    associatedtype StoredObject: Storable
    
    // MARK: - Instance Methods
    
    @discardableResult
    func translate(courseList: CourseList) -> StoredObject
    func translate(storedObject: StoredObject) -> CourseList
    
}
