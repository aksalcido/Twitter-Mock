//
//  LoginViewController.swift
//  Twitter
//
//  Created by Armando Salcido on 4/27/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let segueIdentifer = "loginToHome"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: UserStatus.UserLoggedIn.rawValue) == true {
            self.performSegue(withIdentifier: self.segueIdentifer, sender: self)
        }
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        
        TwitterAPICaller.client?.login(url: Url.TokenRequest.rawValue, success: {
            
            UserDefaults.standard.set(true, forKey: UserStatus.UserLoggedIn.rawValue)
            
            self.performSegue(withIdentifier: self.segueIdentifer, sender: self)
            
        }, failure: { (Error) in
            print("Could not Login!")
        })
    }

}
