//
//  CoursesViewController.swift
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

protocol CoursesDataStoreHolder {
    var dataStore: CoursesDataStore! { get }
}

protocol CoursesDisplayLogic: LoaderDisplayLogic, ErrorMessagePresenter {
    func displayListCourses(sections: [Courses.TableView.Section])
    func showLoginScreen()
    func showCourseDetailsScreen(with data: Any?)
    func showPointsScreen(with data: Any?)
}

class CoursesViewController: UIViewController, CoursesDisplayLogic, CoursesDataStoreHolder {
    
    // MARK: - Nested Types
    
    fileprivate enum Constants {
        
        // MARK: - Properties
        
        static let backgroundColor = UIColor(red: 42 / 255.0, green: 42 / 255.0, blue: 42 / 255.0, alpha: 1)
    }
    
    // MARK: -
    
    fileprivate enum Segues {
        
        // MARK: - Properties
        
        static let courseDetails = "CourseDetails"
        static let showLogin = "ShowLogin"
        static let coursePoints = "CoursePoints"
    }
    
    // MARK: - Instance Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: -
    
    private let datasource = CoursesDatasource()
    
    var interactor: CoursesBusinessLogic!
    var router: (NSObjectProtocol & CoursesRoutingLogic & CoursesDataPassing)!
    var dataStore: CoursesDataStore!
    
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
        let interactor = CoursesInteractor()
        let presenter = CoursesPresenter()
        let router = CoursesRouter()
        viewController.interactor = interactor
        viewController.router = router
        viewController.dataStore = interactor
        interactor.presenter = presenter
        interactor.userNetworkManager = NetworkManagers.userNetworkManager
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            switch scene {
            case Segues.courseDetails:
                self.router.routeToCourseDetails(segue: segue, sender: sender)
                
            case Segues.coursePoints:
                self.router.routeToPoints(segue: segue, sender: sender)
                
            default:
                break
            }
        }
    }
    
    // MARK: - Instance Methods
    
    private func configureDesign() {
        self.tableView.register(CourseTableViewCell.nib(), forCellReuseIdentifier: CourseTableViewCell.identifier())
        self.tableView.dataSource = self.datasource
        self.tableView.delegate = self.datasource
        self.tableView.tableFooterView = UIView()
        
        self.datasource.onTap = { [unowned self] (indexPath) in
            self.interactor.selectCourse(at: indexPath, numberOfSections: self.tableView.numberOfSections)
            self.performSegue(withIdentifier: Segues.courseDetails, sender: nil)
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureDesign()
        self.interactor.fetchCourses()
    }
    
    // MARK: - CoursesDisplayLogic Methods
    
    func displayListCourses(sections: [Courses.TableView.Section]) {
        self.datasource.sections = sections
        self.tableView.reloadData()
    }
    
    func showLoginScreen() {
        self.performSegue(withIdentifier: Segues.showLogin, sender: nil)
    }
    
    func showCourseDetailsScreen(with data: Any?) {
        self.performSegue(withIdentifier: Segues.courseDetails, sender: data)
    }
    
    func showPointsScreen(with data: Any?) {
        self.performSegue(withIdentifier: Segues.coursePoints, sender: data)
    }
}
