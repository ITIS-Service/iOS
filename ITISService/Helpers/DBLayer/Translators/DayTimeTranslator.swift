//
//  DayTimeTranslator.swift
//  ITISService
//
//  Created by Timur Shafigullin on 26/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

protocol DayTimeTranslator {
    
    associatedtype StoredObject: Storable
    
    // MARK: - Instance Methods
    
    @discardableResult
    func translate(dayTime: DayTime) -> StoredObject
    func translate(storedObject: StoredObject) -> DayTime
    
}
