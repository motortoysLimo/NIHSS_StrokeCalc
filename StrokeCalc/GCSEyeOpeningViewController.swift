//
//  GCSEyeOpeningViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 12/26/16.
//  Copyright © 2016 Mobile Guru. All rights reserved.
//

import UIKit

class GCSEyeOpeningViewController: SCBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
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
    
    // MARK: - Init UI
    
    func initUI() {
        self.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "GCS - Eye Opening")
        self.descriptionLabel.attributedText = NSMutableAttributedString().normal(text: "Please select one option from the list below")
        
        self.tableViewHeightConstraint.constant = SCUtils.shared.sizeFor(value: 262)
    }
    
    // MARK: - UITableViewDelegate and UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0 {
//            return SCUtils.shared.sizeFor(value: 330)
//        } else {
            return SCUtils.ComponentSize.BUTTON_HEIGHT
//        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let defaultCell = UITableViewCell()
        
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell") as! SCDetailTableViewCell
//            
//            cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "GCS - Eye Opening")
//            cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "Please select one option from the list below")
//            
//            return cell
//        } else
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "gsccell") as! SCAnswerTableViewCell
            cell.answerLabel.attributedText = NSAttributedString(string: "Eyes open spontaneously", attributes: cell.answerLabel.attributedText!.attributes(at: 0, effectiveRange: nil))
            cell.answerLabel.font = UIFont(name: cell.answerLabel.font.fontName, size: SCUtils.ComponentSize.LABEL_FONT17)
            cell.dictionaryButton.isHidden = true
            cell.dictionaryButton.isEnabled = false
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "gsccell") as! SCAnswerTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Eyes open to verbal command", size: 17, alignment: .left)
            cell.dictionaryButton.isHidden = true
            cell.dictionaryButton.isEnabled = false
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "gsccell") as! SCAnswerTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Eyes open to pain (deep sternal rub)", size: 17, alignment: .left)
            cell.dictionaryButton.isHidden = true
            cell.dictionaryButton.isEnabled = false
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "gsccell") as! SCAnswerTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "No eye opening", size: 17, alignment: .left)
            cell.dictionaryButton.tag = 1
            cell.dictionaryButton.isHidden = true
            cell.dictionaryButton.isEnabled = false
            return cell
        }
        return defaultCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var score = 0
//        if indexPath.row == 0 {
//            return
//        }
        
        if indexPath.row == 2 { // 2 GCS points
            score = 2
        }else if indexPath.row == 3 { // 1 GCS point
            score = 1
        }
        
        testScoreService.setScoresForQuestions(dictionary: ["GCS": score])
        
        performSegue(withIdentifier: "togcsverbal", sender: self)
    }
    
}
