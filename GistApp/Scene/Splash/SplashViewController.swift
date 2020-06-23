//
//  SplashViewController.swift
//  GistApp
//
//  Created by Egor Khmara on 23.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        makeServiceCall()
    }
    
    private func transitTo() {
        if StoredData.token == nil {
            SceneDelegate.shared.rootViewController.showOAuthScreen()
        }
        else {
            SceneDelegate.shared.rootViewController.switchToGistListScreen()
        }
    }
    
    
    private func makeServiceCall() {
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            self.transitTo()
            self.activityIndicator.stopAnimating()
        }
    }
}
