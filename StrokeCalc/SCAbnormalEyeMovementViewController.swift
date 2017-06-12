//
//  SCAbnormalEyeMovementViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 10/28/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCAbnormalEyeMovementViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource, SCGCSModalProtocol {
    
    // MARK: - Properties

    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.table.separatorColor = UIColor.init(red: 208, green: 225, blue: 236, transperancy: 1.0)
        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Custom Methods
    
    func initUI() {
        
        let titleStr: String
        if testScoreService.getFlowNumber() == 1
            || testScoreService.getFlowNumber() == 2
        || testScoreService.getFlowNumber() == 5
            || testScoreService.getFlowNumber() == 6 {
            
            titleStr = "Abnormal Eye Movement"
            
        }else if testScoreService.getFlowNumber() == 4 {
            
            if SCAnswerStatus.sharedInstance.isAdjustForGuardRail1 {
                titleStr = "What is the Abnormal Eye Movement?"
            }else {
                titleStr = "Abnormal Eye Movement"
            }
            
        }else {
            titleStr = "What is the Abnormal Eye Movement?"
        }
        
        self.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: titleStr)
        
        self.contentLabel.attributedText = NSMutableAttributedString().normal(text: "Are ").orangeBold(text: "BOTH").normal(text: " eyes deviated to one side and ").orangeBold(text: "FIXED").normal(text: " in position, like either of the images below?\nIf there are any eye abnormalities OTHER than the 2 choices below, tap OTHER ABNORMAL EYE MOVEMENT.")
        
        self.tableViewHeightConstraint.constant = SCUtils.shared.sizeFor(value: 65) * 3 + 2
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
            
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Both eyes are deviated to the LEFT and fixed in position.", size: 17, alignment: .left)
            cell.dictionaryButton.setImage(UIImage(named: "eyesLeft"), for: .disabled)
            cell.dictionaryButton.isEnabled = false
            cell.dictionaryButton.isHidden = false
            cell.dictionaryButton.tag = 101
        } else if indexPath.row == 1 {
            
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Both eyes are deviated to the RIGHT and fixed in position.", size: 17, alignment: .left)
            cell.dictionaryButton.setImage(UIImage(named: "eyesRight"), for: .disabled)
            cell.dictionaryButton.isEnabled = false
            cell.dictionaryButton.isHidden = false
            cell.dictionaryButton.tag = 102
        } else if indexPath.row == 2 {
            
            let newcell = tableView.dequeueReusableCell(withIdentifier: "answercelltext") as! SCAnswerTableViewCell

            newcell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "OTHER ABNORMAL EYE MOVEMENT", size: 17, alignment: .left)
            
            return newcell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 2 {
            
            testScoreService.setScoresForQuestions(dictionary: [SCQType.Q2.rawValue: 1])
            
            if testScoreService.getFlowNumber() == 1
                || testScoreService.getFlowNumber() == 2 {// Score 1 point & go to Q4
                
                self.showFacialPalsyVC()
                
            } else if testScoreService.getFlowNumber() == 3
                || testScoreService.getFlowNumber() == 4
                || testScoreService.getFlowNumber() == 5
                || testScoreService.getFlowNumber() == 6 {// Score 1 point & go to Q3
                
                self.showVisualFieldVC()
                
            }
            
        }else { // Deviated & Fixed Gaze of Both Eyes
            
            if testScoreService.getFlowNumber() == 4
                || testScoreService.getFlowNumber() == 6 {
                
                self.showModal()
                
            }else {
                performSegue(withIdentifier: "todeviated", sender: self)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCUtils.ComponentSize.BUTTON_HEIGHT
    }
    
    // MARK: - SCGCSModalProtocol
    
    func understandPressed() {
        performSegue(withIdentifier: "todeviated", sender: self)
    }

    // MARK: - Custom Methods
    
    func showModal() {
        let modalVC = self.storyboard?.instantiateViewController(withIdentifier: "SCGCSModalViewController") as! SCGCSModalViewController
        
        modalVC.delegate = self
        modalVC.modalWith(title: NSMutableAttributedString().boldRed(text: "WARNING:", size: 35, align: NSTextAlignment.center), content: NSMutableAttributedString().boldBlue(text: "Because the ", size: 18).boldRed(text: "patient is intubated,", size: 18, align: NSTextAlignment.center).boldBlue(text: " take appropriate precautions to ensure a secure airway and avoid accidental extubation.", size: 18))
        modalVC.modalTransitionStyle = .crossDissolve
        modalVC.modalPresentationStyle = .overCurrentContext
        
        self.present(modalVC, animated: true, completion: nil)
    }
    
    func showVisualFieldVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCVisualFieldsViewController") as! SCVisualFieldsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showFacialPalsyVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCFacialPalsyViewController") as! SCFacialPalsyViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
