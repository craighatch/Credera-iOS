//
//  GitHubGiphyIntegrationService.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 4/18/19.
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
    
    
    func getImagesForAllReposAndCommits(withGitHubData gitHubData: [GitHubData]) -> Promise<[GitHubAndGiphyData]>{
        let promises = gitHubData.map { getImagesForEachCommit(withGitHubData: $0) }
        return Promises.all(promises)
            .then{ gitAndGiphyData in
                return gitAndGiphyData
        }
    }
    
    
    func getImagesForEachCommit(withGitHubData gitHubData: GitHubData) -> Promise<GitHubAndGiphyData>{
        
        let promises = gitHubData.commits.map { getImageForWord(withSearchWord: $0) }
        return Promises.all(promises)
            .then{ gitAndGiphyData in
                return GitHubAndGiphyData(withUserName: gitHubData.userName, withRepoName: gitHubData.repoName, withCommmitGiphyDetails: gitAndGiphyData)
        }
    }
    
    
    func getImageForWord(withSearchWord word: String) -> Promise<CommitGiphyDetails>{
        return giphyApi.getImage(withSearchTerm: word).then{ response in
            return CommitGiphyDetails(commit: word, imageLink: response.stuff!)
        }
    }
    
}
