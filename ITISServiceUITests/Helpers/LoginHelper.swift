//
//  LoginHelper.swift
//  ITISServiceUITests
//
//  Created by Timur Shafigullin on 14/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation
import XCTest

class LoginHelper: HelperBase {
    
    override init(appManager: AppManager) {
        super.init(appManager: appManager)
    }
    
    func login(with userData: UserData) {
        let app = self.appManager.app
        
        app.textFields["Ваша почта КФУ"].tap()
        app.textFields["Ваша почта КФУ"].typeText(userData.email)
        
        let secureTextField = app.secureTextFields["Ваш пароль"]
        
        secureTextField.tap()
        secureTextField.typeText(userData.password)
        app.buttons["ВОЙТИ"].tap()
    }
    
    func isLogged() -> Bool {
        let app = self.appManager.app
        
        return app.buttons["ПРОПУСТИТЬ"].exists
    }
    
}
