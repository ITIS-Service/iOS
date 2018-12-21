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
    fileprivate var registeredNotificationsObserver: AnyObject?
    
    // MARK: - Initializers
    
    deinit {
        self.unsubscribeFromNotificationsReceive()
        self.unsubscribeFromregisteredNotifications()
    }
    
    // MARK: - Instance Methods
    
    @IBAction func loginFinished(segue: UIStoryboardSegue) {
        Log.i(segue.identifier ?? "")
    }
    
    // MARK: -
    
    fileprivate func subscribeToRegisteredNotifications() {
        self.registeredNotificationsObserver = NotificationCenter.default.addObserver(forName: .deviceDidRegisteredNotifications, object: nil, queue: OperationQueue.main, using: { (notification) in
            guard let token = notification.userInfo?[Keys.deviceToken] as? String else {
                return
            }
            
            let model = UIDevice.modelName
            let systemVersion = UIDevice.current.systemVersion
            
            NetworkManagers.deviceNetworkManager.register(name: model, os: "iOS \(systemVersion)", token: token, success: { (response) in
                Log.i("Device registered on server successfully")
            }, failure: { (error) in
                Log.e("Unable to register device on server. Message: \(error.message)")
            })
        })
    }
    
    fileprivate func unsubscribeFromregisteredNotifications() {
        if let registeredNotificationsObserver = self.registeredNotificationsObserver {
            NotificationCenter.default.removeObserver(registeredNotificationsObserver)
            self.registeredNotificationsObserver = nil
        }
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.subscribeToNotificationsReceive()
        self.subscribeToRegisteredNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Managers.userManager.first() == nil {
            NotificationCenter.default.post(name: .userUnauthorized, object: self)
        }
    }
}
