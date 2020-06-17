//
//  OAuthService.swift
//  GistApp
//
//  Created by Egor Khmara on 16.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import Foundation
import OAuthSwift

class OAuthService {
    
    func getToken(oauthObj: OAuth2Swift, completionHandler completion:
    @escaping (Result<String, Error>) -> ()) {
        
        oauthObj.authorizeURLHandler = OAuthSwiftOpenURLExternally.sharedInstance
        
        let _ = oauthObj.authorize(
        withCallbackURL: URL(string: Constants.URL.callbackURL), scope: "gist", state: Constants.OAuth.state) { result in
            
            switch result {
            case .success(let (credential, response, parameters)):
                var token = credential.oauthToken
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
                print(error.description)
            }
        }
    }
    
}
