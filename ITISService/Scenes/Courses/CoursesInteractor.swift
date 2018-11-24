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
}

protocol CoursesDataStore {
    //var name: String { get set }
}

class CoursesInteractor: CoursesBusinessLogic, CoursesDataStore {
    
    // MARK: - Instance Properties
    
    var presenter: CoursesPresentationLogic!
    var worker: CoursesWorker!
    var userNetworkManager: UserNetworkManager!
    
    var listCourses: ListCourses?

    // MARK: - Instance Methods
    
    func fetchCourses() {
        self.presenter.showActivityIndicator(true)
        self.userNetworkManager.fetchCourses(success: { [weak self] (listCourses) in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.presenter.showActivityIndicator(false)
            strongSelf.listCourses = listCourses
            strongSelf.presenter.displayCourses(response: Courses.List.Response(listCourses: listCourses))
        }) { [weak self] (error) in
            self?.presenter.showActivityIndicator(false)
            self?.presenter.showAlert(with: error)
        }
    }
    
}
