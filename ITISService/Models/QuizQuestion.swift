//
//  Qustion.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 27/10/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

struct QuizQuestion: Codable {
    
    let id: Int
    let title: String
    let answers: [Answer]
    
}
