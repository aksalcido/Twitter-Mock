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

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
            self.performSegue(withIdentifier: self.segueIdentifer, sender: self)
        }
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        
        let requestUrl = "https://api.twitter.com/oauth/request_token"

        TwitterAPICaller.client?.login(url: requestUrl, success: {
            
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            
            self.performSegue(withIdentifier: self.segueIdentifer, sender: self)
            
        }, failure: { (Error) in
            print("Could not Login!")
        })
        
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
