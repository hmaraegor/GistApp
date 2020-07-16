//
//  GistViewController.swift
//  GistApp
//
//  Created by Egor Khmara on 23.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import UIKit

class GistViewController: UIViewController {
    
    
    @IBAction func updateButton(_ sender: UIButton) {
        update()
    }
    
    @IBAction func createButton(_ sender: UIButton) {
        create()
    }
    
    func create() {
        var newGistFile = NewGist()
        newGistFile.files["default_name"]?.content = gistTextView.text
        
        var gistUrl = "gists?access_token=" + (StoredData.token ?? "")
        postRequest(model: newGistFile, gistUrl: gistUrl)
    }
    
    func update() {
        var newGistFile = NewGist(usePublic: false, useFilename: true)
        let fileName = titleLabel.text ?? "default_name"
        newGistFile.files[fileName]?.content = gistTextView.text
        let gistId = gist?.id
        newGistFile.files[fileName]?.filename = "new_file_name"
        
        var gistUrl = "gists/" + gistId! + "?access_token=" + (StoredData.token ?? "")
        postRequest(model: newGistFile, gistUrl: gistUrl)
    }
    
    func postRequest(model: NewGist, gistUrl: String){
        let url = Constants.API.GitHub.baseURL + gistUrl
        
        NetworkRequestService().postData(model: model, url: url) { (result) in
            switch result {
            case .success(let returnedHttpCode):
                print(returnedHttpCode)
            case .failure(let error):
                DispatchQueue.main.async {
                    ErrorAlertService.showErrorAlert(error: error as! NetworkServiceError, viewController: self)
                }
            }
        }

    }
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet private weak var gistTextView: UITextView!
    
    var gist: Gist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gistTextView.text = "Load file..."
        
        guard let gist = self.gist else { return }
        let gistFileNames = getFileNames(from: gist)
        let gistFiles = gist.files
        titleLabel.text = gistFileNames.first
        
        getFile(url: gistFiles.first?.rawUrl)
    }
    
    func getFileNames(from content: Gist) -> [String] {
        return content.files.map { $0.filename }
    }
    
    func getFile(url: String?) {
        guard let fileUrl = url else { return }
        GistFileService().gistListRequest(url: fileUrl) { (file, error) in
            if file != nil {
                DispatchQueue.main.async {
                    self.gistTextView.text = file!
                }
            }
            else if error != nil {
                DispatchQueue.main.async {
                    ErrorAlertService.showErrorAlert(error: error as! NetworkServiceError, viewController: self)
                }
            }
        }
    }
}
