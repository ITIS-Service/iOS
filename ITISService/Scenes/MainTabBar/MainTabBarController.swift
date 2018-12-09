//
//  MainTabBarViewController.swift
//  ITISService
//
//  Created by Timur Shafigullin on 06/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Instance Methods
    
    @IBAction func loginFinished(segue: UIStoryboardSegue) {
        Log.i(segue.identifier ?? "")
    }
    
    // MARK - UIViewController
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Managers.userManager.first() == nil {
            NotificationCenter.default.post(name: .userUnauthorized, object: self)
        }
    }
}
