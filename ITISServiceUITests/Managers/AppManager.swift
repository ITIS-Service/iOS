//
//  AppManager.swift
//  ITISServiceUITests
//
//  Created by Timur Shafigullin on 14/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation
import XCTest

class AppManager {
    
    static let shared = AppManager()
    
    var loginHelper: LoginHelper!
    let app = XCUIApplication()
    
    private init() {
        self.loginHelper = LoginHelper(appManager: self)
    }
    
}
