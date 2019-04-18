//
//  GitHubCommitMessage.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 4/17/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
struct GitHubCommitMessage: Decodable {
    
    var message: String
    
    init(name: String) {
        self.message = name
    }
    
    enum MyStructKeys: String, CodingKey { // declaring our keys
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MyStructKeys.self)
        let name: String = try container.decode(String.self, forKey: .message)
        self.init(name: name)
    }
    
}
