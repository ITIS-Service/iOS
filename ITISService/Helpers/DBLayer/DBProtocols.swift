//
//  DBProtocols.swift
//  ITISService
//
//  Created by Timur Shafigullin on 07/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

public protocol Storable {
    
    // MARK: - Instance Properties
    
    static var entityName: String { get }
}
