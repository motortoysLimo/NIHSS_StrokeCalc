//
//  SCQ9_36ViewController.swift
//  StrokeCalc
//
//  Created by Mobile on 10/03/2017.
//  Copyright © 2017 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ9_36ViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource {

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
    
    
    
    // MARK: - UITableViewDelegate / UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return SCUtils.shared.sizeFor(value: 220)
        }else {
            return SCUtils.shared.sizeFor(value: 120)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! SCDetailTableViewCell
            
            if testScoreService.getFlowNumber() == 3 {
                cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "9. Best Language -\nComprehension of Events")
            }else if testScoreService.getFlowNumber() == 4 {
                cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "9. Best Language -\nComprehension of Events\nAnd Expression of Ideas In\nIntubated Patient")
            }
            
            cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "(PLEASE SELECT ONE OPTION FROM THE LIST BELOW)")
            
            return cell
        }else if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "centerCell", for: indexPath) as! SCCenteredLabelTableViewCell
            
            if testScoreService.getFlowNumber() == 3 {
                cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "It is difficult to have a conversation about the events in the picture. But you know which event the patient is trying to describe.", size: 17, alignment: NSTextAlignment.left)
            }else if testScoreService.getFlowNumber() == 4 {
                cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "The patient can mostly understand instructions, and can generally be understood when writing.", size: 17, alignment: NSTextAlignment.left)
            }
        
            return cell
            
        }else if indexPath.row == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "centerCell", for: indexPath) as! SCCenteredLabelTableViewCell
            
            if testScoreService.getFlowNumber() == 3 {
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "You are doing most of the talking and you need to guess which event the patient is trying to describe.", size: 17, alignment: NSTextAlignment.left)
            }else if testScoreService.getFlowNumber() == 4 {
                cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "You have to guess what the patient is trying to write, and which action they are trying to describe.", size: 17, alignment: NSTextAlignment.left)
            }
            return cell
            
        }else if indexPath.row == 3 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "centerCell", for: indexPath) as! SCCenteredLabelTableViewCell
            if testScoreService.getFlowNumber() == 3 {
                cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "The patient demonstrates zero understanding of spoken language.", size: 17, alignment: NSTextAlignment.left)
            }else if testScoreService.getFlowNumber() == 4 {
                cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "The patient demonstrates zero understanding of written language.", size: 17, alignment: NSTextAlignment.left)
            }
        
            return cell
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            return
        }
        
        var score = indexPath.row
        testScoreService.setScoresForQuestions(dictionary: [SCQ9Type.Q9C.rawValue: score])
        
//        if SCAnswerStatus.sharedInstance.isAdjustForGuardRail6 == false {
            // calculate and save Q9 score
            testScoreService.setScoreForQ9()
        
        if testScoreService.getFlowNumber() == 3 {
            score = testScoreService.getScoreAsIntForQuestionNumberAsString(questionNumber: SCQType.Q9.rawValue)
            if score == 0 { // Go to screen 38 only if Q9 score is zero
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ10_38ViewController") as! SCQ10_38ViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else { // Go to screen 37 if Q9 score is 1, 2 or 3
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ10SpeechClarityViewController") as! SCQ10SpeechClarityViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else if testScoreService.getFlowNumber() == 4 {
            
            testScoreService.setScoresForQuestions(dictionary: [SCQType.Q10.rawValue: "UN"])
            
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
//        }else {
        
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ10VSpeechClarityViewController") as! SCQ10VSpeechClarityViewController
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
    }

}
