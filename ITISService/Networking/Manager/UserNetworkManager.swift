//
//  UserNetworkManager.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 01/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

protocol UserNetworkManager {
    
    // MARK: - Instance Methods
    
    func registration(with email: String, password: String, success: @escaping (() -> Void), failure: @escaping (ExceptionResponse) -> Void)
    
    func login(with email: String, password: String, success: @escaping ((LoginResponseDto) -> Void), failure: @escaping (ExceptionResponse) -> Void)
    
    func fetchQuestions(success: @escaping ([QuizQuestion]) -> Void, failure: @escaping (ExceptionResponse) -> Void)
    
    func sendAnswers(with answers: [String: Int], success: @escaping (Response) -> Void, failure: @escaping (ExceptionResponse) -> Void)
    
    func fetchCourses(success: @escaping (ListCourses) -> (), failure: @escaping (ExceptionResponse) -> ())
    
    func fetchCourseDetails(courseID: Int, success: @escaping (CourseDetails) -> (), failure: @escaping (ExceptionResponse) -> ())
    
    func signUpCourse(with courseID: Int, success: @escaping (CourseDetails) -> (), failure: @escaping (ExceptionResponse) -> ()) 
}

class UserNetworkManagerImpl: UserNetworkManager {
    
    // MARK: - Instance Properties
    
    fileprivate let router = Router<UserApi>()
    
    // MARK: - Instance Methods
    
    fileprivate func extractToken(from response: URLResponse) {
        if let httpResponse = response as? HTTPURLResponse, let authHeader = httpResponse.allHeaderFields[Common.Token.headerString] as? String {
            let token = authHeader.replacingOccurrences(of: Common.Token.prefix, with: "")
            KeychainManager.shared.token = token
        }
    }
    
    // MARK: -
    
    func registration(with email: String, password: String, success: @escaping (() -> Void), failure: @escaping (ExceptionResponse) -> Void) {
        router.request(.registration(email: email, password: password), success: { [weak self] (data, response) in
            self?.extractToken(from: response)
            success()
        }) { (error) in
            failure(error)
        }
    }
    
    func login(with email: String, password: String, success: @escaping ((LoginResponseDto) -> Void), failure: @escaping (ExceptionResponse) -> Void) {
        router.request(.login(email: email, password: password), success: { [weak self] (data, response) in
            if let loginResponseDto = try? JSONDecoder().decode(LoginResponseDto.self, from: data) {
                self?.extractToken(from: response)
                success(loginResponseDto)
            } else {
                failure(ExceptionResponse.parseException())
            }
        }) { (error) in
            failure(error)
        }
    }
    
    func fetchQuestions(success: @escaping ([QuizQuestion]) -> Void, failure: @escaping (ExceptionResponse) -> Void) {
        router.request(.questions, success: { (data, _) in
            if let questions = try? JSONDecoder().decode([QuizQuestion].self, from: data) {
                success(questions)
            } else {
                failure(ExceptionResponse.parseException())
            }
        }) { (error) in
            failure(error)
        }
    }
    
    func sendAnswers(with answers: [String: Int], success: @escaping (Response) -> Void, failure: @escaping (ExceptionResponse) -> Void) {
        router.request(.answers(answers: answers), success: { (data, _) in
            if let response = try? JSONDecoder().decode(Response.self, from: data) {
                success(response)
            } else {
                failure(ExceptionResponse.parseException())
            }
        }) { (error) in
            failure(error)
        }
    }
    
    func fetchCourses(success: @escaping (ListCourses) -> (), failure: @escaping (ExceptionResponse) -> ()) {
        router.request(.courses, success: { (data, _) in
            if let listCourses = try? JSONDecoder().decode(ListCourses.self, from: data) {
                success(listCourses)
            } else {
                failure(ExceptionResponse.parseException())
            }
        }) { (error) in
            failure(error)
        }
    }
    
    func fetchCourseDetails(courseID: Int, success: @escaping (CourseDetails) -> (), failure: @escaping (ExceptionResponse) -> ())  {
        router.request(.courseDetails(courseID: courseID), success: { (data, _) in
            if let courseDetails = try? JSONDecoder().decode(CourseDetails.self, from: data) {
                success(courseDetails)
            } else {
                failure(ExceptionResponse.parseException())
            }
        }) { (error) in
            failure(error)
        }
    }
    
    func signUpCourse(with courseID: Int, success: @escaping (CourseDetails) -> (), failure: @escaping (ExceptionResponse) -> ()) {
        router.request(.signUp(courseID: courseID), success: { (data, _) in
            if let courseDetails = try? JSONDecoder().decode(CourseDetails.self, from: data) {
                success(courseDetails)
            } else {
                failure(ExceptionResponse.parseException())
            }
        }) { (error) in
            failure(error)
        }
    }
}
