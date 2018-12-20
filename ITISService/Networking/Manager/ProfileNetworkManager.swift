//
//  ProfileNetworkManager.swift
//  ITISService
//
//  Created by Timur Shafigullin on 20/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

protocol ProfileNetworkManager {
    
    // MARK: - Instance Properties
    
    func updateSettings(userSettings: UserSettings)
}

class ProfileNetworkManagerImpl: ProfileNetworkManager {
    
    // MARK: - Instance Properties
    
    fileprivate let router = Router<ProfileApi>()
    
    // MARK: -

    var userSettingsManager: UserSettingsManager!
    
    // MARK: - Instance Methods
    
    func updateSettings(userSettings: UserSettings) {
        router.request(.updateSettings(userSettings: userSettings), success: { [weak self] (data, _) in
            if let userSettings = try? JSONDecoder().decode(UserSettings.self, from: data) {
                self?.userSettingsManager.save(userSettings)
                Log.i("User settings updated")
            } else {
                Log.w("Error parse user settings response")
            }
        }) { (error) in
            Log.w("Error update user settings. Message: \(error.message)")
        }
    }
    
}
