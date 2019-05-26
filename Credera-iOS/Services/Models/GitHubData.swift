//
//  GitHubData.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 4/17/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
struct GitHubData: Codable {
    var userName: String
    var repoName: String
    var commits: [Commit]
    
    init(withUserName userName: String, withRepoName repoName: String, withCommits commits: [Commit]) {
        self.userName = userName
        self.repoName = repoName
        self.commits = commits
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
