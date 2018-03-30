//
//  QuestionViewController.swift
//  Trivia
//
//  Created by Vincent on 15/03/2018.
//  Copyright © 2018 Native App Studio. All rights reserved.
//

import UIKit
import Firebase

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionText: UITextView!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreDiffLabel: UILabel!
    
    var ref = Database.database().reference()
    
    var questionIndex = 0
    var score = 0
    let minusScore = -50
    
    var questions = [Question]()
    
    /// Retrieves the questions from jservice.io API and updates the view
    override func viewDidLoad() {
        super.viewDidLoad()
        QuestionController.shared.getRandomQuestions() { (resp) in
            if let resp = resp {
                self.questions = resp
                
                DispatchQueue.main.async {
                    self.updateUI(self.score)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// Updates the UI
    func updateUI(_ diffScore: Int) {
        if (questionIndex < questions.count) {
            let currentQuestion = questions[questionIndex]
            navigationItem.title = "Question \(questionIndex+1)"
            questionText.text = currentQuestion.question
            answerTextField.text = ""
            updateScores(diffScore)
        } else {
            updateScores(diffScore)
            uploadScore()
            questionIndex = 0
            performSegue(withIdentifier: "toResultsSegue", sender: nil)
        }
    }
    
    /// Updates the scores on the UI as well as internally
    func updateScores(_ diff: Int) {
        score += diff
        scoreLabel.text = "Score: \(score)"
        
        if score == 0 {
            scoreDiffLabel.isHidden = true
            return
        }
        
        scoreDiffLabel.isHidden = false
        if (diff > 0) {
            scoreDiffLabel.text = "+\(diff)"
            scoreDiffLabel.textColor = UIColor.green
        } else {
            scoreDiffLabel.text = "\(diff)"
            scoreDiffLabel.textColor = UIColor.red
        }
    }
    
    /// Uploads the new high score to Firebase (if newScore > oldScore) and possibly creates a new user entry in the Firebase DB (if not exists)
    func uploadScore() {
        let currentUserID = Auth.auth().currentUser!.uid
        let currentUserEmail = Auth.auth().currentUser!.email
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            // if user exists
            if snapshot.hasChild(currentUserID) {
                
                // get current high score value stored in database
                self.ref.child("users").child(currentUserID).observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    let currentHiScoreInt: Int! = value!["hiscore"] as! Int
                    
 
                    // if new high score is better than stored one, store in database
                    if (self.score > currentHiScoreInt) {
                        let key = self.ref.child("users").child(currentUserID).key
                        let newData = ["email": currentUserEmail, "hiscore": String(self.score)]
                        let updates = ["/users/\(key)": newData]
                        self.ref.updateChildValues(updates)
                    }
                }) { (error) in
                    print(error.localizedDescription)
                }
                
                // if user doesn't exist
            } else {
                // create user and set high score
                self.ref.child("users").child(currentUserID).setValue(["email": currentUserEmail!, "hiscore": self.score])
            }
        })
    }
    
    /// Makes sure the UI is updated after tapping the submit button, as well as the score
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        let currentQuestion = questions[questionIndex]
        let correctAnswer = currentQuestion.answer
        let answerGiven = answerTextField.text
        var diff = 0
        if (answerGiven!.lowercased() == correctAnswer.lowercased()) {
            diff = currentQuestion.value
        } else {
            diff = minusScore
            
        }
        questionIndex += 1
        updateUI(diff)
        
    }
    
    /// Returns to the login screen when the user taps Quit
    @IBAction func quitButtonTapped(_ sender: UIBarButtonItem) {
        score = 0
        questionIndex = 0
        performSegue(withIdentifier: "unwindToLoginFromQuit", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultsSegue" {
            let resultsVC = segue.destination as! ResultsViewController
            resultsVC.score = self.score
        }
    }
    
}
