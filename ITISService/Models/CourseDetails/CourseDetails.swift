//
//  CourseDetails.swift
//  ITISService
//
//  Created by Timur Shafigullin on 25/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

struct CourseDetails: Codable {
    
    let id: Int
    let name: String
    let description: String
    let courseNumber: Int
    let dayTimes: [DayTime]
    let place: String
    let teacher: Teacher
    let userCourseStatus: UserCourseStatus?
    let signUpOpen: Bool?
    
}
