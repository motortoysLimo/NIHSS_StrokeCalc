//
//  SCQ9RepeatingSentencesChoiceViewController.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 2/15/17.
//  Copyright © 2017 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ9RepeatingSentencesChoiceViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: - Properties
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    // MARK: - UITableViewDelegate & UITableViewDataSource
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return SCUtils.shared.sizeFor(value: 220)
        } else {
            return SCUtils.shared.sizeFor(value: 140)
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell") as! SCDetailTableViewCell
            
            if testScoreService.getFlowNumber() == 3 {
                cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "9. Best Language -\nReading Sentences")
            }else {
                cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "9. Best Language -\nFor Intubated Patient")
            }
            
            cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "(PLEASE SELECT ONE OPTION FROM THE LIST BELOW)")
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "centeredcell") as! SCCenteredLabelTableViewCell
            
            var str = ""
            if testScoreService.getFlowNumber() == 3 {
                str = "The patient can mostly understand instructions, and when speaking can mostly be understood."
            }else { // Flow 4
                str = "The patient can mostly understand instructions, and can generally be understood when writing."
            }
            
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: str, size: 17, alignment: .left)
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "centeredcell") as! SCCenteredLabelTableViewCell
            
            var str = ""
            if testScoreService.getFlowNumber() == 3 {
                if SCAnswerStatus.sharedInstance.isAdjustForGuardRail6 {
                    str = "At best the patient may read one sentence correctly, but generally you have to guess what they are trying to say."
                }else {
                    str = "At best the patient may use one sentence correctly, but generally you have to guess which sentence the patient is trying to say."
                }
            }else { // Flow 4
                str = "At best the patient may copy one sentence correctly, but generally you have to guess what they are trying to write."
            }
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: str, size: 17, alignment: .left)
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "centeredcell") as! SCCenteredLabelTableViewCell
            
            var str = ""
            if testScoreService.getFlowNumber() == 3 {
                str = "The patient demonstrates zero understanding of spoken language."
            }else { // Flow 4
                str = "The patient demonstrates zero understanding of written language."
            }
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: str, size: 17, alignment: .left)
            return cell
        }
        return defaultCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            return
        }
        
        let score = indexPath.row
        testScoreService.setScoresForQuestions(dictionary: [SCQ9Type.Q9B.rawValue: score])
        
        if SCAnswerStatus.sharedInstance.isAdjustForGuardRail6 {
            
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
        
        }else { // Continue for Guardrail 6
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ9ExpressionOfEventViewController") as! SCQ9ExpressionOfEventViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
}
