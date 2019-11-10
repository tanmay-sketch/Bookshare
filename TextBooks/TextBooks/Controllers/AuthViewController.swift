//
//  AuthViewController.swift
//  TextBooks
//
//  Created by Akshay on 10/11/19.
//  Copyright © 2019 Tanmay Grandhisiri. All rights reserved.
//

import UIKit
import FirebaseUI
import Firebase

class AuthViewController: UIViewController, FUIAuthDelegate {
    
    var authUI : FUIAuth?
    override func viewDidLoad() {
        super.viewDidLoad()
        authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self

        let providers: [FUIAuthProvider] = [
          FUIGoogleAuth()
        ]
        authUI?.providers = providers
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        let authViewController = authUI?.authViewController()
        self.present(authViewController!, animated: true, completion: nil)
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
      // handle user and error as necessary
        if error == nil {
            self.performSegue(withIdentifier: "showGrades", sender: nil)
        }
    }
    
    @IBAction func performLogout(_ segue:UIStoryboardSegue) {
        
    }

}
