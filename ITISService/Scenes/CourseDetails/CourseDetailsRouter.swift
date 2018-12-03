//
//  CourseDetailsRouter.swift
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

@objc protocol CourseDetailsRoutingLogic {
    func routeToUserPoints(segue: UIStoryboardSegue) 
}

protocol CourseDetailsDataPassing {
    var dataStore: CourseDetailsDataStore! { get }
}

class CourseDetailsRouter: NSObject, CourseDetailsRoutingLogic, CourseDetailsDataPassing {
    
    // MARK: - Instance Properties
    
    weak var viewController: CourseDetailsViewController!
    var dataStore: CourseDetailsDataStore!
    
    // MARK: - Instance Methods
    
    fileprivate func passDataToUserPoints(source: CourseDetailsDataStore, destination: PointsDataStore) {
        destination.course = source.course
    }
    
    // MARK: -

    func routeToUserPoints(segue: UIStoryboardSegue) {
        guard let dataStoreHolder = segue.destination as? PointsDataStoreHolder else {
            return
        }
        
        self.passDataToUserPoints(source: self.dataStore, destination: dataStoreHolder.datastore)
    }
    
}