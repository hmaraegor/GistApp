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
    
    static var getOAuthObject: OAuth2Swift {
        return OAuth2Swift(
            consumerKey:    Constants.OAuth.consumerKey,
            consumerSecret: Constants.OAuth.consumerSecret,
            authorizeUrl:   Constants.OAuth.authorizeUrl,
            accessTokenUrl: Constants.OAuth.accessTokenUrl,
            responseType:   Constants.OAuth.responseType
        )
    }
    
    static func getToken(oauthObj: OAuth2Swift, completionHandler completion:
    @escaping (Result<String, Error>) -> ()) {
        
        oauthObj.authorizeURLHandler = OAuthSwiftOpenURLExternally.sharedInstance
        
        let _ = oauthObj.authorize(
        withCallbackURL: URL(string: Constants.URL.callbackURL), scope: "gist", state: Constants.OAuth.state) { result in
            
            switch result {
            case .success(let (credential, response, parameters)):
                var token = credential.oauthToken
                completion(.success(token))
                //printResponse(credential, response, parameters)
            case .failure(let error):
                completion(.failure(error))
                print(error.description)
            }
        }
    }
    
    static func printResponse(_ credential: OAuthSwiftCredential, _ response: OAuthSwiftResponse?, _ parameters: OAuthSwift.Parameters) {
        print("credential.oauthToken\n", credential.oauthToken)
        print("response\n", response?.response as Any)
        print("parameters\n", parameters)
    }
    
}
