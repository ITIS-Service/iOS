//
//  Translators.swift
//  ITISService
//
//  Created by Timur Shafigullin on 08/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

enum Translators {
    
    static let userTranslator = CoreDataUserTranslator(storageContext: Services.storageContext,
                                                       groupTranslator: Translators.groupTranslator,
                                                       userSettingsTranslator: Translators.userSettingsTranslator)
    
    static let groupTranslator = CoreDataGroupTranslator(storageContext: Services.storageContext)
    static let userSettingsTranslator = CoreDataUserSettingsTranslator(storageContext: Services.storageContext)
    
}
