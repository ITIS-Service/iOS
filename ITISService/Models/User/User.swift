//
//  User.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 27/10/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

protocol User {
    
    // MARK: - Instance Properties
    
    var id: Int { get set }
    
    var firstName: String? { get set }
    var lastName: String? { get set }
    var email: String? { get set }
    
    var passedQuiz: Bool { get set }
    
    var group: Group? { get set }
}
