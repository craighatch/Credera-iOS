//
//  GitHubData.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 4/17/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
import UIKit
struct GitHubData {
    var userName: String
    var repoName: String
    var commits: [Commit]
    
    init(withUserName userName:String, withRepoName repoName:String, withCommits commits: [Commit]) {
        self.userName = userName
        self.repoName = repoName
        self.commits = commits
    }
}

struct GitHubAndGiphyData {
    
    var userName: String
    var repoName: String
    var commmitGiphyDetails: [CommitGiphyDetails]
    
    init(withUserName userName: String, withRepoName repoName: String, withCommmitGiphyDetails commmitGiphyDetails: [CommitGiphyDetails]) {
        self.userName = userName
        self.repoName = repoName
        self.commmitGiphyDetails = commmitGiphyDetails
    }
}

struct CommitGiphyDetails {
    var commit: Commit
    var image: UIImage
    init(commit: Commit, image: UIImage) {
        self.commit = commit
        self.image = image
    }
}

struct Commit {
    var word: String
    var occurrances: Int
    
    init( word: String, occurrances: Int) {
        self.word = word
        self.occurrances = occurrances
    }
}
