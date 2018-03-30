//
//  QuestionController.swift
//  Trivia
//
//  Created by Vincent on 15/03/2018.
//  Copyright © 2018 Native App Studio. All rights reserved.
//

import UIKit

class QuestionController {
    static let shared = QuestionController()
    let apiURL = "http://jservice.io/api/"
    
    func getRandomQuestions(completion: @escaping ([Question]?) -> Void) {
        let query = URL(string: apiURL + "random?count=10")!
        
        let task = URLSession.shared.dataTask(with: query) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            if let data = data {
                if let obj = try? jsonDecoder.decode([Question].self, from: data) {
                    completion(obj)
                }
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}


