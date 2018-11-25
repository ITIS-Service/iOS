//
//  UserCourseStatus.swift
//  ITISService
//
//  Created by Timur Shafigullin on 25/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

enum UserCourseStatus: String, Codable {
    
    case waiting = "WAITING"
    case accepted = "ACCEPTED"
    case rejected = "REJECTED"
    case moved = "MOVED"
    
}
