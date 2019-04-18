//
//  GitHubRepoReponse.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 4/17/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
struct GitHubRepoResponse: Decodable {
    
    var commit: GitHubCommitMessage
    
    init(commit: GitHubCommitMessage) {
        self.commit = commit
    }
    
    enum MyStructKeys: String, CodingKey { // declaring our keys
        case commit
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MyStructKeys.self)
        let commit: GitHubCommitMessage = try container.decode(GitHubCommitMessage.self, forKey: .commit)
        self.init(commit: commit)
    }
    
}
