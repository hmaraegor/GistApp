//
//  TableViewCell.swift
//  iTunesSearchAPI
//
//  Created by Egor Khmara on 09.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet private var gistID: UILabel!
    @IBOutlet private var author: UILabel!
    
    func configure(with content: Gist) {
        gistID.text = "Gist ID: " + content.id
        author.text = "Author: " + content.owner.login
    }
}
