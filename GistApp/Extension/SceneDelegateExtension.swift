//
//  SceneDelegateExtension.swift
//  GistApp
//
//  Created by Egor Khmara on 23.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import UIKit

extension SceneDelegate {
    static var shared: SceneDelegate {
        return UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
    }
    var rootViewController: RootViewController {
        return window!.rootViewController as! RootViewController
    }
}
