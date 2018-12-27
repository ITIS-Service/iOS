//
//  CourseDetailsTranslator.swift
//  ITISService
//
//  Created by Timur Shafigullin on 26/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

protocol CourseDetailsTranslator {
    
    associatedtype StoredObject: Storable
    
    // MARK: - Instance Methods
    
    @discardableResult
    func translate(courseDetails: CourseDetails) -> StoredObject
    func translate(storedObject: StoredObject) -> CourseDetails
    
}
