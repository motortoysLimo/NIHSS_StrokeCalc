//
//  SCDoubleSimultaneousStimulationViewController.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 11/3/16.
//  Copyright © 2016 Mobile Guru. All rights reserved.
//

import UIKit

class SCDoubleSimultaneousStimulationViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - Properties

    @IBOutlet weak var videoButton: SCRoundButton!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - UITableViewDelegate & UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return SCUtils.shared.sizeFor(value: 680)
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
            
            cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "Double Simultaneous\nStimulation (Visual)")
            cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "Ask the patient to continue looking at your nose and not move their eyes.")
            cell.contentLabel.attributedText = NSMutableAttributedString().normal(text: "Start with your hands beside each of the patient's ear. Extend your fingers on both hands and begin wigging them. Move your hands slowly in an arc around around the face and ask the patient to tell you (or show you) when he/she sees your fingers.\nOn which hand did the patient see your fingers?")
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "centeredcell") as! SCCenteredLabelTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "BOTH", size: 17, alignment: .left)
            
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "centeredcell") as! SCCenteredLabelTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "RIGHT", size: 17, alignment: .left)
            
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "centeredcell") as! SCCenteredLabelTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "LEFT", size: 17, alignment: .left)
            
            return cell
        }
        return defaultCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            return
        }
        
        self.showFacialPalacyVC(sender: indexPath.row)
    }
    
    // MARK: - Custom Methods
    
    func showFacialPalacyVC(sender: Int) {
        var score: Int = 0
        let selectedIndex = sender
        if selectedIndex == 2
            || selectedIndex == 3 { //Guardrail 3 (Q3)
            score = 1
            testScoreService.setScoresForQuestions(dictionary: [SCQType.Q3.rawValue: score])
            testScoreService.setScoresForQuestions(dictionary: [SCQ11Type.Q11A.rawValue: score])
        }else if selectedIndex == 1 { // BOTH
            score = 0
            testScoreService.setScoresForQuestions(dictionary: [SCQType.Q3.rawValue: score])
            testScoreService.setScoresForQuestions(dictionary: [SCQ11Type.Q11A.rawValue: score])
        }
        
//        testScoreService.setScoresForQuestions(dictionary: [SCQType.Q3.rawValue: score])
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCFacialPalsyViewController") as! SCFacialPalsyViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
