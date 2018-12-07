//
//  CoreDataObject.swift
//  ITISService
//
//  Created by Timur Shafigullin on 07/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject: Storable {
    
    // MARK: - Instance Properties
    
    public static var entityName: String {
        return self.entity().name ?? String(describing: self)
    }
    
}
