//
//  RootViewController.swift
//  GistApp
//
//  Created by Egor Khmara on 21.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private var current: UIViewController
    
    init() {
       self.current = SplashViewController()
       super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(current)                   // 1
        current.view.frame = view.bounds    // 2
        view.addSubview(current.view)       // 3
        current.didMove(toParent: self)     // 4
    }
    

    func showOAuthScreen() {
        let new = UINavigationController(rootViewController: OAuthViewController())  // 1
        addChild(new)                       // 2
        new.view.frame = view.bounds        // 3
        view.addSubview(new.view)           // 4
        new.didMove(toParent: self)         // 5
        current.willMove(toParent: nil)     // 6
        current.view.removeFromSuperview()  // 7
        current.removeFromParent()          // 8
        current = new                       // 9
     }
    
    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(new)
        
        transition(from: current, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
        }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()  //1
        }
    }
    
    private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        let initialFrame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
        current.willMove(toParent: nil)
        addChild(new)
        transition(from: current, to: new, duration: 0.3, options: [], animations: {
            new.view.frame = self.view.bounds
        }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
    
    func switchToGistListScreen() {
       let gistListViewController = GistListTVController()
       let gistListScreen = UINavigationController(rootViewController: gistListViewController)
       animateFadeTransition(to: gistListScreen)
    }
    
    func switchToOAuth() {
       let oauthViewController = OAuthViewController()
       let oauthScreen = UINavigationController(rootViewController: oauthViewController)
       animateDismissTransition(to: oauthScreen)
    }

}


extension SceneDelegate {
    static var shared: SceneDelegate {
        return UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
    }
    var rootViewController: RootViewController {
        return window!.rootViewController as! RootViewController
    }
}


class SplashViewController: UIViewController {
    
    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
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
            SceneDelegate.shared.rootViewController.switchToOAuth()
        }
        else {
            SceneDelegate.shared.rootViewController.switchToGistListScreen()
        }
    }
    
    
    private func makeServiceCall() {
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
           self.activityIndicator.stopAnimating()
            self.transitTo()
        }
    }
}
