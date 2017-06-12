//
//  SCGuardRail1ForFlow5ViewController.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 14/03/2017.
//  Copyright © 2017 Mobile Guru. All rights reserved.
//

import UIKit

class SCGuardRail1ForFlow5ViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    @IBOutlet weak var q1bLabel: UILabel!
    @IBOutlet weak var q1cLabel: UILabel!
    @IBOutlet weak var scoreViewTopConstraint: NSLayoutConstraint!
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.scoreViewTopConstraint.constant = -60
        
        if SCAnswerStatus.sharedInstance.isAdjustForGuardRail1 {
            self.q1bLabel.text = "Q1B: scored as " + String(testScoreService.getScoreAsIntForQuestionNumberAsString(questionNumber: SCQType.Q1B.rawValue))
            self.q1cLabel.text = "Q1C: obeyed " + String(testScoreService.getScoreAsIntForQuestionNumberAsString(questionNumber: SCQType.Q1C.rawValue)) + " commands"
        }else {
            self.q1bLabel.text = "Q1B: scored as " + String(testScoreService.getScoreAsIntForQuestionNumberAsString(questionNumber: SCQType.Q1B.rawValue))
            self.q1cLabel.text = "Q1C: obeyed " + String(testScoreService.getScoreAsIntForQuestionNumberAsString(questionNumber: SCQType.Q1C.rawValue)) + " command"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
        if SCAnswerStatus.sharedInstance.isAdjustForGuardRail1 {
            return 4
        }else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if SCAnswerStatus.sharedInstance.isAdjustForGuardRail1 {
                return SCUtils.shared.sizeFor(value: 380)
            }else {
                return SCUtils.shared.sizeFor(value: 510)
            }
        }else {
            return SCUtils.shared.sizeFor(value: 65)
        }
            
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! SCDetailTableViewCell
            cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "Guardrail")
            
            var str: NSMutableAttributedString
            if SCAnswerStatus.sharedInstance.isAdjustForGuardRail1 {
                str = NSMutableAttributedString().boldBlue(text: "Obeys BOTH COMMANDS while stuporous?!").normal(text: "\n\nIt is unlikely that a stuporous patient would follow both of your commands.\nTap ADD NOTE to provide explanation, then press CONTINUE.\nOtherwise, click CANCEL to go back.")
            }else {
                str = NSMutableAttributedString().boldBlue(text: "Mr John Jones is having difficulty understanding and following instructions.\n\n").normal(text: "You have indicated that the patient is stuporous, or nearly unconscious with mental activity that is reduced in its ability to respond to stimulation.\n\n").bold(text: "Stimulate the patient with painful stimuli and by yelling \"Wake Up!\"\nCan the patient open the eyes and\nlook at you?")
            }
            cell.questionInfolabel.attributedText = str
            
            return cell
        }else if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath) as! SCAnswerTableViewCell
            
            if SCAnswerStatus.sharedInstance.isAdjustForGuardRail1 {
                cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "CANCEL", size: 17, alignment: NSTextAlignment.center)
            }else {
                cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "YES\n", size: 17, alignment: NSTextAlignment.center).textForCell(text: "But requires constant stimulation", size: 14, alignment: NSTextAlignment.center)
            }
            
            return cell
        }else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath) as! SCAnswerTableViewCell
            
            if SCAnswerStatus.sharedInstance.isAdjustForGuardRail1 {
                cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "ADD NOTE", size: 17, alignment: NSTextAlignment.center)
            }else {
                cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "NO\n", size: 17, alignment: NSTextAlignment.center).textForCell(text: "Not long enough to maintain gaze", size: 14, alignment: NSTextAlignment.center)
            }
            
            return cell
        }else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath) as! SCAnswerTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "CONTINUE", size: 17, alignment: NSTextAlignment.center).textForCell(text: "\nPatient obeys both commands while stuporous", size: 14, alignment: NSTextAlignment.center)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            return
        }
        
        if indexPath.row == 1 {
            if SCAnswerStatus.sharedInstance.isAdjustForGuardRail1 {
                // Cancel
                let _ = self.navigationController?.popViewController(animated: true)
            }else { // YES
                
                SCAnswerStatus.sharedInstance.isYesForGuardrail1B = true
                self.showBestHorizontalVC()
            }
        }else if indexPath.row == 2 {
            if SCAnswerStatus.sharedInstance.isAdjustForGuardRail1 {
                // Add note
            }else { // NO
                self.showBestHorizontalForFlow1VC()
            }
        }else if indexPath.row == 3 {
            self.showBestHorizontalForFlow1VC()
        }
    }
    
    // MARK: - Custom Methods
    
    func showBestHorizontalVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCBestHorizontalForFlow5ViewController") as! SCBestHorizontalForFlow5ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showBestHorizontalForFlow1VC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCBestGazeFlow1ViewController") as! SCBestGazeFlow1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
