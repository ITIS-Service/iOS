//
//  NetworkManager.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 01/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

enum NetworkEnvironment: String {
    case production = "https://itis-courses.herokuapp.com"
    case local = "http://172.20.10.9:8080"
}

class NetworkManager {
    
    #if PRODUCTION
    static let environment: NetworkEnvironment = .production
    #else
    static let environment: NetworkEnvironment = .local
    #endif
    
}

enum NetworkResponse: String {
    case success
    case internalError = "Ошибка сервера. Повторите запрос позже"
    case unknownError = "Неизвестная ошибка. Повторите запрос позже"
    case noResponse = "Нет ответа от сервера"
    case requestError = "Нет связи с сервером. Проверьте интернет подключение"
}

enum Result<ExceptionResponse> {
    case success
    case failure(ExceptionResponse)
}
