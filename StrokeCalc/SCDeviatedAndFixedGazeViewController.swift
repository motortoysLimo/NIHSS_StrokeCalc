//
//  SCDeviatedAndFixedGazeViewController.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 10/28/16.
//  Copyright © 2016 Mobile Guru. All rights reserved.
//

import UIKit

class SCDeviatedAndFixedGazeViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    
    @IBOutlet weak var abnormalButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var shadow: UIView!
    
    // Constraints
    @IBOutlet weak var normalButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var abnormalButtonHeightConstraint: NSLayoutConstraint!
    
    
    var isNeutral = false
    
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button Actions
    
    @IBAction func abnormal(_ sender: AnyObject) {
        
        testScoreService.setScoresForQuestions(dictionary: [SCQType.Q2.rawValue: 2])
        
        let currentFlow = testScoreService.getFlowNumber()
        
        if currentFlow == 1
        || currentFlow == 2{
            // Score 2 points & go to Q4
            
            self.showFacialPalsy()
            
        }else if currentFlow == 3
            || currentFlow == 4
            || currentFlow == 5
            || currentFlow == 6 {
            // Score 2 points & go to Q3
    
            self.showVisualFields()
            
        }
    }

    @IBAction func normalAction(_ sender: AnyObject) {
        
        if self.isNeutral {
            testScoreService.setScoresForQuestions(dictionary: [SCQType.Q2.rawValue: 0])
        }else {
            testScoreService.setScoresForQuestions(dictionary: [SCQType.Q2.rawValue: 1])
        }
        
        let currentFlow = testScoreService.getFlowNumber()
        if currentFlow == 1
            || currentFlow == 2 {
            
            self.showFacialPalsy()
            
        }else if currentFlow == 3
            || currentFlow == 4
            || currentFlow == 5
            || currentFlow == 6 {
            // Score 1 points & go to Q3

            self.showVisualFields()
            
        }
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
        
        self.normalButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
        self.abnormalButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
        
        self.normalButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "Normal\nresponse", size: 20), for: UIControlState.normal)
        self.abnormalButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "Abnormal\nresponse", size: 20), for: UIControlState.normal)
    }
    
    func showVisualFields() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCVisualFieldsViewController") as! SCVisualFieldsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showFacialPalsy() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCFacialPalsyViewController") as! SCFacialPalsyViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - UITableViewDelegate / UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let currentFlow = testScoreService.getFlowNumber()
        if ((currentFlow == 1
            || currentFlow == 2
            || currentFlow == 5
            || currentFlow == 6 )
            && self.isNeutral == true ){
            
            return SCUtils.shared.sizeFor(value: 600)
            
        }else {
            
            return SCUtils.shared.sizeFor(value: 530)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! SCDetailTableViewCell
        
        let titleStr: String
        let contentStr: String
        
        
        let currentFlow = testScoreService.getFlowNumber()
        if ((currentFlow == 1
            || currentFlow == 2
            || currentFlow == 5
            || currentFlow == 6)
            && self.isNeutral == true ){
            titleStr = "Oculocephalic Maneuver In a Patient With Decreased Level of Consciousness"
            contentStr = "Watch the video below and then perform the oculocephalic (or Doll's Eye) maneuver on the patient."
            cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "Does the patient's eyes respond exactly\nin the same way as in the video?\nIf yes, tap ").bold(text: "NORMAL RESPONSE").normal(text: ".\nOtherwise, tap ").bold(text: "ABNORMAL\nRESPONSE").normal(text: ".")
        }else {
            titleStr = "Deviated & Fixed Gaze of Both Eyes"
            contentStr = "You must perform the oculocephalic (Doll's Eyes) maneuver."
            cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "Does the Doll's Eyes maneuver\novercome the deviated gaze, similar\nto the video? If yes, tap ").bold(text: "NORMAL\nRESPONSE").normal(text: ". Otherwise, tap\n").bold(text: "ABNORMAL RESPONSE").normal(text: ".")
        }
        cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: titleStr)
        cell.contentLabel.attributedText = NSMutableAttributedString().normal(text: contentStr)
    
        return cell
        
    }

}
