//
//  NotificationManager.swift
//  ITISService
//
//  Created by Timur Shafigullin on 18/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit
import UserNotifications

class DefaultNotificationManager: NSObject, NotificationManager {
    
    // MARK: - Initializers
    
    var bannerManager: BannerManager
    
    init(bannerManager: BannerManager) {
        self.bannerManager = bannerManager
        
        super.init()
        
        UNUserNotificationCenter.current().delegate = self
    }
    
}

extension DefaultNotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        Log.i(notification.request.content.categoryIdentifier)
        
        guard let category = NotificationCategory(rawValue: notification.request.content.categoryIdentifier) else {
            return completionHandler([])
        }
        
        if UIApplication.shared.applicationState == .active {
            self.bannerManager.showInfoBanner(category: category, title: notification.request.content.body, subtitle: notification.request.content.title)
        } else {
            completionHandler([.badge, .sound, .alert])
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        Log.i(response.notification.request.content.categoryIdentifier)
        
        defer {
            completionHandler()
        }
        
        guard let category = NotificationCategory(rawValue: response.notification.request.content.categoryIdentifier) else {
            return
        }
        
        NotificationCenter.default.post(name: .notificationDidReceived, object: self, userInfo: [Keys.notificationCategory: category])
    }
    
}
