//
//  GistService.swift
//  GistApp
//
//  Created by Egor on 06/07/2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import Foundation
import UIKit

class GistService {
    
    func gistListRequest(gistListVC: GistListTVController, completionHandler:
    @escaping ([Gist]) -> ()) {
        
        let gistsURL = "gists" //"gists?access_token=" + (StoredData.token ?? "")
        let url = Constants.API.GitHub.baseURL + gistsURL
        
        NetworkService().getData(url: url) { (result: Result<[Gist], NetworkServiceError>) in
            
            switch result {
            case .success(let returnedContentList):
                completionHandler(returnedContentList)
            case .failure(let error):
                ErrorAlertService.showErrorAlert(error: error, viewController: gistListVC)
            }
        }
    }
}
