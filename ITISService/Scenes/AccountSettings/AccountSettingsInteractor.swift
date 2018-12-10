//
//  AccountSettingsInteractor.swift
//  ITISService
//
//  Created by Timur Shafigullin on 10/12/2018.
//  Copyright (c) 2018 Timur Shafigullin. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol AccountSettingsBusinessLogic {
    func prepareInitialState()
}

protocol AccountSettingsDataStore {
    
}

class AccountSettingsInteractor: AccountSettingsBusinessLogic, AccountSettingsDataStore {
    
    // MARK: - Instance Properties
    
    var presenter: AccountSettingsPresentationLogic!
    var worker: AccountSettingsWorker!
    
    // MARK: - Instance Methods
    
    func prepareInitialState() {
        self.presenter.displayInitialAccountSettingsRows()
    }
    
}
