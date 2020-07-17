//
//  GistService.swift
//  GistApp
//
//  Created by Egor on 06/07/2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import UIKit

class GistService {
    private let networkService = NetworkService2<[Gist]>()
        
    func getGists(completionHandler:
    @escaping ([Gist]?, Error?) -> ()) {
        let gistsURL = "gists?access_token=" + (StoredData.token ?? "")
        let url = Constants.API.GitHub.baseURL + gistsURL
        
        var completion = { (result: Result<[Gist], NetworkServiceError>) in
            switch result {
            case .success(let returnedContentList):
                completionHandler(returnedContentList, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
        networkService.get(url: url, decodingDataType: .json, completion)
        //NetworkService().performHTTPRequest(url: url, completionHandler: completion)
    }
}
