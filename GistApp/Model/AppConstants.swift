//
//  AppConstants.swift
//  GistApp
//
//  Created by Egor Khmara on 16.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import Foundation
import UIKit
import OAuthSwift

struct Constants {
    
    struct API {
        struct GitHub {
            static let baseURL = "https://api.github.com/"
        }
    }
    
    struct URL {
        static let callbackHost =   "oauth-callback"
        static let callbackURL =    "gistapp://oauth-callback/github"
    }
    
    struct OAuth {
        static let consumerKey =    "ed019ea221d91ec09305"
        static let consumerSecret = "0c52ffb4b3ca3bd48b7b25cd6cc922ffa0e72277"
        static let authorizeUrl =   "https://github.com/login/oauth/authorize"
        static let accessTokenUrl = "https://github.com/login/oauth/access_token"
        static let responseType =   "code"
        static let state =          generateState(withLength: 20)
    }
}
