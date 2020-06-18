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

    private var oauthswift: OAuth2Swift?
    
    @IBAction func OAuthButtonTapped(_ sender: UIButton) {
        
        let oauthswift = OAuth2Swift.github

        OAuthService().getToken(oauthObj: oauthswift) { result in
            switch result {
            case .success(let responseToken):
                print()
                StoredData.token = responseToken
                self.dismiss(animated: true, completion: nil)
                print(StoredData.token)
            case .failure(let error):
                print(error)
            }
        }

        self.oauthswift = oauthswift
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

