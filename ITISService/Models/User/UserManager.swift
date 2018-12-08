//
//  UserManager.swift
//  ITISService
//
//  Created by Timur Shafigullin on 08/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

protocol UserManager {
    
    // MARK: - Instance Methods
    
    func save(_ user: User)
    func first() -> User?
}
