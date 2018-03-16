//
//  QuestionController.swift
//  Trivia
//
//  Created by Vincent on 15/03/2018.
//  Copyright © 2018 Native App Studio. All rights reserved.
//

import UIKit

class QuestionController {

    
    
//    let apiURL = URL(string: "http://jservice.io/api/")!
//    var redoCount = 0
//
//    func fetchQuestions(completion: @escaping ([Question]?) -> Void) {
//        let questionsURL = apiURL.appendingPathComponent("random?count=10")
//        let task = URLSession.shared.dataTask(with: questionsURL) {
//            (data, response, error) in
//            guard let data = data, error == nil, response != nil else {
//                print("Error retrieving data from server")
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let questions = try decoder.decode([Question].self, from: data)
//                print(questions)
//                completion(questions)
//            } catch let error {
//                print("JSON decoding error")
//                print(error)
//                completion(nil)
//            }
//        }
//        task.resume()
//    }
//
//    func fquest() -> Any {
//        var q: [Question]?
//        q = nil
//        self.fetchQuestions { (questions) in
//            if let questions = questions {
//                q = questions
//            }
//        }
//        return q
//    }
//
//    func checkFetchQuestions() -> Any {
//        var q = fquest()
//        while (q != nil && redoCount < 100) {
//            print("Retry no. \(redoCount+1)")
//            q = fquest()
//            redoCount += 1
//        }
//        print("Got correct JSON format or redocount reached")
//        return q
//
//
//    }
    
    
}


