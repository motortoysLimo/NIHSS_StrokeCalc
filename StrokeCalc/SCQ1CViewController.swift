//
//  SCQ1CViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 10/28/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ1CViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: - Properties
    
    @IBOutlet weak var table: UITableView!

    @IBOutlet weak var mimicButton: UIButton!
    @IBOutlet weak var lightBulbButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.separatorColor = UIColor.init(red: 208, green: 225, blue: 236, transperancy: 1.0)
        
        // Do any additional setup after loading the view.
//        mimicButton.setShadowLayer()
//        lightBulbButton.setShadowLayer()
        
        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func lightbulpTapped(_ sender: AnyObject) {
        
        self.infoImage = #imageLiteral(resourceName: "lightbulb_icon")
        self.infoDetail = NSMutableAttributedString().normal(text: "• Full credit is provided if the patient\n   merely attempts your command.\n").normal(text: "• If the patient's hand is amputated,\n   injured or has an impediment,\n   provide another simple one-step\n   command such as ").bold(text: "wiggling his or\n   her toes ").normal(text: "or ").bold(text: "sticking out his or\n   her tongue").normal(text: ".")
//        self.infoHeader = "Hint"
        self.performSegue(withIdentifier: "showinfo", sender: self)
        
    }
    
    @IBAction func mimicTapped(_ sender: AnyObject) {
        self.infoImage = #imageLiteral(resourceName: "mimic_icon")
        self.infoDetail = NSMutableAttributedString().normal(text: "You may demonstrate opening and\nclosing your eyes and opening a fist\nto the patient.")
//        self.infoHeader = "Mimic"
        self.performSegue(withIdentifier: "showinfo", sender: self)
    }
 
    // MARK: - UITableViewDelegate & UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "answercell") as! SCAnswerTableViewCell
        
        if indexPath.row == 0 {
            cell.answerNumber.image = UIImage(named: "zero")
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Obeys BOTH commands", size: 17, alignment: .left)
            cell.dictionaryButton.isHidden = true
            cell.dictionaryButton.tag = 101
        } else if indexPath.row == 1 {
            cell.answerNumber.image = UIImage(named: "one")
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Obeys ONE command", size: 17, alignment: .left)
            cell.dictionaryButton.isHidden = true
            cell.dictionaryButton.tag = 102
        } else if indexPath.row == 2 {
            cell.answerNumber.image = UIImage(named: "two")
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Obeys NEITHER commands", size: 17, alignment: .left)
            cell.dictionaryButton.isHidden = true
            cell.dictionaryButton.tag = 103
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCUtils.ComponentSize.BUTTON_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performNext(score: indexPath.row)
        
    }
    
    // MARK: - Custom Methods
    
    func initUI() {
        self.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "1C. LOC Commands")
        self.contentLabel.attributedText = NSMutableAttributedString().normal(text: "Ask the patient to:\n 1. ").orangeBold(text: "OPEN THEIR EYES").normal(text: ", then\n   close them.\n 2. ").orangeBold(text: "MAKE A FIST").normal(text: " with the non-\n   paralyzed hand, then open\n   it.")
        self.descriptionLabel.attributedText = NSMutableAttributedString().orangeBoldItalic(text: "* Full credit if patient merely attempts your command")
        
        self.tableViewHeightConstraint.constant = SCUtils.shared.sizeFor(value: 65) * 3 + 2
    }
    
    func performNext(score: Int) {
        
        testScoreService.setScoresForQuestions(dictionary: [SCQType.Q1C.rawValue: score])
        
        if testScoreService.getFlowNumber() == 3 {
            
            let q1bScore = testScoreService.getScoreAsIntForQuestionNumberAsString(questionNumber: SCQType.Q1B.rawValue)
            let q1cScore = score
            
            if (q1bScore + q1cScore) >= 2 { // Guardrail 1 Trigger is activated...
                performSegue(withIdentifier: "toguardrail", sender: self)
            }else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCBestHorizontalGazeViewController") as! SCBestHorizontalGazeViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
                SCAnswerStatus.sharedInstance.isAdjustForGuardRail1 = false
            }
        }else if testScoreService.getFlowNumber() == 4 {
            
            if score == 0 { //
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCBestHorizontalGazeViewController") as! SCBestHorizontalGazeViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
                SCAnswerStatus.sharedInstance.isAdjustForGuardRail1 = false
            }else { // Guardrail 1 Trigger is activated...
                
                performSegue(withIdentifier: "toguardrail", sender: self)
            }
            
        }else if testScoreService.getFlowNumber() == 5 {
            if score == 0 {
                SCAnswerStatus.sharedInstance.isAdjustForGuardRail1 = true
            }else { //
                SCAnswerStatus.sharedInstance.isAdjustForGuardRail1 = false
            }
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCGuardRail1ForFlow5ViewController") as! SCGuardRail1ForFlow5ViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if testScoreService.getFlowNumber() == 6 {
            if score == 0 {
                
                SCAnswerStatus.sharedInstance.isAdjustForGuardRail1 = true
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCGuardRail1ForFlow5ViewController") as! SCGuardRail1ForFlow5ViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else {
                SCAnswerStatus.sharedInstance.isAdjustForGuardRail1 = false
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCGuardRail1ForFlow6ViewController") as! SCGuardRail1ForFlow6ViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showinfo" {
            let infoController = segue.destination as! SCInfoViewController
            infoController.infoHeader = self.infoHeader
            infoController.infoDetail = self.infoDetail
            infoController.infoImage = self.infoImage
        }
    }

}
