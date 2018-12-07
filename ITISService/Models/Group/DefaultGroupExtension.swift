//
//  DefaultGroupExtension.swift
//  ITISService
//
//  Created by Timur Shafigullin on 07/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

extension DefaultGroup: Group {
    
    // MARK: - Instance Properties
    
    var id: Int {
        get {
            return Int(exactly: self.uid) ?? 0
        }
        
        set {
            self.uid = Int64(newValue)
        }
    }
    
    var course: Int? {
        get {
            return Int(self.rawCourse)
        }
        
        set {
            if let newValue = newValue {
                self.rawCourse = Int16(newValue)
            }
        }
    }
    
    var users: [User]? {
        get {
            return (self.rawUsers?.array as? [User]) ?? []
        }
        
        set {
            if let newValue = newValue {
                self.rawUsers = NSOrderedSet(array: newValue)
            } else {
                self.rawUsers = nil
            }
        }
    }
}
