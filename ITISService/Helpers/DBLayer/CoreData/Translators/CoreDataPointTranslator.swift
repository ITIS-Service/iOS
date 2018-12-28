//
//  CoreDataPointTranslator.swift
//  ITISService
//
//  Created by Timur Shafigullin on 27/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

struct CoreDataPointTranslator: PointTranslator {
    
    typealias StoredObject = DefaultPoint
    
    // MARK: - Instance Properties
    
    let storageContext: StorageContext
    
    // MARK: - Instance Methods
    
    func translate(point: Point) -> DefaultPoint {
        guard let storedObject = try? self.storageContext.firstOrNew(StoredObject.self, id: point.id) else {
            fatalError()
        }
        
        storedObject.uid = Int64(point.id)
        storedObject.title = point.title
        storedObject.pointDescription = point.description
        storedObject.count = Int64(point.count)
        
        return storedObject
    }
    
    func translate(storedObject: DefaultPoint) -> Point {
        guard let id = Int(exactly: storedObject.uid) else {
            fatalError()
        }
        
        guard let count = Int(exactly: storedObject.count) else {
            fatalError()
        }
        
        return Point(id: id, title: storedObject.title!, description: storedObject.pointDescription!, count: count)
    }
    
}
