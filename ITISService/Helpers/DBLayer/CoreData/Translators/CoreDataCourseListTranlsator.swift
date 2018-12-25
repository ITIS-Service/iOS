//
//  CoreDataCourseListTranlsator.swift
//  ITISService
//
//  Created by Timur Shafigullin on 25/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

struct CoreDataCourseListTranlsator: CourseListTranslator {
    
    typealias StoredObject = DefaultCourseList
    
    // MARK: - Nested Types
    
    fileprivate struct Constants {
        
        // MARK: - Type Properties
        
        static let listID = 1
    }
    
    // MARK: - Instance Properties
    
    let storageContext: StorageContext
    
    // MARK: - Instance Methods
    
    @discardableResult
    func translate(courseList: CourseList) -> DefaultCourseList {
        guard let storedObject = try? self.storageContext.firstOrNew(StoredObject.self, id: Constants.listID) else {
            fatalError()
        }
        
        let suggestedCourses = courseList.suggestedCourses.map { Translators.courseTranslator.translate(course: $0) }
        let userCourses = courseList.userCourses.map { Translators.courseTranslator.translate(course: $0) }
        let allCourses = courseList.allCourses.map { Translators.courseTranslator.translate(course: $0) }
        
        storedObject.addToSuggestedCourses(NSOrderedSet(array: suggestedCourses))
        storedObject.addToUserCourses(NSOrderedSet(array: userCourses))
        storedObject.addToAllCourses(NSOrderedSet(array: allCourses))
        
        return storedObject
    }
    
    func translate(storedObject: DefaultCourseList) -> CourseList {
        let suggestedCourses = storedObject.suggestedCourses?.array as? [DefaultCourse] ?? []
        let userCourses = storedObject.userCourses?.array as? [DefaultCourse] ?? []
        let allCourses = storedObject.allCourses?.array as? [DefaultCourse] ?? []
        
        let courseTranslator = Translators.courseTranslator
        
        return CourseList(
            userCourses: userCourses.map { courseTranslator.translate(storedObject: $0) },
            suggestedCourses: suggestedCourses.map { courseTranslator.translate(storedObject: $0) },
            allCourses: allCourses.map { courseTranslator.translate(storedObject: $0) }
        )
    }
    
}
