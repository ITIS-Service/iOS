//
//  LoginModels.swift
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

enum Login {
  // MARK: Use cases
  
  enum SignIn {
    
    struct Request {
        let email: String
        let password: String
    }
    
    struct Response {
        let success: Bool
        let message: String
    }
    
    struct ViewModel {
        let errorMessage: String
    }
    
  }
}
