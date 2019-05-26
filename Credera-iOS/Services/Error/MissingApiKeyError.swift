//
//  ApiKeyError.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 5/24/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
class MissingApiKeyError: Error {
    public static let message: String = "Giphy needs an API key, ask Craig for his."
}
