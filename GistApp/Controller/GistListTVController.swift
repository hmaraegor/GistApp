//
//  GistListTVController.swift
//  GistApp
//
//  Created by Egor Khmara on 18.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import UIKit

class GistListTVController: UITableViewController {

    private var gistArray = [Gist]()
    
    override func viewDidAppear(_ animated: Bool) {
        if StoredData.token == nil { segueToOAuth() }
        else {
            gistListRequest()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func segueToOAuth() {
        performSegue(withIdentifier: "SegueToOAuthScreen", sender: self)
    }
    
    private func gistListRequest() {
        let url = Constants.API.GitHub.baseURL + "gists?access_token=" + (StoredData.token ?? "")
        NetworkService().getData(url: url) { (result: Result<[Gist], NetworkServiceError>) in
            
            switch result {
            case .success(let returnedContentList):
                self.gistArray = returnedContentList
            case .failure(let error):
                ErrorAlertService.showErrorAlert(error: error, viewController: self)
            }

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gistArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        let gist = gistArray[indexPath.row]
        cell.configure(with: gist)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

}
