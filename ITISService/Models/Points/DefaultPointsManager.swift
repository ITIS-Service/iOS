//
//  DefaultPointsManager.swift
//  ITISService
//
//  Created by Timur Shafigullin on 19/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

struct DefaultPointsManager: PointsManager {
    
    var didPointsChangedEvent = Event<Int>()
    var didPointsUpdateEvent = Event<Int>()
    
}
