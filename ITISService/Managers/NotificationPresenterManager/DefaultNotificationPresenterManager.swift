//
//  DefaultNotificationPresenterManager.swift
//  ITISService
//
//  Created by Timur Shafigullin on 18/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

class DefaultNotificationPresenterManager: NotificationPresenterManager {
    
    // MARK: - Instance Properties
    
    var bannerManager: BannerManager
    
    // MARK: - Initializers
    
    init(bannerManager: BannerManager) {
        self.bannerManager = bannerManager
    }
    
    // MARK: - Instance Methods
    
    fileprivate func shouldShowBanner(for category: NotificationCategory) -> Bool {
        guard let visibleViewController = UIApplication.shared.visibleViewController else {
            return true
        }
        
        switch category {
        case .courseStatus:
            return !(visibleViewController is CourseDetailsViewController)
        }
    }
    
    // MARK: -
    
    func reveiveNotification(category: NotificationCategory, title: String, subtitle: String) {
        if self.shouldShowBanner(for: category) {
            self.bannerManager.showInfoBanner(category: category, title: title, subtitle: subtitle)
        } else {
            switch category {
            case .courseStatus(let courseID):
                Managers.courseDetailsManager.didUpdateEvent.raise(data: courseID)
            }
        }
    }
}
