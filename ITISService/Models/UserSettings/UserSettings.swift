//
//  UserSettings.swift
//  ITISService
//
//  Created by Timur Shafigullin on 20/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

struct UserSettings: Codable {
    
    let id: Int
    var courseStatusNotificationEnabled: Bool
    var pointsNotificationEnabled: Bool
    
}
