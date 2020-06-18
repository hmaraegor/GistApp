//
//  GistListTVController.swift
//  GistApp
//
//  Created by Egor Khmara on 18.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import UIKit

class GistListTVController: UITableViewController {

    private var token: String?
    private var gistArray = [Gist]()
    
    override func viewDidAppear(_ animated: Bool) {
        if StoredData.token == nil { segueToOAuth() }
        else {
            token = StoredData.token
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
        let url = Constants.API.GitHubAPI + "gists?access_token=" + (token ?? "")
        NetworkService.getData(url: url) { (result) in
            
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

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
