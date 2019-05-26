//
//  GitHubResponse.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 4/12/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation

struct GitHubResponse: Decodable {
    
    var name: String

    init(name: String) {
        self.name = name
    }
    
    enum MyStructKeys: String, CodingKey { // declaring our keys
        case name
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MyStructKeys.self)
        let name: String = try container.decode(String.self, forKey: .name)
        self.init(name: name)
    }

}
