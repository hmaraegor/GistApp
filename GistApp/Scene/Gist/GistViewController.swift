//
//  GistViewController.swift
//  GistApp
//
//  Created by Egor Khmara on 23.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import UIKit

class GistViewController: UIViewController {
    
    @IBOutlet private weak var gistTextView: UITextView!
    
    var gist: Gist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let gist = self.gist else { return }
        let gistFiles = getFileNames(from: gist)
        gistTextView.text = gist.files.first?.rawUrl
    }
    
    func getFileNames(from content: Gist) -> [String] {
        return content.files.map { $0.filename }
    }
}
