//
//  CoursesInteractor.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 27/10/2018.
//  Copyright (c) 2018 Timur Shafigullin. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CoursesBusinessLogic {
    func fetchCourses()
    func selectCourse(at indexPath: IndexPath, numberOfSections: Int)
    func setupInitialState()
}

protocol CoursesDataStore {
    var listCourses: CourseList? { get }
    var selectedCourse: Course? { get }
    
    func updateListCourses()
}

class CoursesInteractor: CoursesBusinessLogic, CoursesDataStore {
    
    // MARK: - Nested Types
    
    fileprivate struct Constants {
        
        // MARK: - Properties
        
        static let suggestedCoursesSectionIndex = 0
        static let allCoursesSectionIndex = 1
    }
    
    // MARK: - Instance Properties
    
    fileprivate var userUnauthorizedObserver: AnyObject?
    fileprivate var userSignInObserver: AnyObject?
    fileprivate var userFinishQuizObserver: AnyObject?
    fileprivate var userSignUpObserver: AnyObject?
    
    fileprivate var courseDetailsHandler: Disposable?
    fileprivate var pointsChangeHandler: Disposable?
    
    // MARK: -
    
    var presenter: CoursesPresentationLogic!
    var worker: CoursesWorker!
    var userNetworkManager: UserNetworkManager!
    
    var listCourses: CourseList?
    var selectedCourse: Course?
    
    // MARK: - Initializers
    
    init() {
        self.subscribeToUserUnauthorizedNotification()
        self.subsribeToUserSignInNotification()
        self.subsribeToUserSignUpNotification()
        self.subscribeToUserFinishQuizNotification()
        self.subscribeToCourseDetailsEvents()
        self.subscribeToPointsChangeEvents()
    }
    
    deinit {
        self.unsubscribeFromUserUnauthorizedNotification()
        self.unsubscribeFromUserSignInNotification()
        self.unsubscriveFromUserSignUpNotification()
        self.unsubscribeFromUserFinishQuiz()
        self.unsubscriveFromUserSignUpNotification()
        self.unsubscribeFromPointsChangeEvents()
    }

    // MARK: - Instance Methods
    
    fileprivate func subscribeToUserUnauthorizedNotification() {
        self.userUnauthorizedObserver = NotificationCenter.default.addObserver(forName: .userUnauthorized, object: nil, queue: OperationQueue.main, using: { [weak self] (notification) in
            self?.presenter.showLoginScreen()
        })
    }
    
    fileprivate func subsribeToUserSignInNotification() {
        self.userSignInObserver = NotificationCenter.default.addObserver(forName: .userDidSignIn, object: nil, queue: OperationQueue.main, using: { [weak self] (notification) in
            self?.fetchCourses()
        })
    }
    
    fileprivate func subscribeToUserFinishQuizNotification() {
        self.userFinishQuizObserver = NotificationCenter.default.addObserver(forName: .userDidFinishQuiz, object: nil, queue: OperationQueue.main, using: { [weak self] (notification) in
            self?.fetchCourses()
        })
    }
    
    fileprivate func subsribeToUserSignUpNotification() {
        self.userSignUpObserver = NotificationCenter.default.addObserver(forName: .userDidSignUp, object: nil, queue: OperationQueue.main, using: { [weak self] (notification) in
            self?.fetchCourses()
        })
    }
    
    fileprivate func subscribeToCourseDetailsEvents() {
        self.courseDetailsHandler = Managers.courseDetailsManager.didStatusChangeEvent.addHandler(target: self) { [weak self] (courseID) in
            let response = Courses.CourseStatus.Response(courseID: courseID)
            
            self?.presenter.didCourseDetailsStatusChanged(with: response)
        }
    }
    
    fileprivate func subscribeToPointsChangeEvents() {
        self.pointsChangeHandler = Managers.pointsManager.didPointsChangedEvent.addHandler(target: self, handler: { [weak self] (courseID) in
            let response = Courses.Points.Response(courseID: courseID)
            
            self?.presenter.didPointsChanged(with: response)
        })
    }
    
    fileprivate func unsubscribeFromUserUnauthorizedNotification() {
        if let userUnauthorizedObserver = self.userUnauthorizedObserver {
            NotificationCenter.default.removeObserver(userUnauthorizedObserver)
            self.userUnauthorizedObserver = nil
        }
    }
    
    fileprivate func unsubscribeFromUserSignInNotification() {
        if let userSignInObserver = self.userSignInObserver {
            NotificationCenter.default.removeObserver(userSignInObserver)
            self.userSignInObserver = nil
        }
    }
    
    fileprivate func unsubscribeFromUserFinishQuiz() {
        if let userFinishQuizObserver = self.userFinishQuizObserver {
            NotificationCenter.default.removeObserver(userFinishQuizObserver)
            self.userFinishQuizObserver = nil
        }
    }
    
    fileprivate func unsubscriveFromUserSignUpNotification() {
        if let userSignUpObserver = self.userSignUpObserver {
            NotificationCenter.default.removeObserver(userSignUpObserver)
            self.userSignUpObserver = nil
        }
    }
    
    fileprivate func unsubscribeFromCourseDetailsEvents() {
        if let courseDetailsHandler = self.courseDetailsHandler {
            courseDetailsHandler.dispose()
            self.courseDetailsHandler = nil
        }
    }
    
    fileprivate func unsubscribeFromPointsChangeEvents() {
        if let pointsChangeHandler = self.pointsChangeHandler {
            pointsChangeHandler.dispose()
            self.pointsChangeHandler = nil
        }
    }
    
    // MARK: -
    
    func setupInitialState() {
        if let courseList = Managers.courseListManager.fetch() {
            self.listCourses = courseList
            self.presenter.displayCourses(response: Courses.List.Response(listCourses: courseList))
        }
    }
    
    func updateListCourses() {
        self.fetchCourses()
    }
    
    func fetchCourses() {
        guard Managers.userManager.first() != nil else {
            return
        }
        
        if self.listCourses == nil {
            self.presenter.showActivityIndicator(true)
        }
        
        self.userNetworkManager.fetchCourses(success: { [weak self] (listCourses) in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.presenter.showActivityIndicator(false)
            strongSelf.listCourses = listCourses
            strongSelf.presenter.displayCourses(response: Courses.List.Response(listCourses: listCourses))
        }) { [weak self] (error) in
            self?.presenter.showActivityIndicator(false)
            self?.presenter.didFetchCoursesFailed(with: Courses.Error.Response(exceptionResponse: error))
        }
    }
    
    // MARK: -
    
    func selectCourse(at indexPath: IndexPath, numberOfSections: Int) {
        guard let listCourses = self.listCourses else {
            return
        }
        
        var sections = [[Course]]()
        
        if !listCourses.userCourses.isEmpty {
            sections.append(listCourses.userCourses)
        }
        
        if !listCourses.suggestedCourses.isEmpty {
            sections.append(listCourses.suggestedCourses)
        }
        
        if !listCourses.allCourses.isEmpty {
            sections.append(listCourses.allCourses)
        }
        
        self.selectedCourse = sections[indexPath.section][indexPath.row]
    }
}
