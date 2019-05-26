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
        let request = HttpRequest(httpMethod: HttpMethod.get, path: "users/\(userName)/repos", requestDefaults: requestDefaults)
        let response: Promise<[GitHubResponse]> = caller.call(request)
        
        return response
    }
    
    func getCommits(witUserName userName: String, withRepoName repo: String) -> Promise<[GitHubRepoResponse]> {
        let request = HttpRequest(httpMethod: HttpMethod.get, path: "repos/\(userName)/\(repo)/commits", requestDefaults: requestDefaults)
        let response: Promise<[GitHubRepoResponse]> = caller.call(request)
        return response
//        do{
//
////            let dataMapper: (Data) -> [GitHubRepoResponse] = ResponseMapper.makeDecodingMapper()
////            let response: Promise<[GitHubRepoResponse]> = caller.asdf(request, mapper: dataMapper)
//
//
//
//
//
//            let response: Promise<[GitHubRepoResponse]> = caller.asdf(request, mapper: {
////                data -> GitHubRepoResponse in
//                let decoder = JSONDecoder()
//                return decoder.decode([GitHubRepoResponse].self, from: $0)
//            })
//
//            let response2: Promise<[Data]> = caller.asdf(request, mapper: {
//                data in
////                (data:Data) -> Data in
//                return data as! Data
//            })
//
//            return response
//
//        }catch {
//
//        }
    }
}
