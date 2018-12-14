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
    
    // MARK: - Nested Types
    
    fileprivate enum Keys {
        
        // MARK: - Type Properties
        
        static let token = "token"
        static let deviceToken = "device_token"
    }
    
    // MARK: - Instance Methods
    
    func clear() {
        let _ = KeychainWrapper.standard.removeAllKeys()
    }
    
    // MARK: - Instance Properties
    
    static let shared = KeychainManager()
    
    // MARK: -
    
    var token: String? {
        set {
            if let newValue = newValue {
                Log.i("\(newValue)")
                KeychainWrapper.standard.set(newValue, forKey: Keys.token)
            } else {
                KeychainWrapper.standard.removeObject(forKey: Keys.token)
            }
        }
        
        get {
            return KeychainWrapper.standard.string(forKey: Keys.token)
        }
    }
    
    var deviceToken: String? {
        set {
            if let newValue = newValue {
                Log.i(newValue)
                KeychainWrapper.standard.set(newValue, forKey: Keys.deviceToken)
            } else {
                KeychainWrapper.standard.removeObject(forKey: Keys.deviceToken)
            }
        }
        
        get {
            return KeychainWrapper.standard.string(forKey: Keys.token)
        }
    }
}
