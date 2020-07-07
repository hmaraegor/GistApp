//
//  GistListTVController.swift
//  GistApp
//
//  Created by Egor Khmara on 18.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import UIKit

class GistListTVController: UITableViewController {
    
    var gistArray = [Gist]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if StoredData.token == nil { presentOAuthVC() }
        GistService().gistListRequest() { (array, error) in
            if array != nil {
                self.gistArray = array!
            }
            else if error != nil {
                ErrorAlertService.showErrorAlert(error: error as! NetworkServiceError, viewController: self)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: Present methods
    func presentOAuthVC() {
        let storyboard = UIStoryboard(name: "OAuth", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OAuthVC")
        self.present(vc, animated: true, completion: nil)
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentGistController(with gist: Gist) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Gist", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GistVC")
        (vc as? GistViewController)?.gist = gist
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: TableView methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gistArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? GistListCell else {
            return UITableViewCell()
        }
        
        let gist = gistArray[indexPath.row]
        cell.configure(with: gist)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return UITableView.automaticDimension // Why UITableView? Why not self?
        return 85
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentGistController(with: gistArray[indexPath.row])
    }
    
    
}
