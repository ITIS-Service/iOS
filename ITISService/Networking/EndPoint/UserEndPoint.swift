//
//  UsersEndPoint.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 01/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case production
    case local
}

public enum UserApi  {
    case registration(email: String, password: String)
    case login(email: String, password: String)
}

extension UserApi: EndPointType {
    
    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production: return "production url"
        case .local: return "http://localhost:8080/users"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    var path: String {
        switch self {
        case .registration(_, _):
            return "registration"
        case .login(_, _):
            return "login"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .post
    }
    
    var task: HTTPTask {
        switch self {
        case .registration(let email, let password):
            return .requestParameters(bodyParameters: ["email": email, "password": password], urlParameters: nil)
        case .login(let email, let password):
            return .requestParameters(bodyParameters: ["email": email, "password": password], urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
}