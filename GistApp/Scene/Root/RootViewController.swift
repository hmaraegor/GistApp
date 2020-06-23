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
    var gist: Gist?
    
    init() {
       self.current = SplashViewController()
       super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
    }
    

    func showOAuthScreen() {
        let storyboard = UIStoryboard(name: "OAuth", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OAuthVC")
        //self.present(vc, animated: false, completion: nil)
        //let new = UINavigationController(rootViewController: OAuthViewController())
        let new = UINavigationController(rootViewController: vc)
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = new
        
//        let splashVC = splash as! SplashViewController
//        splashVC.activityIndicator.stopAnimating()
     }
    
    func showGistScreen() {
            let storyboard = UIStoryboard(name: "Gist", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "GistVC")
            //self.present(vc, animated: false, completion: nil)
            //let new = UINavigationController(rootViewController: OAuthViewController())
            let new = UINavigationController(rootViewController: vc)
            addChild(new)
            new.view.frame = view.bounds
            view.addSubview(new.view)
            new.didMove(toParent: self)
            current.willMove(toParent: nil)
            current.view.removeFromSuperview()
            current.removeFromParent()
            current = new
         }
    
    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(new)
        transition(from: current, to: new, duration: 0.0, options: [], animations: nil, completion: nil)
    }
    
    private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        new.view.frame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
        current.willMove(toParent: nil)
        addChild(new)
        transition(from: current, to: new, duration: 0.0, options: [], animations: nil, completion: nil)
    }
    
    func switchToGistListScreen(viewController: UIViewController = GistListTVController()) {
       let gistListViewController = viewController
       let gistListScreen = UINavigationController(rootViewController: gistListViewController)
       animateFadeTransition(to: gistListScreen)
    }
    
    func switchToOAuth(viewController: UIViewController = OAuthViewController()) {
       let oauthViewController = viewController
       let oauthScreen = UINavigationController(rootViewController: oauthViewController)
       animateDismissTransition(to: oauthScreen)
    }

}
