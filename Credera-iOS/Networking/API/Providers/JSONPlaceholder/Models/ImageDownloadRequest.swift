//
//  ImageDownloadRequest.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 4/22/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation

/*
 * Example of subclassing `HttpRequest` class to make constructing requests easier, less repetitive and/or to override
 * methods from it.
 */
class ImageDownLoadRequest: HttpRequest {
    
    init(httpMethod: HttpMethod, baseUrl: String, path: String) {
        super.init(httpMethod: httpMethod, path: path, baseUrl: baseUrl)
    }

}
