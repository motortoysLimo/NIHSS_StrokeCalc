//
//  SCFacialPalsyViewController.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 11/3/16.
//  Copyright © 2016 Mobile Guru. All rights reserved.
//

import UIKit

class SCFacialPalsyViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties


    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var lightButton: UIButton!
    @IBOutlet weak var mimicButton: UIButton!
    
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.edgesForExtendedLayout = UIRectEdge()
        self.table.backgroundColor = UIColor.white
        let backView = UIView(frame: table.bounds)
        backView.backgroundColor = UIColor.white
        self.table.backgroundView = backView
        self.table.separatorColor = UIColor.init(red: 208, green: 225, blue: 236, transperancy: 1.0)
        
        // -- 
//        self.lightButton.setShadowLayer()
//        self.mimicButton.setShadowLayer()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showinfo" {
            let infoController = segue.destination as! SCInfoViewController
            infoController.infoHeader = self.infoHeader
            infoController.infoDetail = self.infoDetail
            infoController.infoImage = self.infoImage
        }
    }

    
    @IBAction func dictButtonTapped(_ sender: UIButton) {
        self.infoImage = #imageLiteral(resourceName: "dictionary_icon")
        
        if sender.tag == 102 {
            self.infoDetail = NSMutableAttributedString().normal(text: "Flattened nasolabial fold, asymmetry on smiling.")
        }else if sender.tag == 103 {
            self.infoDetail = NSMutableAttributedString().normal(text: "Total/near paralysis of ").bold(text: "lower").normal(text: " face.")
        }else if sender.tag == 104 {
            self.infoDetail = NSMutableAttributedString().normal(text: "Complete absence of movements in both the ").bold(text: "upper and lower").normal(text: " face.")
        }
        
        self.performSegue(withIdentifier: "showinfo", sender: self)
    }
    
    @IBAction func lightBulpTapped(_ sender: AnyObject) {
        self.infoImage = #imageLiteral(resourceName: "lightbulb_icon")
        self.infoDetail = NSMutableAttributedString().normal(text: "For a patient that is ").underlinedNormal(text: "aphasic").normal(text: ", ").underlinedNormal(text: "confused").normal(text: " or ").underlinedNormal(text: "unresponsive").normal(text: ", ").normal(text: "a noxious stimuli may result in a grimace and the symmetry of this expression can be observed and scored. An example would be to tickle each nasal passage one at a time using a cotton-tipped applicator and observe facial movement.")
        self.performSegue(withIdentifier: "showinfo", sender: self)
        
    }
    
    @IBAction func mimicTapped(_ sender: AnyObject) {
        self.infoImage = #imageLiteral(resourceName: "mimic_icon")
        self.infoDetail = NSMutableAttributedString().normal(text: "You can open your eyes wide and close them repeatedly, and smile while showing your teeth for the patient to mimic.")
        self.performSegue(withIdentifier: "showinfo", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDelegate & UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return SCUtils.ComponentSize.SIZE_260
            } else if indexPath.row == 1 {
                return SCUtils.ComponentSize.SIZE_405
            } else {
                return SCUtils.ComponentSize.BUTTON_HEIGHT
            }
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
                
                detailCell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "4. Facial Palsy")
                detailCell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "Ask the patient to:\n 1. show ").orangeBold(text: "THEIR TEETH").normal(text: ".\n 2. raise ").orangeBold(text: "THEIR EYEBROWS").normal(text: " and\n    then, close ").orangeBold(text: "THEIR EYES\n    TIGHTLY.")
                
                return detailCell
            } else if indexPath.row == 1 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "bigimagecell", for: indexPath) as! SCBigImageTableViewCell
                let face = UIImage(named: "face0")
                cell.bigImage.image = face
                return cell
                
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "answercell", for: indexPath) as! SCAnswerTableViewCell
                cell.answerNumber.image = UIImage(named: "zero")
                cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Normal and symmetrical movements", size: 17, alignment: .left)
                
                cell.dictionaryButton.isHidden = false
                cell.dictionaryButton.tag = 101
                cell.dictionaryButton.isHidden = true
                cell.backgroundView = UIView(frame: cell.bounds)
                return cell
                
            }
        } else if indexPath.section == 1 {
            
            if indexPath.row == 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "bigimagecell", for: indexPath) as! SCBigImageTableViewCell
                cell.bigImage.image = UIImage(named: "face1")

                return cell
                
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "answercell", for: indexPath) as! SCAnswerTableViewCell
                cell.answerNumber.image = UIImage(named: "one")
                cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Minor paralysis", size: 17, alignment: .left)
                
                cell.dictionaryButton.isHidden = false
                cell.dictionaryButton.tag = 102
                cell.backgroundView = UIView(frame: cell.bounds)
                
                return cell
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "bigimagecell", for: indexPath) as! SCBigImageTableViewCell
                cell.bigImage.image = UIImage(named: "face2")
//                cell.backgroundView = UIView(frame: cell.bounds)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "answercell", for: indexPath) as! SCAnswerTableViewCell
                cell.answerNumber.image = UIImage(named: "two")
                cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Partial paralysis", size: 17, alignment: .left)
                
                cell.dictionaryButton.isHidden = false
                cell.dictionaryButton.tag = 103
                cell.backgroundView = UIView(frame: cell.bounds)
                return cell
                
            }
        } else if indexPath.section == 3 {
            if indexPath.row == 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "bigimagecell", for: indexPath) as! SCBigImageTableViewCell
                cell.bigImage.image = UIImage(named: "face3")
                return cell
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "answercell", for: indexPath) as! SCAnswerTableViewCell
                cell.answerNumber.image = UIImage(named: "three")
                cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Complete paralysis on one or both sides", size: 17, alignment: .left)
                
                cell.dictionaryButton.isHidden = false
                cell.dictionaryButton.tag = 104
                cell.backgroundView = UIView(frame: cell.bounds)
                return cell
            }
        } else {
            return defaultCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            
            let score = indexPath.section
            testScoreService.setScoresForQuestions(dictionary: [SCQType.Q4.rawValue: score])
            
            let currentFlow = testScoreService.getFlowNumber()
            if currentFlow == 1
                || currentFlow == 2 {
                /// End exam
                SCUtils.shared.showEndExamAlert()
            }else if currentFlow == 3
                || currentFlow == 4
                || currentFlow == 5
                || currentFlow == 6 {
                performSegue(withIdentifier: "to5a", sender: self)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        print("TableView: didHighlight:%@", indexPath.row)
        
        if indexPath.row == 0 {
            return
        }
        
        let bigImageIndex = IndexPath(row: indexPath.row - 1, section: indexPath.section)
        let cell = tableView.cellForRow(at: bigImageIndex) as! SCBigImageTableViewCell
        cell.contentView.backgroundColor = UIColor.prnCellNormalColor
        
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        print("TableView: didUnHighlight:%@", indexPath.row)
        
        if indexPath.row == 0 {
            return
        }
        
        let bigImageIndex = IndexPath(row: indexPath.row - 1, section: indexPath.section)
        let cell = tableView.cellForRow(at: bigImageIndex) as! SCBigImageTableViewCell
        cell.contentView.backgroundColor = UIColor.prnGray
    }
    
}
