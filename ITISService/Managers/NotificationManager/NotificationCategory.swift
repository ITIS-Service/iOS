//
//  NotificationCategory.swift
//  ITISService
//
//  Created by Timur Shafigullin on 18/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

enum NotificationCategory {
    
    case courseStatus(courseID: Int)
    
    // MARK: - Initializers
    
    init(courseID: Int) {
        self = .courseStatus(courseID: courseID)
    }
    
}
