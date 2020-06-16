//
//  StoredData.swift
//  GistApp
//
//  Created by Egor Khmara on 16.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import Foundation
import Locksmith

class StoredData {
    
    static var token: String? {
        get {
            return StoredData().loadTokenFromKeychain()
        }
        
        set {
            StoredData().saveTokenInKeychain(token: newValue)
        }
    }
    
    private func saveTokenInKeychain(token: String?) {
        guard let token = token else { return }
        do {
            try Locksmith.saveData(data: ["token" : token], forUserAccount: "MyAccount")
        } catch {
            print("Unable to save data")
        }
    }
    
    private func loadTokenFromKeychain() -> String? {
        let dictionary = Locksmith.loadDataForUserAccount(userAccount: "MyAccount")
        return dictionary?["token"] as? String
    }
    
}
