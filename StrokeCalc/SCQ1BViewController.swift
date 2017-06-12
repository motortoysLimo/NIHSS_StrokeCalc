//
//  SCQ1BViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 10/28/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ1BViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.separatorColor = UIColor.init(red: 208, green: 225, blue: 236, transperancy: 1.0)
        // Do any additional setup after loading the view.
        self.initUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dictButtondTapped(_ sender: UIButton) {
        if sender.tag == 101 {
            print("one point")
        } else if sender.tag == 102 {
            print("two points")
        } else if sender.tag == 103 {
            print("three points")
        } else if sender.tag == 104 {
            print("four points")
        }
    }

    // MARK: - UITableViewDelegate / UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "answercell") as! SCAnswerTableViewCell
        
        if indexPath.row == 0 {
            cell.answerNumber.image = UIImage(named: "zero")
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Answers BOTH correctly", size: 17, alignment: .left)
            cell.dictionaryButton.isHidden = true
            cell.dictionaryButton.tag = 101
        } else if indexPath.row == 1 {
            cell.answerNumber.image = UIImage(named: "one")
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Answers ONE correctly", size: 17, alignment: .left)
            cell.dictionaryButton.isHidden = true
            cell.dictionaryButton.tag = 102
        } else if indexPath.row == 2 {
            cell.answerNumber.image = UIImage(named: "two")
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Answers NEITHER correctly", size: 17, alignment: .left)
            cell.dictionaryButton.isHidden = true
            cell.dictionaryButton.tag = 103
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        testScoreService.setScoresForQuestions(dictionary: [SCQType.Q1B.rawValue: indexPath.row])
        performSegue(withIdentifier: "toq1c", sender: self)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCUtils.ComponentSize.BUTTON_HEIGHT
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Custom Methods
    
    func initUI() {
        self.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "1B. LOC Questions")
        self.contentLabel.attributedText = NSMutableAttributedString().normal(text: "Ask the patient:\n 1. what his or her ").orangeBold(text: "AGE").normal(text: " is.\n 2. what ").orangeBold(text: "MONTH").normal(text: " it is.")
        
        self.tableViewHeightConstraint.constant = SCUtils.shared.sizeFor(value: 65) * 3 + 2
        
    }

}
