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
    let gitHubService: GitHubService
    
    init() {
        self.caller = RequestCaller()
        self.giphyApi = GiphyApi(caller: self.caller)
        self.gitHubService = GitHubService(caller: self.caller)
    }
    
    public func getGiphyImageForMostCommonCommitWords(forUserName gitHubUsername: String, numberOfRepos: Int, numberofWords: Int) -> Promise<[GitHubAndGiphyData]> {
        return self.gitHubService.getRepos(forUsername: gitHubUsername, numberOfRepos: numberOfRepos)
            .then { repos in
                self.gitHubService.populateCommonCommitWords(limitedTo: numberofWords, withRepos: repos)
                    .then { reposAndCommits in
                        try self.getImagesForAllReposAndCommits(withGitHubData: reposAndCommits)
                            .then { gitHubAndGiphyData in
                                return gitHubAndGiphyData
                        }
                }
        }
    }
    
    private func getImagesForAllReposAndCommits(withGitHubData gitHubData: [GitHubData]) throws -> Promise<[GitHubAndGiphyData]> {
        let promises = try gitHubData.map { try getImagesForEachCommit(withGitHubData: $0) }
        return Promises.all(promises)
            .then { gitAndGiphyData in
                return gitAndGiphyData
        }
    }
    
    private func getImagesForEachCommit(withGitHubData gitHubData: GitHubData) throws -> Promise<GitHubAndGiphyData> {
        let promises = try gitHubData.commits.map { try getImageForCommit(forCommit: $0) }
        return Promises.all(promises)
            .then { gitAndGiphyData in
                return GitHubAndGiphyData(withUserName: gitHubData.userName, withRepoName: gitHubData.repoName, withCommmitGiphyDetails: gitAndGiphyData)
        }
    }
    
    private func getImageForCommit(forCommit commit: Commit) throws -> Promise<CommitGiphyDetails> {
        return try giphyApi.getImage(withSearchTerm: commit.word)
            .then { response in
                return self.getUIImageFromCommitAndLink(forCommit: commit, fromLink: response.imageLink[0])
                    .then { details in
                        return details
                }
            }
    }
    
    private func getUIImageFromCommitAndLink(forCommit commit: Commit, fromLink link: String) -> Promise<CommitGiphyDetails> {
        return self.giphyApi.getUIImage(fromFullUrl: link)
            .then { imageResponse -> CommitGiphyDetails in
                return CommitGiphyDetails(commit: commit, imageData: imageResponse)
        }
    }
}
