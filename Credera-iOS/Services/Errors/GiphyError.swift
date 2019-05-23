//
//  GiphyError.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 5/13/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
struct GiphyError: Error {
    enum ErrorKind {
        case tooManyRequests
        case notFound
        case unknown
        case missingAPIkey
    }
    
    let kind: ErrorKind
    
    init(kind: ErrorKind){
        self.kind = kind
    }
    
    func getMessage() -> String {
        switch self.kind {
        case .notFound:
            return "unable to find image"
        case .tooManyRequests:
            return "to many requests have been made in the last hour"
        case .unknown:
            return "An error occurred"
        case .missingAPIkey:
            return "Giphy needs an API key, ask Craig for his."
        }
    }
}
