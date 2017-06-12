//
//  SCAlertViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 12/1/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

@objc protocol SCAlertServiceProtocol  {
    @objc optional func yesButtonPressed()
    @objc optional func noButtonPressed()
    @objc optional func okButtonPressed(sender:UIButton)
}

class SCAlertViewController: UIViewController {
    
    // MARK: - Properties
    
    var delegate : SCAlertServiceProtocol?

    @IBOutlet weak var gloveAlertView: UIView!
    @IBOutlet weak var gloveMessageLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: SCAnswerButton!
    
    @IBOutlet weak var rotateAlertView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var rotatoTitleLabel: UILabel!
    @IBOutlet weak var rotateMessageLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var phoneImageView: UIImageView!
    
    var alertIdentifier = AlertStyle.rotateA
    var titleStr = NSMutableAttributedString()
    var messageStr = NSMutableAttributedString()
    var yesButtonTitle = NSMutableAttributedString()
    var noButtonTitle = NSMutableAttributedString()
    var okButtonTitle = NSMutableAttributedString()
    var isLogo:Bool = false
    var isPhone:Bool = false
    
    // Constraints
    
    // -- Glove View
    @IBOutlet weak var yesButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var noButtonHeightConstraint: NSLayoutConstraint!
    
    // -- Rotate View
    @IBOutlet weak var okButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var phoneHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var phoneWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var phoneTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageLabelLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rotateContentLabelBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var rotateContentLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var rotateTitleLabelTopConstraint: NSLayoutConstraint!
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        self.gloveAlertView.alpha = 0.0
        self.rotateAlertView.alpha = 0.0
        self.gloveAlertView.isUserInteractionEnabled = false
        self.rotateAlertView.isUserInteractionEnabled = false
        self.view.layoutIfNeeded()
        
        // set contraints
        self.okButtonHeightConstraint.constant = SCUtils.shared.sizeFor(value: 65)
        self.yesButtonHeightConstraint.constant = SCUtils.shared.sizeFor(value: 65)
        self.noButtonHeightConstraint.constant = SCUtils.shared.sizeFor(value: 65)
        self.imageViewHeightConstraint.constant = SCUtils.shared.sizeFor(value: 80)
        
        self.imageView.alpha = 0
        self.phoneImageView.alpha = 0
        
        self.gloveAlertView.layer.cornerRadius = 10.0
        self.rotateAlertView.layer.cornerRadius = 10.0
        self.gloveAlertView.clipsToBounds = true
        self.rotateAlertView.clipsToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presentAlert()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentAlert() {
        if self.alertIdentifier == AlertStyle.gloveA {
            self.showGloveAlert()
        } else if self.alertIdentifier == AlertStyle.rotateA {
            self.showRotatePhoneAlert()
        }
    }
    
    // MARK: - Init Alert info
    
    func alertWith(title:NSMutableAttributedString, message:NSMutableAttributedString, yesButtonTitle:NSMutableAttributedString, noButtonTitle:NSMutableAttributedString, okButtonTitle: NSMutableAttributedString, style: AlertStyle, isLogo: Bool) {
        self.titleStr = title
        self.messageStr = message
        self.alertIdentifier = style
        self.yesButtonTitle = yesButtonTitle
        self.noButtonTitle = noButtonTitle
        self.okButtonTitle = okButtonTitle
        self.isLogo = isLogo
        
    }
    
    func alertWith(title:NSMutableAttributedString, message:NSMutableAttributedString, okButtonTitle: NSMutableAttributedString, isLogo: Bool) {
        self.titleStr = title
        self.messageStr = message
        self.alertIdentifier = AlertStyle.rotateA
        self.okButtonTitle = okButtonTitle
        self.isLogo = isLogo
        
    }
    
    func alertWith(title:NSMutableAttributedString, message:NSMutableAttributedString, okButtonTitle: NSMutableAttributedString, isPhone: Bool) {
        self.titleStr = title
        self.messageStr = message
        self.alertIdentifier = AlertStyle.rotateA
        self.okButtonTitle = okButtonTitle
        self.isLogo = false
        self.isPhone = isPhone
        
    }
    
    func alertWith(message:NSMutableAttributedString, yesButtonTitle:NSMutableAttributedString, noButtonTitle:NSMutableAttributedString) {

        self.messageStr = message
        self.alertIdentifier = AlertStyle.gloveA
        self.yesButtonTitle = yesButtonTitle
        self.noButtonTitle = noButtonTitle
    
    }
    
    
    // MARK: - Show the Alert
    
    func showGloveAlert() {
        self.yesButton.setAttributedTitle(self.yesButtonTitle, for: UIControlState.normal)
        
        self.noButton.setAttributedTitle(self.noButtonTitle, for: UIControlState.normal)
        
        self.gloveMessageLabel.attributedText = self.messageStr
        
        self.gloveAlertView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.gloveAlertView.alpha = 1.0
            self.gloveAlertView.transform = .identity
            self.view.layoutIfNeeded()
            }
            , completion: { (finished) in
                self.gloveAlertView.isUserInteractionEnabled = true
        })
    }
    
    func showRotatePhoneAlert() {
        
        if !self.isLogo {
            self.imageViewHeightConstraint.constant = 0
            self.rotateTitleLabelTopConstraint.constant = 0
        }else {
            self.imageView.alpha = 1.0
        }
        
        if !self.isPhone {
            self.phoneWidthConstraint.constant = 0
            self.messageLabelLeadingConstraint.constant = 0
        }else {
            self.phoneImageView.alpha = 1
        }
        
        self.okButton.setAttributedTitle(self.okButtonTitle, for: UIControlState.normal)
        
        if self.titleStr.length == 0 {
            self.rotateContentLabelTopConstraint.constant = 0
            self.phoneTopConstraint.constant = 5
        }
        
        self.rotatoTitleLabel.attributedText = self.titleStr
        
        self.rotateMessageLabel.attributedText = self.messageStr
        
        self.rotateAlertView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.rotateAlertView.alpha = 1.0
            self.rotateAlertView.transform = .identity
            self.view.layoutIfNeeded()
        }
            , completion: { (finished) in
                self.rotateAlertView.isUserInteractionEnabled = true
        })
        
    }

    @IBAction func yesAction(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.delegate!.yesButtonPressed!()
        })
    }
    
    @IBAction func noAction(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.delegate!.noButtonPressed!()
        })
    }
    
    @IBAction func okAction(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.delegate?.okButtonPressed!(sender: sender as! UIButton)
        })
    }

}

enum AlertStyle {
    case rotateA
    case gloveA
}
