//
//  SCQ9NamingViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 11/3/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ9NamingViewController: SCBaseViewController, SCAlertServiceProtocol {
    
    
    // MARK: - Properties

    @IBOutlet weak var adjustButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var glassesButton: SCRoundButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var continueButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var adjustButtonHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.adjustButton.setBackgroundColor(color: UIColor.init(red: 241, green: 250, blue: 255, transperancy: 1.0), forState: .normal)
        self.adjustButton.setBackgroundColor(color: UIColor.init(red: 208, green: 225, blue: 236, transperancy: 1.0), forState: .highlighted)
        self.continueButton.setBackgroundColor(color: UIColor.init(red: 241, green: 250, blue: 255, transperancy: 1.0), forState: .normal)
        self.continueButton.setBackgroundColor(color: UIColor.init(red: 208, green: 225, blue: 236, transperancy: 1.0), forState: .highlighted)
        //--
//        self.glassesButton.setShadowLayer()
        
        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showinfo" {
            let infoController = segue.destination as! SCInfoViewController
            infoController.infoHeader = self.infoHeader
            infoController.infoDetail = self.infoDetail
            infoController.infoImage = self.infoImage
        }
    }
    
    
    @IBAction func continueAction(_ sender: Any) {
        
        SCAnswerStatus.sharedInstance.isAdjustForGuardRail6 = false
        
        SCAnswerStatus.sharedInstance.isAdjustForQ9 = false
        
        let q3Score = testScoreService.getScoreAsIntForQuestionNumberAsString(questionNumber: SCQType.Q3.rawValue)
        
//        SCAnswerStatus.sharedInstance.isGuardRail2A
        if q3Score >= 2 { // GuardRail 6 Trigger is Activated...
            
            let alertController = self.storyboard?.instantiateViewController(withIdentifier: "alertcontroller") as! SCAlertViewController
            
            alertController.alertWith(title: NSMutableAttributedString().bold23(text: "Visually Impaired Patient", alignment: NSTextAlignment.center), message: NSMutableAttributedString().normalBlue(text: "The remainder of this exam will be challenging and inaccurate if the patient cannot see. Recommend \"Adjust\" for impaired vision.", alignment:NSTextAlignment.center), okButtonTitle: NSMutableAttributedString().blueButton(text: "OK", size: 20), isLogo: true)
            alertController.delegate = self
            alertController.alertIdentifier = AlertStyle.rotateA
            alertController.modalTransitionStyle = .crossDissolve
            alertController.modalPresentationStyle = .overCurrentContext
            self.present(alertController, animated: true, completion: nil)
            
        }else {
            performSegue(withIdentifier: "torecognition", sender: self)
        }
        
    }
    
    @IBAction func adjustAction(_ sender: Any) {
        SCAnswerStatus.sharedInstance.isAdjustForGuardRail6 = true
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ9VisualImpairedViewController") as! SCQ9VisualImpairedViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func glassesTapped(_ sender: SCRoundButton) {
        self.infoImage = #imageLiteral(resourceName: "glasses_icon")
        self.infoDetail = NSMutableAttributedString().normal(text: "Please remind the patient to wear their glasses when you see the icon.")//\n\nIf the patient does not have their glasses or has difficulty with vision, you may tap on this icon for tips to modify the exam to fit the patient's needs.")
        self.performSegue(withIdentifier: "showinfo", sender: self)
    }
    
    // MARK: - Custom Methods
    
    func initUI() {
        
        var titleStr = ""
        if testScoreService.getFlowNumber() == 3 {
            
            titleStr = "9. Best Language -\nNaming Objects"
            self.adjustButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "ADJUST\n", size: 20).blueButton(text: "For impaired vision", size: 14), for: UIControlState.normal)
            self.continueButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "CONTINUE\n", size: 20).blueButton(text: "For normal vision", size: 14), for: UIControlState.normal)
            
        }else if testScoreService.getFlowNumber() == 4 {
            
            titleStr = "9. Best Language -\nNaming Objects For\nIntubated Patient"
            self.adjustButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "ADJUST", size: 20), for: UIControlState.normal)
            self.continueButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "CONTINUE", size: 20), for: UIControlState.normal)
            
        }
        
        self.contentLabel.attributedText = NSMutableAttributedString().normal(text: "Ask the patient ").orangeBold(text: "TO NAME").normal(text: " the items shown in the next 6 screens.\n\nIf the patient wears glasses, please ask that they wear them.\n\nIf the patient does not have their glasses available or has difficulty with vision, tap ").bold(text: "ADJUST").normal(text: " for impaired vision. Otherwise, tap ").bold(text: "CONTINUE").normal(text: ".")
        
        self.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: titleStr)
        
        self.continueButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
        self.adjustButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
    }
    
    // MARK: - SCAlertServiceProtocol
    
    func okButtonPressed(sender: UIButton) {
//        performSegue(withIdentifier: "torecognition", sender: self)
    }

}
