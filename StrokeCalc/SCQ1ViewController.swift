//
//  SCQ1ViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 10/28/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ1ViewController: SCBaseViewController {

    // MARK: - Properties
    
    @IBOutlet weak var shadow: UIView!
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var yesBtn: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // Constraints
    @IBOutlet weak var noButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var yesButtonHeightConstraint: NSLayoutConstraint!
    
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UIButton Actions
    
    @IBAction func yesAction(_ sender: AnyObject) {
        testScoreService.setScoresForQuestions(dictionary: ["0": 1])
        
        performSegue(withIdentifier: "toq1a", sender: self)
    }
    
    @IBAction func noAction(_ sender: AnyObject) {
        testScoreService.setScoresForQuestions(dictionary: ["0": 0])
        performSegue(withIdentifier: "toq1a", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Custom Methods
    
    func initUI() {
        self.noButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
        self.yesButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
        
        self.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "Barriers to Communication")
        self.contentLabel.attributedText = NSMutableAttributedString().normal(text: "Does the patient have any barriers to verbal communication, such as:\n•   ").bold(text: "Intubation").normal(text: "\n•   oral/facial trauma,\n•   foreign language speaker without\n    presence of translator, etc?")
        self.descriptionLabel.attributedText = NSMutableAttributedString().blueBoldItalic(text: "Remember to use a translator when possible for a non-English speaking patient.")
        self.yesBtn.setAttributedTitle(NSMutableAttributedString().blueButton(text: "YES", size: 20), for: UIControlState.normal)
        self.noBtn.setAttributedTitle(NSMutableAttributedString().blueButton(text: "NO", size: 20), for: UIControlState.normal)
    }

}
