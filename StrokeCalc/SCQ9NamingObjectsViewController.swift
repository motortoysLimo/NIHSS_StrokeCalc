//
//  SCQ9NamingObjectsViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 11/30/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ9NamingObjectsViewController: SCBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
    
    // MARK: - UITableViewDelegate & UITableViewDataSource
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return SCUtils.shared.sizeFor(value: 220)
        } else {
            return SCUtils.ComponentSize.SIZE_140
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell") as! SCDetailTableViewCell
            
            cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "Please assess the visually impaired patient's ability to name objects.")
            cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "(PLEASE SELECT ONE OPTION FROM THE LIST BELOW)")
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "centeredcell") as! SCCenteredLabelTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Overall, the patient partly understands what is being asked, tries to name at least some objects, and some of the names are correct.", size: 17, alignment: .left)
            return cell
            
        } else if indexPath.row == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "centeredcell") as! SCCenteredLabelTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Only one or two items identified.", size: 17, alignment: .left)
            return cell
            
        } else if indexPath.row == 3 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "centeredcell") as! SCCenteredLabelTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Overall, the patient has very little understanding of the instructions, or says words or syllables or sounds that have at best a limited connection with the correct object names.", size: 17, alignment: .left)
            
            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "centeredcell") as! SCCenteredLabelTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "The patient demonstrates zero understanding of written or spoken language and is mute.", size: 17, alignment: .left)
            return cell
        }
        return defaultCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 { // content part
            return
        }
//        performSegue(withIdentifier: "toq9reading", sender: self)
        
        var score: Int = 0
        if indexPath.row == 2 || indexPath.row == 3 {
            score = 2
        }else if indexPath.row == 1 {
            score = 1
        }else if indexPath.row == 4 {
            score = 3
        }
        testScoreService.setScoresForQuestions(dictionary: [SCQ9Type.Q9A.rawValue:score])
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ9RepeatingSentencesViewController") as! SCQ9RepeatingSentencesViewController
    
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
