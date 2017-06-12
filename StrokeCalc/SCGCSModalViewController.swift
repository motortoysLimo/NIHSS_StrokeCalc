//
//  SCGCSModalViewController.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 14/03/2017.
//  Copyright © 2017 Mobile Guru. All rights reserved.
//

import UIKit

@objc protocol SCGCSModalProtocol {
    @objc optional func understandPressed()
}

class SCGCSModalViewController: UIViewController {
    
    // MARK: - Properties
    
    var delegate: SCGCSModalProtocol?

    @IBOutlet weak var understandHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var understandButton: SCAnswerButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var noteView: UIView!
    
    var titleAttr = NSMutableAttributedString()
    var contentAttr = NSMutableAttributedString()
    var logoImage: UIImage?
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.understandHeightConstraint.constant = SCUtils.shared.sizeFor(value: 65)
        self.understandButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "I Understand", size: 20), for: UIControlState.normal)
        
        self.noteView.alpha = 0.0
        self.noteView.clipsToBounds = true
        self.noteView.isUserInteractionEnabled = false
        self.noteView.layer.cornerRadius = 10.0
        self.view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showNoteView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Init Modal View
    
    func modalWith(title: NSMutableAttributedString, content: NSMutableAttributedString, logo: UIImage) {
        self.titleAttr = title
        self.contentAttr = content
        self.logoImage = logo
    }
    
    func modalWith(title: NSMutableAttributedString, content: NSMutableAttributedString) {
        self.titleAttr = title
        self.contentAttr = content
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func understandTouchUp(_ sender: UIButton) {
        self.dismiss(animated: true) { 
            self.delegate?.understandPressed!()
        }
    }
    
    // MARK: - Show note view
    
    func showNoteView() {
        
        self.titleLabel.attributedText = self.titleAttr
        self.contentLabel.attributedText = self.contentAttr
        
        if logoImage != nil {
            self.logoImageView.image = self.logoImage
        }
        
        self.noteView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.noteView.alpha = 1.0
            self.noteView.transform = .identity
            self.view.layoutIfNeeded()
        }
            , completion: { (finished) in
                self.noteView.isUserInteractionEnabled = true
        })
    }

}
