//
//  GitHubResponse.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 4/12/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation

struct GitHubResponse: Decodable {
    
    let name: String

    init(name: String) {
        self.name = name
    }
    
    enum MyStructKeys: String, CodingKey { // declaring our keys
        case name
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MyStructKeys.self) // defining our (keyed) container
        let name: String = try container.decode(String.self, forKey: .name) // extracting the data
        //let id: Int = try container.decode(Int.self, forKey: .id) // extracting the data
        self.init(name: name)
    }

}
