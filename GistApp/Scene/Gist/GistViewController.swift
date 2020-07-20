//
//  GistViewController.swift
//  GistApp
//
//  Created by Egor on 14/07/2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import UIKit



class GistViewController: UIViewController, FileViewDelegate {

    var fileViewsArray: [FileView] = []
    var gist: Gist?
    var currentView: FileView?
    var newFileView: FileView!
    
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    @IBOutlet var indicatorLabel: UILabel!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let gist = self.gist else { return }
        initFileViews()
        indicatorView.isHidden = true
        
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
        newFileView.titleTextField.text = "New file"
        newFileView.fileTextView.text = "Text"
        newFileView.titleTextField.textColor = .gray
        newFileView.deleteButton.isHidden = true
        
        
        self.stackView.addArrangedSubview(newFileView)
        
    }
    
    func getFile(url: String?, fileView: FileView) {
        guard let fileUrl = url else { return }
        
        GistFileService().getGistFiles(url: fileUrl) { (fileText, error) in
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
    
    func viewWraping() {
        guard !indicatorView.isHidden else { return }
        indicatorView.isHidden = true
        guard activityIndicator.isAnimating else { return }
        activityIndicator.stopAnimating()
    }
    
    func viewUnwraping(fileView: FileView) {
        if fileView == newFileView {
            fileView.titleTextField.textColor = .black
        }
    }
    
    func create(fileView: FileView) {
        indicatorView.isHidden = false
        activityIndicator.startAnimating()
        indicatorLabel.text = "Saving"
        
        let fileName = fileView.titleTextField.text ?? "default name/"
        let content = fileView.fileTextView.text ?? "default text/"
        let description = gist?.description
        let newGistFile = NewGist(isPublic: true, newName: fileName, description: description, content: content)
        
        let gistUrl = "gists?access_token=" + (StoredData.token ?? "")
        postRequest(model: newGistFile)
    }
    
    func delete(fileView: FileView) {
        indicatorView.isHidden = false
        activityIndicator.startAnimating()
        indicatorLabel.text = "Deleting"
        
        var fileIndex: Int = 0
        var currentName = ""
        for (index, view) in fileViewsArray.enumerated() {
            if fileView == view {
                fileIndex = index
                break
            }
        }
        currentName = ((gist?.files[fileIndex].filename)!)
        let newGistFile = NewGist(currentName: currentName)
        
        let gistId = gist?.id
        
        let gistUrl = "gists/" + gistId! + "?access_token=" + (StoredData.token ?? "")
        postRequest(model: newGistFile)
    }
    
    func update(fileView: FileView) {
        indicatorView.isHidden = false
        activityIndicator.startAnimating()
        indicatorLabel.text = "Saving"
        
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
        
        let content = fileView.fileTextView.text ?? "default text/"
        let description = gist?.description
        let newGistFile = NewGist(currentName: currentName, updateName: updateFileName, description: description, content: content)
        
        let gistId = gist?.id
        
        postRequest(model: newGistFile)
    }
    
    func postRequest(model: NewGist){
        
        GistUpdateService().putGist(model: model, gistId: gist?.id) { (code, error) in
            if code != nil {
                print(code)
            }
            else if error != nil {
                DispatchQueue.main.async {
                    ErrorAlertService.showErrorAlert(error: error as! NetworkServiceError, viewController: self)
                }
            }
            DispatchQueue.main.async {
                guard !self.indicatorView.isHidden else { return }
                self.indicatorView.isHidden = true
                guard self.activityIndicator.isAnimating else { return }
                self.activityIndicator.stopAnimating()
            }
        }

    }
    
}
