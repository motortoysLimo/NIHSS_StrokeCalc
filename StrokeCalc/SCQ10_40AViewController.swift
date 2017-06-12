//
//  SCQ10_40AViewController.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 13/03/2017.
//  Copyright © 2017 Mobile Guru. All rights reserved.
//

import UIKit

class SCQ10_40AViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionInfoLabel: UILabel!
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        self.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "10. Speech clarity")
        self.questionInfoLabel.attributedText = NSMutableAttributedString().normal(text: "How clear was the patient's speech?")
        
        self.tableViewHeightConstraint.constant = SCUtils.shared.sizeFor(value: 401)
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
//        if indexPath.row == 0 {
//            return SCUtils.shared.sizeFor(value: 200)
//        }else {
            return SCUtils.shared.sizeFor(value: 100)
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! SCDetailTableViewCell
//            cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "10. Speech clarity")
//            cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "How clear was the patient's speech?")
//            
//            return cell
//        }else
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "centerCell", for: indexPath) as! SCCenteredLabelTableViewCell
            
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Clear and normal", size: SCUtils.shared.sizeFor(value: 17), alignment: NSTextAlignment.left)
            
            return cell
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "centerCell", for: indexPath) as! SCCenteredLabelTableViewCell
            
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Some slurring\n", size: SCUtils.shared.sizeFor(value: 17), alignment: NSTextAlignment.left).textForCell(text: "Words are understandable.", size: SCUtils.shared.sizeFor(value: 14), alignment: NSTextAlignment.left)
            
            return cell
        }else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "centerCell", for: indexPath) as! SCCenteredLabelTableViewCell
            
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Severely slurred\n", size: SCUtils.shared.sizeFor(value: 17), alignment: NSTextAlignment.left).textForCell(text: "Speech cannot be understood in any\nmeaningful way.", size: SCUtils.shared.sizeFor(value: 14), alignment: NSTextAlignment.left)
            
            return cell
        }else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "centerCell", for: indexPath) as! SCCenteredLabelTableViewCell
            
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Unable/Mute\n", size: SCUtils.shared.sizeFor(value: 17), alignment: NSTextAlignment.left).textForCell(text: "Patient is mute.", size: SCUtils.shared.sizeFor(value: 14), alignment: NSTextAlignment.left)
            
            return cell
        }
        
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//            return
//        }
        
        var score = indexPath.row// - 1
        if score > 2 { // Normal: 0, Some Slurring: 1, Severely Slurred: 2, Mute: 2 
            score = 2
        }
        testScoreService.setScoresForQuestions(dictionary: [SCQType.Q10.rawValue: score])
        
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
