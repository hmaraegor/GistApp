//
//  GistViewController.swift
//  GistApp
//
//  Created by Egor Khmara on 23.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import UIKit

class GistViewController: UIViewController {
    
    @IBOutlet weak var gistTextView: UITextView!
    
    @IBAction func backButton_Tapped(_ sender: UIButton) {
        SceneDelegate.shared.rootViewController.switchToGistListScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let gist = SceneDelegate.shared.rootViewController.gist else { return }
        let gistFiles = getFileNames(from: gist)
        gistTextView.text = gist.files[gistFiles[0]]?.raw_url
    }
    
    func getFileNames(from content: Gist) ->[String] {
        var names = [String]()
        for (key, value) in content.files {
                names.append(key)
        }
        return names
    }
}
