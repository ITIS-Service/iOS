//
//  LoginViewControllerTests.swift
//  ITISServiceTests
//
//  Created by Timur Shafigullin on 18/01/2019.
//  Copyright © 2019 Timur Shafigullin. All rights reserved.
//

import XCTest
@testable import ITISService

fileprivate class LoginRouterMock: NSObject, LoginRoutingLogic, LoginDataPassing {
    
    fileprivate var isCourseScreenOpened = false
    fileprivate var isStartQuizScreenOpened = false
    
    var dataStore: LoginDataStore!
    
    func openCourseScreen() {
        self.isCourseScreenOpened = true
    }
    
    func openStartQuizScreen() {
        self.isStartQuizScreenOpened = true
    }
}

class LoginViewControllerTests: XCTestCase {
    
    var loginViewController: LoginViewController!
    
    override func setUp() {
        super.setUp()
        
        let loginStoryboard = UIStoryboard(name: "Login", bundle: Bundle.main)
        
        let nivagationController = loginStoryboard.instantiateInitialViewController() as! UINavigationController
        
        self.loginViewController = nivagationController.viewControllers.first as? LoginViewController
    }
    
    func testConfigureDesign() {
        // arrange
        let expectedEmailAttributedPlaceholder = NSAttributedString(string: "Ваша почта КФУ", attributes: Common.Autorization.placeholderAttributes)
        let expectedEmailAutocorrectionType: UITextAutocorrectionType = .no
        let expectedPasswordAttributedPlaceholder = NSAttributedString(string: "Ваш пароль", attributes: Common.Autorization.placeholderAttributes)
        
        // act
        self.loginViewController.loadViewIfNeeded()
        
        // assert
        XCTAssertEqual(self.loginViewController.emailTextField.attributedPlaceholder, expectedEmailAttributedPlaceholder)
        XCTAssertEqual(self.loginViewController.emailTextField.autocorrectionType, expectedEmailAutocorrectionType)
        XCTAssertEqual(self.loginViewController.passwordTextField.attributedPlaceholder, expectedPasswordAttributedPlaceholder)
    }
    
    func testOpenCourseScreen() {
        // arrange
        let loginRouterMock = LoginRouterMock()
        
        self.loginViewController.router = loginRouterMock
        
        // act
        self.loginViewController.openCoursesScreen()
        
        // assert
        XCTAssertTrue(loginRouterMock.isCourseScreenOpened)
    }
    
    func testOpenStartQuizScreen() {
        // arrange
        let loginRouterMock = LoginRouterMock()
        
        self.loginViewController.router = loginRouterMock
        
        // act
        self.loginViewController.openStartQuizScreen()
        
        // assert
        XCTAssertTrue(loginRouterMock.isStartQuizScreenOpened)
    }
    
    func testShowError() {
        // arrange
        let expectedErrorViewHidden = false
        let expectedEmailTextFieldTextColor = Common.Autorization.errorColor
        let expectedPasswordTextFieldTextColor = Common.Autorization.errorColor
        
        let expectedErrorTitle = "Ошибка"
        let expectedActionTitle = "OK"
        let expectedErrorMessage = "Test message"
        let errorViewModel = Login.SignIn.ViewModel(errorMessage: expectedErrorMessage)
        
        // act
        self.loginViewController.loadViewIfNeeded()
        
        self.loginViewController.showError(with: errorViewModel)
        
        // assert
        if UIScreen.isIphone5Screen() {
            XCTAssertTrue(self.loginViewController.presentedViewController is UIAlertController)
            
            let alertController = self.loginViewController.presentedViewController as! UIAlertController
            
            XCTAssertEqual(alertController.title, expectedErrorTitle)
            XCTAssertEqual(alertController.message, expectedErrorMessage)
            XCTAssertEqual(alertController.actions.first?.title, expectedActionTitle)
        } else {
            XCTAssertEqual(self.loginViewController.errorView.isHidden, expectedErrorViewHidden)
            XCTAssertEqual(self.loginViewController.emailTextField.textColor, expectedEmailTextFieldTextColor)
            XCTAssertEqual(self.loginViewController.passwordTextField.textColor, expectedPasswordTextFieldTextColor)
            XCTAssertEqual(self.loginViewController.errorLabel.text, expectedErrorMessage)
        }
    }
    
    func testShowActivityIndicator() {
        // arrange
        let activityIndicatorViewTag = 56
        
        // act
        self.loginViewController.showActivityIndicator(true)
        
        // assert
        XCTAssertNotNil(self.loginViewController.view.viewWithTag(activityIndicatorViewTag))
    }
    
    func testHideActivityIndicator() {
        // arrange
        let activityIndicatorViewTag = 56
        
        // act
        self.loginViewController.showActivityIndicator(true)
        self.loginViewController.showActivityIndicator(false)
        
        // assert
        XCTAssertNil(self.loginViewController.view.viewWithTag(activityIndicatorViewTag))
    }
    
    func testShowKeyboard() {
        // arrange
        self.loginViewController.loadViewIfNeeded()
        
        let keyboardHeight: CGFloat = 180
        let expectedBottomSpacerConstant = keyboardHeight - self.loginViewController.signUpButtonToBottomSpacerConstraint.constant
        
        // act
        self.loginViewController.handle(keyboardHeight: keyboardHeight, view: self.loginViewController.view)
        
        // assert
        XCTAssertEqual(self.loginViewController.bottomSpacerHeightConstraint.constant, expectedBottomSpacerConstant)
    }
    
    func testHideKeyboard() {
        // arrange
        self.loginViewController.loadViewIfNeeded()
        
        let expectedBottomSpacerConstant: CGFloat = 0
        
        // act
        self.loginViewController.handle(keyboardHeight: 0, view: self.loginViewController.view)
        
        // assert
        XCTAssertEqual(self.loginViewController.bottomSpacerHeightConstraint.constant, expectedBottomSpacerConstant)
    }
}
