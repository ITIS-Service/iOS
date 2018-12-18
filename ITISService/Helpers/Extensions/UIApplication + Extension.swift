//
//  UIApplication + Extension.swift
//  ITISService
//
//  Created by Timur Shafigullin on 18/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

extension UIApplication {
    
    // MARK: - Instance Properties
    
    var visibleViewController: UIViewController? {
        guard let rootViewController = self.keyWindow?.rootViewController else {
            return nil
        }
        
        return self.visibleViewController(rootViewController: rootViewController)
    }
    
    // MARK: - Instance Methods
    
    fileprivate func visibleViewController(rootViewController: UIViewController) -> UIViewController? {
        if let navigationController = rootViewController as? UINavigationController {
            if let lastViewController = navigationController.viewControllers.last {
                return self.visibleViewController(rootViewController: lastViewController)
            }
        }
        
        if let tabBarController = rootViewController as? UITabBarController {
            if let selectedViewController = tabBarController.selectedViewController {
                return self.visibleViewController(rootViewController: selectedViewController)
            }
        }
        
        if let presentedViewController = rootViewController.presentedViewController {
            return self.visibleViewController(rootViewController: presentedViewController)
        }
        
        if rootViewController.presentedViewController == nil {
            return rootViewController
        }
        
        return nil
    }
}
