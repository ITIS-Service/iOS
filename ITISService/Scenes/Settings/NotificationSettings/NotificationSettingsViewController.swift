//
//  NotificationSettingsViewController.swift
//  ITISService
//
//  Created by Timur Shafigullin on 19/12/2018.
//  Copyright (c) 2018 Timur Shafigullin. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol NotificationSettingsDisplayLogic: class {
    func showNotificationSettings(with sections: [TableViewSection])
}

class NotificationSettingsViewController: UIViewController, NotificationSettingsDisplayLogic {
    
    // MARK: - Constants
    
    fileprivate struct Constants {
        
    }
    
    // MARK: - Instance Properties
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    // MARK: -
    
    fileprivate let datasource = NotificationSettingsDatasource()
    
    // MARK: -
    
    var interactor: NotificationSettingsBusinessLogic!
    var router: (NSObjectProtocol & NotificationSettingsRoutingLogic & NotificationSettingsDataPassing)!
    
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
        let interactor = NotificationSettingsInteractor()
        let presenter = NotificationSettingsPresenter()
        let router = NotificationSettingsRouter()
        viewController.interactor = interactor
        viewController.router = router
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
    
    private func configureDesign() {
        self.tableView.dataSource = self.datasource
        self.tableView.delegate = self.datasource
        self.tableView.tableFooterView = UIView()
        self.tableView.register(NotificationSettingTableViewCell.nib(), forCellReuseIdentifier: NotificationSettingTableViewCell.identifier())
        
        self.interactor.setupInitialState()
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDesign()
    }
    
    // MARK: - NotificationSettingsDisplayLogic Methods
    
    func showNotificationSettings(with sections: [TableViewSection]) {
        self.datasource.sections = sections
        self.tableView.reloadData()
    }
    
}