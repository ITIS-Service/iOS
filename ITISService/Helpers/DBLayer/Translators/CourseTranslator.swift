//
//  CourseTranslator.swift
//  ITISService
//
//  Created by Timur Shafigullin on 24/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

protocol CourseTranslator {
    
    associatedtype StoredObject: Storable
    
    // MARK: - Instance Methods
    
    func translate(course: Course) -> StoredObject
    func translate(storedObject: StoredObject) -> Course
}
