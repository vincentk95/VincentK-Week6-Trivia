//
//  GameData.swift
//  Trivia
//
//  Created by Vincent on 15/03/2018.
//  Copyright © 2018 Native App Studio. All rights reserved.
//

import Foundation

/// Struct that holds a question and answer, as well as value
struct Question : Codable {
    var question: String
    var answer: String
    var value: Int
}
