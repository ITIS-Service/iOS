//
//  SettingsViewController.swift
//  ITISService
//
//  Created by Timur Shafigullin on 05/12/2018.
//  Copyright (c) 2018 Timur Shafigullin. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SettingsDisplayLogic: class {
    func displaySettingRows(with sections: [TableViewSection])
}

class SettingsViewController: UIViewController, SettingsDisplayLogic {
    
    // MARK: - Constants
    
    fileprivate struct Constants {
        
    }
    
    // MARK: - Instance Properties
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var emailLabel: UILabel!
    @IBOutlet fileprivate weak var groupNameLabel: UILabel!
    @IBOutlet fileprivate weak var courseNumberLabel: UILabel!
    
    // MARK: -
    
    var interactor: SettingsBusinessLogic!
    var router: (NSObjectProtocol & SettingsRoutingLogic & SettingsDataPassing)!
    
    // MARK: -
    
    fileprivate let datasource = SettingsTableViewDatasource()
    
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
        let interactor = SettingsInteractor()
        let presenter = SettingsPresenter()
        let router = SettingsRouter()
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
    
    // MARK: -
    
    private func configureDesign() {
        self.tableView.dataSource = self.datasource
        self.tableView.delegate = self.datasource
        
        self.interactor.prepareInitialState()
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDesign()
    }
    
    // MARK: - SettingsDisplayLogic Methods
    
    func displaySettingRows(with sections: [TableViewSection]) {
        self.datasource.sections = sections
        self.tableView.reloadData()
    }
    
}
