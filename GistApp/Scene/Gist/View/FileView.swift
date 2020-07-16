//
//  FileView.swift
//  GistApp
//
//  Created by Egor on 14/07/2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import UIKit

class FileView: UIView {
    
    @IBOutlet var textViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var fileTextView: UITextView!
    @IBOutlet var bottomButtonsView: UIView!
    
    @IBOutlet var wrapButton: UIButton!
    
    @IBOutlet var saveButton: UIButton!
    
    @IBOutlet var deleteButton: UIButton!
    
    var delegate: GistViewControllerV2?
    
    @IBAction func wrapButtonTapped(_ sender: UIButton) {
        fileTextView.isHidden = !fileTextView.isHidden
        bottomButtonsView.isHidden = !bottomButtonsView.isHidden
        if sender.titleLabel?.text == "ᐁ Close" && (delegate?.isNewFileView(self))! {
            setAtrText("ᐊ Create", for: sender, withSize: 16)
            delegate?.showViews()
        }
        else if sender.titleLabel?.text == "ᐊ Edit" || sender.titleLabel?.text == "ᐊ Create" {
            //sender.setTitle("ᐁ Close", for: .normal)
            setAtrText("ᐁ Close", for: sender, withSize: 16)
            delegate?.hideViews(apartFrom: self)
        }
        else if sender.titleLabel?.text == "ᐁ Close" {
            //sender.setTitle("ᐊ Edit", for: .normal)
            setAtrText("ᐊ Edit", for: sender, withSize: 16)
            delegate?.showViews()
        }
    }
    
    func setAtrText(_ string: String, for button: UIButton, withSize: CGFloat) {
        let amountText = NSMutableAttributedString.init(string: string)
        amountText.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: withSize)], range: NSMakeRange(0, 1))
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
    
    
    override func awakeFromNib() {
        fileTextView.isHidden = true
        bottomButtonsView.isHidden = true
        setAtrText("ᐊ Edit", for: wrapButton, withSize: 16)
    }
    
    
}
