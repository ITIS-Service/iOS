//
//  SettingsPresenter.swift
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

protocol SettingsPresentationLogic {
    func displaySettings(with response: Settings.InitialState.Response)
    func displayUserInfo(with response: Settings.UserProfile.Response)
    func displayConfirmExitActionSheet()
    func showLoginScreen()
}

class SettingsPresenter: SettingsPresentationLogic {
    
    // MARK: - Instance Properties
    
    weak var viewController: SettingsDisplayLogic!

    // MARK: - Instance Methods
    
    func displaySettings(with response: Settings.InitialState.Response) {
        var items: [TableViewCompatible] = response.settingsNames.map {
            return Settings.TableView.Model(settingName: $0)
        }
        
        let exitModel = Settings.TableView.ExitModel()
        
        items.append(exitModel)
        
        let section = DefaultTableViewSection(items: items, headerTitle: "Основные")
        
        self.viewController.displaySettingRows(with: [section])
    }
    
    func displayUserInfo(with response: Settings.UserProfile.Response) {
        let user = response.user
        
        guard let firstName = user.firstName, let lastName = user.lastName else {
            return
        }
        
        guard let email = user.email else {
            return
        }
        
        guard let groupName = user.group?.name, let courseNumber = user.group?.course else {
            return
        }
        
        let fullName = "\(lastName) \(firstName)"
        let course = "\(courseNumber)"
        
        let viewModel = Settings.UserProfile.ViewModel(name: fullName, email: email, group: groupName, courseNumber: course)
        
        self.viewController.displayUserProfile(with: viewModel)
    }
    
    func displayConfirmExitActionSheet() {
        let title = "Подтверждения выхода"
        
        let confirmTitle = "Выйти"
        let cancelTitle = "Отмена"
        
        self.viewController.displayConfirmExitActionSheet(with: Settings.SelectCell.ViewModel(title: title, confirmTitle: confirmTitle, cancelTitle: cancelTitle))
    }
    
    func showLoginScreen() {
        self.viewController.showLoginScreen()
    }
    
}
