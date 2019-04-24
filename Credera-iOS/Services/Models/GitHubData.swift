//
//  GitHubData.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 4/17/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
import UIKit
struct GitHubData: Codable {
    var userName: String
    var repoName: String
    var commits: [Commit]
    
    init(withUserName userName:String, withRepoName repoName: String, withCommits commits: [Commit]) {
        self.userName = userName
        self.repoName = repoName
        self.commits = commits
    }
}

struct GitHubAndGiphyData: Codable {
    
    let userName: String
    let repoName: String
    let commmitGiphyDetails: [CommitGiphyDetails]
    
    init(withUserName userName: String, withRepoName repoName: String, withCommmitGiphyDetails commmitGiphyDetails: [CommitGiphyDetails]) {
        self.userName = userName
        self.repoName = repoName
        self.commmitGiphyDetails = commmitGiphyDetails
    }
}

struct CommitGiphyDetails: Codable {
    let commit: Commit
    let imageData: Data
    init(commit: Commit, imageData: Data) {
        self.commit = commit
        self.imageData = imageData
    }
}

struct Commit: Codable {
    let word: String
    let occurrances: Int
    
    init( word: String, occurrances: Int) {
        self.word = word
        self.occurrances = occurrances
    }
}
