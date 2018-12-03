//
//  DefaultTableViewSection.swift
//  ITISService
//
//  Created by Timur Shafigullin on 02/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

class DefaultTableViewSection: TableViewSection {
    
    // MARK: - Instance Properties
    
    var items: [TableViewCompatible]
    var headerTitle: String?
    var footerTitle: String?
    
    // MARK: - Initializers
    
    required init(items: [TableViewCompatible], headerTitle: String? = nil, footerTitle: String? = nil) {
        self.items = items
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
    }
}
