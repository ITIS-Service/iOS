//
//  Configurable.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 27/10/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

protocol Configurable {
    
    associatedtype T
    var model: T? { get set }
    func configure(with model: T)
    
}
