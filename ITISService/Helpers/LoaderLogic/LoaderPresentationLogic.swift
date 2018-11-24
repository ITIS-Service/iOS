//
//  LoaderPresentationLogic.swift
//  ITISService
//
//  Created by Timur Shafigullin on 23/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

protocol LoaderPresentationLogic {
    
    // MARK: - Instance Properties
    
    var loaderDislpayViewController: LoaderDisplayLogic! { get }
    
    // MARK: - Instance Methods
    
    func showActivityIndicator(_ show: Bool)
}

// MARK: -

extension LoaderPresentationLogic {
    
    // MARK: - Instance Methods
    
    func showActivityIndicator(_ show: Bool) {
        self.loaderDislpayViewController.showActivityIndicator(show)
    }
}
