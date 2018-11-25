//
//  CourseDetailsViewController.swift
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

protocol CourseDetailsDataStoreHolder {
    var courseDetailsDataStore: CourseDetailsDataStore! { get }
}

protocol CourseDetailsDisplayLogic: LoaderDisplayLogic, ErrorMessagePresenter {
    func configureInitialState(with viewModel: CourseDetailsModels.InitialSate.ViewModel)
    func showCourseDetails(with viewModel: CourseDetailsModels.Fetch.ViewModel)
}

class CourseDetailsViewController: UIViewController, CourseDetailsDisplayLogic, CourseDetailsDataStoreHolder {
    
    // MARK: - Constants
    
    fileprivate struct Constants {
        
    }
    
    // MARK: - Instance Properties
    
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    @IBOutlet fileprivate weak var teacherNameLabel: UILabel!
    @IBOutlet fileprivate weak var teacherLinkTextView: UITextView!
    @IBOutlet fileprivate weak var placeLabel: UILabel!
    @IBOutlet fileprivate weak var timeLabel: UILabel!
    @IBOutlet fileprivate weak var managementView: UIView!
    @IBOutlet fileprivate weak var academicPerformanceButton: UIButton!
    @IBOutlet fileprivate weak var signUpCourseButton: UIButton!
    
    // MARK: -
    
    var interactor: CourseDetailsBusinessLogic!
    var router: (NSObjectProtocol & CourseDetailsRoutingLogic & CourseDetailsDataPassing)!
    var courseDetailsDataStore: CourseDetailsDataStore!
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = CourseDetailsInteractor()
        let presenter = CourseDetailsPresenter()
        let router = CourseDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        viewController.courseDetailsDataStore = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: - Instance Methods
    
    // MARK: -
    
    private func configureDesign() {
        self.interactor.setupInitialState()
        
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDesign()
    }
    
    // MARK: - CourseDetailsDisplayLogic Methods
    
    func configureInitialState(with viewModel: CourseDetailsModels.InitialSate.ViewModel) {
        self.navigationController?.title = viewModel.name
        self.descriptionLabel.text = viewModel.description
    }
    
    func showCourseDetails(with viewModel: CourseDetailsModels.Fetch.ViewModel) {
        self.teacherNameLabel.text = viewModel.teacherName
        
        self.teacherLinkTextView.attributedText = viewModel.teacherLink
        self.teacherLinkTextView.linkTextAttributes = [
            .foregroundColor: viewModel.foregroundColor,
            .underlineStyle: viewModel.underlineStyle.rawValue
        ]
        
        self.placeLabel.text = viewModel.place
        self.timeLabel.text = viewModel.times
        
        self.managementView.isHidden = !viewModel.shouldShowManagementView
        self.academicPerformanceButton.isHidden = !viewModel.shouldShowAcademicPerformanceButton
        self.signUpCourseButton.isHidden = !viewModel.shouldShowSignUpCourseButton
    }
    
}
