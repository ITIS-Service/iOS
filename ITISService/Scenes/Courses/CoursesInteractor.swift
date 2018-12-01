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
}

protocol CoursesDataStore {
    var listCourses: ListCourses? { get }
    var selectedCourse: Course? { get }
}

class CoursesInteractor: CoursesBusinessLogic, CoursesDataStore {
    
    // MARK: - Nested Types
    
    fileprivate struct Constants {
        
        // MARK: - Properties
        
        static let suggestedCoursesSectionIndex = 0
        static let allCoursesSectionIndex = 1
    }
    
    // MARK: - Instance Properties
    
    var presenter: CoursesPresentationLogic!
    var worker: CoursesWorker!
    var userNetworkManager: UserNetworkManager!
    
    var listCourses: ListCourses?
    var selectedCourse: Course?

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
