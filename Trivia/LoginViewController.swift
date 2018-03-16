//
//  LoginViewController.swift
//  Trivia
//
//  Created by Vincent on 15/03/2018.
//  Copyright © 2018 Native App Studio. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {


    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Handles the user login when the user taps the Login button
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email = emailAddress.text, let password = password.text {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    let alert = UIAlertController(title: "Could not log in", message: "Wrong username or password", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                        NSLog("Could not log in")
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    // start segue to gameViewController
                    self.performSegue(withIdentifier: "toQuestionsSegue", sender: nil)
                }
                return
            }
        }
        
    }
    
    
    @IBAction func unwindToLogin(unwindSegue: UIStoryboardSegue) {
        
    }
}

