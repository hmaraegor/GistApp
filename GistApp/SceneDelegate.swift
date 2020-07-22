//
//  SceneDelegate.swift
//  GistApp
//
//  Created by Egor Khmara on 15.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import UIKit
import OAuthSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
            guard let url = URLContexts.first?.url else {
                return
            }
        if url.host == Constants.URL.callbackHost {
                OAuthSwift.handle(url: url)
            }
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let storyboard = UIStoryboard(name: "GistList", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GistListTVC")
        
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()
        
        return
    }
}

