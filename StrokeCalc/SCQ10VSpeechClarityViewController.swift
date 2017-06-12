//
//  SCQ10VSpeechClarityViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 11/3/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ10VSpeechClarityViewController: SCBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionInfoLabel: UILabel!
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
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
    
    
    // MARK: - Init UI
    
    func initUI() {
        self.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "10. Speech clarity")
        self.questionInfoLabel.attributedText = NSMutableAttributedString().normal(text: "How clear was the patient's speech?")
        
        self.tableViewHeightConstraint.constant = SCUtils.shared.sizeFor(value: 90) * 3
    }
    
    
    // MARK: - UITableViewDelegate / UITableViewDataSource
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0 {
//            return SCUtils.ComponentSize.SIZE_260
//        } else {
           return SCUtils.ComponentSize.SIZE_90
//        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell") as! SCDetailTableViewCell
//            
//            cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "10. Speech clarity")
//            cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "How clear was the patient's speech?")
//            
//            return cell
//        } else
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "centeredcell") as! SCCenteredLabelTableViewCell
            
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Clear and normal", size: 17, alignment: .left)
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "centeredcell") as! SCCenteredLabelTableViewCell
            
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Some slurring\n", size: 17, alignment: .left).textForCell(text: "Words are understandable.", size: 14, alignment: .left)
            
//            cell.subtitleText.attributedText = NSMutableAttributedString().textForCell(text: "Words are understandable.", size: 15, alignment: .left)
            
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "centeredcell") as! SCCenteredLabelTableViewCell
            
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Severely slurred\n", size: 17, alignment: .left).textForCell(text: "Speech cannot be understood in any\nmeaningful way.", size: 15, alignment: .left)
            
//            cell.subtitleText.attributedText = NSMutableAttributedString().textForCell(text: "Speech cannot be understood in any\nmeaningful way.", size: 15, alignment: .left)
            
            return cell
        }
        return defaultCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        if indexPath.row == 0 {
//            return
//        }
        
        let score = indexPath.row
        
        testScoreService.setScoresForQuestions(dictionary: [SCQType.Q10.rawValue: score])
        
        if testScoreService.getFlowNumber() == 3 {
            if SCAnswerStatus.sharedInstance.isAdjustForGuardRail6 { // End exam
                if SCAnswerStatus.sharedInstance.isAdjustForGuardRail1
                    && testScoreService.getScoreAsIntForQuestionNumberAsString(questionNumber: SCQType.Q3.rawValue) > 1 { // Guardrail 7 - If non-confused/non-aphasic patient has received a score of 2 or 3 for Q3, exam does not end and goes to Screen 43
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ11BothViewController") as! SCQ11BothViewController
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }else { // End exam
                    SCUtils.shared.showEndExamAlert()
                }
            }else {
                
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
            if score == 1 { // Some Slurring
                testScoreService.setScoresForQuestions(dictionary: [SCQType.Q9.rawValue: 1])
            }else if score == 2 {
                testScoreService.setScoresForQuestions(dictionary: [SCQType.Q9.rawValue: 2])
            }
            
            // End exam
            SCUtils.shared.showEndExamAlert()
        }
        
    }
    


}
