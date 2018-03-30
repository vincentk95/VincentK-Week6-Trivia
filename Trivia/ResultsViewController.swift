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
    
    @IBOutlet weak var userNameLabel1: UILabel!
    @IBOutlet weak var userNameLabel2: UILabel!
    @IBOutlet weak var userNameLabel3: UILabel!
    @IBOutlet weak var userNameLabel4: UILabel!
    @IBOutlet weak var userNameLabel5: UILabel!
    
    @IBOutlet weak var userScoreLabel1: UILabel!
    @IBOutlet weak var userScoreLabel2: UILabel!
    @IBOutlet weak var userScoreLabel3: UILabel!
    @IBOutlet weak var userScoreLabel4: UILabel!
    @IBOutlet weak var userScoreLabel5: UILabel!
    
    
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
    
    
    /// Compute leaderboard and set appropriate labels for viewing
    func calcLeaderboard() {
        var leaderboard = [String: Int]()
        //var leaderboard: [String: Any] = []
        ref.child("users").queryOrdered(byChild: "hiscore").queryLimited(toLast: 5).observeSingleEvent(of: .value, with: { (snapshot) in
            let top5Dict = snapshot.value as! NSDictionary
            
            for item in top5Dict {
                var inner = item.value as! [String: Any]
                let user = inner["email"] as! String
                let hiscore = inner["hiscore"] as! Int
                leaderboard[user] = hiscore
            }
            //print(leaderboard)
            let leaderboardSorted = leaderboard.sorted(by: <)
            self.userNameLabel1.text = leaderboardSorted[0].key
            self.userScoreLabel1.text = String(leaderboardSorted[0].value)
            self.userNameLabel2.text = leaderboardSorted[1].key
            self.userScoreLabel2.text = String(leaderboardSorted[1].value)
            self.userNameLabel3.text = leaderboardSorted[2].key
            self.userScoreLabel3.text = String(leaderboardSorted[2].value)
            self.userNameLabel4.text = leaderboardSorted[3].key
            self.userScoreLabel4.text = String(leaderboardSorted[3].value)
            self.userNameLabel5.text = leaderboardSorted[4].key
            self.userScoreLabel5.text = String(leaderboardSorted[4].value)
        })
    }
    
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        score = 0
        performSegue(withIdentifier: "unwindToLoginFromQuit", sender: self)
    }
    

}
