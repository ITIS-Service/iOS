//
//  DefaultUserSettingsManager.swift
//  ITISService
//
//  Created by Timur Shafigullin on 20/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

struct DefaultUserSettingsManager<Object>: UserSettingsManager where Object: Storable {
    
    // MARK: - Instance Methods
    
    func save(_ userSettings: UserSettings) {
        try? Services.storageContext.update {
            Translators.userSettingsTranslator.translate(userSettings: userSettings)
        }
    }
    
    func deleteAll() {
        try? Services.storageContext.deleteAll(Object.self)
    }
}
