//
//  RegisterViewController.swift
//  Trivia
//
//  Created by Vincent on 15/03/2018.
//  Copyright © 2018 Native App Studio. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {


    
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// Registers a new user with Firebase
    func registerUser() {
        if let email = emailAddress.text, let password = password.text {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    let alert = UIAlertController(title: "Could not register", message: "Could not register your account. Please try again.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                        NSLog("Could not register user")
                    }))
                } else {
                    let alert = UIAlertController(title: "Successfully registered", message: "You have successfully registered an account. Please log in.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                        (_) in
                        self.performSegue(withIdentifier: "unwindToLoginSegue", sender: self)
                    })
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)

                    print("User successfully created with \(email) and \(password)")
                    //returnToLoginScreen()
                }
            }
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        registerUser()
    }
    

    
    

}
