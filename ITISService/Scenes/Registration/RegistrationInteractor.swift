//
//  RegistrationInteractor.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 22/10/2018.
//  Copyright (c) 2018 Timur Shafigullin. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol RegistrationBusinessLogic {
    func signUp(with request: Registration.SignUp.Request)
}

protocol RegistrationDataStore {
    //var name: String { get set }
}

class RegistrationInteractor: RegistrationBusinessLogic, RegistrationDataStore {
    
    var presenter: RegistrationPresentationLogic!
    var worker: RegistrationWorker!
    var userNetworkManager: UserNetworkManager!
    
    init() {
        self.worker = RegistrationWorker()
    }
    
    func signUp(with request: Registration.SignUp.Request) {
        guard Validator.validate(studEmail: request.email) else {
            self.presenter.signUp(response: Registration.SignUp.Response(success: false, errorType: .email, message: Common.Messages.invalidEmail))
            return
        }
        
        guard request.password == request.confirmPassword else {
            self.presenter.signUp(response: Registration.SignUp.Response(success: false, errorType: .password, message: "Пароли не совпадают"))
            return
        }
        
        self.presenter.showActivityIndicator(true)
        self.userNetworkManager.registration(with: request.email, password: request.password, success: { [weak self] in
            self?.presenter.showActivityIndicator(false)
            self?.presenter.signUp(response: Registration.SignUp.Response(success: true, errorType: nil, message: nil))
        }) { [weak self] (error) in
            self?.presenter.showActivityIndicator(false)
            self?.presenter.signUp(response: Registration.SignUp.Response(success: false, errorType: .network, message: error.message))
        }
    }
    
}
