//
//  ITISServiceUITests.swift
//  ITISServiceUITests
//
//  Created by Timur Shafigullin on 14/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import XCTest

class ITISServiceUITests: TestBase {

    func testLogin() {
        // Arrange
        let userData = UserData(email: "TestUI", password: "qwe123")
        
        // Act
        self.appManager.loginHelper.login(with: userData)
        
        // Assert
        XCTAssertTrue(self.appManager.loginHelper.isLogged())
    }
}
