//
//  SCQ9ReadingViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 11/3/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ9ReadingViewController: SCBaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var nextButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButton: SCAnswerButton!
    
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
    
    func initUI() {
        
        if testScoreService.getFlowNumber() == 3 {
            self.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "9. Best Language -\nReading Sentences")
            self.contentLabel.attributedText = NSMutableAttributedString().normal(text: "Ask the patient to ").orangeBold(text: "READ THE SENTENCES").normal(text: " listed on the next screen.")
        }else if testScoreService.getFlowNumber() == 4 {
            self.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "9. Best Language -\nFor Intubated Patient")
            self.contentLabel.attributedText = NSMutableAttributedString().normal(text: "Ask Mr. Smith ").orangeBold(text: "TO WRITE THE SENTENCES").normal(text: " listed on the next screen.\n\nDoes Mr. Smith wear reading glasses?")
        }
        
        self.nextButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
        self.nextButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "NEXT", size: 20), for: UIControlState.normal)
    }
    
    @IBAction func nextAction(_ sender: Any) {
        self.performSegue(withIdentifier: "tosentences", sender: self)
    }

    @IBAction func glassesTapped(_ sender: Any) {
        self.infoImage = #imageLiteral(resourceName: "glasses_icon")
        self.infoDetail = NSMutableAttributedString().normal(text: "Please remind the patient to wear their glasses when you see the icon.")//\n\nIf the patient does not have their glasses or has difficulty with vision, you may tap on this icon for tips to modify the exam to fit the patient's needs.")
        self.performSegue(withIdentifier: "showinfo", sender: self)
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
