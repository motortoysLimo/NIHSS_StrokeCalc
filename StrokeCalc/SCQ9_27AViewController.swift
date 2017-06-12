//
//  SCQ9_27AViewController.swift
//  StrokeCalc
//
//  Created by Mobile on 10/03/2017.
//  Copyright © 2017 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ9_27AViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return SCUtils.shared.sizeFor(value: 260)
        }else {
            return SCUtils.shared.sizeFor(value: 180)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! SCDetailTableViewCell
            
            cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "Please assess the patient's ability to name objects")
            cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "(PLEASE SELECT ONE OPTION FROM THE LIST BELOW)")
            
            return cell
        }else if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "centerCell", for: indexPath) as! SCCenteredLabelTableViewCell
            
            var str = ""
            
            if testScoreService.getFlowNumber() == 3 {
                str = "Overall, the patient partly understands what is being asked, tries to name at least some objects, and some of the names are correct."
            }else if testScoreService.getFlowNumber() == 4 {
                str = "Overall, the patient partly understands what is being asked, tries to write at least some objects, and some of the names are correct."
            }
            
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: str, size: 17, alignment: .left)
            
            return cell
            
        }else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "centerCell", for: indexPath) as! SCCenteredLabelTableViewCell
            
            var str = ""
            
            if testScoreService.getFlowNumber() == 3 {
                str = "Overall, the patient has very little understanding of the instructions, or says words or syllables or sounds that have at best a limited connection with the correct object names."
            }else if testScoreService.getFlowNumber() == 4 {
                str = "You have to guess what the patient is trying to write, and which object they are trying to describe."
            }
            
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: str, size: 17, alignment: .left)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            return
        }
        
        let score = indexPath.row // points
        testScoreService.setScoresForQuestions(dictionary: [SCQ9Type.Q9A.rawValue: score])
        
        // Show Q9-28A View
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ9ReadingViewController") as! SCQ9ReadingViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
