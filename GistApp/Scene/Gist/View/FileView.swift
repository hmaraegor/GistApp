//
//  FileView.swift
//  GistApp
//
//  Created by Egor on 14/07/2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import UIKit

protocol FileViewDelegate {
    func create(fileView: FileView)
    func update(fileView: FileView)
    func delete(fileView: FileView)
    func hideViews(apartFrom view: FileView)
    func showViews()
    func isNewFileView(_ fileView: FileView) -> Bool
    func viewWraping()
    func viewUnwraping(fileView: FileView)
}

class FileView: UIView {
    
    @IBOutlet var textViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var fileNameView: UIView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var fileTextView: UITextView!
    @IBOutlet var bottomButtonsView: UIView!
    
    @IBOutlet var wrapButton: UIButton!
    
    @IBOutlet var saveButton: UIButton!
    
    @IBOutlet var deleteButton: UIButton!
    
    var delegate: FileViewDelegate? //GistViewController?
    var isUnwrapped: Bool = false
    
    @IBAction func titleStartEditing(_ sender: UITextField) {
        delegate?.viewUnwraping(fileView: self)
        guard !isUnwrapped else { return }
            wrapButtonTapped(wrapButton)
    }
    
    func setCorner() {
        fileNameView.clipsToBounds = true
        fileNameView.layer.cornerRadius = 10
        fileNameView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
//        newFileView.clipsToBounds = true
//        newFileView.layer.cornerRadius = 10
//        newFileView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func returnCorner() {
        fileNameView.layer.cornerRadius = 10
        fileNameView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    @IBAction func wrapButtonTapped(_ sender: UIButton) {
        fileTextView.isHidden = !fileTextView.isHidden
        bottomButtonsView.isHidden = !bottomButtonsView.isHidden
        isUnwrapped = !isUnwrapped
        if sender.titleLabel?.text == "ᐁ Close" && (delegate?.isNewFileView(self))! {
            setAtrText("ᐊ Create", for: sender, withSize: 16)
            returnCorner()
            delegate?.showViews()
        }
        else if sender.titleLabel?.text == "ᐊ Edit" || sender.titleLabel?.text == "ᐊ Create" {
            //sender.setTitle("ᐁ Close", for: .normal)
            setAtrText("ᐁ Close", for: sender, withSize: 16)
            setCorner()
            delegate?.hideViews(apartFrom: self)
        }
        else if sender.titleLabel?.text == "ᐁ Close" {
            //sender.setTitle("ᐊ Edit", for: .normal)
            setAtrText("ᐊ Edit", for: sender, withSize: 16)
            returnCorner()
            delegate?.showViews()
        }
        
    }
    
    func setAtrText(_ string: String, for button: UIButton, withSize: CGFloat) {
        let amountText = NSMutableAttributedString(string: string)
        amountText.setAttributes([.font: UIFont.systemFont(ofSize: withSize), .foregroundColor: UIColor.gray,
            .strokeColor: UIColor.black],
                                 range: NSMakeRange(0, 1))
        button.setTitle(string, for: .normal)
        button.titleLabel!.attributedText = amountText
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
            delegate?.update(fileView: self)
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        delegate?.delete(fileView: self)
    }
    
    class func instanceFromNib() -> FileView {
        return UINib(nibName: "FileView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! FileView // as! UIView
    }
    
    func initView(title: String, text: String = "", screenHeight: CGFloat) {
        titleTextField.text = title
        fileTextView.text = text
        setTextViewHeight(screenHeight: screenHeight)
    }

    func setTextViewHeight(screenHeight: CGFloat){
        let maxSizeForTextView = screenHeight - titleTextField.frame.height - bottomButtonsView.frame.height
        self.textViewHeightConstraint.constant = CGFloat(maxSizeForTextView * 0.8)
        
    }
    
    func setBottomView() {
        bottomButtonsView.clipsToBounds = true
        bottomButtonsView.layer.cornerRadius = 10
        bottomButtonsView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    override func awakeFromNib() {
        fileTextView.isHidden = true
        bottomButtonsView.isHidden = true
        setAtrText("ᐊ Edit", for: wrapButton, withSize: 16)
        
        fileTextView.addLeftBorder(with: "#2F2E2B".hexToUIColor(alpha: 0.1), andWidth: 2)
        fileTextView.addRightBorder(with: "#2F2E2B".hexToUIColor(alpha: 0.1), andWidth: 2)
        setBottomView()
    }
    
    
}
