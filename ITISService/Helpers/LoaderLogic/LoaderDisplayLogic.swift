//
//  LoaderDisplayLogic.swift
//  ITISService
//
//  Created by Timur Shafigullin on 24/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

protocol LoaderDisplayLogic: class {
    
    // MARK: - Instance Methods
    
    func showActivityIndicator(_ show: Bool)
}

// MARK: -

extension LoaderDisplayLogic where Self: UIViewController {
    
    // MARK: - Instance Methods
    
    func showActivityIndicator(_ show: Bool) {
        if (show) {
            self.view.showActivityIndicator()
        } else {
            self.view.hideActivityIndicator()
        }
    }
}
