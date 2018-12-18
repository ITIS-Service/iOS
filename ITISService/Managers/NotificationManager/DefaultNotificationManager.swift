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
    
    // MARK: - Nested Types
    
    fileprivate enum Category {
        
        // MARK: - Type Properties
        
        static let courseStatus = "course.status"
    }
    
    // MARK: -
    
    fileprivate enum JSONKeys {
        
        // MARK: - Type Properties
        
        static let courseID = "courseID"
    }
    
    // MARK: - Instance Methods
    
    fileprivate func notificationCategory(from content: UNNotificationContent) -> NotificationCategory? {
        switch content.categoryIdentifier {
        case Category.courseStatus:
            guard let courseID = content.userInfo[JSONKeys.courseID] as? Int else {
                return nil
            }
            
            return NotificationCategory(courseID: courseID)
            
        default:
            return nil
        }
    }
    
    // MARK: - Initializers
    
    var notificationPresenterManager: NotificationPresenterManager
    
    init(notificationPresenterManager: NotificationPresenterManager) {
        self.notificationPresenterManager = notificationPresenterManager
        
        super.init()
        
        UNUserNotificationCenter.current().delegate = self
    }
    
}

extension DefaultNotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        Log.i(notification.request.content.categoryIdentifier)
        
        guard let category = self.notificationCategory(from: notification.request.content) else {
            return completionHandler([])
        }
        
        if UIApplication.shared.applicationState == .active {
            self.notificationPresenterManager.reveiveNotification(category: category, title: notification.request.content.body, subtitle: notification.request.content.title)
        } else {
            completionHandler([.badge, .sound, .alert])
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        Log.i(response.notification.request.content.categoryIdentifier)
        
        defer {
            completionHandler()
        }
        
        guard let category = self.notificationCategory(from: response.notification.request.content) else {
            return
        }
        
        NotificationCenter.default.post(name: .notificationDidReceived, object: self, userInfo: [Keys.notificationCategory: category])
    }
    
}
