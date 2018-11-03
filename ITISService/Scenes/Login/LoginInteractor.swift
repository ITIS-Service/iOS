//
//  LoginInteractor.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 19/10/2018.
//  Copyright (c) 2018 Timur Shafigullin. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LoginBusinessLogic {
    func signIn(with request: Login.SignIn.Request)
}

protocol LoginDataStore {
  //var name: String { get set }
}

class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    
    var presenter: LoginPresentationLogic!
    var worker: LoginWorker!
    var networkManager: UserNetworkManager!
  
    // MARK: Do something
    
    init() {
        self.worker = LoginWorker()
    }
    
    func signIn(with request: Login.SignIn.Request) {
        guard Validator.validate(studEmail: request.email) else {
            let response = Login.SignIn.Response(success: false, message: Common.Messages.invalidEmail, shouldShowQuiz: false)
            self.presenter.signIn(response: response)
            return
        }
        
        self.presenter.showActivityIndicator(true)
        self.networkManager.login(with: request.email, password: request.password, success: { [weak self] (loginResponseDto) in
            self?.presenter.showActivityIndicator(false)
            self?.presenter.signIn(response: Login.SignIn.Response(success: true, message: nil, shouldShowQuiz: !loginResponseDto.passedQuiz))
        }) { [weak self] (error) in
            self?.presenter.showActivityIndicator(false)
            self?.presenter.signIn(response: Login.SignIn.Response(success: false, message: error.message, shouldShowQuiz: false))
        }
    }

}
