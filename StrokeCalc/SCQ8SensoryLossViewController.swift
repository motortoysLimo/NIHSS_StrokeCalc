//
//  SCQ8SensoryLossViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 11/3/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ8SensoryLossViewController: SCBaseViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Properties
    
    @IBOutlet weak var lightButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.lightButton.setShadowLayer()
//        self.videoButton.setShadowLayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func lightBulpAction(_ sender: Any) {
        self.infoImage = #imageLiteral(resourceName: "lightbulb_icon")
        self.infoDetail = NSMutableAttributedString().normal(text: "Test as many body areas as needed to accurately check for the ").bold(text: "hemi-sensory loss").normal(text: ".\n\n").normal(text: "Testing should be ").bold(text: "AVOIDED on the hands and feet ").normal(text: "because the pre-existing neuropathy may impair sensation in those areas.\n\n").normal(text: "When testing, start with the head and work down to the feet, pricking skin sites in RANDOM ORDER.")
        self.performSegue(withIdentifier: "showinfo", sender: self)
    }
    
    @IBAction func mimicAction(_ sender: Any) {
        print("mimic")
    }
    
    // MARK: - UITableViewDelegate & UITableViewDataSource

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if SCAnswerStatus.sharedInstance.isAdjustForGuardRail1 {
                return SCUtils.shared.sizeFor(value: 400)
            }else {
                return SCUtils.shared.sizeFor(value: 500)
            }
        } else {
            return SCUtils.ComponentSize.BUTTON_HEIGHT
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        if indexPath.row == 0 {
            let detailCell = tableView.dequeueReusableCell(withIdentifier: "detailcell") as! SCDetailTableViewCell
            
            var titleStr: String = ""
            var questionStr: String = ""
            if SCAnswerStatus.sharedInstance.isAdjustForGuardRail1 {
                titleStr = "8. Sensory Loss in an\nUnresponsive Patient"
                questionStr = "1.  Tell the patient that they may\n    feel small pinpricks.\n2.  Use a pinprick to examine:\n    • the face,\n    • then forearms (not hands),\n    • then shins (not feet)\n3.  Observe the face for grimace.\n4.  No response? Apply a noxious\n    stimulus until patient grimaces or\n    withdraws (pull away)."
            }else {
                titleStr = "8. Sensory Loss"
                questionStr = "1.  Tell the patient that they\n    may feel small pinpricks to\n    their skin.\n2.  Ask the patient to indicate when\n    the pinpricks are felt by saying,\n    writing, or point RIGHT or LEFT.\n3.  Use a pinprick to examine:\n    • the face,\n    • then forearms (not hands),\n    • then shins (not feet)\n4.  Test the SAME AREA ON BOTH\n    SIDES and compare by asking if\n    the patient feels any diference\n    between the LEFT and RIGHT."
            }
            
            detailCell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: titleStr)
            detailCell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: questionStr)
            
            return detailCell
        } else if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "answercell", for: indexPath) as! SCAnswerTableViewCell
            cell.answerNumber.image = UIImage(named: "zero")
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Normal", size: 17, alignment: .left)
            return cell
            
        } else if indexPath.row == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "answercell", for: indexPath) as! SCAnswerTableViewCell
            cell.answerNumber.image = UIImage(named: "one")
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Mild to moderate loss.\nPatient aware of touch.", size: 17, alignment: .left)
            return cell
            
        } else if indexPath.row == 3 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "answercell", for: indexPath) as! SCAnswerTableViewCell
            cell.answerNumber.image = UIImage(named: "two")
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Severe loss.\nNOT aware of touch.", size: 17, alignment: .left)
            
            return cell
        } else {
            return defaultCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            return
        }
        
        let score = indexPath.row - 1
        testScoreService.setScoresForQuestions(dictionary: [SCQType.Q8.rawValue: score])
        
        performSegue(withIdentifier: "toq9", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showinfo" {
            let infoController = segue.destination as! SCInfoViewController
            infoController.infoHeader = self.infoHeader
            infoController.infoDetail = self.infoDetail
            infoController.infoImage = self.infoImage
        }
    }

}
