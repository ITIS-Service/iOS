//
//  PointTranslator.swift
//  ITISService
//
//  Created by Timur Shafigullin on 27/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

protocol PointTranslator {
    
    associatedtype StoredObject: Storable
    
    // MARK: - Instance Methods
    
    func translate(point: Point) -> StoredObject
    func translate(storedObject: StoredObject) -> Point
}
