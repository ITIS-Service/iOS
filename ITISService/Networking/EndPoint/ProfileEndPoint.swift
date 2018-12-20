//
//  ProfileEndPoint.swift
//  ITISService
//
//  Created by Timur Shafigullin on 20/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

enum ProfileApi {
    
    // MARK: - Enumeration Cases
    
    case updateSettings(userSettings: UserSettings)
}

// MARK: - EndPointType

extension ProfileApi: EndPointType {
    
    // MARK: - Instance Properties
    
    var environmentBaseURL: String {
        return NetworkManager.environment.rawValue + "/users/profile"
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    var path: String {
        switch self {
        case .updateSettings:
            return "settings"
        }
    }
        
    var httpMethod: HTTPMethod {
        switch self {
        case .updateSettings:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .updateSettings(let userSettings):
            return .requestParameters(bodyParameters: ["courseStatusNotificationEnabled": userSettings.courseStatusNotificationEnabled, "pointsNotificationEnabled": userSettings.pointsNotificationEnabled], urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
