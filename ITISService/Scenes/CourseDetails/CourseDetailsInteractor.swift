//
//  CourseDetailsInteractor.swift
//  ITISService
//
//  Created by Timur Shafigullin on 25/11/2018.
//  Copyright (c) 2018 Timur Shafigullin. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CourseDetailsBusinessLogic {
    func setupInitialState()
    func fetchCourseDetails()
    func signUpCourse()
    func signOutCourse()
    func courseName() -> String
}

protocol CourseDetailsDataStore: class {
    var course: Course! { get set }
}

class CourseDetailsInteractor: CourseDetailsBusinessLogic, CourseDetailsDataStore {
    
    // MARK: - Instance Properties
    
    var presenter: CourseDetailsPresentationLogic!
    var worker: CourseDetailsWorker!
    var userNetworkManager: UserNetworkManager!
    
    var course: Course!
    
    // MARK: - Instance Methods

    func setupInitialState() {
        self.presenter.displayInitialState(with: CourseDetailsModels.InitialSate.Response(course: self.course))
        self.presenter.showActivityIndicator(true)
    }
    
    func fetchCourseDetails() {
        self.userNetworkManager.fetchCourseDetails(courseID: self.course.id, success: { [weak self] (courseDetails) in
            self?.presenter.showActivityIndicator(false)
            self?.presenter.displayCourseDetails(with: CourseDetailsModels.Fetch.Response(courseDetails: courseDetails))
        }) { [weak self] (error) in
            self?.presenter.showActivityIndicator(false)
            self?.presenter.showAlert(with: error)
        }
    }
    
    func signUpCourse() {
        self.presenter.showActivityIndicator(true)
        self.userNetworkManager.signUpCourse(with: self.course.id, success: { [weak self] (courseDetails) in
            self?.presenter.showActivityIndicator(false)
            self?.presenter.displayCourseDetails(with: CourseDetailsModels.Fetch.Response(courseDetails: courseDetails))
            self?.presenter.updateListCourse()
        }) { [weak self] (error) in
            self?.presenter.showActivityIndicator(false)
            self?.presenter.showAlert(with: error)
        }
    }
    
    func signOutCourse() {
        self.presenter.showActivityIndicator(true)
        self.userNetworkManager.signOutCourse(with: self.course.id, success: { [weak self] (courseDetails) in
            self?.presenter.showActivityIndicator(false)
            self?.presenter.displayCourseDetails(with: CourseDetailsModels.Fetch.Response(courseDetails: courseDetails))
            self?.presenter.updateListCourse()
        }) { [weak self] (error) in
            self?.presenter.showActivityIndicator(false)
            self?.presenter.showAlert(with: error)
        }
    }
    
    func courseName() -> String {
        return self.course.name
    }

}
