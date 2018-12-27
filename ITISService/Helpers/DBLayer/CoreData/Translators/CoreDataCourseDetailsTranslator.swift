//
//  CoreDataCourseDetailsTranslator.swift
//  ITISService
//
//  Created by Timur Shafigullin on 26/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

struct CoreDataCourseDetailsTranslator: CourseDetailsTranslator {
    
    typealias StoredObject = DefaultCourseDetails
    
    // MARK: - Instance Properties
    
    let storageContext: StorageContext
    
    // MARK: - Instance Methods
    
    @discardableResult
    func translate(courseDetails: CourseDetails) -> DefaultCourseDetails {
        guard let storedObject = try? self.storageContext.firstOrNew(StoredObject.self, id: courseDetails.id) else {
            fatalError()
        }
        
        storedObject.uid = Int64(courseDetails.id)
        storedObject.courseNumber = Int64(courseDetails.courseNumber)
        storedObject.place = courseDetails.place
        storedObject.userCourseStatus = courseDetails.userCourseStatus?.rawValue
        storedObject.signUpOpen = courseDetails.signUpOpen ?? true
        storedObject.teacher = Translators.teacherTranslator.translate(teacher: courseDetails.teacher)
        storedObject.course = Translators.courseTranslator.translate(course: courseDetails.course)
        
        if let storedDayTimes = storedObject.dayTimes {
            storedObject.removeFromDayTimes(storedDayTimes)
        }
        
        let dayTimes = courseDetails.dayTimes.map { Translators.dayTimeTranslator.translate(dayTime: $0) }
        
        storedObject.addToDayTimes(NSOrderedSet(array: dayTimes))
        
        return storedObject
    }
    
    func translate(storedObject: DefaultCourseDetails) -> CourseDetails {
        guard let id = Int(exactly: storedObject.uid) else {
            fatalError()
        }
        
        guard let courseNumber = Int(exactly: storedObject.courseNumber) else {
            fatalError()
        }
        
        guard let rawDayTimes = storedObject.dayTimes?.array as? [DefaultDayTime] else {
            fatalError()
        }
        
        let dayTimes = rawDayTimes.map { Translators.dayTimeTranslator.translate(storedObject: $0) }
        
        guard let userCourseStatus = UserCourseStatus(rawValue: storedObject.userCourseStatus!) else {
            fatalError()
        }
        
        let teacher = Translators.teacherTranslator.translate(storedObject: storedObject.teacher!)
        let course = Translators.courseTranslator.translate(storedObject: storedObject.course!)
        
        return CourseDetails(id: id, course: course, courseNumber: courseNumber, dayTimes: dayTimes, place: storedObject.place!, teacher: teacher, userCourseStatus: userCourseStatus, signUpOpen: storedObject.signUpOpen)
    }
    
}
