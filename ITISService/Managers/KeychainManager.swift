//
//  KeychainManager.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 02/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class KeychainManager {
    
    static let shared = KeychainManager()
    
    var token: String? {
        set {
            Log.i("\(newValue ?? "null")")
            KeychainWrapper.standard.set(newValue ?? "", forKey: "token")
        }
        get {
            return KeychainWrapper.standard.string(forKey: "token")
        }
    }
    
}
