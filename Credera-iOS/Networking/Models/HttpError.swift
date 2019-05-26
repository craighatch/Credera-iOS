//
//  HttpError.swift
//  Credera-iOS
//
//  Created by Fernando Berrios on 3/19/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation

public enum HttpError: Int, Error {
    case BadRequest = 400
    case Unauthorized = 401
    case Forbidden = 403
    case NotFound = 404
    case MethodNotAllowed = 405
    case TooManyRequests = 429
    case InternalServerError = 500
    case NotImplemented = 501
    case ServiceUnavailable = 503
}
