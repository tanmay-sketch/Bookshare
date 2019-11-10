//
//  AuthViewController.swift
//  TextBooks
//
//  Created by Akshay on 10/11/19.
//  Copyright © 2019 Tanmay Grandhisiri. All rights reserved.
//

import UIKit
import FirebaseUI

class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(string: "https://example.appspot.com")
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setAndroidPackageName("com.firebase.example", installIfNotAvailable: false, minimumVersion: "12")

        let provider = FUIEmailAuth.initAuthAuthUI(FUIAuth.defaultAuthUI(), signInMethod: FIRG, forceSameDevice: false, allowNewEmailAccounts: true, actionCodeSetting: actionCodeSettings)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
