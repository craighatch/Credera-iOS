//
//  GitHubData.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 4/17/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
struct GitHubData {
    var userName: String
    var repoName:String
    var commits: [String]
    
    init(withUserName userName:String, withRepoName repoName:String, withCommits commits: [String]) {
        self.userName = userName
        self.repoName = repoName
        self.commits = commits
    }
}


struct GitHubAndGiphyData {
    
    
    var userName: String
    var repoName:String
    var commmitGiphyDetails: [CommitGiphyDetails]
    
    init(withUserName userName:String, withRepoName repoName:String, withCommmitGiphyDetails commmitGiphyDetails: [CommitGiphyDetails]) {
        self.userName = userName
        self.repoName = repoName
        self.commmitGiphyDetails = commmitGiphyDetails
    }
    
    
}





struct CommitGiphyDetails {
    var commit: String
    var imageLink: String
    
    init(commit: String, imageLink: String){
        self.commit = commit
        self.imageLink = imageLink
    }
}
