//
//  NewGist.swift
//  GistApp
//
//  Created by Egor on 13/07/2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import Foundation

enum FileOperation {
    case create
    case update
    case delete
}

struct NewGist: Codable {
    var description: String?
    var isPublic: Bool?
    var files: [String : UpdateFile]
    
    enum CodingKeys: String, CodingKey {
        case description
        case isPublic = "public"
        case files
    }
    
    init(operatoin: FileOperation, isPublic: Bool, newName: String, description: String, content: String) {
        self.description = description
        self.isPublic = isPublic
        files = [newName : UpdateFile(operatoin: operatoin, content: content)]
    }
    
    init(operatoin: FileOperation, currentName: String, updateName: String, description: String, content: String) {
        self.description = description
        files = [currentName : UpdateFile(operatoin: operatoin, updateName: updateName, content: content)]
    }
    
    init(operatoin: FileOperation, currentName: String){
        files = [currentName : UpdateFile()]
    }
    
    init(usePublic: Bool = true, useFilename: Bool = false) {
        description = "default description"
        if usePublic { isPublic = true }
        files = ["default_name" : UpdateFile(useFilename: useFilename)]
    }
    
    init(usePublic: Bool = true, useFilename: Bool = false, fileName: String = "default_name") {
        description = "default description"
        if usePublic { isPublic = true }
        let currName = fileName 
        files = [currName : UpdateFile(useFilename: useFilename, changeName: currName)]
    }
}

struct UpdateFile: Codable {
    var content: String?
    var filename: String?
    
    init() {
        
    }
    
    init(operatoin: FileOperation, content: String) {
        self.content = content
    }
    
    init(operatoin: FileOperation, updateName: String, content: String) {
        self.content = content
        filename = updateName
    }
    
    init(useFilename: Bool, changeName: String = "default_name"){
        content = "default text"
        if useFilename { filename = changeName }
    }
}
