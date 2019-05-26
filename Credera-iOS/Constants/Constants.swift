//
//  Constants.swift
//  Credera-iOS
//
//  Created by Zachary Slayter on 1/2/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
import UIKit

class Constants {
    
    enum TabBarScreens: Int {
        case first = 0
        case second = 1
    }
    
    enum ColorScheme {
        static let primary = UIColor(red: 10, green: 74, blue: 88)
        static let secondary = UIColor(red: 2, green: 181, blue: 173)
        static let tertiary = UIColor(red: 245, green: 231, blue: 210)
        static let quaternary = UIColor(red: 1, green: 1, blue: 1)
    }
    
    static var boringWords: [String] = ["about", "below", "toward", "above", "beneath", "for", "on", "under", "across", "beside", "from", "onto", "underneath", "after", "between", "in", "out", "until", "against", "beyond", "in front of", "outside", "up", "along", "but", "inside", "over", "upon", "among", "by", "past", "up to", "around", "regarding", "with", "at", "despite", "into", "since", "within", "down", "like", "through", "without", "before", "during", "near", "throughout", "behind", "except", "of", "to", "for", "and", "nor", "but", "or", "yet", "so", "a", "the", "an"]
    static var punctuation: [String] = [";", "'", ".", "/", ":", "<", ">", "?", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "=", "_", "+", "|", "\n"]
    
}
