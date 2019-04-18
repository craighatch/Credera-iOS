//
//  GiphyApi.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 4/17/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
import Promises

class GiphyApi {
    
    private let requestDefaults: HttpRequestDefaults = HttpRequestDefaults(GiphyProviderConfig.baseUrl, headers: ["Accept": "application/json"])
    private let caller: RequestCaller
    
    init(caller: RequestCaller) {
        self.caller = caller
    }
    
    func getImage(withSearchTerm searchTerm: String) -> Promise<GihpyResponse> {
        let request = HttpRequest(
            httpMethod: HttpMethod.get,
            path: "v1/gifs/search",
            baseUrl: GiphyProviderConfig.baseUrl,
            query: [
                "api_key": "",
                "q": searchTerm,
                "rating": "g",
                "lang": "en",
                "fmt": "json",
                "limit": 1
            ],
            headers: ["Accept": "application/json"])
        
        let response: Promise<GihpyResponse> = caller.call(request)
        
        return response
    }
}
