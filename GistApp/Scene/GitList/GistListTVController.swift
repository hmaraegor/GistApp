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
        fetchGistList()
    }
    
    func fetchGistList() {
        GistService().getGists() { (array, error) in
            if array != nil {
                self.gistArray = array!
            }
            else if error != nil {
                DispatchQueue.main.async {
                    ErrorAlertService.showErrorAlert(error: error as! NetworkServiceError, viewController: self)
                }
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
        
        if Bool(1) {
            let storyboard: UIStoryboard = UIStoryboard(name: "GistV2", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "GistVCv2")
            (vc as? GistViewControllerV2)?.gist = gist
            navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let storyboard: UIStoryboard = UIStoryboard(name: "Gist", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "GistVC")
            (vc as? GistViewController)?.gist = gist
            navigationController?.pushViewController(vc, animated: true)
        }
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
    
    //Do I need it?
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let gistId = gistArray[indexPath.row].id
            gistArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            GistDeleteService().getGists(gistId: gistId) { (code, error) in
                if code != nil {
                    print(code)
                }
                else if error != nil {
                    ErrorAlertService.showErrorAlert(error: error as! NetworkServiceError, viewController: self)
                }
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}
