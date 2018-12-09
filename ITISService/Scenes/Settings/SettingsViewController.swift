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
    func displayUserProfile(with viewModel: Settings.UserProfile.ViewModel)
    func displayConfirmExitActionSheet(with viewModel: Settings.SelectCell.ViewModel)
    func showLoginScreen()
}

class SettingsViewController: UIViewController, SettingsDisplayLogic {
    
    // MARK: - Nested Types
    
    fileprivate enum Segues {
        
        // MARK: - Type Properties
        
        static let showLoginScreen = "ShowLoginScreen"
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
        self.tableView.tableFooterView = UIView()
        
        self.tableView.register(SettingTableViewCell.nib(), forCellReuseIdentifier: SettingTableViewCell.identifier())
        self.tableView.register(ExitTableViewCell.nib(), forCellReuseIdentifier: ExitTableViewCell.identifier())
        
        self.datasource.onTap = { [unowned self] indexPath in
            self.interactor.selectCellRequest(with: Settings.SelectCell.Request(indexPath: indexPath))
        }
        
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
    
    func displayUserProfile(with viewModel: Settings.UserProfile.ViewModel) {
        self.nameLabel.text = viewModel.name
        self.emailLabel.text = viewModel.email
        self.groupNameLabel.text = viewModel.group
        self.courseNumberLabel.text = viewModel.courseNumber
    }
    
    func displayConfirmExitActionSheet(with viewModel: Settings.SelectCell.ViewModel) {
        let alertController = UIAlertController(title: viewModel.title, message: nil, preferredStyle: .actionSheet)
        
        let confirmAction = UIAlertAction(title: viewModel.confirmTitle, style: .destructive) { [unowned self] (action) in
            self.interactor.exitProfile()
        }
        
        let cancelAction = UIAlertAction(title: viewModel.cancelTitle, style: .cancel)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    func showLoginScreen() {
        self.performSegue(withIdentifier: Segues.showLoginScreen, sender: nil)
    }
}
