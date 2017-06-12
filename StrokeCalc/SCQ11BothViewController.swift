//
//  SCQ11BothViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 12/11/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ11BothViewController: SCBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    
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
    
    func initUI() {
        self.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "11. Extinction & Neglect\n(prior evidence absent)")
        self.questionInfoLabel.attributedText = NSMutableAttributedString().normal(text: "Both sides: Touch the patient on both hands OR both feet at the same time and ask them which side you touched.")
        
        self.tableViewHeightConstraint.constant = SCUtils.shared.sizeFor(value: 196.0)
    }
    
    // MARK: - UITableViewDelegate and UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0 {
//            return SCUtils.ComponentSize.SIZE_375
//        } else {
            return SCUtils.ComponentSize.BUTTON_HEIGHT
//        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell") as! SCDetailTableViewCell
//            
//            cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "11. Extinction & Neglect\n(prior evidence absent)")
//            cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "Both sides: Touch the patient on both hands OR both feet at the same time and ask them which side you touched.")
//            
//            return cell
//        } else
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "centeredcell") as! SCCenteredLabelTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "BOTH", size: 17, alignment: .left)
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "centeredcell") as! SCCenteredLabelTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "RIGHT", size: 17, alignment: .left)
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "centeredcell") as! SCCenteredLabelTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "LEFT", size: 17, alignment: .left)
            return cell
        }
        return defaultCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         // 
        
//        if indexPath.row == 0 {
//            return
//        }
        
        var score = 0
        if indexPath.row == 0 {
            score = 0
        }else {
            score = 1
        }
        
        testScoreService.setScoresForQuestions(dictionary: [SCQType.Q11.rawValue: score])
        
        if score > 0 && testScoreService.getScoreAsIntForQuestionNumberAsString(questionNumber: SCQType.Q9.rawValue) > 0 { // Trigger is activated
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCGuardrail9ViewController") as! SCGuardrail9ViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else { // End exam
            SCUtils.shared.showEndExamAlert()
        }
    }

}
