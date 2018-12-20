//
//  CoreDataUserTranslator.swift
//  ITISService
//
//  Created by Timur Shafigullin on 08/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

struct CoreDataUserTranslator: UserTranslator {
    
    typealias StoredObject = DefaultUser
    
    // MARK: - Instance Properties
    
    let storageContext: StorageContext
    let groupTranslator: CoreDataGroupTranslator
    let userSettingsTranslator: CoreDataUserSettingsTranslator
    
    // MARK: - Instance Methods
    
    @discardableResult
    func translate(user: User) -> StoredObject {
        guard let storedObject = try? storageContext.firstOrNew(StoredObject.self, id: user.id) else {
            fatalError()
        }
       
        storedObject.uid = Int64(user.id)
        storedObject.firstName = user.firstName
        storedObject.lastName = user.lastName
        storedObject.email = user.email
        storedObject.passedQuiz = user.passedQuiz
        
        if let group = user.group {
            storedObject.group = self.groupTranslator.translate(group: group)
        }
        
        if let userSettings = user.userSettings {
            storedObject.userSettings = self.userSettingsTranslator.translate(userSettings: userSettings)
        }
        
        return storedObject
    }
    
    func translate(storedObject: StoredObject) -> User {
        guard let id = Int(exactly: storedObject.uid) else {
            fatalError()
        }
        
        var group: Group?
        var userSettings: UserSettings?
        
        if let storedGroup = storedObject.group {
            group = self.groupTranslator.translate(storedObject: storedGroup)
        }
        
        if let storedUserSettings = storedObject.userSettings {
            userSettings = self.userSettingsTranslator.translate(storedObject: storedUserSettings)
        }
        
        return User(id: id, firstName: storedObject.firstName, lastName: storedObject.lastName, email: storedObject.email, group: group, passedQuiz: storedObject.passedQuiz, userSettings: userSettings)
    }
}
