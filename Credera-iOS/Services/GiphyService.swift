//
//  GiphyService.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 4/17/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
import Promises

class GitHubGiphyIntegrationService {
    
    let caller: RequestCaller
    let giphyApi: GiphyApi
    
    init() {
        self.caller = RequestCaller()
        self.giphyApi = GiphyApi(caller: self.caller)
    }
    
    func getImagesForCommits(withGitHubData data: [GitHubData]) -> Promise<[GitHubAndGiphyData]> {
        let promises = data.map { getImageLinkForCommitWord(withGitHubData: $0)}
        return Promises.all(promises).then { gitHubAndGiphyData in
            return gitHubAndGiphyData
        }
    }
    
    func getImageLinkForCommitWord(withGitHubData data: GitHubData) -> Promise<GitHubAndGiphyData> {
       
        let promises = data.commits.map { getImageForSearchWord(withSearchString: $0) }
        
        return Promises.all(promises).then { gitHubAndGiphyData in
            return GitHubAndGiphyData(withUserName: data.userName, withRepoName: data.repoName, withCommmitGiphyDetails: gitHubAndGiphyData)
        }
    }
    
    func getImageForSearchWord(withSearchString data: String) -> Promise<CommitGiphyDetails> {
        return giphyApi.getImage(withSearchTerm: data)
            .then{ (value) -> CommitGiphyDetails in
                return CommitGiphyDetails(commit: data, imageLink: value.stuff!)
        }
    }
    
    
    
}
