//
//  GistFileService.swift
//  GistApp
//
//  Created by Egor on 13/07/2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import UIKit

class GistFileService {
    private let networkService = NetworkService2<String>()
    
    
    func getGistFiles(url: String, completionHandler:
    @escaping (String?, Error?) -> ()) {
        
        var completion = { (result: Result<String, NetworkServiceError>) in
            switch result {
            case .success(let returnedContentList):
                completionHandler(returnedContentList, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
        
        networkService.get(url: url, decodingDataType: .string, completion)
        //NetworkService().performHTTPRequest(decodingDataType: .string, url: url, completionHandler: completion)
    }
}
