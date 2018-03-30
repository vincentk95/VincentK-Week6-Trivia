//
//  GameData.swift
//  Trivia
//
//  Created by Vincent on 15/03/2018.
//  Copyright © 2018 Native App Studio. All rights reserved.
//

import Foundation

/// Holds the categories from jservice.io
struct Category : Codable {
    let id: Int
    let title: String
    let created_at: String
    let updated_at: String
    let clues_count: Int
    
    init(id: Int = Int(), title: String = String(), created_at: String = String(), updated_at: String = String(), clues_count: Int = Int()) {
        self.id = id
        self.title = title
        self.created_at = created_at
        self.updated_at = updated_at
        self.clues_count = clues_count
    }
}

/// Holds the questions from jservice.io
struct Question : Codable {
    let id: Int
    let answer: String
    let question: String
    let value: Int
    let airdate: String
    let created_at: String
    let updated_at: String
    let category_id: Int
    let game_id: Int?
    let invalid_count: Int?
    let category: Category
}
