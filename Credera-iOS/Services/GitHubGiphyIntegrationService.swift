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
    
    func getImagesForAllReposAndCommits(withGitHubData gitHubData: [GitHubData]) -> Promise<[GitHubAndGiphyData]> {
        let promises = gitHubData.map { getImagesForEachCommit(withGitHubData: $0) }
        return Promises.all(promises)
            .then { gitAndGiphyData in
                return gitAndGiphyData
            }.catch { error in
                let gitGphyData =  gitHubData.map { GitHubAndGiphyData(withUserName: $0.userName, withRepoName: $0.repoName, withCommmitGiphyDetails: $0.commits.map { CommitGiphyDetails(commit: $0, imageLink: "https://www.keycdn.com/img/support/429-too-many-requests-lg@2x.webp") }) }
        }
    }
    
    func getImagesForEachCommit(withGitHubData gitHubData: GitHubData) -> Promise<GitHubAndGiphyData> {
        
        let promises = gitHubData.commits.map { getImageForWord(withSearchWord: $0) }
        return Promises.all(promises)
            .then { gitAndGiphyData in
                return GitHubAndGiphyData(withUserName: gitHubData.userName, withRepoName: gitHubData.repoName, withCommmitGiphyDetails: gitAndGiphyData)
        }
    }
    
    func getImageForWord(withSearchWord word: String) -> Promise<CommitGiphyDetails> {
        return giphyApi.getImage(withSearchTerm: word).then { response in
            return CommitGiphyDetails(commit: word, imageLink: response.imageLink[0])
        }
    }
    
}
