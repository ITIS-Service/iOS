//
//  CourseDetailsManager.swift
//  ITISService
//
//  Created by Timur Shafigullin on 18/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

protocol CourseDetailsManager {
    
    var didStatusChangeEvent: Event<Int> { get }
    var didUpdateEvent: Event<Int> { get }
    
}
