//
//  LocalizedStrings.swift
//  GistApp
//
//  Created by Egor on 22/07/2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import Foundation

struct LocString {
    
    struct Gist {
        static let closeᐁ = NSLocalizedString("ᐁ Close", comment: "ᐁ Close")
        static let createᐊ = NSLocalizedString("ᐊ Create", comment: "ᐊ Create")
        static let editᐊ = NSLocalizedString("ᐊ Edit", comment: "ᐊ Edit")
        static let newFile = NSLocalizedString("New file", comment: "New file")
        static let text = NSLocalizedString("Text", comment: "Text")
        static let saving = NSLocalizedString("Saving", comment: "Saving")
        static let deleting = NSLocalizedString("Deleting", comment: "Deleting")
        static let defaultName = NSLocalizedString("default name", comment: "default name")
        static let defaultText = NSLocalizedString("default text", comment: "default text")
        static let save = NSLocalizedString("Save", comment: "Save")
        static let delete = NSLocalizedString("Delete", comment: "Delete")
    }
    
    struct Cell {
        static let gistFiles = NSLocalizedString("Gist files: ", comment: "Gist files: ")
        static let author = NSLocalizedString("Author: ", comment: "Author: ")
        static let date = NSLocalizedString("Date: ", comment: "Date: ")
    }
    
    struct GistList {
        static let addNewGist = NSLocalizedString("Adding new Gist", comment: "Adding new Gist")
        static let enterFileName = NSLocalizedString("Enter file name", comment: "Enter file name")
        static let ok = NSLocalizedString("Ok", comment: "Ok")
        static let cancel = NSLocalizedString("Cancel", comment: "Cancel")
        static let newGistFile = NSLocalizedString("New gistfile", comment: "New gistfile")
        static let newGist = NSLocalizedString("New gist", comment: "New gist")
        static let content = NSLocalizedString("<content>", comment: "<content>")
    }
    
}
