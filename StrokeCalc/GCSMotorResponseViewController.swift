//
//  GCSMotorResponseViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 12/26/16.
//  Copyright © 2016 Mobile Guru. All rights reserved.
//

import UIKit

class GCSMotorResponseViewController: SCBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
    
    // MARK: - UITableViewDelegate / UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return SCUtils.shared.sizeFor(value: 220)
        } else {
            return SCUtils.shared.sizeFor(value: 65)
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell") as! SCDetailTableViewCell
            
            cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "GCS - Motor Response")
            cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "Please select one option from the list below")
            
            return cell
        } else if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "gsccell") as! SCAnswerTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Obeys commands", size: 17, alignment: .left)
            cell.dictionaryButton.isHidden = true
            cell.dictionaryButton.isEnabled = false
            
            return cell
        } else if indexPath.row == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "gsccell") as! SCAnswerTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Localizes pain", size: 17, alignment: .left)
            cell.dictionaryButton.isHidden = true
            cell.dictionaryButton.isEnabled = false
            
            return cell
        } else if indexPath.row == 3 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "gsccell") as! SCAnswerTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Withdrawal from pain", size: 17, alignment: .left)
            cell.dictionaryButton.isHidden = true
            cell.dictionaryButton.isEnabled = false
            
            return cell
        } else if indexPath.row == 4 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "gsccell") as! SCAnswerTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Flexion to pain\n(Decerebrate posturing)", size: 17, alignment: .left)
            cell.dictionaryButton.tag = 1
            cell.dictionaryButton.isHidden = false
            cell.dictionaryButton.isEnabled = true
            
            return cell
        } else if indexPath.row == 5 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "gsccell") as! SCAnswerTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Extension to pain\n(Decerebrate posturing)", size: 17, alignment: .left)
            cell.dictionaryButton.tag = 2
            cell.dictionaryButton.isHidden = false
            cell.dictionaryButton.isEnabled = true
            
            return cell
        } else if indexPath.row == 6 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "gsccell") as! SCAnswerTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "No motor response", size: 17, alignment: .left)
            cell.dictionaryButton.isHidden = true
            cell.dictionaryButton.isEnabled = false
            
            return cell
        }
        return defaultCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            return
        }
        var score = 0
        if indexPath.row == 1 {
            score = 0
        }else {
            score = 7 - indexPath.row
        }
        
        score += testScoreService.getScoreAsIntForQuestionNumberAsString(questionNumber: "GCS")
        testScoreService.setScoresForQuestions(dictionary: ["GCS": score])
        
        if score <= 8 { // GCS =< 8 go to screen 7
            performSegue(withIdentifier: "segue_totalscore", sender: self)
        }else { // GCS >= 9 -> go to screen 10
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCDeviatedAndFixedGazeViewController") as! SCDeviatedAndFixedGazeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
