//
//  RegistrationModels.swift
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

enum Registration {
  // MARK: Use cases
  
    enum SignUp {
        struct Request {
            let email: String
            let password: String
            let confirmPassword: String
        }
        struct Response {
            enum ErrorType {
                case email
                case password
                case network
            }
            
            let success: Bool
            let errorType: ErrorType?
            let message: String?
        }
        struct ViewModel {
            let errorMessage: String
            let emailTextColor: UIColor
            let passwordsTextColor: UIColor
        }
    }
    
}
