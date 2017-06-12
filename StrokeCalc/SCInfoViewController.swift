//
//  SCInfoViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 11/17/16.
//  Copyright © 2016 Mobile Guru. All rights reserved.
//

import UIKit

class SCInfoViewController: SCBaseViewController {
    
    // MARK: - Properties
    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var centerImageView: UIImageView!

    @IBOutlet weak var infoDetails: UILabel!
    @IBOutlet weak var header: UILabel!
    
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var infoTextTopConstraint: NSLayoutConstraint!
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = self.infoImage {
            self.infoImageView.image = image
            self.centerImageView.image = image
        }
        
        if let headerText = self.infoHeader {
            self.header.attributedText = NSMutableAttributedString().boldHeader(text: headerText)
        } else {
            self.header.text = ""
        }
        if self.infoHeader == nil || (self.infoHeader?.isEmpty)! {
//            self.infoImageView.isHidden = true
//            self.centerImageView.isHidden = false
            self.infoTextTopConstraint.constant = 0
        }
        self.infoImageView.isHidden = true
        self.centerImageView.isHidden = false
        
        if let deatils = self.infoDetail {
            self.infoDetails.attributedText = deatils
            self.infoTextView.attributedText = deatils
        } else {
            self.infoDetails.attributedText = NSAttributedString(string: "", attributes: self.infoDetails.attributedText?.attributes(at: 0, effectiveRange: nil))
            self.infoTextView.attributedText = NSAttributedString(string: "", attributes: self.infoDetails.attributedText?.attributes(at: 0, effectiveRange: nil))
        }
        
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    

}
