//
//  ExceptionResponse.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 01/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

public struct ExceptionResponse: Codable {
    
    enum ErrorCode: String, Codable {
        // Inner codes
        case noResponse = "NO_RESPONSE"
        case internalError = "INTERNAL_ERROR"
        case requestError = "REQUEST_ERROR"
        
        // Server codes
        case resourceNotFound = "RESOURCE_NOT_FOUND"
        case loginError = "LOGIN_ERROR"
        case alreadyRegistered = "ALREADY_REGISTERED"
    }
    
    let message: String
    let errorCode: ErrorCode
    
}
