//
//  UserNetworkManager.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 01/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

class UserNetworkManager {
    
    private let router = Router<UserApi>()
    
    func registration(with email: String, password: String, success: @escaping (() -> Void), failure: @escaping (ExceptionResponse) -> Void) {
        router.request(.registration(email: email, password: password), success: { (data, response) in
            if let httpResponse = response as? HTTPURLResponse, let authHeader = httpResponse.allHeaderFields[Common.Token.headerString] as? String {
                let token = authHeader.replacingOccurrences(of: Common.Token.prefix, with: "")
                KeychainManager.shared.token = token
            }
            success()
        }) { (error) in
            failure(error)
        }
    }
    
}
