//
//  ResultsViewController.swift
//  Trivia
//
//  Created by Vincent on 16/03/2018.
//  Copyright © 2018 Native App Studio. All rights reserved.
//

import UIKit
import Firebase

class ResultsViewController: UIViewController {
    
    var ref = Database.database().reference()
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var score: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        scoreLabel.text = "Your score: \(score)"
        calcLeaderboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func calcLeaderboard() {
        var leaderboard: [[String: Any]] = []
        ref.child("users").queryOrdered(byChild: "hiscore").queryLimited(toLast: 5).observeSingleEvent(of: .value, with: { (snapshot) in
            let top5Dict = snapshot.value as! NSDictionary
            for item in top5Dict {
                // dictionary with keys "email" and "hiscore"
                var entry = item.value as! [String: Any]
                leaderboard.append(entry)
                //leaderboard(item.value as! [String: Any])
            }
            //self.lb5NameLabel.text = leaderboard[4]["email"] as! String
            //self.lb5ScoreLabel.text = leaderboard[4]["hiscore"] as! String
            
            
        })
    }
    
    
    
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        score = 0
        performSegue(withIdentifier: "unwindToLoginFromQuit", sender: self)
    }
    

}
