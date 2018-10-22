//
//  UINavigationController + Extension.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 22/10/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    /// Makes the navigation bar transparent
    func transparent() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = .clear
    }
    
}

