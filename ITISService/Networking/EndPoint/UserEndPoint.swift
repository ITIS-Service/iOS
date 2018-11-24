//
//  UsersEndPoint.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 01/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

public enum UserApi  {
    case registration(email: String, password: String)
    case login(email: String, password: String)
    case questions
    case answers(answers: [String: Int])
    case courses
}

// MARK: - EndPointType

extension UserApi: EndPointType {
    
    // MARK: - Instance Properties
    
    var environmentBaseURL: String {
        return NetworkManager.environment.rawValue + "/users"
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    var path: String {
        switch self {
        case .registration:
            return "registration"
        case .login:
            return "login"
        case .questions:
            return "questions"
        case .answers:
            return "answers"
        case .courses:
            return "courses"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login, .registration, .answers:
            return .post
        case .questions, .courses:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .registration(let email, let password):
            return .requestParameters(bodyParameters: ["email": email, "password": password], urlParameters: nil)
        case .login(let email, let password):
            return .requestParameters(bodyParameters: ["email": email, "password": password], urlParameters: nil)
        case .questions, .courses:
            return .request
        case .answers(let answers):
            return .requestParameters(bodyParameters: ["answers": answers], urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
