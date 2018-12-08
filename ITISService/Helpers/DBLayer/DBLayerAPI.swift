//
//  DBLayerAPI.swift
//  ITISService
//
//  Created by Timur Shafigullin on 07/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

public struct Sorted {
    
    // MARK: - Instance Properties
    
    var key: String
    var ascending: Bool = true
}

// MARK: -

protocol StorageContext {
    
    // MARK: - Instance Methods
    
    func create<T: Storable>(_ model: T.Type) throws -> T
    func update(block: @escaping () -> ()) throws
    
    func delete(object: Storable) throws
    func deleteAll<T: Storable>(_ model: T.Type) throws
    
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?) -> [T]
    func firstOrNew<T: Storable>(_ model: T.Type, id: Int) throws -> T
}
