//
//  TransparentNavigationController.swift
//  ITISService
//
//  Created by Timur Shafigullin on 27/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

class TransparentNavigationController: UINavigationController {
    
    // MARK: - UINavigationController

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.titleTextAttributes = [
            .foregroundColor: Colors.white,
            .font: Fonts.light(ofSize: 17)
        ]
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = .clear
        
        self.navigationBar.tintColor = Colors.backButton
        self.navigationBar.barTintColor = Colors.barBackground
    }

}
