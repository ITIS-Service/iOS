//
//  DefaultUserExtension.swift
//  ITISService
//
//  Created by Timur Shafigullin on 07/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

extension DefaultUser: User {
    
    // MARK: - Instance Properties
    
    var id: Int {
        get {
            return Int(exactly: self.uid) ?? 0
        }
        
        set {
            self.uid = Int64(newValue)
        }
    }
    
    var group: Group? {
        get {
            return self.rawGroup
        }
        
        set {
            if let newValue = newValue as? DefaultGroup {
                self.rawGroup = newValue
            } else {
                self.rawGroup = nil
            }
        }
    }
    
}
