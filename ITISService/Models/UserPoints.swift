//
//  UserPoints.swift
//  ITISService
//
//  Created by Timur Shafigullin on 02/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

struct UserPoints: Codable {
    
    let total: Int
    let points: [Point]
    
}
