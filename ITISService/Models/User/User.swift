//
//  User.swift
//  ITISService
//
//  Created by Timur Shafigullin on 08/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let id: Int
    let firstName: String?
    let lastName: String?
    let email: String?
    let group: Group?
    let passedQuiz: Bool
    
    init(id: Int, firstName: String?, lastName: String?, email: String?, group: Group?, passedQuiz: Bool) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.group = group
        self.passedQuiz = passedQuiz
    }
}
