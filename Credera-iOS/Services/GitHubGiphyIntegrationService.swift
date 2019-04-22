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
    
    func getImagesForAllReposAndCommits(withGitHubData gitHubData: [GitHubData]) -> Promise<[GitHubAndGiphyData]> {
        let promises = gitHubData.map { getImagesForEachCommit(withGitHubData: $0) }
        return Promises.all(promises)
            .then { gitAndGiphyData in
                return gitAndGiphyData
            }
//            .catch { error in
//                return gitHubData.map { GitHubAndGiphyData(withUserName: $0.userName, withRepoName: $0.repoName, withCommmitGiphyDetails: $0.commits.map { getUIImageFromCommitAndLink(forWord: $0, fromLink: "https://www.keycdn.com/img/support/429-too-many-requests-lg@2x.webp") })
//                }
//        }
    }
    
    func getImagesForEachCommit(withGitHubData gitHubData: GitHubData) -> Promise<GitHubAndGiphyData> {
        
        let promises = gitHubData.commits.map { getImageForWord(withSearchWord: $0) }
        return Promises.all(promises)
            .then { gitAndGiphyData in
                return GitHubAndGiphyData(withUserName: gitHubData.userName, withRepoName: gitHubData.repoName, withCommmitGiphyDetails: gitAndGiphyData)
        }
    }
    
    func getImageForWord(withSearchWord word: String) -> Promise<CommitGiphyDetails> {
        return giphyApi.getImage(withSearchTerm: word)
            .then { response in
                return self.getUIImageFromCommitAndLink(forWord: word, fromLink: response.imageLink[0])
                    .then { details in
                        return details
                }
        }
    }
    
    func getUIImageFromCommitAndLink(forWord word: String, fromLink link: String) -> Promise<CommitGiphyDetails> {
        return self.giphyApi.getUIImage(fromFullUrl: link)
            .then { imageResponse -> CommitGiphyDetails in
                let image = UIImage(data: imageResponse)
                return CommitGiphyDetails(commit: word, image: image!)
        }
    }
    
    func asdf(forWord word: String, fromLink link: String) -> Promise<CommitGiphyDetails> {
        let url: URL = URL(string: link)!
        let baseUrl = "https://" + url.host!
        var path = url.path
        path.remove(at: path.startIndex)
        let imageRequest: ImageDownLoadRequest = ImageDownLoadRequest(httpMethod: HttpMethod.get, baseUrl: baseUrl, path: path)
        return self.requestCaller.downloadImage(imageRequest)
            .then { imageResponse -> CommitGiphyDetails in
                let image = UIImage(data: imageResponse)
                return CommitGiphyDetails(commit: word, image: image!)
        }
    }
}
