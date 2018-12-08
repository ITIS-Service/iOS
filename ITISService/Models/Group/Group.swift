//
//  Group.swift
//  ITISService
//
//  Created by Timur Shafigullin on 08/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

struct Group: Codable {
    
    let id: Int
    let name: String?
    let course: Int?
    
    init(id: Int, name: String?, course: Int?) {
        self.id = id
        self.name = name
        self.course = course
    }
}
