//
//  CoreDataUserSettingsTranslator.swift
//  ITISService
//
//  Created by Timur Shafigullin on 20/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

struct CoreDataUserSettingsTranslator: UserSettingsTranslator {
    
    typealias StoredObject = DefaultUserSettings
    
    // MARK: - Instance Properties
    
    let storageContext: StorageContext
    
    // MARK: - Instance Methods
    
    @discardableResult
    func translate(userSettings: UserSettings) -> DefaultUserSettings {
        guard let storedObject = try? storageContext.firstOrNew(StoredObject.self, id: userSettings.id) else {
            fatalError()
        }
        
        storedObject.uid = Int64(userSettings.id)
        storedObject.courseStatusNotificationEnabled = userSettings.courseStatusNotificationEnabled
        storedObject.pointsNotificationEnabled = userSettings.pointsNotificationEnabled
        
        return storedObject
    }
    
    func translate(storedObject: DefaultUserSettings) -> UserSettings {
        guard let id = Int(exactly: storedObject.uid) else {
            fatalError()
        }
        
        return UserSettings(id: id, courseStatusNotificationEnabled: storedObject.courseStatusNotificationEnabled, pointsNotificationEnabled: storedObject.pointsNotificationEnabled)
    }
    
}
