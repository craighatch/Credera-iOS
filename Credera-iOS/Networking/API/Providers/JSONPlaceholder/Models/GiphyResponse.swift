//
//  GiphyResponse.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 4/17/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
struct GihpyResponse: Decodable {
    
    var imageLink: [String] = []
    
    enum DataCodingKeys: String, CodingKey {
        case response = "Response"
        case data
        case images
        case original_still
        case url
    }
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var data = try container.nestedUnkeyedContainer(forKey: CodingKeys.data)
        while !data.isAtEnd {
            let element = try data.nestedContainer(keyedBy: DataCodingKeys.self)
            let images = try element.nestedContainer(keyedBy: DataCodingKeys.self, forKey: DataCodingKeys.images)
            let original_still = try images.nestedContainer(keyedBy: DataCodingKeys.self, forKey: DataCodingKeys.original_still)
            imageLink.append(try original_still.decode(String.self, forKey: DataCodingKeys.url))
        }
    }
    
}
