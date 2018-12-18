//
//  DefaultBannerManager.swift
//  ITISService
//
//  Created by Timur Shafigullin on 18/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation
import NotificationBannerSwift

class DefaultBannerManager: BannerManager {
    
    // MARK: - Instance Properties
    
    func showInfoBanner(category: NotificationCategory, title: String, subtitle: String) {
        let banner = NotificationBanner(title: title, subtitle: subtitle, style: .info)
        
        banner.haptic = .heavy
        banner.onTap = {
            NotificationCenter.default.post(name: .notificationDidReceived, object: self, userInfo: [Keys.notificationCategory: category])
        }
        
        banner.show()
    }
    
}
