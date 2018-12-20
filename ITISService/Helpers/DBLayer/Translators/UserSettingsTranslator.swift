//
//  UserSettingsTranslator.swift
//  ITISService
//
//  Created by Timur Shafigullin on 20/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

protocol UserSettingsTranslator {
    
    associatedtype StoredObject: Storable
    
    // MARK: - Instance Methods
    
    @discardableResult
    func translate(userSettings: UserSettings) -> StoredObject
    func translate(storedObject: StoredObject) -> UserSettings
}
