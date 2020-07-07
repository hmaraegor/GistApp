//
//  ImageDownloader.swift
//  iTunesSearchAPI
//
//  Created by Egor Khmara on 11.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import UIKit

class ImageDownloader {
    
    private init() { }
    
    static func downloadImage(stringURL: String, completionHandler:
        @escaping (Data) -> ()) {
        
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            completionHandler(imageData)
        }
    }
}
