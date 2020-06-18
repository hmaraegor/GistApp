//
//  Content.swift
//  iTunesSearchAPI
//
//  Created by Egor Khmara on 09.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import Foundation

struct Gist: Codable {
    
    let id: String
    let owner: Owner
 
//    enum CodingKeys: String, CodingKey {
//        case artistName
//        case trackName
//        case artworkUrl = "artworkUrl100"
//    }
    
}

struct Owner: Codable {
    
    let login: String
    
}
