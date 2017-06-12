//
//  SCVisualFieldsViewController.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 2/10/17.
//  Copyright © 2017 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCVisualFieldsViewController: SCBaseViewController {
    
    // MARK: - Properties
    
    var scoringPanelVC: SCScoringPanelViewController?

    @IBOutlet weak var lightButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_info" {
            let infoController = segue.destination as! SCInfoViewController
            infoController.infoHeader = self.infoHeader
            infoController.infoDetail = self.infoDetail
            infoController.infoImage = self.infoImage
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func lightButtonTouchUp(_ sender: SCRoundButton) {
        self.infoImage = #imageLiteral(resourceName: "lightbulb_icon")
        self.infoDetail = NSMutableAttributedString().normal(text: "When vision is absent or impaired on one entire side of the visual field (both an upper and lower quadrant), this is referred to as ").bold(text: "hemianopia").normal(text: " (half vision). If the same side is affected in both eyes, it is referred to as ").bold(text: "homonymous hemianopia").normal(text: " or ").bold(text: "complete hemianopia").normal(text: " (Score = 2).")
        self.performSegue(withIdentifier: "segue_info", sender: self)
    }

    // MARK: - Cutom Methods
    
    func initUI() {
        self.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "3. Visual Fields")
        self.contentLabel.attributedText = NSMutableAttributedString().normal(text: "Has the patient undergone enucleation (removal of the eye), or uses a prosthetic eye, or is blind in one or both eyes?")
        
        self.tableViewHeightConstraint.constant = SCUtils.shared.sizeFor(value: 65) * 4 + 2
    }
    
    func showLeftEyeVisualFieldVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ3LeftEyeVisualFieldViewController") as! SCQ3LeftEyeVisualFieldViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showRightEyeVisualFieldVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ3RightEyeVisualFieldViewController") as! SCQ3RightEyeVisualFieldViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showFacialPalsy() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCFacialPalsyViewController") as! SCFacialPalsyViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension SCVisualFieldsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCUtils.ComponentSize.BUTTON_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "answercelltext") as! SCAnswerTableViewCell
        
        var str = ""
        
        if indexPath.row == 0 {
            str = "Not blind"
        } else if indexPath.row == 1 {
            str = "LEFT eye blind"
        } else if indexPath.row == 2 {
            str = "RIGHT eye blind"
        } else if indexPath.row == 3 {
            str = "BOTH eyes blind"
        }
        cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: str, size: 17, alignment: .left)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 3 { // BOTH eyes blind: Score 3 points & go to Q4
            testScoreService.setScoresForQuestions(dictionary: [SCQType.Q3.rawValue: 3])
            
            SCAnswerStatus.sharedInstance.isGuardRail2A = true
            
            self.showFacialPalsy()
            
        }else { // Not blind / LEFT eye blind / RIGHT eye blind
            
            switch indexPath.row {
                case 0, 2: // Not blind || RIGHT eye blind
                    self.showLeftEyeVisualFieldVC()
                    break
                case 1: // LEFT eye blind
                    self.showRightEyeVisualFieldVC()
                    break
                default:
                    break
            }
            
            if indexPath.row == 0 {
                SCAnswerStatus.sharedInstance.isNotBlind = true
            }else {
                SCAnswerStatus.sharedInstance.isNotBlind = false
            }
        }
    }
    
    //
    
}
