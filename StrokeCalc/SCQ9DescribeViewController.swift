//
//  SCQ9DescribeViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 12/7/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ9DescribeViewController: SCBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var nextButtonHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nextButton: SCAnswerButton!
    
    var checkDic = [Bool](repeating: false, count: 4)
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.nextButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
        self.nextButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "NEXT", size: 20), for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDelegate / UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return SCUtils.shared.sizeFor(value: 240)
        }else {
            return SCUtils.ComponentSize.SIZE_90
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell") as! SCDetailTableViewCell
            
            cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "Which of the following\nevents from preceding\npicture did the patient\ndescribe?")
            cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "(PLEASE MARK ALL THAT APPLY)")
            
            return cell
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SCCookieThiefCell") as! SCCookieThiefCell
            cell.switchB.tag = 101
            cell.contentLabel.attributedText = NSMutableAttributedString().normal(text: "The boy is taking cookies from the cookie jar while the girl reashes for a cookie.")
            return cell
        }else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SCCookieThiefCell") as! SCCookieThiefCell
            cell.switchB.tag = 102
            cell.contentLabel.attributedText = NSMutableAttributedString().normal(text: "The boy's stool us falling.")
            return cell
        }else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SCCookieThiefCell") as! SCCookieThiefCell
            cell.switchB.tag = 103
            cell.contentLabel.attributedText = NSMutableAttributedString().normal(text: "The sink is overflowing.")
            return cell
        }else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SCCookieThiefCell") as! SCCookieThiefCell
            cell.switchB.tag = 104
            cell.contentLabel.attributedText = NSMutableAttributedString().normal(text: "The mother is washing dishes.")
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    
    // MARK: - UIButton Actions

    @IBAction func nextAction(_ sender: Any) {
        
        if checkDic[0] == true && checkDic[1] == true && checkDic[2] == true && checkDic[3] == true {
            testScoreService.setScoresForQuestions(dictionary: [SCQ11Type.Q11B.rawValue:0])
        }else {
            testScoreService.setScoresForQuestions(dictionary: [SCQ11Type.Q11B.rawValue:1])
        }
        
        self.performSegue(withIdentifier: "toassess", sender: self)
    }
    
    @IBAction func switchTouchUp(_ sender: UISwitch) {
        checkDic[sender.tag - 101] = sender.isOn
    }
    
}
