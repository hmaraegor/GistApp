//
//  NewGist.swift
//  GistApp
//
//  Created by Egor on 13/07/2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import Foundation

struct NewGist: Codable {
    var description: String?
    var isPublic: Bool?
    var files: [String : UpdateFile]
    
    enum CodingKeys: String, CodingKey {
        case description
        case isPublic = "public"
        case files
    }
    
    init(isPublic: Bool, newName: String, description: String?, content: String) {
        if let description = description {
            self.description = description
        }
        self.isPublic = isPublic
        files = [newName : UpdateFile(content: content)]
    }
    
    init(currentName: String, updateName: String, description: String?, content: String) {
        if let description = description {
            self.description = description
        }
        files = [currentName : UpdateFile(updateName: updateName, content: content)]
    }
    
    init(currentName: String){
        files = [currentName : UpdateFile()]
    }
}

struct UpdateFile: Codable {
    var content: String?
    var filename: String?
    
    init() {
    }
    
    init(content: String) {
        self.content = content
    }
    
    init(updateName: String, content: String) {
        self.content = content
        filename = updateName
    }
}
