//
//  SCIntubationModalViewController.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 13/03/2017.
//  Copyright © 2017 Mobile Guru. All rights reserved.
//

import UIKit

@objc protocol SCIntubationModalDelegate  {
    @objc optional func understandPressed(sender:UIButton)
}

class SCIntubationModalViewController: UIViewController {
    
    // MARK: - Properties
    
    var delegate: SCIntubationModalDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var understandButton: SCAnswerButton!
    @IBOutlet weak var understandButtonHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.titleLabel.attributedText = NSMutableAttributedString().boldRed(text: "WARNING:", size: 35, align: NSTextAlignment.center)
        self.contentLabel.attributedText = NSMutableAttributedString().boldBlue(text: "Because the ", size: 19).boldRed(text: "patient is intubated, ", size: 19, align: NSTextAlignment.left).boldBlue(text: "take appropriate precautions to ensure a secure airway and avoid accident extubation.", size: 19)
        
        self.understandButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "I Understand", size: 20), for: UIControlState.normal)
        
        self.understandButtonHeightConstraint.constant = SCUtils.shared.sizeFor(value: 65)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func understandTouchUp(_ sender: SCAnswerButton) {
        self.dismiss(animated: true) { 
            self.delegate?.understandPressed!(sender: sender)
        }
    }

}
