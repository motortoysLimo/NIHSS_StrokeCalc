//
//  SCQ10SpeechClarityAssessViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 11/3/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ10SpeechClarityAssessViewController: SCBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var nextButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButton: SCAnswerButton!
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.nextButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "NEXT", size: 20), for: UIControlState.normal)
        self.nextButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCUtils.ComponentSize.SIZE_600
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell") as! SCDetailTableViewCell
        
        cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "10. Speech clarity")
        cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "Ask the patient ").orangeBold(text: "TO REPEAT").normal(text: " the following words:\n\n  Mama\n  Tip-top\n  Fifty-fifty\n  Thanks\n  Huckelberry\n  Baseball player\n\n").normalItalic(text: "If the patient can't repeat words, ").boldItalic(text: "EVALUATE ANY").normalItalic(text: "responses or spontaneous speech for clarity. Listen very carefully and note any slurring of speech. If the patient cannot speak, or with only minimal sounds, tap UNABLE, otherwise tap NEXT.")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    @IBAction func nextAction(_ sender: Any) {
        self.performSegue(withIdentifier: "toq10read", sender: self)
    }

}
