//
//  TeacherTranslator.swift
//  ITISService
//
//  Created by Timur Shafigullin on 26/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

protocol TeacherTranslator {
    
    associatedtype StoredObject: Storable
    
    // MARK: - Instance Methods
    
    func translate(teacher: Teacher) -> StoredObject
    func translate(storedObject: StoredObject) -> Teacher
}
