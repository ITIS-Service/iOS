//
//  BannerManager.swift
//  ITISService
//
//  Created by Timur Shafigullin on 18/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

protocol BannerManager {
    
    func showInfoBanner(category: NotificationCategory, title: String, subtitle: String)
    
}
