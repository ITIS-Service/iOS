//
//  PointsInteractor.swift
//  ITISService
//
//  Created by Timur Shafigullin on 02/12/2018.
//  Copyright (c) 2018 Timur Shafigullin. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PointsBusinessLogic {
    func fetchPoints()
}

protocol PointsDataStore: class {
    var courseID: Int? { get set }
    var userPoints: UserPoints? { get set }
}

class PointsInteractor: PointsBusinessLogic, PointsDataStore {
    
    // MARK: - Instance Properties
    
    var presenter: PointsPresentationLogic!
    var worker: PointsWorker!
    var userNetworkManager: UserNetworkManager!
    
    // MARK: -
    
    var courseID: Int?
    var userPoints: UserPoints?
    
    var pointsUpdateHandler: Disposable?
    
    // MARK: - Initializers
    
    init() {
        self.subscribeToPointsUpdateEvent()
    }
    
    deinit {
        self.unsubscribeFromPointsUpdateEvent()
    }

    // MARK - Instance Methods
    
    fileprivate func subscribeToPointsUpdateEvent() {
        self.pointsUpdateHandler = Managers.pointsManager.didPointsUpdateEvent.addHandler(target: self, handler: { [weak self] (updateCourseID) in
            guard let strongSelf = self else {
                return
            }
            
            guard let courseID = strongSelf.courseID else {
                return
            }
            
            if updateCourseID == courseID {
                self?.fetchPoints()
            }
        })
    }
    
    fileprivate func unsubscribeFromPointsUpdateEvent() {
        if let pointsUpdateHandler = self.pointsUpdateHandler {
            pointsUpdateHandler.dispose()
            self.pointsUpdateHandler = nil
        }
    }
    
    // MARK: -
    
    func setupInitialState() {
        if let userPoints = self.userPoints {
            self.presenter.displayPoints(with: Points.Fetch.Response(total: userPoints.total, points: userPoints.points))
        }
    }

    func fetchPoints() {
        guard let courseID = self.courseID else {
            return
        }
        
        if self.userPoints == nil {
            self.presenter.showActivityIndicator(true)
        }
        
        self.userNetworkManager.fetchPoints(courseID: courseID, success: { [weak self] (userPoints) in
            self?.presenter.showActivityIndicator(false)
            self?.presenter.displayPoints(with: Points.Fetch.Response(total: userPoints.total, points: userPoints.points))
        }) { [weak self] (error) in
            self?.presenter.showActivityIndicator(false)
            self?.presenter.didFetchPointsFailed(with: Points.Error.Response(errorMessage: error.message))
        }
    }
    
}
