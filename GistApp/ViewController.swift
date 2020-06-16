//
//  ViewController.swift
//  GistApp
//
//  Created by Egor Khmara on 15.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

//Test User ↓
//login:    hmaraegortest@gmail.com
//password: hmaraegortest1234

import UIKit
import OAuthSwift

class ViewController: UIViewController {

    var oauthswift: OAuth2Swift?
    
    @IBAction func OAuthButtonTapped(_ sender: UIButton) {
        // create an instance and retain it
        let oauthswift = OAuth2Swift(
            consumerKey:    "ed019ea221d91ec09305",
            consumerSecret: "0c52ffb4b3ca3bd48b7b25cd6cc922ffa0e72277",
            authorizeUrl:   "https://github.com/login/oauth/authorize",
            accessTokenUrl: "https://github.com/login/oauth/access_token",
            responseType:   "code"
        )
        
        self.oauthswift = oauthswift
        oauthswift.authorizeURLHandler = OAuthSwiftOpenURLExternally.sharedInstance
        
        
        let state = generateState(withLength: 20)
        let _ = oauthswift.authorize(
        withCallbackURL: URL(string: "gistapp://oauth-callback/github")!, scope: "gist", state: state) { result in
            switch result {
            case .success(let (credential, response, parameters)):
                self.printResponse(credential, response, parameters)
                //self.showTokenAlert(name: "", credential: credential)
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
    func printResponse(_ credential: OAuthSwiftCredential, _ response: OAuthSwiftResponse?, _ parameters: OAuthSwift.Parameters) {
        print("credential.oauthToken\n", credential.oauthToken)
        print("response\n", response?.response as Any)
        print("parameters\n", parameters)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

