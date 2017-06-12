//
//  SCQ9AssessScreenViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 11/3/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ9AssessScreenViewController: SCBaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var normalButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var abnormalHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var normalButton: SCAnswerButton!
    @IBOutlet weak var abnormalButton: SCAnswerButton!
    
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
    
    // MARK: - UIButton Actions
    
    @IBAction func normalAction(_ sender: Any) {
        testScoreService.setScoresForQuestions(dictionary: [SCQ9Type.Q9B.rawValue: 0])
        self.performSegue(withIdentifier: "toq11event", sender: self)
    }
    
    @IBAction func abnormalAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ9RepeatingSentencesChoiceViewController") as! SCQ9RepeatingSentencesChoiceViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func initUI() {
        self.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "9. Best Language -\nReading Sentences")
        self.questionLabel.attributedText = NSMutableAttributedString().normal(text: "How would you assess the patient's ability to communicate through spoken language?")
        
        self.normalButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
        self.abnormalHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
        
        self.normalButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "NORMAL", size: 20), for: UIControlState.normal)
        self.abnormalButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "ABNORMAL", size: 20), for: UIControlState.normal)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
