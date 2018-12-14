//
//  DeviceNetworkManager.swift
//  ITISService
//
//  Created by Timur Shafigullin on 14/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

protocol DeviceNetworkManager {
    
    // MARK: - Instance Properties
    
    func register(name: String, os: String, token: String, success: @escaping (Response) -> (), failure: @escaping (ExceptionResponse) -> ())
    func unregister(token: String, success: @escaping (Response) -> (), failure: @escaping (ExceptionResponse) -> ())
    
}

class DeviceNetworkManagerImpl: DeviceNetworkManager {
    
    // MARK: - Instance Properties
    
    fileprivate let router = Router<DeviceApi>()
    
    // MARK: - Instance Methods
    
    func register(name: String, os: String, token: String, success: @escaping (Response) -> (), failure: @escaping (ExceptionResponse) -> ()) {
        router.request(.register(name: name, os: os, token: token), success: { (data, response) in
            if let response = try? JSONDecoder().decode(Response.self, from: data) {
                success(response)
            } else {
                failure(ExceptionResponse.parseException())
            }
        }) { (error) in
            failure(error)
        }
    }
    
    func unregister(token: String, success: @escaping (Response) -> (), failure: @escaping (ExceptionResponse) -> ()) {
        router.request(.unregister(token: token), success: { (data, response) in
            if let response = try? JSONDecoder().decode(Response.self, from: data) {
                success(response)
            } else {
                failure(ExceptionResponse.parseException())
            }
        }) { (error) in
            failure(error)
        }
    }
}
