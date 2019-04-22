//
//  RequestCaller.swift
//  Credera-iOS
//
//  Created by Fernando Berrios on 3/12/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
import Promises

public class RequestCaller {
    
    private lazy var decoder = JSONDecoder()
    private var urlSession: URLSession
    
    public init(config: URLSessionConfiguration) {
        urlSession = URLSession(configuration: config)
    }
    
    public convenience init() {
        self.init(config: URLSessionConfiguration.default)
    }
    
    /*
     * Makes an asynchronous HTTP request and returns a Promise with the JSON response mapped
     * to a model object that implements `Decodable`
     */
    public func call<D: Decodable>(_ request: HttpRequest) -> Promise<D> {
        
        if !request.isValid() {
            return Promise(NetworkError.InvalidRequest)
        }
        
        return Promise<D>(on: .global(qos: .background), { (fullfill, reject) in
            self.urlSession.dataTask(with: request.asURLRequest()) { (data, response, error) in
                // TODO: When is this damn thing populated?!
                if let error = error {
                    reject(error)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    
                    do {
                        let responseData = data ?? Data()
                        if (200...399).contains(statusCode) {
                            let result = try self.decoder.decode(D.self, from: responseData)
                            fullfill(result)
                        } else {
                            let httpError = self.mapToHttpError(statusCode: statusCode)
                            reject(httpError ?? NetworkError.Unknown)
                        }
                    } catch let decodeError {
                        // TODO: Log this decodeError using the log framework thingy...
                        reject(NetworkError.DecodeJson)
                    }
                } else {
                    reject(NetworkError.UnknownResponse)
                }
            }.resume()
        })
    }
    
    private func mapToHttpError(statusCode: Int) -> HttpError? {
        return HttpError(rawValue: statusCode) ?? nil
    }
    

    public func downloadImage(_ request: HttpRequest) -> Promise<Data> {
        return Promise<Data>(on: .global(qos: .background), { (fullfill, reject) in
            self.urlSession.dataTask(with: request.asURLRequest()) { (data, response, error) in
                // TODO: When is this damn thing populated?!
                if let error = error {
                    reject(error)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    
                    do {
                        let responseData = data ?? Data()
                        if (200...399).contains(statusCode) {
                            fullfill(responseData)
                        } else {
                            let httpError = self.mapToHttpError(statusCode: statusCode)
                            reject(httpError ?? NetworkError.Unknown)
                        }
                    } catch let decodeError {
                        // TODO: Log this decodeError using the log framework thingy...
                        reject(NetworkError.DecodeJson)
                    }
                } else {
                    reject(NetworkError.UnknownResponse)
                }
                }.resume()
        })
    }
    
    
    
}
