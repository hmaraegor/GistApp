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
    
    @IBOutlet var fileNameView: UIView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var fileTextView: UITextView!
    @IBOutlet var bottomButtonsView: UIView!
    
    @IBOutlet var wrapButton: UIButton!
    
    @IBOutlet var saveButton: UIButton!
    
    @IBOutlet var deleteButton: UIButton!
    
    var delegate: GistViewControllerV2?
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
        let amountText = NSMutableAttributedString.init(string: string)
        amountText.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: withSize), NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.strokeColor: UIColor.black],
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

extension UIView {
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }

    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        addSubview(border)
    }
}

extension String {
    
    func hexToUIColor (alpha: CGFloat) -> UIColor {
      var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
      
      if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
      }
      
      if ((cString.count) != 6) {
        return UIColor.gray
      }
      
      var rgbValue:UInt32 = 0
      Scanner(string: cString).scanHexInt32(&rgbValue)
      
      return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: alpha
      )
    }
}
