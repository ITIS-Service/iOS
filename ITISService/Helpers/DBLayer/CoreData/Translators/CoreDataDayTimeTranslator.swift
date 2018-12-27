//
//  CoreDataDayTimeTranslator.swift
//  ITISService
//
//  Created by Timur Shafigullin on 26/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

struct CoreDataDayTimeTranslator: DayTimeTranslator {
    
    typealias StoredObject = DefaultDayTime
    
    // MARK: - Instance Properties
    
    let storageContext: StorageContext
    
    // MARK: - Instance Methods
    
    @discardableResult
    func translate(dayTime: DayTime) -> DefaultDayTime {
        guard let storedObject = try? self.storageContext.firstOrNew(StoredObject.self, id: dayTime.id) else {
            fatalError()
        }
        
        storedObject.uid = Int64(dayTime.id)
        storedObject.day = Int16(dayTime.day.rawValue)
        storedObject.times = dayTime.times as NSObject
        
        return storedObject
    }
    
    func translate(storedObject: DefaultDayTime) -> DayTime {
        guard let id = Int(exactly: storedObject.uid) else {
            fatalError()
        }
        
        guard let day = Day(rawValue: Int(storedObject.day)) else {
            fatalError()
        }
        
        guard let times = storedObject.times as? [String] else {
            fatalError()
        }
        
        return DayTime(id: id, day: day, times: times)
    }
    
}
