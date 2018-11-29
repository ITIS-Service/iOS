//
//  UserCourseStatus.swift
//  ITISService
//
//  Created by Timur Shafigullin on 25/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

enum UserCourseStatus: String, Codable {
    
    // MARK: - Type enumerations
    
    case waiting = "WAITING"
    case accepted = "ACCEPTED"
    case rejected = "REJECTED"
    case moved = "MOVED"
    
    // MARK: - Instance Properties
    
    var description: String {
        switch self {
        case .waiting: return "Ожидание подтверждения"
        case .accepted: return "Принят"
        case .rejected: return "Отклонен"
        case .moved: return "Перенесен на другой курс"
        }
    }
}
