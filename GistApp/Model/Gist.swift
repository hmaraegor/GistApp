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
    let files: Dictionary<String, File>
    let created_at: String
    let updated_at: String?
    
}

struct Owner: Codable {
    let login: String
    let avatar_url: String?
}

struct File: Codable {
    let filename: String
    let type: String
    let language: String?
    let raw_url: String
    let size: Int
}

