//
//  Services.swift
//  ITISService
//
//  Created by Timur Shafigullin on 07/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

enum Services {
    
    // MARK: - Storage
    
    static let storageContext: StorageContext = CoreDataStorageContext(identifier: "ITISService")
    
}
