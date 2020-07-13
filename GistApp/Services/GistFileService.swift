//
//  GistFileService.swift
//  GistApp
//
//  Created by Egor on 13/07/2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import UIKit

class GistFileService {
    
    func gistListRequest(url: String, completionHandler:
    @escaping (String?, Error?) -> ()) {
        
        NetworkService().getData(decodingDataType: .string, url: url) { (result: Result<String, NetworkServiceError>) in
            
            switch result {
            case .success(let returnedContentList):
                completionHandler(returnedContentList, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
