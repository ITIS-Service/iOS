//
//  Managers.swift
//  ITISService
//
//  Created by Timur Shafigullin on 08/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

enum Managers {
    
    // MARK: - Type Properties
    
    static let userManager: UserManager = DefaultUserManager<DefaultUser>()
    static let courseDetailsManager: CourseDetailsManager = DefaultCourseDetailsManager()
    static let pointsManager: PointsManager = DefaultPointsManager()
    static let userSettingsManager: UserSettingsManager = DefaultUserSettingsManager<DefaultUserSettings>()
    
    static let bannerManager: BannerManager = DefaultBannerManager()
    static let notificationManager: NotificationManager = DefaultNotificationManager(notificationPresenterManager: Managers.notificationPresenterManager)
    static let notificationPresenterManager: NotificationPresenterManager = DefaultNotificationPresenterManager(bannerManager: Managers.bannerManager)
    
}
