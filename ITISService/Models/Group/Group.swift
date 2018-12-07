//
//  Group.swift
//  ITISService
//
//  Created by Timur Shafigullin on 07/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

protocol Group {
    
    // MARK: - Instance Properties
    
    var id: Int { get set }
    
    var name: String? { get set }
    var course: Int? { get set }
    
    var users: [User]? { get set }
}
