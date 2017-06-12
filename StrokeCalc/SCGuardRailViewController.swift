//
//  SCGuardRailViewController.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 10/28/16.
//  Copyright © 2016 Mobile Guru. All rights reserved.
//

import UIKit

class SCGuardRailViewController: SCBaseViewController, SCAlertServiceProtocol {
    
    // MARK: - Properties

    @IBOutlet weak var adjustButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var shadow: UIView!
    @IBOutlet weak var q1bLabel: UILabel!
    @IBOutlet weak var q1cLabel: UILabel!
    @IBOutlet weak var scoreView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    // Constraints
    @IBOutlet weak var scoreViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var continueButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var adjustButtonHeightConstraint: NSLayoutConstraint!
    
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initUI()
        
        self.scoreViewTopConstraint.constant = -60
        
        self.adjustButton.setBackgroundColor(color: UIColor.init(red: 241, green: 250, blue: 255, transperancy: 1.0), forState: .normal)
        self.adjustButton.setBackgroundColor(color: UIColor.init(red: 208, green: 225, blue: 236, transperancy: 1.0), forState: .highlighted)
        self.continueButton.setBackgroundColor(color: UIColor.init(red: 241, green: 250, blue: 255, transperancy: 1.0), forState: .normal)
        self.continueButton.setBackgroundColor(color: UIColor.init(red: 208, green: 225, blue: 236, transperancy: 1.0), forState: .highlighted)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showScoreView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Custom Methods
    
    func initUI() {
        self.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "Guardrail")
        self.questionLabel.attributedText = NSMutableAttributedString().boldBlue(text: "Is your patient having difficulty understanding language (aphasia) and/or following instructions?")
        self.descriptionLabel.attributedText = NSMutableAttributedString().normal(text: "If so, tap 'ADJUST' and the remainder of this exam will be directed towards an aphasic/confused patient.")
        
        self.adjustButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "ADJUST", size: 20).blueButton(text: "\nConfusion or aphasia", size: 14), for: UIControlState.normal)
        self.continueButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "CONTINUE", size: 20).blueButton(text: "\nStandard NIHSS exam", size: 14), for: UIControlState.normal)
        
        self.continueButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
        self.adjustButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
    }
    
    func showScoreView() {
        
        let q1bScore = testScoreService.getScoreAsIntForQuestionNumberAsString(questionNumber: SCQType.Q1B.rawValue)
        let q1cScore = testScoreService.getScoreAsIntForQuestionNumberAsString(questionNumber: SCQType.Q1C.rawValue)
        
        if (2 - q1bScore) > 1 {
            self.q1bLabel.text = "Q1B: answered \(2 - q1bScore) questions"
        }else {
            self.q1bLabel.text = "Q1B: answered \(2 - q1bScore) question"
        }
        
        if (2 - q1cScore) > 1 {
            self.q1cLabel.text = "Q1C: obeyed \(2 - q1cScore) commands"
        }else {
            self.q1cLabel.text = "Q1C: obeyed \(2 - q1cScore) command"
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            // Show the scoreView
            self.scoreViewTopConstraint.constant = 0
            self.view.layoutIfNeeded()
        }) { (isFinished) in
            // Hide scoreView 1s later
            let when = DispatchTime.now() + 1.5 // change 3 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                // Your code with delay
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                    self.scoreViewTopConstraint.constant = -60
                    self.view.layoutIfNeeded()
                }) { (isFinished) in
                    
                }
            }
        }
        
    }
    
    // MARK: - Button Actions
    
    @IBAction func adjustTouchup(_ sender: UIButton) {
        SCAnswerStatus.sharedInstance.isAdjustForGuardRail1 = true
        
        let alertController = self.storyboard?.instantiateViewController(withIdentifier: "alertcontroller") as! SCAlertViewController
        alertController.alertWith(title: NSMutableAttributedString().bold23(text: "Exam adjusted for\nAphasia/Confusion", alignment: NSTextAlignment.center), message: NSMutableAttributedString().normalBlue(text: "The rest of this exam will be adjusted for a patient with aphasia or confusion."), okButtonTitle: NSMutableAttributedString().blueButton(text: "OK", size: 20), isLogo: false)
        alertController.delegate = self
        alertController.alertIdentifier = AlertStyle.rotateA
        alertController.modalTransitionStyle = .crossDissolve
        alertController.modalPresentationStyle = .overCurrentContext
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func continueTouchup(_ sender: UIButton) {
        SCAnswerStatus.sharedInstance.isAdjustForGuardRail1 = false
        
        self.performSegue(withIdentifier: "tobesthorizontal", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - SCAlertServiceProtocol
    
    func okButtonPressed(sender: UIButton) {
        self.performSegue(withIdentifier: "tobesthorizontal", sender: self)
    }

}
