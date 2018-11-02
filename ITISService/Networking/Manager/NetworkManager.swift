//
//  NetworkManager.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 01/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let environment: NetworkEnvironment = .local
    
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
