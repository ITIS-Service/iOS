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
    case courseDetails(courseID: Int)
    case signUp(courseID: Int)
    case points(courseID: Int)
    case signOut(courseID: Int)
    
    case changePassword(oldPassword: String, newPassword: String)
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
        case .courseDetails(let courseID):
            return "courses/\(courseID)/details"
        case .signUp(let courseID):
            return "courses/\(courseID)/signUp"
        case .points(let courseID):
            return "courses/\(courseID)/points"
        case .signOut(let courseID):
            return "courses/\(courseID)/signOut"
        case .changePassword:
            return "profile/password/change"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login, .registration, .answers, .signUp, .signOut, .changePassword:
            return .post
        case .questions, .courses, .courseDetails, .points:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .registration(let email, let password):
            return .requestParameters(bodyParameters: ["email": email, "password": password], urlParameters: nil)
        case .login(let email, let password):
            return .requestParameters(bodyParameters: ["email": email, "password": password], urlParameters: nil)
        case .questions, .courses, .courseDetails, .signUp, .points, .signOut:
            return .request
        case .answers(let answers):
            return .requestParameters(bodyParameters: ["answers": answers], urlParameters: nil)
        case .changePassword(let oldPassword, let newPassword):
            return .requestParameters(bodyParameters: ["oldPassword": oldPassword, "newPassword": newPassword], urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
