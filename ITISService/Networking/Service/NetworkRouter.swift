//
//  NetworkRouter.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 01/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

public typealias NetworkRouterSuccess = (_ data: Data, _ response: URLResponse) -> ()
public typealias NetworkRouterFailure = (_ error: ExceptionResponse) -> ()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, success: @escaping NetworkRouterSuccess, failure: @escaping NetworkRouterFailure)
    func cancel()
}
