//
//  GitHubService.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 4/17/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
import Promises

class GitHubService {
    
    let caller: RequestCaller
    let gitHubApi: GitHubApi
    let giphyService: GitHubGiphyIntegrationService
    init() {
        self.caller = RequestCaller()
        self.gitHubApi = GitHubApi(caller: self.caller)
        self.giphyService = GitHubGiphyIntegrationService()
    }
    
    func getRepos(forUsername username: String, numberOfRepos repoLimit: Int) -> Promise<[GitHubData]> {
        return gitHubApi.getPublicRepos(forUsername: username).then { repos -> [GitHubData] in
            return repos.prefix(repoLimit).map {GitHubData(withUserName: username, withRepoName: $0.name, withCommits: [])}
        }
    }
    
    func populateCommonCommitWords(limitedTo limit: Int, withRepos gitHubData: [GitHubData]) -> Promise<[GitHubData]> {
        
        let promises = gitHubData.map { getGitHubCommits(gitHubData: $0, limitedTo: limit)}
        
        return Promises.all(promises).then { repoAndCommitData in
            return repoAndCommitData
        }
        
    }
    
    func getGitHubCommits(gitHubData: GitHubData, limitedTo limit: Int) -> Promise<GitHubData> {
        return gitHubApi.getCommits(witUserName: gitHubData.userName, withRepoName: gitHubData.repoName).then { values in
            return GitHubData(
                withUserName: gitHubData.userName,
                withRepoName: gitHubData.repoName,
                withCommits: Array(self.createWordCountMap(gitHubRepoResponses: values).prefix(limit))
            )
        }
    }
    
    func createWordCountMap(gitHubRepoResponses: [GitHubRepoResponse]) -> [Commit] {
        let words = gitHubRepoResponses.flatMap {$0.commit.message.split(separator: " ")}.map {String($0)}
        
        var wordCount: [String: Int] = [:]
        words.forEach { word in
            if let occurances = wordCount[word] {
                wordCount[word] = occurances + 1
            } else {
                wordCount[word] = 1
            }
        }
        let popularCommits = wordCount.sorted {$0.value > $1.value}
            .map { Commit(word: $0.key.lowercased(), occurrances: $0.value) }
            .map { self.removePunctuation(commit: $0) }
            .filter { !WordUtil.boringWords.contains($0.word)}
        
        return popularCommits
    }
    
    func removePunctuation(commit: Commit) -> Commit {
        var newWord = commit.word
        WordUtil.punctuation.forEach({
            newWord = newWord.replacingOccurrences(of: $0, with: "")
        })
        return Commit(word: newWord, occurrances: commit.occurrances)
    }
    
}
