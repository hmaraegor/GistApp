//
//  GistViewControllerV2.swift
//  GistApp
//
//  Created by Egor on 14/07/2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import UIKit

protocol FileViewDelegate {
    func create(fileView: FileView)
    func update(fileView: FileView)
    func hideViews(apartFrom view: FileView)
    func showViews()
    func isNewFileView(_ fileView: FileView) -> Bool
}

class GistViewControllerV2: UIViewController, FileViewDelegate {

    var fileViewsArray: [FileView] = []
    var gist: Gist?
    var currentView: FileView?
    var newFileView: FileView!
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let gist = self.gist else { return }
        initFileViews()
    }

    func initFileViews() {
        for file in gist!.files {
            let view = FileView.instanceFromNib()
            view.initView(title: file.filename, screenHeight: UIScreen.main.bounds.height)
            getFile(url: file.rawUrl, fileView: view)
            fileViewsArray.append(view)
            view.delegate = self
            self.stackView.addArrangedSubview(view)
        }
        newFileView = FileView.instanceFromNib()
        newFileView.initView(title: "", screenHeight: UIScreen.main.bounds.height)
        fileViewsArray.append(newFileView)
        newFileView.delegate = self
        newFileView.wrapButton.setTitle("ᐊ Create", for: .normal)
        self.stackView.addArrangedSubview(newFileView)
    }
    
    func getFile(url: String?, fileView: FileView) {
        guard let fileUrl = url else { return }
        
        GistFileService().gistListRequest(url: fileUrl) { (fileText, error) in
            if fileText != nil {
                DispatchQueue.main.async {
                    fileView.fileTextView.text = fileText!
                }
            }
            else if error != nil {
                DispatchQueue.main.async {
                    ErrorAlertService.showErrorAlert(error: error as! NetworkServiceError, viewController: self)
                }
            }
        }
    }
    
    func isNewFileView(_ fileView: FileView) -> Bool {
        return fileView == newFileView
    }
    
    func hideViews(apartFrom fileView: FileView) {
        for view in fileViewsArray {
            if view != fileView {
                view.isHidden = true
            }
        }
    }
    
    func showViews() {
        for view in fileViewsArray {
            view.isHidden = false
        }
    }
    
    func create(fileView: FileView) {
        let fileName = fileView.titleTextField.text ?? "default name/"
        let content = fileView.fileTextView.text ?? "default text/"
        let newGistFile = NewGist(operatoin: .create, isPublic: true, newName: fileName, description: "descr/", content: content)
        
        let gistUrl = "gists?access_token=" + (StoredData.token ?? "")
        postRequest(model: newGistFile, gistUrl: gistUrl)
    }
    
    func delete(fileView: FileView) {
        var fileIndex: Int = 0
        var currentName = ""
        for (index, view) in fileViewsArray.enumerated() {
            if fileView == view {
                fileIndex = index
                break
            }
        }
//        if (gist?.files.count)! <= fileIndex {
//            currentName = updateFileName
//        }
//        else {
            currentName = ((gist?.files[fileIndex].filename)!)
//        }
        let newGistFile = NewGist(operatoin: .delete, currentName: currentName)
        
        let gistId = gist?.id
        
        let gistUrl = "gists/" + gistId! + "?access_token=" + (StoredData.token ?? "")
        postRequest(model: newGistFile, gistUrl: gistUrl)
    }
    
    func update(fileView: FileView) {
        var fileIndex: Int = 0
        let updateFileName = fileView.titleTextField.text ?? "default name/"
        var currentName = ""
        
        for (index, view) in fileViewsArray.enumerated() {
            if fileView == view {
                fileIndex = index
                break
            }
        }
        
        if (gist?.files.count)! <= fileIndex {
            currentName = updateFileName
        }
        else {
            currentName = ((gist?.files[fileIndex].filename)!)
        }
        
        //let currentName = (gist?.files.first?.filename)!
        let content = fileView.fileTextView.text ?? "default text/"
        let newGistFile = NewGist(operatoin: .update, currentName: currentName, updateName: updateFileName, description: "descr/", content: content)
        
        let gistId = gist?.id
        
        let gistUrl = "gists/" + gistId! + "?access_token=" + (StoredData.token ?? "")
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
                    ErrorAlertService.showErrorAlert(error: error, viewController: self)
                }
            }
        }

    }
    
}
