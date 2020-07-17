//
//  GistUpdateService.swift
//  GistApp
//
//  Created by Egor on 17/07/2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import UIKit

class GistUpdateService {
    private let networkService = NetworkService2<Int>()
    
    func putGist<T: Codable>(model: T, gistId: String?, completionHandler:
    @escaping (Int?, Error?) -> ()) {
        
        let gistUrl = "gists/" + gistId! + "?access_token=" + (StoredData.token ?? "")
        let url = Constants.API.GitHub.baseURL + gistUrl
        
        let completion = { (result: Result<Int, NetworkServiceError>) in
            switch result {
            case .success(let returnedHttpCode):
                completionHandler(returnedHttpCode, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
        
        //NetworkService().performHTTPRequest(decodingDataType: .string, url: url, completionHandler: completion)
        networkService.post(url: url, model: model, completion: completion)
    }
}
