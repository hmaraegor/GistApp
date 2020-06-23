//
//  TableViewCell.swift
//  iTunesSearchAPI
//
//  Created by Egor Khmara on 09.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet private var files: UILabel!
    @IBOutlet private var author: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var date: UILabel!
    
    func configure(with content: Gist) {
        files.text = "Gist files: " + getFileNames(from: content).joined(separator:", ")
        author.text = "Author: " + content.owner.login
        date.text = "Date: " + getDate(strDate: content.created_at)
        
        avatarImage.layer.cornerRadius = avatarImage.frame.size.height / 5
        guard let stringURL = content.owner.avatar_url  else { return }
        ImageDownloader.downloadImage(stringURL: stringURL) { (imageData) in

            DispatchQueue.main.async {
                self.avatarImage.image = UIImage(data: imageData)
            }

        }
    }
    
    func getDate(strDate: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        var myDate = formatter.date(from: strDate) //as NSDate?
        formatter.dateFormat = "HH:mm d MMM y"
        var newDate = formatter.string(from: myDate!)
        
        return newDate
    }
    
    func getFileNames(from content: Gist) ->[String] {
        var names = [String]()
        for (key, value) in content.files {
                names.append(key)
        }
        return names
    }
}
