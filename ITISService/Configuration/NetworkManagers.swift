//
//  NetworkManagers.swift
//  ITISService
//
//  Created by Timur Shafigullin on 10/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

enum NetworkManagers {
    
    static var userNetworkManager: UserNetworkManager = {
        let networkManager = UserNetworkManagerImpl()
        networkManager.userManager = Managers.userManager
        networkManager.courseListManager = Managers.courseListManager
        networkManager.courseDetailsManager = Managers.courseDetailsManager
        return networkManager
    }()
    
    static var deviceNetworkManager: DeviceNetworkManager = {
        let deviceNetworkManager = DeviceNetworkManagerImpl()
        return deviceNetworkManager
    }()
    
    static var profileNetworkManager: ProfileNetworkManager = {
       let profileNetworkManager = ProfileNetworkManagerImpl()
        profileNetworkManager.userSettingsManager = Managers.userSettingsManager
        return profileNetworkManager
    }()
    
}
