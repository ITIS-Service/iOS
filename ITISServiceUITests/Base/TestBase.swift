//
//  TestBase.swift
//  ITISServiceUITests
//
//  Created by Timur Shafigullin on 14/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//
import XCTest

class TestBase: XCTestCase {
    
    var appManager: AppManager!
    
    override func setUp() {
        XCUIApplication().launch()
        
        self.appManager = AppManager.shared
    }
    
}
