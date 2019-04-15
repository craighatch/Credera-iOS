//
//  GitHubApi.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 4/12/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
import Promises

class GitHubApi {
    
    private let requestDefaults: HttpRequestDefaults = HttpRequestDefaults(GitHubProviderConfig.baseUrl, headers: ["Accept": "application/json"])
    private let caller: RequestCaller
    
    init(caller: RequestCaller) {
        self.caller = caller
    }
    
    func getPublicRepos(forUsername userName: String) -> Promise<[GitHubResponse]> {
        let request = HttpRequest(httpMethod: HttpMethod.get, path: "users/"+userName+"/repos", requestDefaults: requestDefaults)
        let response: Promise<[GitHubResponse]> = caller.call(request)
        
        return response
    }
    
    
    
}
