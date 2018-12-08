//
//  GroupTranslator.swift
//  ITISService
//
//  Created by Timur Shafigullin on 08/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

protocol GroupTranslator {
    
    associatedtype StoredObject: Storable
    
    // MARK: - Instance Methods
    
    func translate(group: Group) -> StoredObject
    func translate(storedObject: StoredObject) -> Group
}
