//
//  DayTime.swift
//  ITISService
//
//  Created by Timur Shafigullin on 25/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

enum Day: Int, Codable {
    case monday = 1
    case tuesday = 2
    case wednesday = 3
    case thursday = 4
    case friday = 5
    case saturday = 6
    
    var name: String {
        get {
            switch self {
            case .monday: return "Понедельник"
            case .tuesday: return "Вторник"
            case .wednesday: return "Среда"
            case .thursday: return "Четверг"
            case .friday: return "Пятница"
            case .saturday: return "Суббота"
            }
        }
    }
}

struct DayTime: Codable {
    
    let day: Day
    let times: [String]
    
}
