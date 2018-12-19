//
//  MainTabBarViewController.swift
//  ITISService
//
//  Created by Timur Shafigullin on 06/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Nested Types
    
    enum Tabs: Int {
        
        // MARK: - Enumeration Cases
        
        case courses
        case settings
    }
    
    // MARK: - Instance Properties
    
    fileprivate var notificationReceiveObserver: AnyObject?
    
    // MARK: - Initializers
    
    deinit {
        self.unsubscribeFromNotificationsReceive()
    }
    
    // MARK: - Instance Methods
    
    @IBAction func loginFinished(segue: UIStoryboardSegue) {
        Log.i(segue.identifier ?? "")
    }
    
    // MARK: -
    
    fileprivate func subscribeToNotificationsReceive() {
        self.notificationReceiveObserver = NotificationCenter.default.addObserver(forName: .notificationDidReceived, object: nil, queue: OperationQueue.main, using: { (notification) in
            guard let category = notification.userInfo?[Keys.notificationCategory] as? NotificationCategory else {
                return
            }
            
            switch category {
            case .courseStatus(let courseID):
                self.selectedIndex = Tabs.courses.rawValue
                Managers.courseDetailsManager.didStatusChangeEvent.raise(data: courseID)
                
            case .coursePoints(let courseID):
                self.selectedIndex = Tabs.courses.rawValue
                Managers.pointsManager.didPointsChangedEvent.raise(data: courseID)
            }
        })
    }
    
    fileprivate func unsubscribeFromNotificationsReceive() {
        if let notificationReceiveObserver = self.notificationReceiveObserver {
            NotificationCenter.default.removeObserver(notificationReceiveObserver)
            self.notificationReceiveObserver = nil
        }
    }
    
    // MARK - UIViewController
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Managers.userManager.first() == nil {
            NotificationCenter.default.post(name: .userUnauthorized, object: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.subscribeToNotificationsReceive()
    }
}
