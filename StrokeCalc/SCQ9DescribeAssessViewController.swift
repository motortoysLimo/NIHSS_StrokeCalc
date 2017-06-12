//
//  SCQ9DescribeAssessViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 12/7/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ9DescribeAssessViewController: SCBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var yesButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var noButtonHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var yesButton: SCAnswerButton!
    @IBOutlet weak var noButton: SCAnswerButton!
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.yesButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
        self.noButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
        
        self.yesButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "YES\n", size: 20).blueButton(text: "Coherent", size: 14), for: UIControlState.normal)
        self.noButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "NO\n", size: 20).blueButton(text: "Incoherent", size: 14), for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UITableViewDelegate and UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCUtils.shared.sizeFor(value: 420)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell") as! SCDetailTableViewCell
        
        cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "When describing the events\nof the preceding picture,\nwas the patient coherent in\ntheir expression by using\nwords and sentences?")
        cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "Choose ").bold(text: "YES").normal(text: " if the patient is coherent in expressing ideas.\n\nChoose ").bold(text: "NO").normal(text: " if the patient having difficulty expressing ideas with words.")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    // MARK: - UIButton Actions
    
    @IBAction func noAction(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ9_36ViewController") as! SCQ9_36ViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func yesAction(_ sender: Any) {
        testScoreService.setScoresForQuestions(dictionary: [SCQ9Type.Q9C.rawValue: 0])
        
        testScoreService.setScoreForQ9()
        
        if testScoreService.getFlowNumber() == 3 {
            let score = testScoreService.getScoreAsIntForQuestionNumberAsString(questionNumber: SCQType.Q9.rawValue)
            if score == 0 {
                
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
    }

}
