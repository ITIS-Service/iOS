//
//  Router.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 01/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {
    
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, success: @escaping NetworkRouterSuccess, failure: @escaping NetworkRouterFailure) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            NetworkLogger.log(request: request)
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                guard let data = data, let response = response as? HTTPURLResponse else {
                    DispatchQueue.main.async {
                        let noResponse = ExceptionResponse(message: NetworkResponse.noResponse.rawValue, errorCode: .noResponse)
                        failure(noResponse)
                    }
                    return
                }
                NetworkLogger.log(response: response, data: data)
                
                DispatchQueue.main.async {
                    switch self.handleNetworkResponse(response, data: data) {
                    case .success:
                        success(data, response)
                    case .failure(let exceptionResponse):
                        failure(exceptionResponse)
                    }
                }
            })
        } catch {
            DispatchQueue.main.async {
                let requestError = ExceptionResponse(message: NetworkResponse.requestError.rawValue, errorCode: .requestError)
                failure(requestError)
            }
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse, data: Data) -> Result<ExceptionResponse> {
        switch response.statusCode {
        case 200...299:
            return .success
        case 400...500:
            if let exceptionResponse = try? JSONDecoder().decode(ExceptionResponse.self, from: data) {
                return .failure(exceptionResponse)
            } else {
                return .failure(ExceptionResponse(message: NetworkResponse.internalError.rawValue, errorCode: .internalError))
            }
        case 501...599:
            return .failure(ExceptionResponse(message: NetworkResponse.internalError.rawValue, errorCode: .internalError))
        default:
            return .failure(ExceptionResponse(message: NetworkResponse.unknownError.rawValue, errorCode: .internalError))
        }
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters, let urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let additionalHeaders):
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}
