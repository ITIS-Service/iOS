//
//  NotificationPresenterManager.swift
//  ITISService
//
//  Created by Timur Shafigullin on 18/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

protocol NotificationPresenterManager {
    
    func reveiveNotification(category: NotificationCategory, title: String, subtitle: String)
    
}
