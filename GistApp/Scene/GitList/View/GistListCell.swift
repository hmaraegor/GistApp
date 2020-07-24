//
//  TableViewCell.swift
//  iTunesSearchAPI
//
//  Created by Egor Khmara on 09.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import UIKit

class GistListCell: UITableViewCell {
    
    @IBOutlet private var files: UILabel!
    @IBOutlet private var author: UILabel!
    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var date: UILabel!
    
    func configure(with content: Gist) {
        files.text = LocString.Cell.gistFiles + getFileNames(from: content).joined(separator:", ")
        author.text = LocString.Cell.author + content.owner.login
        date.text = LocString.Cell.date + getDate(strDate: content.createdAt)
        
        avatarImage.layer.cornerRadius = avatarImage.frame.size.height / 5
        guard let stringURL = content.owner.avatarUrl  else { return }
        ImageDownloader.downloadImage(stringURL: stringURL) { (imageData) in

            DispatchQueue.main.async {
                self.avatarImage.image = UIImage(data: imageData)
            }

        }
    }
    
    private func getDate(strDate: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let myDate = formatter.date(from: strDate) //as NSDate?
        formatter.dateFormat = "HH:mm d MMM y"
        let newDate = formatter.string(from: myDate!)
        
        return newDate
    }
    
    private func getFileNames(from content: Gist) -> [String] {
        return content.files.map { $0.filename }
    }
}
