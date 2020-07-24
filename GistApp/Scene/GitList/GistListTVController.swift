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
    private var gistUpdateService = GistUpdateService()
    private var gistService = GistService()
    private var gistDeleteService = GistDeleteService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.action(sender:)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if StoredData.token == nil { presentOAuthVC() }
        fetchGistList()
    }
    
    @objc func action(sender: UIBarButtonItem) {
        let ac = UIAlertController(title: LocString.GistList.addNewGist, message: LocString.GistList.enterFileName, preferredStyle: .alert)

        let ok = UIAlertAction(title: LocString.GistList.ok, style: .default) { action in
            self.create(fileName: ac.textFields?[0].text ?? LocString.GistList.newGistFile, description: LocString.GistList.newGist)
        }
        
        let cancel = UIAlertAction(title: LocString.GistList.cancel, style: .default, handler: nil)
        ac.addTextField {
            textField in
            
        }
        
        ac.addAction(ok)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
    
    private func create(fileName: String, description: String) {
        let newGistFile = NewGist(isPublic: true, newName: fileName, description: description, content: LocString.GistList.content)
        
        postRequest(model: newGistFile)
    }
    
    private func postRequest(model: NewGist){
        
        gistUpdateService.putGist(model: model, gistId: nil) { (code, error) in
            if code != nil {
                print(code)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            else if error != nil {
                DispatchQueue.main.async {
                    ErrorAlertService.showErrorAlert(error: error as! NetworkServiceError, viewController: self)
                }
            }
        }

    }
    
    private func fetchGistList() {
        gistService.getGists() { (array, error) in
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
    private func presentOAuthVC() {
        let storyboard = UIStoryboard(name: "OAuth", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OAuthVC")
        self.present(vc, animated: true, completion: nil)
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    private func presentGistController(with gist: Gist) {
        
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let gistId = gistArray[indexPath.row].id
            gistArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            gistDeleteService.deleteGist(gistId: gistId) { (code, error) in
                if code != nil {
                    print(code)
                }
                else if error != nil {
                    ErrorAlertService.showErrorAlert(error: error as! NetworkServiceError, viewController: self)
                }
            }
        }
    }
}
