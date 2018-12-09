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
    
    fileprivate enum Segues {
        
        // MARK: - Type Properties
        
        static let showLoginScreen = "ShowLoginScreen"
    }
    
    // MARK: - Instance Methods
    
    @IBAction func loginFinished(segue: UIStoryboardSegue) {
        Log.i(segue.identifier ?? "")
    }
    
    // MARK - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Managers.userManager.first() == nil {
            self.performSegue(withIdentifier: Segues.showLoginScreen, sender: nil)
        }
    }
    
}
