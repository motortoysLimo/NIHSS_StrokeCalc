//
//  SCQ9RepeatingSentencesViewController.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 2/15/17.
//  Copyright © 2017 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ9RepeatingSentencesViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: - Properties
    
    @IBOutlet weak var abnormalButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var normalButtonHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var abnormalButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var glassButton: SCRoundButton!
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
//        self.glassButton.setShadowLayer()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // MARK: - UIButton Actions
    
    func initUI() {
        self.normalButtonHeightConstraint.constant = SCUtils.shared.sizeFor(value: 65)
        self.abnormalButtonHeightConstraint.constant = SCUtils.shared.sizeFor(value: 65)
        
        self.normalButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "NORMAL", size: 20), for: UIControlState.normal)
        self.abnormalButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "ABNORMAL", size: 20), for: UIControlState.normal)
    }
    
    @IBAction func normalTouchUp(_ sender: Any) {
        // Calculate the Q9 Score
        testScoreService.setScoreForQ9()
        
        if testScoreService.getFlowNumber() == 3 {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ10SpeechClarityViewController") as! SCQ10SpeechClarityViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else if testScoreService.getFlowNumber() == 4 {
            
            if SCAnswerStatus.sharedInstance.isAdjustForGuardRail1
                && testScoreService.getScoreAsIntForQuestionNumberAsString(questionNumber: SCQType.Q3.rawValue) > 1 { // Guardrail 7 - If non-confused/non-aphasic patient has received a score of 2 or 3 for Q3, exam does not end and goes to Screen 43
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ11BothViewController") as! SCQ11BothViewController
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else { // End exam
                // Q10 is skipped (screen 37, 38, 39, 40 & 41) and auto-scored as UN - End exam
                testScoreService.setScoresForQuestions(dictionary: [SCQType.Q10.rawValue: "UN"])
                
                SCUtils.shared.showEndExamAlert()
            }
        }
    }

    @IBAction func abnormalTouchUp(_ sender: Any) {
        //----
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ9RepeatingSentencesChoiceViewController") as! SCQ9RepeatingSentencesChoiceViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func glassesTapped(_ sender: SCRoundButton) {
        self.infoImage = #imageLiteral(resourceName: "glasses_icon")
        self.infoDetail = NSMutableAttributedString().normal(text: "Please remind the patient to wear their glasses when you see the icon.")//\n\nIf the patient does not have their glasses or has difficulty with vision, you may tap on this icon for tips to modify the exam to fit the patient's needs.")
        self.performSegue(withIdentifier: "showinfo", sender: self)
    }
    
    // MARK: - UITableViewDelegate / UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCUtils.shared.sizeFor(value: 530)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! SCDetailTableViewCell
        
        cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "9. Best Language -\nRepeating Sentences")
        cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "Ask the patient ").orangeBold(text: "TO REPEAT THE SENTENCES").normal(text: " below.\n\n").bold(text: "You know how.\nDown to earth.\nI got home from work.\nNear the table in the dining room.\nThey heard him speak on the radio last night.", space:14.0).normal(text: "\n\nHow would you assess the patient's ability to communicate through spoken language?")
        
        return cell
    }
}
