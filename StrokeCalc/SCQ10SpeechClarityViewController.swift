//
//  SCQ10SpeechClarityViewController.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 2/15/17.
//  Copyright © 2017 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ10SpeechClarityViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    @IBOutlet weak var unableButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var unableButtonHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.unableButtonHeightConstraint.constant = SCUtils.shared.sizeFor(value: 65)
        self.unableButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "UNABLE", size: 20), for: UIControlState.normal)
        self.nextButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "NEXT", size: 20), for: UIControlState.normal)
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
    
    // MARK: - Methods

    @IBAction func unableTouchUp(_ sender: Any) {
        
        if testScoreService.getFlowNumber() == 3 {
            //
            if SCAnswerStatus.sharedInstance.isAdjustForGuardRail6 { // Score 2 points and end exam
                if SCAnswerStatus.sharedInstance.isAdjustForGuardRail1
                    && testScoreService.getScoreAsIntForQuestionNumberAsString(questionNumber: SCQType.Q3.rawValue) > 1 { // Guardrail 7 - If non-confused/non-aphasic patient has received a score of 2 or 3 for Q3, exam does not end and goes to Screen 43
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ11BothViewController") as! SCQ11BothViewController
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }else { // End exam
                    SCUtils.shared.showEndExamAlert()
                }
                
            }else { // Score 2 points and skip screens 40 and 41
                if testScoreService.getScoreAsIntForQuestionNumberAsString(questionNumber: SCQ11Type.Q11A.rawValue) == 1
                    && testScoreService.getScoreAsIntForQuestionNumberAsString(questionNumber: SCQ11Type.Q11B.rawValue) == 1 { // End exam
                    
                    testScoreService.setScoresForQuestions(dictionary: [SCQType.Q11.rawValue: 2])
                    
                    SCUtils.shared.showEndExamAlert()
                    
                }else if testScoreService.getScoreAsIntForQuestionNumberAsString(questionNumber: SCQ11Type.Q11A.rawValue) == 0
                    && testScoreService.getScoreAsIntForQuestionNumberAsString(questionNumber: SCQ11Type.Q11B.rawValue) == 0 { // then screen 43
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ11BothViewController") as! SCQ11BothViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }else { // then screen 42
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ11ExtinctionAndNeglectViewController") as! SCQ11ExtinctionAndNeglectViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
            }
        }else if testScoreService.getFlowNumber() == 5 {
            
            if SCAnswerStatus.sharedInstance.isYesForGuardrail1B {
                testScoreService.setScoresForQuestions(dictionary: [SCQType.Q9.rawValue: 2])
            }else  {
                testScoreService.setScoresForQuestions(dictionary: [SCQType.Q9.rawValue: 3])
            }
            
            testScoreService.setScoresForQuestions(dictionary: [SCQType.Q10.rawValue: 2])
            
            // End exam
            SCUtils.shared.showEndExamAlert()
        }
        
    }
    
    @IBAction func nextTouchUp(_ sender: Any) { // Next
        
        if testScoreService.getFlowNumber() == 3 {
            
            self.showSpeechClarityVC()
            
        }else if testScoreService.getFlowNumber() == 5 {
            
            self.showSpeechClarityVC()
            
        }
        
    }
    
    func showSpeechClarityVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ10VSpeechClarityViewController") as! SCQ10VSpeechClarityViewController
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
        return SCUtils.shared.sizeFor(value: 660)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! SCDetailTableViewCell
        
        cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "10. Speech clarity")
        cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "Ask the patient ").orangeBold(text: "TO REPEAT").bold(text: " the following words:\n").bold(text: "\n  Mama\n  Tip-top\n  Fifty-fifty\n  Thanks\n  Huckelberry\n  Baseball player\n\n", size:23, align:NSTextAlignment.left).normalItalic(text: "If the patient can't repeat words, ").boldItalic(text: "EVALUATE ANY").normalItalic(text: " responses or spontaneous speech for clarity. Listen very carefully and note any slurring of speech.\nIf the patient cannot speak, or with only minimal sounds, tap ").boldItalic(text: "UNABLE").normalItalic(text: ", otherwise tap ").boldItalic(text: "NEXT").normal(text: ".")
        
        return cell
    }
}
