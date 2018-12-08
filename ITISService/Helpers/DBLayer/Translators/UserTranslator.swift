//
//  UserTranslator.swift
//  ITISService
//
//  Created by Timur Shafigullin on 08/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

protocol UserTranslator {
    
    associatedtype StoredObject: Storable
    
    // MARK: - Instance Methods
    
    @discardableResult
    func translate(user: User) -> StoredObject
    func translate(storedObject: StoredObject) -> User
}
