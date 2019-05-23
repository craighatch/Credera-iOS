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
    
    let requestCaller: RequestCaller
    
    init() {
        self.caller = RequestCaller()
        self.giphyApi = GiphyApi(caller: self.caller)
        self.requestCaller = RequestCaller()
    }
    
    func getImagesForAllReposAndCommits(withGitHubData gitHubData: [GitHubData]) throws -> Promise<[GitHubAndGiphyData]> {
        do {
            let promises = try gitHubData.map { try getImagesForEachCommit(withGitHubData: $0) }
            return Promises.all(promises)
                .then { gitAndGiphyData in
                    return gitAndGiphyData
            }
        } catch HttpError.NotFound {
            throw GiphyError(kind: GiphyError.ErrorKind.notFound)
        }
        
    }
    
    func getImagesForEachCommit(withGitHubData gitHubData: GitHubData) throws -> Promise<GitHubAndGiphyData> {
        do {
            let promises = try gitHubData.commits.map { try getImageForCommit(forCommit: $0) }
            return Promises.all(promises)
                .then { gitAndGiphyData in
                    return GitHubAndGiphyData(withUserName: gitHubData.userName, withRepoName: gitHubData.repoName, withCommmitGiphyDetails: gitAndGiphyData)
                }
        } catch HttpError.NotFound {
            throw GiphyError(kind: GiphyError.ErrorKind.notFound)
        }
    }
    
    func getImageForCommit(forCommit commit: Commit) throws -> Promise<CommitGiphyDetails> {
        do { return try giphyApi.getImage(withSearchTerm: commit.word)
            .then { response in
                return self.getUIImageFromCommitAndLink(forCommit: commit, fromLink: response.imageLink[0])
                    .then { details in
                        return details
                }
            }
        } catch HttpError.NotFound {
            throw GiphyError(kind: GiphyError.ErrorKind.notFound)
        }
    }
    
    func getUIImageFromCommitAndLink(forCommit commit: Commit, fromLink link: String) -> Promise<CommitGiphyDetails> {
        return self.giphyApi.getUIImage(fromFullUrl: link)
            .then { imageResponse -> CommitGiphyDetails in
                return CommitGiphyDetails(commit: commit, imageData: imageResponse)
        }
    }
}
