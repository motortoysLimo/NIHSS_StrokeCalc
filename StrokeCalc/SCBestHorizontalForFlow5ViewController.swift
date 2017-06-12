//
//  SCBestHorizontalForFlow5ViewController.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 14/03/2017.
//  Copyright © 2017 Mobile Guru. All rights reserved.
//

import UIKit

class SCBestHorizontalForFlow5ViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return SCUtils.shared.sizeFor(value: 600)
        }else {
            return SCUtils.shared.sizeFor(value: 65)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! SCDetailTableViewCell
            
            cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "2. Best Horizontal Gaze")
            cell.descriptionLabel.attributedText = NSMutableAttributedString().normal(text: "Establish eye contact with the patient and move from one side of the bed to another, then ").orangeBold(text: "EVALUATE THE HORIZONTAL MOVEMENT").normal(text: " of both eyes as the patient follows you.\n\nThis is normal eye movement ").bold(text: "when tracking:")
            cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "Do both eyes move EXACTLY like the video above?")
            
            return cell
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath) as! SCAnswerTableViewCell
            
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "YES", size: 17 , alignment: NSTextAlignment.center)
            
            return cell
        }else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath) as! SCAnswerTableViewCell
            
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "NO", size: 17, alignment: NSTextAlignment.center)
            
            return cell
        }else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath) as! SCAnswerTableViewCell
            
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Patient is unable to track", size: 17, alignment: NSTextAlignment.center)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            return
        }
        
        if indexPath.row == 1 { // YES
            testScoreService.setScoresForQuestions(dictionary: [SCQType.Q2.rawValue: 0])
            self.showVisualFields()
            
        }else if indexPath.row == 2 { // NO
            self.showAbnormalEyeMovement()
            
        }else if indexPath.row == 3 { // Patient is unable to track
            self.showDeviatedFixedGaze()
        }
        
    }
    
    // MARK: - Custom Methods
    
    func showVisualFields() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCVisualFieldsViewController") as! SCVisualFieldsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAbnormalEyeMovement() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCAbnormalEyeMovementViewController") as! SCAbnormalEyeMovementViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showDeviatedFixedGaze() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCDeviatedAndFixedGazeViewController") as! SCDeviatedAndFixedGazeViewController
        vc.isNeutral = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
