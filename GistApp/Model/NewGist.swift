//
//  NewGist.swift
//  GistApp
//
//  Created by Egor on 13/07/2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import Foundation

struct NewGist: Codable {
    var description: String
    var isPublic: Bool?
    var newFiles: [String : NewFile]
    
    enum CodingKeys: String, CodingKey {
        case description
        case isPublic = "public"
        case newFiles = "files"
    }
    
    init(usePublic: Bool = true, useFilename: Bool = false) {
        description = "default description"
        if usePublic { isPublic = true }
        newFiles = ["default_name" : NewFile(useFilename: useFilename)]
    }
}

struct NewFile: Codable {
    var content: String
    var filename: String?
    init(useFilename: Bool){
        content = "default text"
        if useFilename { filename = "default_name" }
    }
}
