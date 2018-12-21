//
//  NSNotificationName + Extension.swift
//  ITISService
//
//  Created by Timur Shafigullin on 09/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

extension NSNotification.Name {
    
    // MARK: - Instance Properties
    
    public static let userDidSignIn = NSNotification.Name("userDidSignIn")
    public static let userDidSignUp = NSNotification.Name("userDidSignUp")
    public static let userUnauthorized = NSNotification.Name("userUnauthorized")
    public static let userDidFinishQuiz = NSNotification.Name("userDidFinishQuiz")
    
    public static let notificationDidReceived = NSNotification.Name("notificationDidReceived")
    public static let courseStatusDidChanged = Notification.Name("courseStatusDidChanged")
    
    public static let deviceDidRegisteredNotifications = Notification.Name("deviceDidRegisteredNotifications")
}
