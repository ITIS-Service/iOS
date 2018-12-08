//
//  Managers.swift
//  ITISService
//
//  Created by Timur Shafigullin on 08/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

enum Managers {
    
    static let userManager: UserManager = DefaultUserManager<DefaultUser>()
    
}
