//
//  OAuth2SwiftExtension.swift
//  GistApp
//
//  Created by Egor Khmara on 17.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import Foundation
import OAuthSwift

extension OAuth2Swift {
    
    static var github: OAuth2Swift {
        return OAuth2Swift(
            consumerKey:    Constants.OAuth.consumerKey,
            consumerSecret: Constants.OAuth.consumerSecret,
            authorizeUrl:   Constants.OAuth.authorizeUrl,
            accessTokenUrl: Constants.OAuth.accessTokenUrl,
            responseType:   Constants.OAuth.responseType
        )
    }
}
