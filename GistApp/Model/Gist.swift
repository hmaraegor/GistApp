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
    let files: [File]
    let createdAt: String
    let updatedAt: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case owner
        case files
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case description
    }
    
    init(from decoder: Decoder) throws {
        let conteiner = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try conteiner.decode(String.self, forKey: .id )
        owner = try conteiner.decode(Owner.self, forKey: .owner )
        createdAt = try conteiner.decode(String.self, forKey: .createdAt )
        updatedAt = try conteiner.decode(String.self, forKey: .updatedAt )
        description = try conteiner.decode(String.self, forKey: .description )
        
        let filesDictionary = try conteiner.decode([String : File].self, forKey: .files )
        files = filesDictionary.map { $0.value }
    }
}

struct Owner: Codable {
    
    let login: String
    let avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}

struct File: Codable {
    
    let filename: String
    let type: String
    let language: String?
    let rawUrl: String
    let size: Int
    
    enum CodingKeys: String, CodingKey {
        case filename
        case type
        case language
        case rawUrl = "raw_url"
        case size
    }
}

