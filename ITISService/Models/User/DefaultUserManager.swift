//
//  DefaultUserManager.swift
//  ITISService
//
//  Created by Timur Shafigullin on 08/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

struct DefaultUserManager<Object>: UserManager where Object: Storable {

    // MARK: - Instance methods
    
    func save(_ user: User) {
        try? Services.storageContext.update {
            Translators.userTranslator.translate(user: user)
        }
    }
    
    func first() -> User? {
        guard let storedObject = Services.storageContext.fetch(Object.self, predicate: nil, sorted: nil).first else {
            return nil
        }
        
        return Translators.userTranslator.translate(storedObject: storedObject as! CoreDataUserTranslator.StoredObject)
    }
}
