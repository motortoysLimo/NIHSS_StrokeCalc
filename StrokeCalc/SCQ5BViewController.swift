//
//  SCQ5BViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 11/3/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ5BViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var lightButton: UIButton!
    @IBOutlet weak var mimicButton: UIButton!
    @IBOutlet weak var coachButton: UIButton!
    @IBOutlet weak var timerButton: UIButton!
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
//        self.lightButton.setShadowLayer()
//        self.mimicButton.setShadowLayer()
//        self.coachButton.setShadowLayer()
//        self.timerButton.setShadowLayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDelegate & UITableViewDataSource
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return SCUtils.shared.sizeFor(value: 330)
            } else if indexPath.row == 1 {
                return SCUtils.ComponentSize.SIZE_405
            } else {
                return SCUtils.ComponentSize.BUTTON_HEIGHT
            }
        } else if indexPath.section == 5 {
            return SCUtils.ComponentSize.BUTTON_HEIGHT
        } else {
            if indexPath.row == 0 {
                return SCUtils.ComponentSize.SIZE_405
            } else {
                return SCUtils.ComponentSize.BUTTON_HEIGHT
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section > 0 {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20.0))
            headerView.backgroundColor = UIColor.white
            return headerView
        } else {
            let noHeader = UIView()
            return noHeader
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else if section == 5{
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 0 {
            return 20.0
        } else {
            return 0.01
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let detailCell = tableView.dequeueReusableCell(withIdentifier: "detailcell") as! SCDetailTableViewCell
                
                detailCell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "5B. Motor - Right Arm")
                detailCell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "Tap the LIGHTBULB to determine the patient's starting position (sitting or lying down). Test the non-parazyled arm first.\n\nWhen ready, start the ").orangeBold(text: "10-second timer").normal(text: ".")
                
                return detailCell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "bigimagecell", for: indexPath) as! SCBigImageTableViewCell
                let face = UIImage(named: "leftArm0")
                cell.bigImage.image = face
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "answercell", for: indexPath) as! SCAnswerTableViewCell
                cell.answerNumber.image = UIImage(named: "zero")
                cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "No drift", size: 17, alignment: .left)
                
                cell.dictionaryButton.isHidden = false
                cell.dictionaryButton.tag = 101
                return cell
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "bigimagecell", for: indexPath) as! SCBigImageTableViewCell
                cell.bigImage.image = UIImage(named: "leftArm1")
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "answercell", for: indexPath) as! SCAnswerTableViewCell
                cell.answerNumber.image = UIImage(named: "one")
                cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Drifts down", size: 17, alignment: .left)
                
                cell.dictionaryButton.isHidden = false
                cell.dictionaryButton.tag = 102
                
                
                return cell
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "bigimagecell", for: indexPath) as! SCBigImageTableViewCell
                cell.bigImage.image = UIImage(named: "leftArm2")
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "answercell", for: indexPath) as! SCAnswerTableViewCell
                cell.answerNumber.image = UIImage(named: "two")
                cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Falls down (touches bed)", size: 17, alignment: .left)
                
                cell.dictionaryButton.isHidden = false
                cell.dictionaryButton.tag = 103
                return cell
                
            }
        } else if indexPath.section == 3 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "bigimagecell", for: indexPath) as! SCBigImageTableViewCell
                cell.bigImage.image = UIImage(named: "leftArm3")
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "answercell", for: indexPath) as! SCAnswerTableViewCell
                cell.answerNumber.image = UIImage(named: "three")
                cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Drops down (instantly)", size: 17, alignment: .left)
                
                cell.dictionaryButton.isHidden = false
                cell.dictionaryButton.tag = 104
                return cell
            }
        } else if indexPath.section == 4 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "bigimagecell", for: indexPath) as! SCBigImageTableViewCell
                cell.bigImage.image = UIImage(named: "leftArm4")
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "answercell", for: indexPath) as! SCAnswerTableViewCell
                cell.answerNumber.image = UIImage(named: "four")
                cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "No movement", size: 17, alignment: .left)
                
                cell.dictionaryButton.isHidden = false
                cell.dictionaryButton.tag = 105
                return cell
            }
        } else if indexPath.section == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "answercell", for: indexPath) as! SCAnswerTableViewCell
            cell.answerNumber.image = UIImage(named: "un")
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Untestable", size: 17, alignment: .left)
            
            cell.dictionaryButton.isHidden = false
            cell.dictionaryButton.tag = 106
            return cell
        } else {
            return defaultCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row != 0 || indexPath.section == 5 {
            let score = indexPath.section
            if indexPath.section == 5 { // UN - Untestable
                self.showAlertForUntestable()
            }else {
                testScoreService.setScoresForQuestions(dictionary: [SCQType.Q5B.rawValue: score])
                performSegue(withIdentifier: "toq6a", sender: self)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            return
        }
        
        let bigImageCellIndex = IndexPath(row: indexPath.row - 1, section: indexPath.section)
        let cell = tableView.cellForRow(at: bigImageCellIndex)
        cell?.contentView.backgroundColor = UIColor.prnCellNormalColor
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            return
        }
        
        let bigImageCellIndex = IndexPath(row: indexPath.row - 1, section: indexPath.section)
        let cell = tableView.cellForRow(at: bigImageCellIndex)
        cell?.contentView.backgroundColor = UIColor.prnGray
    }
    
    // MARK: - UIButton Actions
    
    @IBAction func lightBulpTapped(_ sender: Any) {
        self.infoImage = #imageLiteral(resourceName: "lightbulb_icon")
        self.infoDetail = NSMutableAttributedString().bold(text: "Starting position for patient that is sitting").normal(text: ": have the arm extended 90 degrees with palm down.\n").bold(text: "Starting position for patient that is lying down").normal(text: ": have the arm extended 45 degrees with the palm down.\n").underlinedNormal(text: "Drift").normal(text: " is scored if the arm falls before 10 seconds. If the patient has ").underlinedNormal(text: "aphasia").normal(text: ", you may coach or pantomime, but may not use noxious stimulation.\n").normal(text: "0: No drift: arm holds at the starting position for full 10 seconds.\n").normal(text: "1: Arm falls (or drifts down) before full 10 seconds, but does not touch bed.\n").normal(text: "2: REQUIRES HOLDING ARM AT STARTING POSITION. Arm falls before full 10 seconds and touches bed, but there was some effort against gravity.\n").normal(text: "3: REQUIRES HOLDING ARM AT STARTING POSITION: Arm falls immediately without any resistance from gravity.\n").normal(text: "4: No movement.\n").normal(text: "UN: Untestable")
        self.performSegue(withIdentifier: "showinfo", sender: self)
    }
    
    @IBAction func mimicAction(_ sender: Any) {
        self.infoImage = #imageLiteral(resourceName: "mimic_icon")
        self.infoDetail = NSMutableAttributedString().normal(text: "OK to act out what you want the patient to do.")
        self.performSegue(withIdentifier: "showinfo", sender: self)
    }
    
    @IBAction func coachTapped(_ sender: Any) {
        self.infoImage = #imageLiteral(resourceName: "coach_icon")
        self.infoDetail = NSMutableAttributedString().normal(text: "You may coach the patient for the questions in which this COACH icon is visible. This includes repeated requests to make an effort OR encouraging a patient to respond.")
        self.performSegue(withIdentifier: "showinfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showinfo" {
            let infoController = segue.destination as! SCInfoViewController
            infoController.infoHeader = self.infoHeader
            infoController.infoDetail = self.infoDetail
            infoController.infoImage = self.infoImage
        }
    }
    
    @IBAction func timerTouchUp(_ sender: SCRoundButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCTimerViewController") as! SCTimerViewController
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        vc.setTime(value: 10)
        
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - Alert for Untestable
    func showAlertForUntestable() {
        let alertC = UIAlertController(title: "UNTESTABLE: 5A: Left Arm", message: "Only in the case of amputation or joint fusion at the left shoulder can the score be recorded as UNTESTABLE.\n\nPlease select one:", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let ampA = UIAlertAction(title: "Amputation", style: .default) { (ampA) in
            self.performNext()
        }
        
        let jointA = UIAlertAction(title: "Joint Fusion", style: .default) { (jointA) in
            self.performNext()
        }
        
        let cancelA = UIAlertAction(title: "Cancel", style: .cancel) { (cancelA) in
            
        }
        alertC.addAction(ampA)
        alertC.addAction(jointA)
        alertC.addAction(cancelA)
        
        self.present(alertC, animated: true, completion: nil)
    }
    
    func performNext() {
        testScoreService.setScoresForQuestions(dictionary: [SCQType.Q5B.rawValue: "UN"])
        performSegue(withIdentifier: "toq6a", sender: self)
        
    }

}
