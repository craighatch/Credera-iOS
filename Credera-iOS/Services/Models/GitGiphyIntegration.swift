//
//  GitGiphyIntegration.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 5/26/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
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
