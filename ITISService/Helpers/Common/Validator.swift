//
//  Validator.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 22/10/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

class Validator {
    
    static func validate(studEmail: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@stud.kpfu.ru"
        
        let regexTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return regexTest.evaluate(with: studEmail)
    }
    
}
