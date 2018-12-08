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
        return networkManager
    }()
    
}
