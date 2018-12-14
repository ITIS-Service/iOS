//
//  DeviceEndPoint.swift
//  ITISService
//
//  Created by Timur Shafigullin on 14/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

public enum DeviceApi {
    
    // MARK: - Enumaration Cases
    
    case register(name: String, os: String, token: String)
    case unregister(token: String)
}

// MARK: - EndPointType

extension DeviceApi: EndPointType {
    
    // MARK: - Instance Properties
    
    var environmentBaseURL: String {
        return NetworkManager.environment.rawValue + "/users"
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    var path: String {
        switch self {
        case .register:
            return "device/register"
        case .unregister:
            return "device/unregister"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .register, .unregister:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .register(let name, let os, let token):
            return .requestParameters(bodyParameters: ["name": name, "os": os, "token": token], urlParameters: nil)
        case .unregister(let token):
            return .requestParameters(bodyParameters: ["token": token], urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
